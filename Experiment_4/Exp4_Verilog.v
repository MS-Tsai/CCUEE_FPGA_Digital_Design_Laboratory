module exp4(f,seg,led,DE,A,B,S); //ALU�Ҳիŧi
 input [3:0]A,B; //��J��4-bits�@8�Ӽ�A[0]~A[3],B[0]~B[3]
 input [1:0]S; //��J��2-bits�@2�Ӽ�S[0],S[1]
 output [4:0]f; //��X��5-bits�@5�Ӽ�f[0]~f[4]
 output [6:0]seg; //��X��7-bits�@7�Ӽ�seg[0]~seg[6]
 output [2:0]DE; //��X��3-bits�@3�Ӽ�DE[0]~DE[2]
 output led; //��XLED�O
 wire [4:0]x1,x2,x4; //ALU���޿�q���Ϥ��|�Ψ�15���u�s�����P���Ҳ�
 wire [7:0]x3; //ALU���޿�q���Ϥ��|�Ψ�8���u�s�����P���Ҳ�
 wire [3:0]out; //ALU���޿�q���Ϥ��|�Ψ�4���u�s�����P���Ҳ�
 reg [6:0]seg; //�O�dseg[0]~seg[6]������U�@�����w�s��

 assign x1=A+B; //�ŧix1���ȵ���A+B����
 assign x2=A<<1; //�ŧix2���ȵ���A*2����
 assign x3=A*B; //�ŧix3���ȵ���A*B����
 assign x4=A&B; //�ŧix4���ȵ���A&B����

 assign f=S[1]?(S[0]?(x3/10):(x2/10)):(S[0]?(x1/10):x4); 
   //��S[1]=1�ɡA�BS[0]=1�ɡAf=x3/10;��S[1]=1�ɡA�BS[0]=0�ɡAf=x2/10;
   //��S[1]=0�ɡA�BS[0]=1�ɡAf=x1/10;��S[1]=0�ɡA�BS[0]=0�ɡAf=x4
 assign out=S[1]?(S[0]?(x3%10):(x2%10)):(S[0]?(x1%10):10); 
   //��S[1]=1�ɡA�BS[0]=1�ɡAout=x3%10;��S[1]=1�ɡA�BS[0]=0�ɡAout=x2%10;
   //��S[1]=0�ɡA�BS[0]=1�ɡAout=x1%10;��S[1]=0�ɡA�BS[0]=0�ɡAout=10

 always@(out) //��out���Ȧ����ܮɡA���U��Behavioral Model���ԭz�|�Q����
   case(out) //�H�ۤ��P��out�ȡA����H�U�ԭz
     4'd0:seg=7'b1111_110; //out=0�ɡA�ϤC�q��ܾ����0
     4'd1:seg=7'b0110_000; //out=1�ɡA�ϤC�q��ܾ����1
     4'd2:seg=7'b1101_101; //out=2�ɡA�ϤC�q��ܾ����2
     4'd3:seg=7'b1111_001; //out=3�ɡA�ϤC�q��ܾ����3
     4'd4:seg=7'b0110_011; //out=4�ɡA�ϤC�q��ܾ����4
     4'd5:seg=7'b1011_011; //out=5�ɡA�ϤC�q��ܾ����5
     4'd6:seg=7'b1011_111; //out=6�ɡA�ϤC�q��ܾ����6
     4'd7:seg=7'b1110_000; //out=7�ɡA�ϤC�q��ܾ����7
     4'd8:seg=7'b1111_111; //out=8�ɡA�ϤC�q��ܾ����8
     4'd9:seg=7'b1111_011; //out=9�ɡA�ϤC�q��ܾ����9
     4'd10:seg=7'b1110_111; //out=10�ɡA�ϤC�q��ܾ����A
   endcase  //case����

 assign led=1'b1; //�ŧiLED�O��1�줸,�G�i��,�ƭȬ�1
 assign DE[0]=0; //�ŧiDE[0]���Ȭ�0
 assign DE[1]=0; //�ŧiDE[1]���Ȭ�0
 assign DE[2]=0; //�ŧiDE[2]���Ȭ�0

endmodule  //ALU�Ҳյ���