module exp11(seg, DE, win, led, MHz, Reset, Result, PS3, PS4, P1Hide, P2Hide); //21點模組宣告
 input MHz, Reset, Result, PS3, PS4, P1Hide, P2Hide; //輸入為MHz,Reset,Result,PS3,PS4,P1Hide,P2Hide
 output led; //輸出為led
 output [6:0]seg; //輸出為seg[0]~[6]
 output [2:0]DE; //輸出為DE[0]~[2]
 output [11:0]win; //輸出為win[0]~[11]
 wire kHz, Hz100, P1Add, P2Add; //用kHz,Hz100,P1Add,P2Add，4條線來連接不同模組
 wire [3:0]cards; //用cards[0]~[3]來連接不同模組
 reg [4:0]tempCard1, tempCard2, P1First, P2First, P1Sum, P2Sum; //保留tempCard1[0]~[4],tempCard2[0]~[4],P1First[0]~[4],P2First[0]~[4],P1Sum[0]~[4],P2Sum[0]~[4]的值到下一次指定新值
 reg P1count, P2count; //保留P1count,P2count的值到下一次指定新值

 div10000 d1(kHz, MHz); //使用除頻器10000的模組，輸入為MHz，輸出為kHz
 div10    d2(Hz100, kHz); //使用除頻器10的模組，輸入為kHz，輸出為Hz100
 debounce d3(P1Add, kHz, PS3); //使用消除彈跳模組，輸入為kHz,PS3，輸出為P1Add
 debounce d4(P2Add, kHz, PS4); //使用消除彈跳模組，輸入為kHz,PS4，輸出為P2Add
 
 random(cards, Hz100); //使用隨機的模組，輸入為Hz100，輸出為cards
  
 always@(posedge P1Add or negedge Reset) //當P1Add正緣觸發或Reset負緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //開始
   if(~Reset) //如果Reset反相為true，執行以下敘述
    begin //開始
     P1Sum<=0; //P1Sum的值變為0
     P1First<=0; //P1First的值變為0
     P1count<=0; //P1count的值變為0
     tempCard1<=0; //tempCard1的值變為0
    end //結束
   else //其他情況
    begin //開始
     if(P1Sum <= 5'd21) //如果P1Sum的值為21時，執行以下敘述
      begin //開始
       if(P1count == 0) //如果P1count的值為0，執行以下敘述
        begin //開始
         P1First<=cards; //P1First的值變為cards的值
         tempCard1<=5'd0;; //tempCard1的值變為0
         P1count<=1; //P1count的值變為1
        end //結束
       else //其他情況
        begin //開始
         tempCard1<=cards; //tempCard1的值變為cards的值
         P1Sum<=P1Sum+cards; //P1Sum的值變為P1Sum+cards的值
        end //結束
      end //結束
    end //結束
  end //結束
        
 always@(posedge P2Add or negedge Reset) //當P2Add正緣觸發或Reset負緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //開始
   if(~Reset) //如果Reset反相為true，執行以下敘述
    begin //開始
     P2Sum<=0; //P2Sum的值變為0
     P2First<=0; //P2First的值變為0
     P2count<=0; //P2count的值變為0
     tempCard2<=0; //tempCard2的值變為0
    end //結束
   else //其他情況
    begin //開始
     if(P2Sum <= 5'd21) //如果P2Sum的值為21時，執行以下敘述
      begin //開始
       if(P2count == 0) //如果P2count的值為時，執行以下敘述
        begin //開始
         P2First<=cards; //P2First的值變為cards的值
         tempCard2<=5'd0; //tempCard2的值變為0
         P2count<=1; //P2count的值變為0
        end //結束
       else //其他情況
        begin //開始
         tempCard2<=cards; //tempCard2的值變為cards的值
         P2Sum<=P2Sum+cards; //P2Sum的值變為P2Sum+cards的值
        end //結束
      end //結束
    end //結束
  end //結束
    
 showCard s1(DE, seg, P1Sum, P2Sum, P1First, P2First, P1Hide, P2Hide, kHz, tempCard1, tempCard2); //使用showCard模組，輸入為P1Sum,P2Sum,P1First,P2First,P1Hide,P2Hide,kHz,tempCard1,tempCard2，輸出為DE,seg
 showWin  s2(win, Result, Reset, P1Sum, P2Sum, P1First, P2First); //使用showWin模組，輸入為Result,Reset,P1Sum,P2Sum,P1First,P2First，輸出為win
 
 assign led=1'b1; //宣告led的值為1
 
endmodule  //結束模組
  
module random(counter, Hz100); //隨機的模組宣告
 input Hz100; //輸入為Hz100
 output reg [3:0]counter; //保留輸出counter[0]~[3]的值到下一次指定新值
 always@(posedge Hz100) //當Hz100正緣觸發時，底下的Behavioral Model的敘述會被執行
   if(counter == 4'd10) //如果counter的值為10時，執行以下敘述
    counter<=4'd1; //counter的值變為1
   else //其他情況
    counter<=counter+4'd1; //counter的值+1
endmodule  //結束模組

module showWin(win, Result, Reset, P1Sum, P2Sum, P1First, P2First); //決定輸贏的模組宣告
 input Result,Reset; //輸入為Result,Reset
 input [4:0]P1Sum, P2Sum, P1First, P2First; //輸入為P1Sum[0]~[4],P2Sum[0]~[4],P1First[0]~[4],P2First[0]~[4]
 output reg [11:0]win; //保留輸出win[0]~[11]的值到下一次指定新值
 wire [4:0]P1R,P2R; //用P1R[0]~[4],P2R[0]~[4]連接不同的模組
 assign P1R = P1Sum+P1First; //宣告P1R的值等於P1Sum+P1First的值
 assign P2R = P2Sum+P2First; //宣告P2R的值等於P2Sum+P2First的值
 
 always@(negedge Result or negedge Reset) //當Result正緣觸發或Reset負緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //開始
   if(~Reset) //如果Reset反相為true，執行以下敘述
    win = 12'b000_000_000_000; //win的值變為000_000_000_000
  if(~Result) //如果Result反相為true，執行以下敘述
   begin //開始
    if(P1R > 5'd21 && P2R > 5'd21) //如果P1R的值大於21且P2R的值大於21，執行以下敘述
     win = 12'b011_111_111_110; //win的值變為011_111_111_110
    else if(P1R > 5'd21) //其他如果P1R的值大於21
     win = 12'b000_000_000_001; //win的值變為000_000_000_001
    else if(P2R > 5'd21) //其他如果P2R的值大於21
     win = 12'b100_000_000_000; //win的值變為100_000_000_000
    else if(P1R > P2R) //其他如果P1R的值大於P2R的值
      win = 12'b100_000_000_000; //win的值變為100_000_000_000
    else if(P1R < P2R) //其他如果P1R的值小於P2R的值
     win = 12'b000_000_000_001; //win的值變為000_000_000_001
    else //其他情況
     win = 12'b011_111_111_110; //win的值變為011_111_111_110
   end //結束
 end //結束
endmodule  //結束模組

module showCard(DE, seg, P1Sum, P2Sum, P1First, P2First, P1Hide, P2Hide, kHz, tempCard1, tempCard2);
 input kHz, P1Hide, P2Hide; //輸入為kHz,P1Hide,P2Hide
 input [4:0]P1Sum, P2Sum, tempCard1, tempCard2, P1First,P2First; //輸入為P1Sum[0]~[4],P2Sum[0]~[4],tempCard1[0]~[4],tempCard2[0]~[4],P1First[0]~[4],P2First[0]~[4]
 output reg [2:0]DE; //保留輸出DE[0]~[2]的值到下一次指定新值
 output reg [6:0]seg; //保留輸出seg[0]~[6]的值到下一次指定新值
 reg [4:0]temp1, temp2, temp3, temp4, number; //保留temp1[0]~[4],temp2[0]~[4],temp3[0]~[4],temp4[0]~[4], number[0]~[4]的值到下一次指定新值
 always@(posedge kHz) //當kHz正緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //開始
   if(DE == 3'b110) //如果DE的值為6時，執行以下敘述
    DE<=3'b000; //DE的值變為0
   else //其他情況
    DE<=DE+3'b001; //DE的值+1
 end //結束
 
 always@(*) //當裡面的值變動時，底下的Behavioral Model的敘述會被執行
  case(DE) //當DE的值為true時，執行以下敘述
   3'b000: //DE的值為0
    begin //開始
     if(P1Hide == 0) //如果P1Hide的值為0，執行以下敘述
      number<=tempCard1; //number的值變為tempCard1的值
     else //其他情況
      number<=P1First; //number的值變為P1First的值
    end //結束
   3'b001: //DE的值為1
    begin //開始
     number<=P1Sum/5'd10; //number的值變為P1Sum/10的值
    end //結束
   3'b010: //DE的值為2
    begin //開始
     number<=P1Sum%5'd10; //number的值變為P1Sum%10的值
    end //結束
   3'b011: //DE的值為3
    begin //開始
     if(P2Hide == 0) //如果P2Hide的值為0，執行以下敘述
      number<=tempCard2; //number的值變為tempCard2的值
     else //其他情況
      number<=P2First; //number的值變為P2First的值
    end //結束
   3'b100: //DE的值為4
    begin //開始
     number<=P2Sum/5'd10; //number的值變為P2Sum/10的值
    end //結束
   3'b101: //DE的值為5
    begin //開始
     number<=P2Sum%5'd10; //number的值變為P2Sum%10的值
    end //結束
  endcase //結束case
  
 always@(*) //當裡面的值變動時，底下的Behavioral Model的敘述會被執行
  case(number) //當number的值為true時，執行以下敘述
   5'd0:seg=7'b1111_110; //number的值為0時，七段顯示器顯示0
   5'd1:seg=7'b0110_000; //number的值為1時，七段顯示器顯示1
   5'd2:seg=7'b1101_101; //number的值為2時，七段顯示器顯示2
   5'd3:seg=7'b1111_001; //number的值為3時，七段顯示器顯示3
   5'd4:seg=7'b0110_011; //number的值為4時，七段顯示器顯示4
   5'd5:seg=7'b1011_011; //number的值為5時，七段顯示器顯示5
   5'd6:seg=7'b1011_111; //number的值為6時，七段顯示器顯示6
   5'd7:seg=7'b1110_000; //number的值為7時，七段顯示器顯示7
   5'd8:seg=7'b1111_111; //number的值為8時，七段顯示器顯示8
   5'd9:seg=7'b1111_011; //number的值為9時，七段顯示器顯示9
  default:seg=7'b0001_111; //number的值為其他的值時，顯示倒過來的f
 endcase //結束case
endmodule   //結束模組

module debounce(out, kHz, in); //消除彈跳的模組宣告
 input kHz, in; //輸入為kHz,in
 output out; //輸出為out
 reg [10:0]d; //保留d[0]~d[10]的值到下一次指定新值
 always@(posedge kHz) //當kHz正緣觸發時，底下的Behavioral Model的敘述會執行
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
endmodule   //消除彈跳的模組結束

module div10000(out, in); //除頻器除以10000的模組宣告
 input in; //輸入為in
 output reg out; //保留輸出out的值到下一次指定新值
 reg [12:0]counter; //保留輸出counter[0]~[12]的值到下一次指定新值
 always@(posedge in) //當in正緣觸發時，底下的Behavioral Model的敘述會被執行
  if(counter==13'd4999) //如果counter的值等於4999時，執行以下敘述
   begin //開始
    counter<=13'd0; //counter的值變為0
    out<=~out; //out反相
   end //結束
  else //其他情況
   counter<=counter+13'd1; //conuter的值+1
endmodule  //結束模組

module div10(out, in); //除頻器除以10的模組宣告
 input in; //輸入為in
 output reg out; //保留輸出out的值到下一次指定新值
 reg [2:0]counter; //保留輸出counter[0]~[2]的值到下一次指定新值
 always@(posedge in) //當in正緣觸發時，底下的Behavioral Model的敘述會被執行
  if(counter==3'd4) //如果counter的值等於4時，執行以下敘述
   begin //開始
    counter<=3'd0; //counter的值變為0
    out<=~out; //out反相
   end //結束
  else //其他情況
   counter<=counter+3'd1; //conuter的值+1
endmodule   //結束模組