module exp4(f,seg,led,DE,A,B,S); //ALU模組宣告
 input [3:0]A,B; //輸入為4-bits共8個數A[0]~A[3],B[0]~B[3]
 input [1:0]S; //輸入為2-bits共2個數S[0],S[1]
 output [4:0]f; //輸出為5-bits共5個數f[0]~f[4]
 output [6:0]seg; //輸出為7-bits共7個數seg[0]~seg[6]
 output [2:0]DE; //輸出為3-bits共3個數DE[0]~DE[2]
 output led; //輸出LED燈
 wire [4:0]x1,x2,x4; //ALU的邏輯電路圖中會用到15條線連接不同的模組
 wire [7:0]x3; //ALU的邏輯電路圖中會用到8條線連接不同的模組
 wire [3:0]out; //ALU的邏輯電路圖中會用到4條線連接不同的模組
 reg [6:0]seg; //保留seg[0]~seg[6]的直到下一次指定新值

 assign x1=A+B; //宣告x1的值等於A+B的值
 assign x2=A<<1; //宣告x2的值等於A*2的值
 assign x3=A*B; //宣告x3的值等於A*B的值
 assign x4=A&B; //宣告x4的值等於A&B的值

 assign f=S[1]?(S[0]?(x3/10):(x2/10)):(S[0]?(x1/10):x4); 
   //當S[1]=1時，且S[0]=1時，f=x3/10;當S[1]=1時，且S[0]=0時，f=x2/10;
   //當S[1]=0時，且S[0]=1時，f=x1/10;當S[1]=0時，且S[0]=0時，f=x4
 assign out=S[1]?(S[0]?(x3%10):(x2%10)):(S[0]?(x1%10):10); 
   //當S[1]=1時，且S[0]=1時，out=x3%10;當S[1]=1時，且S[0]=0時，out=x2%10;
   //當S[1]=0時，且S[0]=1時，out=x1%10;當S[1]=0時，且S[0]=0時，out=10

 always@(out) //當out的值有改變時，底下的Behavioral Model的敘述會被執行
   case(out) //隨著不同的out值，執行以下敘述
     4'd0:seg=7'b1111_110; //out=0時，使七段顯示器顯示0
     4'd1:seg=7'b0110_000; //out=1時，使七段顯示器顯示1
     4'd2:seg=7'b1101_101; //out=2時，使七段顯示器顯示2
     4'd3:seg=7'b1111_001; //out=3時，使七段顯示器顯示3
     4'd4:seg=7'b0110_011; //out=4時，使七段顯示器顯示4
     4'd5:seg=7'b1011_011; //out=5時，使七段顯示器顯示5
     4'd6:seg=7'b1011_111; //out=6時，使七段顯示器顯示6
     4'd7:seg=7'b1110_000; //out=7時，使七段顯示器顯示7
     4'd8:seg=7'b1111_111; //out=8時，使七段顯示器顯示8
     4'd9:seg=7'b1111_011; //out=9時，使七段顯示器顯示9
     4'd10:seg=7'b1110_111; //out=10時，使七段顯示器顯示A
   endcase  //case結束

 assign led=1'b1; //宣告LED燈為1位元,二進制,數值為1
 assign DE[0]=0; //宣告DE[0]的值為0
 assign DE[1]=0; //宣告DE[1]的值為0
 assign DE[2]=0; //宣告DE[2]的值為0

endmodule  //ALU模組結束