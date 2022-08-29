module hm_enc( input wire [3:0] in, output wire[6:0] out);
   assign out[0] = in[0] ^ in[1] ^ in[3];
   assign out[1] = in[0] ^ in[2] ^ in[3];
   assign out[2] = in[0];
   assign out[3] = in[1] ^ in[2] ^ in[3];
   assign out[4] = in[1];
   assign out[5] = in[2];
   assign out[6] = in[3];
endmodule // hm_enc


module hm_dec (
               input [6:0]  recv,
               output [3:0] infoword
               );
   assign infoword = decode(recv);
   wire [3:0] systematic = {recv[2], recv[4], recv[5], recv[6]};
   function [3:0] decode(input [6:0] rx);
      case(rx)
        7'b0000000 : decode=4'b0000;
        7'b1000000 : decode=4'b0000;
        7'b0100000 : decode=4'b0000;
        7'b1100000 : decode=4'b1000;
        7'b0010000 : decode=4'b0000;
        7'b1010000 : decode=4'b1000;
        7'b0110000 : decode=4'b1000;
        7'b1110000 : decode=4'b1000;
        7'b0001000 : decode=4'b0000;
        7'b1001000 : decode=4'b0100;
        7'b0101000 : decode=4'b0010;
        7'b1101000 : decode=4'b0001;
        7'b0011000 : decode=4'b1001;
        7'b1011000 : decode=4'b1010;
        7'b0111000 : decode=4'b1100;
        7'b1111000 : decode=4'b1000;
        7'b0000100 : decode=4'b0000;
        7'b1000100 : decode=4'b0100;
        7'b0100100 : decode=4'b0101;
        7'b1100100 : decode=4'b0110;
        7'b0010100 : decode=4'b1110;
        7'b1010100 : decode=4'b1101;
        7'b0110100 : decode=4'b1100;
        7'b1110100 : decode=4'b1000;
        7'b0001100 : decode=4'b0100;
        7'b1001100 : decode=4'b0100;
        7'b0101100 : decode=4'b1100;
        7'b1101100 : decode=4'b0100;
        7'b0011100 : decode=4'b1100;
        7'b1011100 : decode=4'b0100;
        7'b0111100 : decode=4'b1100;
        7'b1111100 : decode=4'b1100;
        7'b0000010 : decode=4'b0000;
        7'b1000010 : decode=4'b0011;
        7'b0100010 : decode=4'b0010;
        7'b1100010 : decode=4'b0110;
        7'b0010010 : decode=4'b1110;
        7'b1010010 : decode=4'b1010;
        7'b0110010 : decode=4'b1011;
        7'b1110010 : decode=4'b1000;
        7'b0001010 : decode=4'b0010;
        7'b1001010 : decode=4'b1010;
        7'b0101010 : decode=4'b0010;
        7'b1101010 : decode=4'b0010;
        7'b0011010 : decode=4'b1010;
        7'b1011010 : decode=4'b1010;
        7'b0111010 : decode=4'b0010;
        7'b1111010 : decode=4'b1010;
        7'b0000110 : decode=4'b1110;
        7'b1000110 : decode=4'b0110;
        7'b0100110 : decode=4'b0110;
        7'b1100110 : decode=4'b0110;
        7'b0010110 : decode=4'b1110;
        7'b1010110 : decode=4'b1110;
        7'b0110110 : decode=4'b1110;
        7'b1110110 : decode=4'b0110;
        7'b0001110 : decode=4'b0111;
        7'b1001110 : decode=4'b0100;
        7'b0101110 : decode=4'b0010;
        7'b1101110 : decode=4'b0110;
        7'b0011110 : decode=4'b1110;
        7'b1011110 : decode=4'b1010;
        7'b0111110 : decode=4'b1100;
        7'b1111110 : decode=4'b1111;
        7'b0000001 : decode=4'b0000;
        7'b1000001 : decode=4'b0011;
        7'b0100001 : decode=4'b0101;
        7'b1100001 : decode=4'b0001;
        7'b0010001 : decode=4'b1001;
        7'b1010001 : decode=4'b1101;
        7'b0110001 : decode=4'b1011;
        7'b1110001 : decode=4'b1000;
        7'b0001001 : decode=4'b1001;
        7'b1001001 : decode=4'b0001;
        7'b0101001 : decode=4'b0001;
        7'b1101001 : decode=4'b0001;
        7'b0011001 : decode=4'b1001;
        7'b1011001 : decode=4'b1001;
        7'b0111001 : decode=4'b1001;
        7'b1111001 : decode=4'b0001;
        7'b0000101 : decode=4'b0101;
        7'b1000101 : decode=4'b1101;
        7'b0100101 : decode=4'b0101;
        7'b1100101 : decode=4'b0101;
        7'b0010101 : decode=4'b1101;
        7'b1010101 : decode=4'b1101;
        7'b0110101 : decode=4'b0101;
        7'b1110101 : decode=4'b1101;
        7'b0001101 : decode=4'b0111;
        7'b1001101 : decode=4'b0100;
        7'b0101101 : decode=4'b0101;
        7'b1101101 : decode=4'b0001;
        7'b0011101 : decode=4'b1001;
        7'b1011101 : decode=4'b1101;
        7'b0111101 : decode=4'b1100;
        7'b1111101 : decode=4'b1111;
        7'b0000011 : decode=4'b0011;
        7'b1000011 : decode=4'b0011;
        7'b0100011 : decode=4'b1011;
        7'b1100011 : decode=4'b0011;
        7'b0010011 : decode=4'b1011;
        7'b1010011 : decode=4'b0011;
        7'b0110011 : decode=4'b1011;
        7'b1110011 : decode=4'b1011;
        7'b0001011 : decode=4'b0111;
        7'b1001011 : decode=4'b0011;
        7'b0101011 : decode=4'b0010;
        7'b1101011 : decode=4'b0001;
        7'b0011011 : decode=4'b1001;
        7'b1011011 : decode=4'b1010;
        7'b0111011 : decode=4'b1011;
        7'b1111011 : decode=4'b1111;
        7'b0000111 : decode=4'b0111;
        7'b1000111 : decode=4'b0011;
        7'b0100111 : decode=4'b0101;
        7'b1100111 : decode=4'b0110;
        7'b0010111 : decode=4'b1110;
        7'b1010111 : decode=4'b1101;
        7'b0110111 : decode=4'b1011;
        7'b1110111 : decode=4'b1111;
        7'b0001111 : decode=4'b0111;
        7'b1001111 : decode=4'b0111;
        7'b0101111 : decode=4'b0111;
        7'b1101111 : decode=4'b1111;
        7'b0011111 : decode=4'b0111;
        7'b1011111 : decode=4'b1111;
        7'b0111111 : decode=4'b1111;
        7'b1111111 : decode=4'b1111;
        default : decode = systematic;
      endcase
   endfunction
endmodule


module user_module_hamming74
  (
   input wire [7:0]  io_in,
   output wire [7:0] io_out
   );
   wire [6:0]        encoded;
   wire [3:0]        decoded;
   wire [3:0]        infoword = io_in[3:0];
   wire [6:0]        codeword = io_in[6:0];
   wire              enc_dec = io_in[7];
   
   hm_enc encoder (.in(infoword), .out(encoded));
   hm_dec decoder (.recv(codeword), .infoword(decoded));
   
   assign io_out[6:0] = enc_dec ? encoded : {3'b0, decoded};
   
endmodule // user_module_hm
