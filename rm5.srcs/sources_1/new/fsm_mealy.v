module fsm_mealy(
    input wire clk,
    input wire reset,
    input wire ce,            // Diaktifkan oleh tombol push-button Enter
    input wire w,             // Input w (Switch0)
    output reg y,             // Output y (LED LD0)
    output wire [1:0] state_display
);

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] curr, next;

    assign state_display = curr;

    // Sequential Block
    always @(posedge clk or posedge reset) begin
        if (reset) 
            curr <= S0;
        else if (ce) 
            curr <= next;
    end

    // Combinational Block
    always @(*) begin
        next = curr;
        y = 1'b0; // Default output 0
        
        case (curr)
            S0: begin
                next = (w) ? S1 : S0;
                y = 1'b0;
            end
            S1: begin
                next = (w) ? S2 : S1;
                y = 1'b0;
            end
            S2: begin
                next = (w) ? S3 : S2;
                y = 1'b0;
            end
            S3: begin
                next = (w) ? S3 : S0;
                // MEALY: Output y bergantung pada Current State (S3) DAN Input Primer (w)
                if (w == 1'b1) 
                    y = 1'b1; // Sinyal darurat antrian overload!
                else 
                    y = 1'b0;
            end
            default: next = S0;
        endcase
    end
endmodule