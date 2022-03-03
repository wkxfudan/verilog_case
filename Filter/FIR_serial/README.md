# 串行 FIR 滤波器设计
## 简介
### 设计说明
输入频率为 7.5 MHz 和 250 KHz 的正弦波混合信号，经过 FIR 滤波器后，高频信号 7.5MHz 被滤除，只保留 250KMHz 的信号。
***
输入频率：    7.5MHz 和 250KHz\
采样频率：    50MHz\
阻带：           1MHz-6MHz\
阶数：           15 （N=15）\
***
### 文件说明
- FIR.v：
Verilog源代码文件；
- FIR_tb：
Testbench文件（$readmemh地址需改为cosx0p25m7p5m12bit.txt文件地址）；
- cosx0p25m7p5m12bit.txt：
FIR滤波器系数文件（运行.tb文件时调用）；

### 代码参考
https://www.runoob.com/w3cnote/verilog-serial-fir.html
### DATE 
2022.3.1
