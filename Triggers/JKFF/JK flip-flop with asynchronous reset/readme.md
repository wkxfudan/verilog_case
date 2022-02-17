# JK触发器（异步复位）

实现了上升沿触发的JK触发器的功能。**上升沿**来临时JK触发器实现的功能如下表所示：

| J    | K    | 功能 | Q    |
| ---- | ---- | ---- | ---- |
| 0    | 0    | 保持 | Q    |
| 0    | 1    | 置0  | 0    |
| 1    | 0    | 置1  | 1    |
| 1    | 1    | 翻转 | ~Q   |

“JKFF_2.v”中，实现的是带有异步复位端的JK触发器（复位端1有效），当复位信号rst由0变为1时，输出Q立刻置0.