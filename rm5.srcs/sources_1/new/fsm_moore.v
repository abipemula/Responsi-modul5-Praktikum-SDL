module fsm_moore(
    input wire clk,
    input wire reset,
    input wire ce,            // Diaktifkan oleh tombol pemicu (Enter)
    input wire w,             // Input kendali w (Switch0)
    output reg y,             // Output y (LED LD0)
    output wire [1:0] state_display
);

    // Definisi State: S3 (3 antrian) s.d S0 (0 antrian)
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] curr, next;

    assign state_display = curr;

    // Sequential Block
    always @(posedge clk or posedge reset) begin
        if (reset) 
            curr <= S3; // Default mulai dari antrian penuh (S3)
        else if (ce) 
            curr <= next;
    end

    // Combinational Block
    always @(*) begin
        // Moore: Output y hanya bergantung pada Current State (Aktif jika Antrian Habis / S0)
        y = (curr == S0);
        
        case (curr)
            S3: next = (w) ? S2 : S3; // Jika w=1, antrian berkurang ke S2
            S2: next = (w) ? S1 : S2; // Jika w=1, antrian berkurang ke S1
            S1: next = (w) ? S0 : S1; // Jika w=1, antrian berkurang ke S0
            S0: next = (w) ? S3 : S0; // Jika w=1, reset kembali ke antrian penuh (S3)
            default: next = S3;
        endcase
    end
endmodule