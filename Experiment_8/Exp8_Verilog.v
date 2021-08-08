module exp8(Z,led,MHz,PS3,W,Reset); //有限狀態機模組宣告
 input MHz,PS3,W,Reset; //輸入為MHz,PS3,W,Reset
 output Z,led; //輸出為Z,led
 wire kHz,clk; //有限狀態機的邏輯電路圖中會用到2條線連接不同模組
 reg [3:0]state,STATE; //保留state[0]~[3],STATE[0]~[3]的值到下一次指定新值
 parameter s0=4'd0,s1=4'd1,s2=4'd2,s3=4'd4,s4=4'd9,s5=4'd3,s6=4'd7,s7=4'd15; //定義固定的值s0為0,s1為1,s2為2,s3為4,s4為9,s5為3,s6為7,s7為15
 div10000 d1 (kHz,MHz); //使用除頻器1的模組，輸出為kHz，輸入為MHz
 debounce d2 (clk,PS3,kHz); //使用消除彈跳模組，輸出為clk，輸入為PS3,kHz
 always@(state,W) //當state,W的值有改變時，底下的Behavioral Model的敘述會被執行
  case(state) //state的值為true時，執行以下敘述
   s0:STATE=W?s1:s0; //當state為s0時，W=1,STATE=s1，W=0,STATE=s0
   s1:STATE=W?s5:s2; //當state為s1時，W=1,STATE=s5，W=0,STATE=s2
   s2:STATE=W?s1:s3; //當state為s2時，W=1,STATE=s1，W=0,STATE=s3
   s3:STATE=W?s4:s0; //當state為s3時，W=1,STATE=s4，W=0,STATE=s0
   s4:STATE=W?s5:s2; //當state為s4時，W=1,STATE=s5，W=0,STATE=s2
   s5:STATE=W?s6:s2; //當state為s5時，W=1,STATE=s6，W=0,STATE=s2
   s6:STATE=W?s7:s2; //當state為s6時，W=1,STATE=s7，W=0,STATE=s2
   s7:STATE=W?s7:s2; //當state為s7時，W=1,STATE=s7，W=0,STATE=s2
   default:STATE=s0; //state為其他值時，STATE=s0
  endcase //結束case
 always@(posedge clk or negedge Reset) //當clk正緣觸發或Reset負緣觸發，底下的Behavioral Model的敘述會被執行
  if(~Reset) //如果Reset反相為true，執行以下敘述
   state<=s0; //state的值變為s0
  else //其他情況
   state<=STATE; //state的值變為STATE的值
 assign Z=(state==s4 || state==s7); //宣告Z的值為state==s4且state==s7的邏輯判斷
 assign led=1'b1; //宣告led的值為1
endmodule  //結束模組    

module div10000(out,in); //除頻器除以10000的模組宣告
 input in; //輸入為in
 output reg out; //保留輸出out的值到下一次指定新值
 reg [12:0]counter; //保留輸出counter[0]~[12]的值到下一次指定新值
 always@(posedge in) //當in正緣觸發時，底下的Behavioral Model的敘述會被執行
  if(counter==4999) //如果counter的值等於4999時，執行以下敘述
   begin //開始
    counter<=0; //counter的值變為0
    out<=~out; //out反相
   end //結束
  else //其他情況
   counter<=counter+13'd1; //conuter的值+1
endmodule //結束模組

module debounce(out,in,kHz); //消除彈跳的模組宣告
 input kHz,in; //輸入為kHz,in
 output out; //輸出為out
 reg [10:0]d; //保留d[0]~d[10]的值到下一次指定新值
 always@(posedge kHz) //當kHz正緣觸發時，底下的Behavioral Model的敘述會
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