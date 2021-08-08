module exp9(Z,led,W,PS3,MHz,Reset); //以 Gate Level 設計有限狀態機模組宣告
 input W,PS3,MHz,Reset; //輸入為W,PS3,MHz,Reset
 output Z,led; //輸出為Z,led
 reg a,b; //保留a,b的值到下一次指定新值
 wire A,B,clk,kHz; //邏輯電路圖中會用到4條線連接不同模組
 div10000 d1(kHz,MHz); //使用除頻器1的模組，輸出為kHz，輸入為MHz
 debounce d2(clk,kHz,PS3); //使用消除彈跳模組，輸出為clk，輸入為kHz,PS3
 always@(posedge clk or negedge Reset) //當clk正緣觸發或Reset負緣觸發，底下的Behavioral Model的敘述會被執行
  if(~Reset) //如果Reset反相為true，執行以下敘述
   begin //開始
    a=0; //a的值變為0
    b=0; //b的值變為0
   end //結束
  else //其他情況
   begin //開始
    a=A; //a的值變為A的值
    b=B; //b的值變為B的值
   end //結束
 assign A=b; //宣告A的值變為b的值
 assign B=W; //宣告B的值變為W的值
 xor x1(Z,a,b); //邏輯閘XOR，輸入為a,b，輸出為Z
 assign led=1'b1; //宣告led的值為1
endmodule  //結束模組

module div10000(out,in); //除頻器除以10000的模組宣告
 input in; //輸入為in
 output reg out; //保留輸出out的值到下一次指定新值
 reg [12:0]counter; //保留輸出counter[0]~[12]的值到下一次指定新值
 always@(posedge in) //當in正緣觸發時，底下的Behavioral Model的敘述會被執行
  if(counter == 13'd4999) //如果counter的值等於4999時，執行以下敘述
   begin //開始
    counter<=13'd0; //counter的值變為0
    out<=~out; //out反相
   end //結束
  else //其他情況
   counter<=counter+13'd1; //conuter的值+1
endmodule //結束模組
 
module debounce(out,kHz,in); //消除彈跳的模組宣告
 input in,kHz; //輸入為in,kHz
 output out; //輸出為out
 reg [10:0]d; //保留d[0]~d[10]的值到下一次指定新值
 always@(posedge kHz) //當kHz正緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //開始
   d[10]<=d[9]; //d[10]的值變為d[9]的值
   d[9]<=d[8]; //d[9]的值變為d[8]的值
   d[8]<=d[7]; //d[8]的值變為d[7]的值
   d[7]<=d[6]; //d[7]的值變為d[6]的值
   d[6]<=d[5]; //d[6]的值變為d[5]的值
   d[5]<=d[4]; //d[5]的值變為d[4]的值
   d[4]<=d[3]; //d[4]的值變為d[3]的值
   d[3]<=d[2]; //d[3]的值變為d[2]的值
   d[2]<=d[1]; //d[2]的值變為d[1]的值
   d[1]<=d[0]; //d[1]的值變為d[0]的值
   d[0]<=in; //d[0]的值變為in的值
  end //結束
  and(out,d[10],d[9],d[8],d[7],d[6],d[5],d[4],d[3],d[2],d[1],d[0]); //邏輯閘AND，輸入為d[0]~d[10]；輸出為out
 endmodule  //消除彈跳的模組結束 