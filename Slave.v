module spi_sl(rst, mosi, miso, sclk, cs, data_out);
    input rst; 
    input sclk;
    input cs; 
    input mosi; 
    output reg miso; 
    output reg [7:0]data_out; 
    
    reg [3:0]count; 
    reg [7:0]shift; 
    
    always @(posedge sclk or posedge rst) begin 
        if(rst) begin 
            miso<=0; 
            count<=0; 
            data_out<=0;
            shift<=0; 
        end 
        else begin 
            if(!cs) begin 
                shift<={shift[6:0],mosi}; 
                miso<=shift[7]; 
                count<=count+1; 
                
                if(count==7)begin 
                    count<=0;
                    data_out<={shift[6:0],mosi}; 
                end
            end
            else
                count<=0;
        end
    end
endmodule
