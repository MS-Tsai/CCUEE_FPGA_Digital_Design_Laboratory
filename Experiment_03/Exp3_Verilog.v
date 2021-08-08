module exp3(P,led,A,B);//無號數乘法器模組宣告
 input [3:0]A,B;//輸入為4-bits共8個數A[0]~A[3],B[0]~B[3]
 output [7:0]P;//輸出為8-bits共8個數P[0]~P[7]
 output led;//輸出LED燈
 wire [15:0]a;//無號數乘法器的邏輯電路圖中會用到16條線連接不同的模組
 wire [9:0]s;//無號數乘法器的邏輯電路圖中會用到10條線連接不同的模組
 and a1(P[0],A[0],B[0]);//邏輯閘AND，輸入為A[0] B[0]；輸出為P[0]
 and a2(a[0],A[1],B[0]);//邏輯閘AND，輸入為A[1] B[0]；輸出為a[0]
 and a3(a[1],A[2],B[0]);//邏輯閘AND，輸入為A[2] B[0]；輸出為a[1]
 and a4(a[2],A[3],B[0]);//邏輯閘AND，輸入為A[3] B[0]；輸出為a[2]
 assign a[3]=1'b0;//宣告a[3]為1位元,2進制,數值為0
 and a5(a[4],A[0],B[1]);//邏輯閘AND，輸入為A[0] B[1]；輸出為a[4]
 and a6(a[5],A[1],B[1]);//邏輯閘AND，輸入為A[1] B[1]；輸出為a[5]
 and a7(a[6],A[2],B[1]);//邏輯閘AND，輸入為A[2] B[1]；輸出為a[6]
 and a8(a[7],A[3],B[1]);//邏輯閘AND，輸入為A[3] B[1]；輸出為a[7]
 and a9(a[8],A[0],B[2]);//邏輯閘AND，輸入為A[0] B[2]；輸出為a[8]
 and a10(a[9],A[1],B[2]);//邏輯閘AND，輸入為A[1] B[2]；輸出為a[9]
 and a11(a[10],A[2],B[2]);//邏輯閘AND，輸入為A[2] B[2]；輸出為a[10]
 and a12(a[11],A[3],B[2]);//邏輯閘AND，輸入為A[3] B[2]；輸出為a[11]
 and a13(a[12],A[0],B[3]);//邏輯閘AND，輸入為A[0] B[3]；輸出為a[12]
 and a14(a[13],A[1],B[3]);//邏輯閘AND，輸入為A[1] B[3]；輸出為a[13]
 and a15(a[14],A[2],B[3]);//邏輯閘AND，輸入為A[2] B[3]；輸出為a[14]
 and a16(a[15],A[3],B[3]);//邏輯閘AND，輸入為A[3] B[3]；輸出為a[15]
 exp2 z5(s[3:0],s[4],a[3:0],a[7:4],0);//使用4-bits全加器的模組exp2 s[0]~s[3],s[4]為輸出;a[0]~a[3],a[4]~a[7]為輸入,cin值為0
 assign P[1]=s[0];//宣告P[1]的值等於s[0]的值
 exp2 z6(s[8:5],s[9],s[4:1],a[11:8],0);//再使用4-bits全加器的模組exp2 s[5]~s[8],s[9]為輸出;s[1]~s[4],a[8]~a[11]為輸入,cin值為0
 assign P[2]=s[5];//宣告P[2]的值等於s[5]的值
 exp2 z7(P[6:3],P[7],s[9:6],a[15:12],0);//再使用4-bits全加器的模組exp2 P[3]~P[6],P[7]為輸出;s[6]~a[9],a[12]~a[15]為輸入,cin值為0
 assign led=1'b1;//宣告LED燈為1位元,二進制,數值為1
endmodule //無號數乘法器模組結束
 
module exp2(sum,cout,x,y,cin);//4-bits全加器模組宣告
 input [3:0]x,y;//輸入為4-bits共8個加數x[0]~x[3],y[0]~y[3]
 input cin;//另一個輸入為進位值cin
 output [3:0]sum;//輸出為4-bits本位和sum[0]~sum[3]
 output cout;//另一個輸出為高位進位cout
 wire k;//4-bits全加器的邏輯電路圖中會用到一條線連接不同的模組
 F2 z3(sum[1:0],k,x[1:0],y[1:0],cin);//使用2-bits全加器的模組F2 sum[0]~sum[1],j為輸出；x[0]~x[1],y[0]~y[1],ci為輸入
 F2 z4(sum[3:2],cout,x[3:2],y[3:2],k);//再使用一次2-bits全加器的模組F2 sum[2]~sum[3],j為輸出；x[2]~x[3],y[2]~y[3],ci為輸入
endmodule //4-bits全加器模組結束

module F2(s,co,a,b,ci);//2-bits全加器模組宣告
 input [1:0]a,b;//輸入為2-bits共四個加數a[0],a[1],b[0],b[1]
 input ci;//另一個輸入為進位值ci
 output [1:0]s;//輸出為2-bits本位和s[0],[1]
 output co;//另一個輸出為高位進位co
 wire j;//2-bits全加器的邏輯電路圖中會用到一條線連接不同的模組
 F1 z1(s[0],j,a[0],b[0],ci);//使用1-bit全加器的模組F1 s[0],j為輸出；a[0],b[0],ci為輸入
 F1 z2(s[1],co,a[1],b[1],j);//再使用一次1-bit全加器的模組F1 s[1],co為輸出；a[1],b[1],j為輸入
endmodule //2-bits全加器模組結束

module F1(s,cout,a,b,cin);//1-bit全加器模組宣告
 input a,b,cin;//輸入為兩個加數a b和進位值cin
 output s,cout;//輸出為本位和s和高位進位cout
 wire g,h,i;// 1-bit全加器的邏輯電路圖中會用到三條線連接不同的邏輯閘
 xor x1(g,a,b);//邏輯閘XOR，輸入為a b；輸出為g
 and a1(h,a,b);//邏輯閘AND，輸入為a b；輸出為h
 xor x2(s,g,cin);//邏輯閘XOR，輸入為g cin；輸出為s
 and a2(i,g,cin);//邏輯閘AND，輸入為g cin；輸出為i
 xor x3(cout,i,h);//邏輯閘XOR，輸入為i h；輸出為cout
endmodule //1-bit全加器模組結束
