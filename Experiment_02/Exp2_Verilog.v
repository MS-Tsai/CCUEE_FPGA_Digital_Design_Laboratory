module exp2(s,cout,led,x,y,cin);//4-bits全加器模組宣告
 input [3:0]x,y;//輸入為4-bits共8個加數x[0]~x[3],y[0]~y[3]
 input cin;//另一個輸入為進位值cin
 output [3:0]s;//輸出為4-bits本位和s[0]~s[3]
 output cout,led;//另一個輸出為高位進位cout
 wire k;//4-bits全加器的邏輯電路圖中會用到一條線連接不同的模組
 F2 z3(s[1:0],k,x[1:0],y[1:0],cin);//使用2-bits全加器的模組F2 s[0]~s[1],j為輸出；x[0]~x[1],y[0]~y[1],ci為輸入
 F2 z4(s[3:2],cout,x[3:2],y[3:2],k);//再使用一次2-bits全加器的模組F2 s[2]~s[3],j為輸出；x[2]~x[3],y[2]~y[3],ci為輸入
 assign led=1'b1;//賦值給led為1位元2進制值
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
