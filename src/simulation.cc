#include "hamming74_top.cc"
#include <fmt/format.h>
#include <vector>
unsigned int encode(unsigned int word) {
  return (((word & 1) ^ (word & 2) >> 1 ^ (word & 8) >> 3) << 0) |
         (((word & 1) ^ (word & 4) >> 2 ^ (word & 8) >> 3) << 1) |
         (((word & 1)) << 2) |
         (((word & 2) >> 1 ^ (word & 4) >> 2 ^ (word & 8) >> 3) << 3) |
         (((word & 2) >> 1) << 4) | (((word & 4) >> 2) << 5) |
         (((word & 8) >> 3) << 6);
}
int main() {
  using module = cxxrtl_design::p_user__module__hamming74;
  module mod;
  mod.step();
  auto &io_in = mod.p_io__in;
  auto &io_out = mod.p_io__out;
  bool enc_success = true;
  // Test encoding first
  fmt::print("Testing encoder…\n");
  for (unsigned int inp = 0; inp < 16; ++inp) {
    io_in.set<unsigned int>(1 << 7 | inp);
    mod.step();
    auto output = io_out.get<unsigned int>();
    auto encoded = encode(inp);
    bool equal = (encoded == output);
    enc_success = enc_success && equal;
    fmt::print("input: {:04b}  output: {:08b} encoded: {:08b} same: {}\n", inp,
               output, encoded, equal ? "Y" : "N");
    mod.step();
  }
  // Test decoding: encode word, modify word, decode word
  fmt::print("Testing decoder…\n");
  fmt::print("Testing unaltered codewords…\n");
  bool dec_success = true;
  for (unsigned int inp = 0; inp < 16; ++inp) {
    auto encoded = encode(inp);
    io_in.set<unsigned int>(encoded);
    mod.step();
    auto hw_out = io_out.get<unsigned int>();
    auto hw_decoded = hw_out & ((1 << 4) - 1);
    auto hw_syndrome = (hw_out & (((1 << 3) - 1) << 4)) >> 4;
    bool equal = (inp == hw_decoded);
    dec_success = dec_success && equal;
    fmt::print("input: {:04b} encoded: {:08b} decoded: {:04b} syndrome: {:03b} "
               "same: {}\n",
               inp, encoded, hw_decoded, hw_syndrome, equal ? "Y" : "N");
    mod.step();
  }
  fmt::print("Testing single bit-flip codewords…\n");
  std::vector<unsigned int> flips(7, 0);
  for (unsigned int inp = 0; inp < 16; ++inp) {
    auto encoded = encode(inp);
    for (unsigned int flippos = 0; flippos < 7; ++flippos) {
      auto encoded_flipped = encoded ^ (1 << flippos);
      io_in.set<unsigned int>(encoded_flipped);
      mod.step();
      auto hw_out = io_out.get<unsigned int>();
      auto hw_decoded = hw_out & ((1 << 4) - 1);
      auto hw_syndrome = (hw_out & (((1 << 3) - 1) << 4)) >> 4;
      bool equal = (inp == hw_decoded);
      if (not equal)
        flips[flippos]++;
      dec_success = dec_success && equal;
      if (not equal) {
        fmt::print("syn: {:03b} cw: {:07b} infow: {:04b}\n"
                   "    damaged: {:07b} decod: {:04b}\n"
                   " error patt: {:07b} error: {:04b}\n\n",
                   hw_syndrome, encoded, inp, encoded_flipped, hw_decoded,
                   encoded_flipped ^ encoded, hw_decoded ^ inp);
      }
      mod.step();
    }
  }
  for (unsigned int i = 0; i < 7; ++i) {
    fmt::print("errors after flip at pos {:d}: {:d}\n", i, flips[i]);
  }
  if (enc_success && dec_success)
    return 0;
  return (not enc_success) << 3 | (not enc_success) << 4;
}
