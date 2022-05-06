
//Part 1 


module n-bitRegister #(
    parameter N
) (
    input E, [1:0] FunSel, [N-1:0] I,
    output [N-1:0] Q
);

    wire [N-1:0] Q_temp;
    assign Q = Q_temp;
    always @( E) begin
        case (FunSel)
        0: begin
            Q_temp = Q - 1;
        end
        1: begin
            Q_temp = Q + 1;
        end
        2: begin
            Q_temp = I;
        end
        3: begin
            Q_temp =0;
        end
        default: begin
            Q_temp = Q_temp;
        end
        endcase
    end
    
endmodule

module RegFile (
    input [1:0] OutASel, [1:0] OutBSel, [1:0] FunSel, [3:0] RegSel, [7:0] I,
    output [7:0] OutA, [7:0] OutB
);
    n-bitRegister #(.N(8)) R1(.E(~RegSel[0]), .FunSel(FunSel), .I(I), .Q(R1_Q));
    n-bitRegister #(.N(8)) R2(.E(~RegSel[1]), .FunSel(FunSel), .I(I), .Q(R2_Q));
    n-bitRegister #(.N(8)) R3(.E(~RegSel[2]), .FunSel(FunSel), .I(I), .Q(R3_Q));
    n-bitRegister #(.N(8)) R4(.E(~RegSel[3]), .FunSel(FunSel), .I(I), .Q(R4_Q));
    wire [7:0] R1_Q;
    wire [7:0] R2_Q;
    wire [7:0] R3_Q;
    wire [7:0] R4_Q;
    //wire [3:0] R_En;

    wire [7:0] OutA_temp, OutB_temp;
    assign OutA = OutA_temp;
    assign OutB = OutB_temp;
    always@(OutASel) begin
        case (OutASel)
        0: begin
            OutA_temp = R1_Q;
        end
        1: begin
            OutA_temp = R2_Q;
        end
        2: begin
            OutA_temp = R3_Q;
        end
        3: begin
            OutA_temp = R4_Q;
        end
        default: begin
            OutA_temp = OutA_temp;
        end
        endcase
    end
    always@(OutBSel) begin
        case (OutBSel)
        0: begin
            OutB_temp = R1_Q;
        end
        1: begin
            OutB_temp = R2_Q;
        end
        2: begin
            OutB_temp = R3_Q;
        end
        3: begin
            OutB_temp = R4_Q;
        end
        default: begin
            OutB_temp = OutB_temp;
        end
        endcase
    end

endmodule

module ARF (
    input [1:0] OutCSel, [1:0] OutDSel, [1:0] FunSel, [3:0] RegSel, [7:0] I,
    output [7:0] OutC, [7:0] OutD
);

    n-bitRegister #(.N(8)) PC(.E(~RegSel[0]), .FunSel(FunSel), .I(I), .Q(PC_Q));
    n-bitRegister #(.N(8)) AR(.E(~RegSel[1]), .FunSel(FunSel), .I(I), .Q(AR_Q));
    n-bitRegister #(.N(8)) SP(.E(~RegSel[2]), .FunSel(FunSel), .I(I), .Q(SP_Q));

    wire [7:0] PC_Q;
    wire [7:0] AR_Q;
    wire [7:0] SP_Q;

    wire [7:0] OutC_temp, OutC_temp;
    assign OutC = OutC_temp;
    assign OutD = OutD_temp;

    always@(OutDSel) begin
        case (OutDSel)
        0: begin
            OutD_temp = PC_Q;
        end
        1: begin
            OutD_temp = PC_Q;
        end
        2: begin
            OutD_temp = AR_Q;
        end
        3: begin
            OutD_temp = SP_Q;
        end
        default: begin
            OutD_temp = OutD_temp;
        end
        endcase
    end

    
endmodule

module IR (
    input NL/H, En, [1:0] FunSel, [7:0] I,
    output [15:0] IRout
);
    wire [7:0] I_temp;

    n-bitRegister #(.N(16)) IR(.E(En), .FunSel(FunSel), .I(I), .Q(IR_Q));
    wire [15:0] IR_Q;
    assign IRout = IR_Q;
    
endmodule