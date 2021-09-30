/* Generated by Yosys 0.8 (git sha1 5706e90) */

(* src = "word.v:1" *)
module \$paramod\word\BUS_SIZE=16\WORD_SIZE=4 (clk, reset, data_input, data_out, output_control);
  (* src = "word.v:9" *)
  wire [3:0] _00_;
  (* src = "word.v:9" *)
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  (* src = "word.v:3" *)
  input clk;
  (* src = "word.v:5" *)
  input [3:0] data_input;
  (* src = "word.v:6" *)
  output [3:0] data_out;
  (* src = "word.v:7" *)
  output output_control;
  (* src = "word.v:4" *)
  input reset;
  NAND _10_ (
    .A(data_input[0]),
    .B(reset),
    .Y(_02_)
  );
  NOT _11_ (
    .A(_02_),
    .Y(_00_[0])
  );
  NAND _12_ (
    .A(reset),
    .B(data_input[1]),
    .Y(_03_)
  );
  NOT _13_ (
    .A(_03_),
    .Y(_00_[1])
  );
  NAND _14_ (
    .A(reset),
    .B(data_input[2]),
    .Y(_04_)
  );
  NOT _15_ (
    .A(_04_),
    .Y(_00_[2])
  );
  NAND _16_ (
    .A(reset),
    .B(data_input[3]),
    .Y(_05_)
  );
  NOT _17_ (
    .A(_05_),
    .Y(_00_[3])
  );
  NOR _18_ (
    .A(data_input[2]),
    .B(data_input[3]),
    .Y(_06_)
  );
  NOR _19_ (
    .A(data_input[0]),
    .B(data_input[1]),
    .Y(_07_)
  );
  NAND _20_ (
    .A(_06_),
    .B(_07_),
    .Y(_08_)
  );
  NAND _21_ (
    .A(reset),
    .B(_08_),
    .Y(_09_)
  );
  NOT _22_ (
    .A(_09_),
    .Y(_01_)
  );
  (* src = "word.v:9" *)
  DFF _23_ (
    .C(clk),
    .D(_00_[0]),
    .Q(data_out[0])
  );
  (* src = "word.v:9" *)
  DFF _24_ (
    .C(clk),
    .D(_00_[1]),
    .Q(data_out[1])
  );
  (* src = "word.v:9" *)
  DFF _25_ (
    .C(clk),
    .D(_00_[2]),
    .Q(data_out[2])
  );
  (* src = "word.v:9" *)
  DFF _26_ (
    .C(clk),
    .D(_00_[3]),
    .Q(data_out[3])
  );
  (* src = "word.v:9" *)
  DFF _27_ (
    .C(clk),
    .D(_01_),
    .Q(output_control)
  );
endmodule

(* top =  1  *)
(* src = "bus_synth.v:2" *)
module bus_synth(clk, reset, data_input, data_out, output_control);
  (* src = "bus_synth.v:4" *)
  input clk;
  (* src = "bus_synth.v:6" *)
  input [15:0] data_input;
  (* src = "bus_synth.v:7" *)
  output [15:0] data_out;
  (* src = "bus_synth.v:8" *)
  output [3:0] output_control;
  (* src = "bus_synth.v:5" *)
  input reset;
  (* src = "bus_synth.v:13" *)
  \$paramod\word\BUS_SIZE=16\WORD_SIZE=4  \MEM[0].bins  (
    .clk(clk),
    .data_input(data_input[3:0]),
    .data_out(data_out[15:12]),
    .output_control(output_control[3]),
    .reset(reset)
  );
  (* src = "bus_synth.v:13" *)
  \$paramod\word\BUS_SIZE=16\WORD_SIZE=4  \MEM[1].bins  (
    .clk(clk),
    .data_input(data_input[7:4]),
    .data_out(data_out[11:8]),
    .output_control(output_control[2]),
    .reset(reset)
  );
  (* src = "bus_synth.v:13" *)
  \$paramod\word\BUS_SIZE=16\WORD_SIZE=4  \MEM[2].bins  (
    .clk(clk),
    .data_input(data_input[11:8]),
    .data_out(data_out[7:4]),
    .output_control(output_control[1]),
    .reset(reset)
  );
  (* src = "bus_synth.v:13" *)
  \$paramod\word\BUS_SIZE=16\WORD_SIZE=4  \MEM[3].bins  (
    .clk(clk),
    .data_input(data_input[15:12]),
    .data_out(data_out[3:0]),
    .output_control(output_control[0]),
    .reset(reset)
  );
endmodule
