module spi_mr(clk, rst, start, data_in, miso, mosi, sclk, cs, data_out);
    input clk,rst,start;
    input [7:0]data_in;
    input miso;
    output reg mosi;
    output reg sclk;
    output reg cs;
    output reg [7:0]data_out;
    
    reg [3:0]count; 
    reg [7:0]shift;
    reg prev;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            sclk<=0; 
        else if (prev)
            sclk <= ~sclk; 
        else
            sclk<=0;
    end
    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            cs<=1;
            mosi<=0; 
            count<=8; 
            shift<=0; 
            data_out<=0;
            prev<=0; 
        end 
        else begin 
            if(start) begin 
                cs<=0; 
                prev<=1; 
                count<=8; 
                shift<=data_in;
            end 
            else if(!cs) begin
                if(sclk==0)begin
                    count<=8;
                    mosi<=shift[7];
                    shift<={shift[6:0],miso};
                    count<=count-1;
                end
                if(count==0)begin 
                    sclk<=0; 
                    cs<=1; 
                    data_out<={shift[6:0],miso}; 
                    prev<=0; 
                end 
            end 
        end 
    end 
endmodule
