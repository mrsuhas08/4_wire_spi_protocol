module spi_tb;
    reg clk,rst,start;
    reg [7:0]m_data_in;
    wire sclk;
    wire cs;
    wire m_mosi, s_miso;
    wire [7:0]m_data_out, s_data_out;

    spi_top dut(clk, rst, start, m_data_in, m_mosi, sclk, cs,
               s_miso, m_data_out, s_data_out);
               
    always #5 clk = ~clk;
    
    initial begin
        {clk, start,m_data_in}=0;
        rst=1;
        #20 rst=0;
        #10 m_data_in=8'b10101010;
        start=1;
        #10 start=0;
        #200 m_data_in=8'b01010101;
        start=1;
        #10 start=0;
        #200 m_data_in=8'b00001111;
        start=1;
        #10 start=0;
        #200 m_data_in=8'b11111111;
        start=1;
        #10 start=0;
        #400 $finish;
    end
    
endmodule
