异步复位10进制计数器
该模块实现了带异步复位的10进制计数器。
该电路有2个一位的输入clk和reset，以及4位的输出q。clk是时钟信号，上升沿触发。reset是异步复位端，高电平有效。
当异步复位信号无效时，该计数器可以从0到9（含9）计数，周期为10。