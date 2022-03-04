# 积分梳状滤波器设计
## 简介
积分梳状滤波器（CIC，Cascaded Integrator Comb），一般用于数字下变频（DDC）和数字上变频（DUC）系统。CIC 滤波器结构简单，没有乘法器，只有加法器、积分器和寄存器，资源消耗少，运算速率高，可实现高速滤波，常用在输入采样率最高的第一级，在多速率信号处理系统中具有着广泛应用。
### 设计说明
CIC 滤波器本质上就是一个简单的低通滤波器，截止频率为采样频率除以抽取倍数后的一半。输入数据信号仍然是 7.5MHz 和 250KHz，采样频率 50MHz。抽取倍数设置为 5，则截止频率为 5MHz，小于 7.5MHz，可以滤除 7.5MHz 的频率成分。设计参数如下：
***
输入频率：    7.5MHz 和 250KHz\
采样频率：    50MHz\
阻带：           5MHz\
阶数：           1 （M=1）\
级数：           3 （N=3）
***
### 文件说明
- dut.v：
Verilog源代码文件；
- testbench.v：
Testbench文件（$readmemh地址需改为cosx0p25m7p5m12bit.txt文件地址）；
- cosx0p25m7p5m12bit.txt：
FIR滤波器系数文件（运行.tb文件时调用）；

### 代码参考
https://www.runoob.com/w3cnote/verilog-cic.html
### DATE 
2022.3.1
