BCD译码器
===

简介
---
BCD码（Binary-Coded Decimal），用4位二进制数来表示1位十进制数中的0~9这10个数码，是一种二进制的数字编码形式，用二进制编码的十进制代码。BCD码这种编码形式利用了四个位元来储存一个十进制的数码，使二进制和十进制之间的转换得以快捷的进行。

对应表如下：
| 十进制数字 | BCD码 |
| ---------- | ----- |
| 0          | 0000  |
| 1          | 0001  |
| 2          | 0010  |
| 3          | 0011  |
| 4          | 0100  |
| 5          | 0101  |
| 6          | 0110  |
| 7          | 0111  |
| 8          | 1000  |
| 9          | 1001  |

本模块设计了一个从10位的独热码到BCD码的编码器。

该电路有1个4位的输入in，一个10位的输出out，out[in] = 1'b1，其余位均为0。

测试用例与参考输出
---

| 序号 | in   | out          |
| ---- | ---- | ------------ |
| 1    | 0000 | 00_0000_0001 |
| 2    | 0001 | 00_0000_0010 |
| 3    | 0010 | 00_0000_0100 |
| 4    | 0011 | 00_0000_1000 |
| 5    | 0100 | 00_0001_0000 |
| 6    | 0101 | 00_0010_0000 |
| 7    | 0110 | 00_0100_0000 |
| 8    | 0111 | 00_1000_0000 |
| 9    | 1000 | 01_0000_0000 |
| 10   | 1001 | 10_0000_0000 |
| 11   | 1010 | 00_0000_0000 |
| 12   | 1011 | 00_0000_0000 |
| 13   | 1100 | 00_0000_0000 |
| 14   | 1101 | 00_0000_0000 |
| 15   | 1110 | 00_0000_0000 |
| 16   | 1111 | 00_0000_0000 |


参考代码
---

参见https://github.com/wkxfudan/verilog_case/tree/main/Decoder