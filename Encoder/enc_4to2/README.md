42编码器
======

简介
---
该模块实现了42编码器的功能。42编码器的真值表如下：

| A3  | A2  | A1  | A0  | OUT[1] | OUT[0] |
| --- | --- | --- | --- | ------ | ------ |
| 0   | 0   | 0   | 0   | 0      | 0      |
| 0   | 0   | 0   | 1   | 0      | 0      |
| 0   | 0   | 1   | 0   | 0      | 1      |
| 0   | 1   | 0   | 0   | 1      | 0      |
| 1   | 0   | 0   | 0   | 1      | 1      |

其中A3、A2、A1、A0都为1位的输入，OUT是2位的输出。真值表以外的输入值均为非法输入。
本Project帮助你了解42编码器的逻辑实现。
你只需要掌握基本逻辑门电路相关知识即可完成。

测试用例与参考输出
---
| 序号 | A3  | A2  | A1  | A0  | OUT[1] | OUT[0] |
| ---- | --- | --- | --- | --- | ------ | ------ |
| 1    | 0   | 0   | 0   | 0   | 0      | 0      |
| 2    | 0   | 0   | 0   | 1   | 0      | 0      |
| 3    | 0   | 0   | 1   | 0   | 0      | 1      |
| 4    | 0   | 1   | 0   | 0   | 1      | 0      |
| 5    | 1   | 0   | 0   | 0   | 1      | 1      |

参考代码
---
参见 https://github.com/wkxfudan/verilog_case/Encoder