module mips32(clk1, clk2);
// Find the new mips32CPU here: https://github.com/oriod-malo/Custom-MIPS32-CPU
			input wire clk1, clk2;
			
			// IF_ID_ registers
			reg [31:0]	PC, IF_ID_IR, IF_ID_NPC;
			
			// ID_EX_ registers
			reg [31:0]	ID_EX_IR, ID_EX_NPC, ID_EX_A, ID_EX_B, ID_EX_Imm;
			
			// EX_MEM registers
			reg [31:0]	EX_MEM_IR, EX_MEM_ALUOut, EX_MEM_B;
			reg			EX_MEM_cond;
			
			// MEM_WB_ registers
			reg [31:0]	MEM_WB_IR, MEM_WB_ALUOut, MEM_WB_LMD;
			
			
			// Type variables
			reg [2:0] ID_EX_type, EX_MEM_type, MEM_WB_type;
			
			
			reg [31:0] Reg [31:0];		// Register Bank 32x32
			reg [31:0] Mem [1023:0];	// Memory Bank 1024x32
			
			// Assembly Commands
			parameter	ADD = 6'b000_000, SUB = 6'b000_001, AND = 6'b000_010, OR = 6'b000_011,
							SLT = 6'b000_100, MUL = 6'b000_101, HLT = 6'b111_111, LW = 6'b001_000,
							SW = 6'b001_001, ADDI = 6'b001_010, SUBI = 6'b001_011, SLTI = 6'b001_100,
							BNEQZ = 6'b001_101, BEQZ = 6'b001_110;
			
			// Command types (3-bit) [2:0]
			parameter	RR_ALU = 3'b000, RM_ALU = 3'b001, LOAD = 3'b010, STORE = 3'b011,
							BRANCH = 3'b100, HALT = 3'b101;
							
			reg HALTED;				// set after HLT instruction is completed (in WB stage)
			reg TAKEN_BRANCH;		// required to disable instructions after branch
			
			
			
			/*______________________ Different Stages of the Pipeline __________________*/
			
			// The Instruction Fetch (IF) Stage
			
			always @ (posedge clk1)
				if(HALTED == 0) begin // we fetch only if halt is not set
					if( ((EX_MEM_IR[31:26] == BEQZ) && (EX_MEM_cond == 1)) ||
						 ((EX_MEM_IR[31:26] == BNEQZ) && (EX_MEM_cond == 0)) ) // check whether a branch is taken
						begin
							IF_ID_IR			<= #2 Mem[EX_MEM_ALUOut];
							TAKEN_BRANCH	<= #2 1'b1;
							IF_ID_NPC		<= #2 EX_MEM_ALUOut + 1;
							PC					<= #2 EX_MEM_ALUOut + 1;
						end
				else
						begin
							IF_ID_IR			<= #2 Mem[PC];
							IF_ID_NPC		<= #2 PC + 1;
							PC					<= #2 PC + 1;
						end
				end
			
			// The Instruction Decode (ID) Stage
			
			/* We do 3 things:
			1 we decode the instruction
			2 we are pre-fetching two source registers
			3 we are sign-extending the offset */
			
			always @ (posedge clk2)
				if (HALTED == 0) begin
				
					//Rs - register
					if( IF_ID_IR[25:21] == 5'b00000)	ID_EX_A <= 0; // if R0 then assign 0 to ID_EX_A
					else ID_EX_A <= #2 Reg[IF_ID_IR[25:21]];
					//Rt - register
					if( IF_ID_IR[20:16] == 5'b00000)	ID_EX_B <= 0; // if R0 then assign 0 to ID_EX_B
					else ID_EX_B <= #2 Reg[IF_ID_IR[20:16]];

					ID_EX_NPC	<= #2 IF_ID_NPC;
					ID_EX_IR		<= #2 IF_ID_IR;
					ID_EX_Imm	<= #2 {{16{IF_ID_IR[15]}},{IF_ID_IR[15:0]}}; // 16 bit sign extension
				
					case(IF_ID_IR[31:26])
							ADD,SUB,AND,OR,SLT,MUL:		ID_EX_type <= #2 RR_ALU;
							ADDI, SUBI, SLTI:				ID_EX_type <= #2 RM_ALU;
							LW:								ID_EX_type <= #2 LOAD;
							SW:								ID_EX_type <= #2 STORE;
							BNEQZ, BEQZ:					ID_EX_type <= #2 BRANCH;
							HLT:								ID_EX_type <= #2 HALT;
							default:							ID_EX_type <= #2 HALT;
					endcase
				end
			
			// The Execute (EX) stage
			always @(posedge clk1)
				if (HALTED == 0) begin
					EX_MEM_type		<= #2 ID_EX_type;
					EX_MEM_IR		<= #2 ID_EX_IR;
					TAKEN_BRANCH	<= #2 0; // reset the taken branch back to zero
					
					case (ID_EX_type)
							RR_ALU: 
							begin
									case(ID_EX_IR[31:26]) 
											ADD:			EX_MEM_ALUOut <=  #2 ID_EX_A + ID_EX_B;
											SUB:			EX_MEM_ALUOut <=  #2 ID_EX_A - ID_EX_B;
											AND:			EX_MEM_ALUOut <=  #2 ID_EX_A & ID_EX_B;
											OR:			EX_MEM_ALUOut <=  #2 ID_EX_A | ID_EX_B;
											SLT:			EX_MEM_ALUOut <=  #2 ID_EX_A < ID_EX_B;
											MUL:			EX_MEM_ALUOut <=  #2 ID_EX_A * ID_EX_B;
											default:		EX_MEM_ALUOut <=  #2 32'hxxxx_xxxx;
									endcase
							end
							RM_ALU: 
							begin
									case(ID_EX_IR[31:26]) 
											ADDI:			EX_MEM_ALUOut <=  #2 ID_EX_A + ID_EX_Imm;
											SUBI:			EX_MEM_ALUOut <=  #2 ID_EX_A - ID_EX_Imm;
											SLTI:			EX_MEM_ALUOut <=  #2 ID_EX_A < ID_EX_Imm;
											default:		EX_MEM_ALUOut <=  #2 32'hxxxx_xxxx;
									endcase
							end
							LOAD, STORE: begin
															EX_MEM_ALUOut	<= #2 ID_EX_A + ID_EX_Imm;
															EX_MEM_B			<= #2 ID_EX_B;
							end
							BRANCH: begin
															EX_MEM_ALUOut	<= #2 ID_EX_NPC + ID_EX_Imm;
															EX_MEM_cond		<= #2 (ID_EX_A == 0);
							end
					endcase
				
				end
			
			// The Memory (MEM) stage
			always @(posedge clk2)
				if (HALTED == 0) 
				begin
					MEM_WB_type <= #2 EX_MEM_type;
					MEM_WB_IR	<= #2 EX_MEM_IR;
						
						case(EX_MEM_type)
								RR_ALU, RM_ALU:		MEM_WB_ALUOut	<= #2 Mem[EX_MEM_ALUOut];
								LOAD:						MEM_WB_LMD		<= #2 Mem[EX_MEM_ALUOut];
								STORE:		if(TAKEN_BRANCH == 0) Mem[EX_MEM_ALUOut] <= #2 EX_MEM_B;
						endcase
				end
				
			// The Write Back (WB) stage
			always @(posedge clk1)
			begin
				if(TAKEN_BRANCH == 0) begin
					case(MEM_WB_type)
							RR_ALU:					Reg[MEM_WB_IR[15:11]] <= #2 MEM_WB_ALUOut;	//Rd
							
							RM_ALU:					Reg[MEM_WB_IR[20:16]] <= #2 MEM_WB_ALUOut;	// Rt
							
							LOAD:						Reg[MEM_WB_IR[20:16]] <= #2 MEM_WB_LMD;		// Rt
							
							HALT:						HALTED <= #2 1'b1;
					endcase
				end
			end
			
endmodule

