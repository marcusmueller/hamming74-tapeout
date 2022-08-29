module hm_enc( input wire [3:0] in, output wire[6:0] out);
   assign out[0] = in[0] ^ in[1] ^ in[3];
   assign out[1] = in[0] ^ in[2] ^ in[3];
   assign out[2] = in[0];
   assign out[3] = in[1] ^ in[2] ^ in[3];
   assign out[4] = in[1];
   assign out[5] = in[2];
   assign out[6] = in[3];
endmodule // hm_enc

module user_module_hm
  (
   input wire [7:0]  io_in,
   output wire [7:0] io_out
   );
   wire [6:0]        encoded;
   wire [3:0]        infoword = io_in[3:0];
   wire              enc_dec = io_in[7];
   
   hm_enc encoder (.in(infoword), .out(encoded));
   assign io_out[6:0] = enc_dec ? encoded : 0;
   
endmodule // user_module_hm
