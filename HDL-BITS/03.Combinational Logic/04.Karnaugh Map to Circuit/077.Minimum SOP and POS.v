module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
    assign out_sop = (c&d)|(!b&c&!a);
    assign out_pos = (c)&(b|!a)&(!b|d);

endmodule
