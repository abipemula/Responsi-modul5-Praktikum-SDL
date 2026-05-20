module debouncer (
    input wire clk,
    input wire btn_in,
    output reg btn_pulse,
    output reg btn_level
);
    reg [19:0] count;
    reg btn_stable;
    reg btn_sync_0, btn_sync_1;
    reg btn_prev;

    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;

        if (btn_sync_1 == btn_stable) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if (count == 20'd1_000_000) begin
                btn_stable <= btn_sync_1;
            end
        end
        btn_level <= btn_stable;
        btn_prev <= btn_stable;
        btn_pulse <= (btn_stable && !btn_prev);
    end
endmodule