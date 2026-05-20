module display_moore(
    input wire clk,
    input wire w_in,
    input wire y_out,
    input wire [1:0] state,
    output reg [6:0] seg,
    output reg [7:0] an
);

    reg [16:0] scan;
    wire [2:0] sel = scan[16:14];

    always @(posedge clk) scan <= scan + 1;

    always @(*) begin
        an = 8'b11111111;
        an[sel] = 1'b0;
        
        case (sel)
            3'd7: seg = 7'b1100011; // 'w'
            3'd6: seg = (w_in) ? 7'b1111001 : 7'b1000000;  // Nilai X untuk w (1/0)
            3'd5: seg = 7'b0010001; // 'y'
            3'd4: seg = (y_out) ? 7'b1111001 : 7'b1000000; // Nilai X untuk y (1/0)
            3'd3: seg = 7'b0010010; // 'S'
            3'd2: seg = 7'b0000111; // 't'
            3'd1: seg = (state[1]) ? 7'b1111001 : 7'b1000000; // Digit biner pertama State (MSB)
            3'd0: seg = (state[0]) ? 7'b1111001 : 7'b1000000; // Digit biner kedua State (LSB)
            default: seg = 7'b1111111;
        endcase
    end
endmodule