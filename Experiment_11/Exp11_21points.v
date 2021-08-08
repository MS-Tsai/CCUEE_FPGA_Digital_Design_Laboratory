module exp11(seg, DE, win, led, MHz, Reset, Result, PS3, PS4, P1Hide, P2Hide);
 input MHz, Reset, Result, PS3, PS4, P1Hide, P2Hide;
 output led;
 output [6:0]seg;
 output [2:0]DE;
 output [11:0]win;
 wire kHz, Hz100, P1Add, P2Add, P1count, P2count;
 wire [4:0]P1Sum, P2Sum;
 wire [3:0]cards, P1First, P2First;
 
 div10000 d1(kHz, MHz);
 div10    d2(Hz100, kHz);
 debounce d3(P1Add, kHz, PS3);
 debounce d4(P2Add, kHz, PS4);
 
 Addcards a1(P1Sum, P2Sum, P1count, P2count, P1First, P2First, cards, P1Add, P2Add, Hz100, Reset);
 
 showCard s1(DE, seg, P1Sum, P2Sum, P1First, P2First, P1Hide, P2Hide, kHz, cards);
 showWin  s2(win, Result, P1Sum, P2Sum);
 
 assign led=1'b1;
endmodule 

module Addcards(P1Sum, P2Sum, P1count, P2count, P1First, P2First, cards, P1Add, P2Add, Hz100, Reset);
 input P1Add, P2Add, Hz100, Reset;
 output reg [4:0]P1Sum, P2Sum;
 output reg [3:0]cards, P1First, P2First;
 output reg P1count, P2count;
 always@(posedge P1Add, posedge P2Add, posedge Hz100, negedge Reset)
  begin
   if(~Reset)
    begin
     P1Sum<=0;
     P2Sum<=0;
     P1First<=0;
     P2First<=0;
     P1count<=0;
     P2count<=0;
    end
   else
    begin
     if(P1Add == 1)
      begin
       if(P1Sum <= 5'd21)
        begin
         if(P1count == 0)
          begin
           random(P1First);
           P1count<=1;
          end
         else
          begin
           random(cards);
           P1Sum<=P1Sum+cards;
          end
        end
      end
     else if(P2Add == 1)
      begin
       if(P2Sum <= 5'd21)
        begin
         if(P2count == 0)
          begin
           random(P2First);
           P1count<=1;
          end
         else
          begin
           random(cards);
           P2Sum<=P2Sum+cards;
          end
        end
      end
    end
  end
  
  task random;
  output reg [3:0]counter;
   if(counter == 4'd10)
    counter<=4'd1;
   else
    counter<=counter+4'd1;
 endtask 
endmodule 

module showWin(win, Result, P1Sum, P2Sum);
 input Result, P1Sum, P2Sum;
 output reg [11:0]win;
 always@(negedge Result)
  if(~Result)
   begin
    if(P1Sum > P2Sum && P1Sum <=5'd21)
     win = 12'b100_000_000_000;
    else if(P1Sum < P2Sum && P2Sum <=5'd21)
     win = 12'b000_000_000_001;
    else
     win = 12'b011_111_111_110;
   end
endmodule 

module showCard(DE, seg, P1Sum, P2Sum, P1First, P2First, P1Hide, P2Hide, kHz, cards);
 input kHz;
 input [4:0]P1Sum,P2Sum;
 input [3:0]cards,P1First,P2First,P1Hide,P2Hide;
 output reg [2:0]DE;
 output reg [6:0]seg;
 reg [3:0]temp;
 always@(posedge kHz)
  begin
   if(DE == 3'd5)
    DE<=3'd0;
   else
    begin
     case(DE)
      3'd0:
       begin
        if(P1Hide == 0)
         segment(cards, seg);
        else
         segment(P1First, seg);
       end
      3'd1:
       begin
        temp=P1Sum/10;
        segment(temp, seg);
       end
      3'd2:
       begin
        temp=P1Sum%10;
        segment(temp, seg);
       end
      3'd3:
       begin
        if(P2Hide == 0)
         segment(cards, seg);
        else
         segment(P2First, seg);
       end
      3'd4:
       begin
        temp=P2Sum/10;
        segment(temp, seg);
       end
      3'd5:
       begin
        temp=P2Sum%10;
        segment(temp, seg);
       end
     endcase
     DE<=DE+3'd1;
   end
  end

 task segment;
  input [3:0]number;
  output reg [6:0]out;
   case(number)
    4'd0:out=7'b1111_110;
    4'd1:out=7'b0110_000; 
    4'd2:out=7'b1101_101; 
    4'd3:out=7'b1111_001; 
    4'd4:out=7'b0110_011; 
    4'd5:out=7'b1011_011; 
    4'd6:out=7'b1011_111; 
    4'd7:out=7'b1110_000; 
    4'd8:out=7'b1111_111; 
    4'd9:out=7'b1111_011; 
    default:out=7'b0001_111;
   endcase
 endtask 
endmodule 

module debounce(out, kHz, in);
 input kHz, in;
 output out;
 reg [10:0]d;
 always@(posedge kHz)
  begin
   d[10]<=d[9];
   d[9]<=d[8];
   d[8]<=d[7];
   d[7]<=d[6];
   d[6]<=d[5];
   d[5]<=d[4];
   d[4]<=d[3];
   d[3]<=d[2];
   d[2]<=d[1];
   d[1]<=d[0];
   d[0]<=in;
  end
 and(out,d[10],d[9],d[8],d[7],d[6],d[5],d[4],d[3],d[2],d[1],d[0]);
endmodule  

module div10000(out, in);
 input in;
 output reg out;
 reg [12:0]counter;
 always@(posedge in)
  if(counter==13'd4999)
   begin
    counter<=13'd0;
    out<=~out;
   end
  else
   counter<=counter+13'd1;
endmodule 

module div10(out, in);
 input in;
 output reg out;
 reg [2:0]counter;
 always@(posedge in)
  if(counter==3'd4)
   begin
    counter<=3'd0;
    out<=~out;
   end
  else
   counter<=counter+3'd1;
endmodule  