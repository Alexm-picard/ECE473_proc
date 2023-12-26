//instruction definitions
// (R-Type)
`define INST_ADD 8'h1
`define INST_SUB 8'h2
`define INST_XOR 8'h3
`define INST_OR 8'h4
`define INST_AND 8'h5
`define INST_SLL 8'h6
`define INST_SRL 8'h7
`define INST_SRA 8'h8
`define INST_SLT 8'h9
`define INST_SLTU 8'hA

// (I-Type)
`define INST_ADDI 8'hB
`define INST_XORI 8'hC
`define INST_ORI 8'hD
`define INST_ANDI 8'hE
`define INST_SLLI 8'hF
`define INST_SRLI 8'h10
`define INST_SRAI 8'h11
`define INST_SLTI 8'h12
`define INST_SLTIU 8'h13
`define INST_LB 8'h14
`define INST_LH 8'h15
`define INST_LW 8'h16
`define INST_LBU 8'h17
`define INST_LHU 8'h18

// (S-Type)
`define INST_SB 8'h19
`define INST_SH 8'h1A
`define INST_SW 8'h1B

// (B-Type)
`define INST_BEQ 8'h1C
`define INST_BNE 8'h1D
`define INST_BLT 8'h1E
`define INST_BGE 8'h1F
`define INST_BLTU 8'h20
`define INST_BGEU 8'h21

// (J-Type)
`define INST_JAL 8'h22
//I-Type
`define INST_JALR 8'h23

// (U-Type)
`define INST_LUI 8'h24
`define INST_AUIPC 8'h25

//I-Type, special instructions that we won't use
`define INST_ECALL 8'h26
`define INST_EBREAK 8'h27

// Type masks
`define INST_R_MASK 7'b0110011
`define INST_I_MASK 7'b0010011
`define INST_L_MASK 7'b0000011
`define INST_S_MASK 7'b0100011
`define INST_B_MASK 7'b1100011
`define INST_JAL_MASK 7'b1101111
`define INST_JALR_MASK 7'b1100111
`define INST_U_MASK 7'b0110111
`define INST_LUI_MASK 7'b0110111
`define INST_AUIPC_MASK 7'b0010111

//Type states
`define R_TYPE 3'h0
`define I_TYPE 3'h1
`define S_TYPE 3'h2
`define B_TYPE 3'h3
`define J_TYPE 3'h4
`define U_TYPE 3'h5
`define L_TYPE 3'h6

//instruction masks
`define ADD 10'h000
`define SUB {7'h20, 3'h0}
`define XOR 10'h004
`define OR  10'h006
`define AND 10'h007
`define SLL 10'h001
`define SRL 10'h005
`define SRA {7'h20, 3'h5}
`define SLT 10'h002
`define SLTU 10'h003

`define ADDI 3'h0
`define XORI 3'h4
`define ORI  3'h6
`define ANDI 3'h7
`define SLLI 3'h1
`define SRI  3'h5 //Either SRLI or SRAI
`define SLTI 3'h2
`define SLTIU 3'h3

`define LB 3'h0
`define LH 3'h1
`define LW 3'h2
`define LBU 3'h4
`define LHU 3'h5

`define SB 3'h0
`define SH 3'h1
`define SW 3'h2

`define BEQ 3'h0
`define BNE 3'h1
`define BLT 3'h4
`define BGE 3'h5
`define BLTU 3'h6
`define BGEU 3'h7

`define JALR 7'b1100111

