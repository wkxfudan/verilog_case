# 32位有符号数的基4-Booth乘法器

乘法器采用基4的Booth算法，在16个周期内完成两个32位有符号操作数的乘法。可以进行异步清零。
乘法器同步行为受时钟信号上升沿触发。

## 端口和参数

#### 模块名

`booth_multiplier32`来自文件[booth_multiplier32.v](booth_multiplier32.v)

#### 端口

|信号|in/out|位宽|描述|
|:-:|:-:|:-:|:-:|
|`clk`|输入|1|时钟信号|
|`async_rst`|输入|1|异步清零信号|
|`valid`|输入|1|输入数据有效控制信号|
|`A`|输入|32|有符号操作数|
|`B`|输入|32|有符号操作数|
|`R`|输出|64|有符号结果(`ready=1`)|
|`ready`|输出|1|可接收输入数据信号|

## 功能

异步清零：`async_rst`信号被拉高时，内置操作数寄存器、部分和寄存器、计数器始终被置0。
数据加载：在乘法器`ready=1`时可接收操作数输入，输入操作数同时须将`valid`拉高表示输入有效。
乘法计算：采用基4的Booth算法，计算用时**16个周期**，计算时`ready`始终拉低以屏蔽操作数输入。
结果输出：计算完毕后输出乘法结果，`ready`重新拉高。

数据传输模式如下表：

|接收准备`ready`|输入有效`valid`|功能描述|下个周期`ready`值|
|:-:|:-:|:-:|:-:|
|1|1|接收操作数`A`和`B`，开始运算|0|
|1|0|输出`R`保持上次结果，不接收`A`和`B`|1|
|0|x|正在运算，不接收`A`和`B`|未结束则0，结束则1|

## 附：基4的Booth算法

对于32位有符号二进制数A和B，有：
$$
\begin{aligned}
操作数A & = -2^{31} A_{31}+\sum_{j=0}^{30} 2^j A_j \\
操作数B & = -2^{31} B_{31}+\sum_{j=0}^{30} 2^j B_j \\
积A*B & =A* \left( -2^{31} B_{31}+\sum_{j=0}^{30} 2^j B_j \right) \\
& = A* \left( -2^{31}B_{31} +
\sum_{j=1}^{15} \left( (2^{2j}-2*2^{2j-2}) B_{2j-1} + 2^{2j} B_{2j} \right) 
+ 2^0 B_0  \right ) \\
& = A* \sum_{j=0}^{15} 2^{2j} (B_{2j-1}+B_{2j}-2B_{2j+1}) 
\quad with \; B_{-1}=0. \\
& = \sum_{j=0}^{15} 2^{2j} * A * (B_{2j-1}+B_{2j}-2B_{2j+1})
\end{aligned}
$$
因此只需要16次**累加**和**移两位**操作即可计算完毕。
模块设计时，根据`B`的“首尾重合的每三位”读取结果，确定部分和的累加值

|`B[2j+1]`|`B[2j]`|`B[2j-1]`|部分和的累加值（最低位对齐2<sup>2j</sup>位）|
|:-:|:-:|:-:|:-:|
|0|0|0|0|
|0|0|1|`A`|
|0|1|0|`A`|
|0|1|1|`2*A`|
|1|0|0|`2*(~A+1)`|
|1|0|1|`~A+1`|
|1|1|0|`~A+1`|
|1|1|1|0|

