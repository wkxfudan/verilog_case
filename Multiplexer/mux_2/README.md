N位2选1多路选择器
===

简介
---
本模块实现了一个N位2选1多路选择器。

它有3个输入a, b, sel和1个参数DW。a与b均是DW位宽的，sel是1位宽的。
它有1个输出out，当sel为0时，out=a；当sel为1时，out=b。

测试用例与参考输出
---

|序号 |a          |b          |sel  |out        |
|-    |-          |-          |-    |-          |
|1    |0xffffffff |0x00000000 |0    |0xffffffff |
|2    |0xffffffff |0x00000000 |1    |0x00000000 |

参考代码
---

参见https://github.com/wkxfudan/verilog_case/tree/main/Multiplexer
