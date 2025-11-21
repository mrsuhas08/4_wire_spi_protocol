module spi_top(clk, rst, start, m_data_in, m_mosi, sclk, cs,
               s_miso, m_data_out, s_data_out);
    input clk,rst,start;
    input [7:0]m_data_in;
    output sclk;
    output cs;
    output m_mosi, s_miso;
    output [7:0]m_data_out,s_data_out;
    
    wire miso_w,mosi_w;
      
    spi_mr mr(.clk(clk), .rst(rst), .start(start), .data_in(m_data_in), .miso(miso_w), 
              .mosi(mosi_w), .sclk(sclk), .cs(cs), .data_out(m_data_out));
                   
    spi_sl sl(.rst(rst), .mosi(mosi_w), .miso(miso_w), .sclk(sclk), .cs(cs), .data_out(s_data_out));
    
    assign m_mosi=mosi_w;
    assign s_miso=miso_w;

    
endmodule
