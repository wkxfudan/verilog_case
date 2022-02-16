七段数码管编码器
===

简介
---
七段数码管是利用7段发光数码管来拼成常见的数字和某些字母。再加上右下脚的小数点，实际上一个显示电源包含了8根控制信号线。
![](seg.jpg)

通过数码管各个显示段的亮灭情况我们可以推断出显示的数字。本模块就实现了一个从七段数码管编码器。其有1个8位的输入seg，seg[7]位小数点的亮灭（1为亮，0为灭），seg[0]对应a，seg[1]对应b，以此类推。

你可以使用Case语句完成这个模块。

数字与七段数码管的对应表：
| 数字            | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | a   | b   | c   | d   | e   | f   |
| --------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 共阴极表示(HEX) | 3f  | 06  | 5b  | 4f  | 66  | 6d  | 7d  | 07  | 7f  | 6f  | 77  | 7c  | 39  | 5e  | 79  | 71  |

测试用例与参考输出
---
| 序号 | hex | dp  | seg  |
| ---- | --- | --- | ---- |
| 1    | 0x0 | 0   | 0x3f |
| 2    | 0x1 | 1   | 0x86 |
| 3    | 0x2 | 0   | 0x5b |
| 4    | 0x3 | 1   | 0xcf |
| 5    | 0x4 | 0   | 0x66 |
| 6    | 0x5 | 1   | 0xed |
| 7    | 0x6 | 0   | 0x7d |
| 8    | 0x7 | 1   | 0x87 |
| 9    | 0x8 | 0   | 0x7f |
| 10   | 0x9 | 1   | 0xef |
| 11   | 0xa | 0   | 0x77 |
| 12   | 0xb | 1   | 0xfc |
| 13   | 0xc | 0   | 0x39 |
| 14   | 0xd | 1   | 0xde |
| 15   | 0xe | 0   | 0x79 |
| 16   | 0xf | 1   | 0xf1 |