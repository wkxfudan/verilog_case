83译码器
======

简介
---
该模块实现了83译码器的功能。83译码器的真值表如下：

| in  | out       |
| --- | --------- |
| 000 | 0000_0001 |
| 001 | 0000_0010 |
| 010 | 0000_0100 |
| 011 | 0000_1000 |
| 100 | 0001_0000 |
| 101 | 0010_0000 |
| 110 | 0100_0000 |
| 111 | 1000_0000 |

本电路有一个3位的输入in和8位的输出out.

测试用例与参考输出
---

| 序号 | in  | out       |
| ---- | --- | --------- |
| 1    | 000 | 0000_0001 |
| 2    | 001 | 0000_0010 |
| 3    | 010 | 0000_0100 |
| 4    | 011 | 0000_1000 |
| 5    | 100 | 0001_0000 |
| 6    | 101 | 0010_0000 |
| 7    | 110 | 0100_0000 |
| 8    | 111 | 1000_0000 |

参考代码
---
参见https://github.com/wkxfudan/verilog_case/tree/main/Decoder