module exp11(seg, DE, win, led, MHz, Reset, Result, PS3, PS4, P1Hide, P2Hide); //21�I�Ҳիŧi
 input MHz, Reset, Result, PS3, PS4, P1Hide, P2Hide; //��J��MHz,Reset,Result,PS3,PS4,P1Hide,P2Hide
 output led; //��X��led
 output [6:0]seg; //��X��seg[0]~[6]
 output [2:0]DE; //��X��DE[0]~[2]
 output [11:0]win; //��X��win[0]~[11]
 wire kHz, Hz100, P1Add, P2Add; //��kHz,Hz100,P1Add,P2Add�A4���u�ӳs�����P�Ҳ�
 wire [3:0]cards; //��cards[0]~[3]�ӳs�����P�Ҳ�
 reg [4:0]tempCard1, tempCard2, P1First, P2First, P1Sum, P2Sum; //�O�dtempCard1[0]~[4],tempCard2[0]~[4],P1First[0]~[4],P2First[0]~[4],P1Sum[0]~[4],P2Sum[0]~[4]���Ȩ�U�@�����w�s��
 reg P1count, P2count; //�O�dP1count,P2count���Ȩ�U�@�����w�s��

 div10000 d1(kHz, MHz); //�ϥΰ��W��10000���ҲաA��J��MHz�A��X��kHz
 div10    d2(Hz100, kHz); //�ϥΰ��W��10���ҲաA��J��kHz�A��X��Hz100
 debounce d3(P1Add, kHz, PS3); //�ϥή����u���ҲաA��J��kHz,PS3�A��X��P1Add
 debounce d4(P2Add, kHz, PS4); //�ϥή����u���ҲաA��J��kHz,PS4�A��X��P2Add
 
 random(cards, Hz100); //�ϥ��H�����ҲաA��J��Hz100�A��X��cards
  
 always@(posedge P1Add or negedge Reset) //��P1Add���tĲ�o��Reset�t�tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //�}�l
   if(~Reset) //�p�GReset�Ϭ۬�true�A����H�U�ԭz
    begin //�}�l
     P1Sum<=0; //P1Sum�����ܬ�0
     P1First<=0; //P1First�����ܬ�0
     P1count<=0; //P1count�����ܬ�0
     tempCard1<=0; //tempCard1�����ܬ�0
    end //����
   else //��L���p
    begin //�}�l
     if(P1Sum <= 5'd21) //�p�GP1Sum���Ȭ�21�ɡA����H�U�ԭz
      begin //�}�l
       if(P1count == 0) //�p�GP1count���Ȭ�0�A����H�U�ԭz
        begin //�}�l
         P1First<=cards; //P1First�����ܬ�cards����
         tempCard1<=5'd0;; //tempCard1�����ܬ�0
         P1count<=1; //P1count�����ܬ�1
        end //����
       else //��L���p
        begin //�}�l
         tempCard1<=cards; //tempCard1�����ܬ�cards����
         P1Sum<=P1Sum+cards; //P1Sum�����ܬ�P1Sum+cards����
        end //����
      end //����
    end //����
  end //����
        
 always@(posedge P2Add or negedge Reset) //��P2Add���tĲ�o��Reset�t�tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //�}�l
   if(~Reset) //�p�GReset�Ϭ۬�true�A����H�U�ԭz
    begin //�}�l
     P2Sum<=0; //P2Sum�����ܬ�0
     P2First<=0; //P2First�����ܬ�0
     P2count<=0; //P2count�����ܬ�0
     tempCard2<=0; //tempCard2�����ܬ�0
    end //����
   else //��L���p
    begin //�}�l
     if(P2Sum <= 5'd21) //�p�GP2Sum���Ȭ�21�ɡA����H�U�ԭz
      begin //�}�l
       if(P2count == 0) //�p�GP2count���Ȭ��ɡA����H�U�ԭz
        begin //�}�l
         P2First<=cards; //P2First�����ܬ�cards����
         tempCard2<=5'd0; //tempCard2�����ܬ�0
         P2count<=1; //P2count�����ܬ�0
        end //����
       else //��L���p
        begin //�}�l
         tempCard2<=cards; //tempCard2�����ܬ�cards����
         P2Sum<=P2Sum+cards; //P2Sum�����ܬ�P2Sum+cards����
        end //����
      end //����
    end //����
  end //����
    
 showCard s1(DE, seg, P1Sum, P2Sum, P1First, P2First, P1Hide, P2Hide, kHz, tempCard1, tempCard2); //�ϥ�showCard�ҲաA��J��P1Sum,P2Sum,P1First,P2First,P1Hide,P2Hide,kHz,tempCard1,tempCard2�A��X��DE,seg
 showWin  s2(win, Result, Reset, P1Sum, P2Sum, P1First, P2First); //�ϥ�showWin�ҲաA��J��Result,Reset,P1Sum,P2Sum,P1First,P2First�A��X��win
 
 assign led=1'b1; //�ŧiled���Ȭ�1
 
endmodule  //�����Ҳ�
  
module random(counter, Hz100); //�H�����Ҳիŧi
 input Hz100; //��J��Hz100
 output reg [3:0]counter; //�O�d��Xcounter[0]~[3]���Ȩ�U�@�����w�s��
 always@(posedge Hz100) //��Hz100���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
   if(counter == 4'd10) //�p�Gcounter���Ȭ�10�ɡA����H�U�ԭz
    counter<=4'd1; //counter�����ܬ�1
   else //��L���p
    counter<=counter+4'd1; //counter����+1
endmodule  //�����Ҳ�

module showWin(win, Result, Reset, P1Sum, P2Sum, P1First, P2First); //�M�w��Ĺ���Ҳիŧi
 input Result,Reset; //��J��Result,Reset
 input [4:0]P1Sum, P2Sum, P1First, P2First; //��J��P1Sum[0]~[4],P2Sum[0]~[4],P1First[0]~[4],P2First[0]~[4]
 output reg [11:0]win; //�O�d��Xwin[0]~[11]���Ȩ�U�@�����w�s��
 wire [4:0]P1R,P2R; //��P1R[0]~[4],P2R[0]~[4]�s�����P���Ҳ�
 assign P1R = P1Sum+P1First; //�ŧiP1R���ȵ���P1Sum+P1First����
 assign P2R = P2Sum+P2First; //�ŧiP2R���ȵ���P2Sum+P2First����
 
 always@(negedge Result or negedge Reset) //��Result���tĲ�o��Reset�t�tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //�}�l
   if(~Reset) //�p�GReset�Ϭ۬�true�A����H�U�ԭz
    win = 12'b000_000_000_000; //win�����ܬ�000_000_000_000
  if(~Result) //�p�GResult�Ϭ۬�true�A����H�U�ԭz
   begin //�}�l
    if(P1R > 5'd21 && P2R > 5'd21) //�p�GP1R���Ȥj��21�BP2R���Ȥj��21�A����H�U�ԭz
     win = 12'b011_111_111_110; //win�����ܬ�011_111_111_110
    else if(P1R > 5'd21) //��L�p�GP1R���Ȥj��21
     win = 12'b000_000_000_001; //win�����ܬ�000_000_000_001
    else if(P2R > 5'd21) //��L�p�GP2R���Ȥj��21
     win = 12'b100_000_000_000; //win�����ܬ�100_000_000_000
    else if(P1R > P2R) //��L�p�GP1R���Ȥj��P2R����
      win = 12'b100_000_000_000; //win�����ܬ�100_000_000_000
    else if(P1R < P2R) //��L�p�GP1R���Ȥp��P2R����
     win = 12'b000_000_000_001; //win�����ܬ�000_000_000_001
    else //��L���p
     win = 12'b011_111_111_110; //win�����ܬ�011_111_111_110
   end //����
 end //����
endmodule  //�����Ҳ�

module showCard(DE, seg, P1Sum, P2Sum, P1First, P2First, P1Hide, P2Hide, kHz, tempCard1, tempCard2);
 input kHz, P1Hide, P2Hide; //��J��kHz,P1Hide,P2Hide
 input [4:0]P1Sum, P2Sum, tempCard1, tempCard2, P1First,P2First; //��J��P1Sum[0]~[4],P2Sum[0]~[4],tempCard1[0]~[4],tempCard2[0]~[4],P1First[0]~[4],P2First[0]~[4]
 output reg [2:0]DE; //�O�d��XDE[0]~[2]���Ȩ�U�@�����w�s��
 output reg [6:0]seg; //�O�d��Xseg[0]~[6]���Ȩ�U�@�����w�s��
 reg [4:0]temp1, temp2, temp3, temp4, number; //�O�dtemp1[0]~[4],temp2[0]~[4],temp3[0]~[4],temp4[0]~[4], number[0]~[4]���Ȩ�U�@�����w�s��
 always@(posedge kHz) //��kHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //�}�l
   if(DE == 3'b110) //�p�GDE���Ȭ�6�ɡA����H�U�ԭz
    DE<=3'b000; //DE�����ܬ�0
   else //��L���p
    DE<=DE+3'b001; //DE����+1
 end //����
 
 always@(*) //��̭������ܰʮɡA���U��Behavioral Model���ԭz�|�Q����
  case(DE) //��DE���Ȭ�true�ɡA����H�U�ԭz
   3'b000: //DE���Ȭ�0
    begin //�}�l
     if(P1Hide == 0) //�p�GP1Hide���Ȭ�0�A����H�U�ԭz
      number<=tempCard1; //number�����ܬ�tempCard1����
     else //��L���p
      number<=P1First; //number�����ܬ�P1First����
    end //����
   3'b001: //DE���Ȭ�1
    begin //�}�l
     number<=P1Sum/5'd10; //number�����ܬ�P1Sum/10����
    end //����
   3'b010: //DE���Ȭ�2
    begin //�}�l
     number<=P1Sum%5'd10; //number�����ܬ�P1Sum%10����
    end //����
   3'b011: //DE���Ȭ�3
    begin //�}�l
     if(P2Hide == 0) //�p�GP2Hide���Ȭ�0�A����H�U�ԭz
      number<=tempCard2; //number�����ܬ�tempCard2����
     else //��L���p
      number<=P2First; //number�����ܬ�P2First����
    end //����
   3'b100: //DE���Ȭ�4
    begin //�}�l
     number<=P2Sum/5'd10; //number�����ܬ�P2Sum/10����
    end //����
   3'b101: //DE���Ȭ�5
    begin //�}�l
     number<=P2Sum%5'd10; //number�����ܬ�P2Sum%10����
    end //����
  endcase //����case
  
 always@(*) //��̭������ܰʮɡA���U��Behavioral Model���ԭz�|�Q����
  case(number) //��number���Ȭ�true�ɡA����H�U�ԭz
   5'd0:seg=7'b1111_110; //number���Ȭ�0�ɡA�C�q��ܾ����0
   5'd1:seg=7'b0110_000; //number���Ȭ�1�ɡA�C�q��ܾ����1
   5'd2:seg=7'b1101_101; //number���Ȭ�2�ɡA�C�q��ܾ����2
   5'd3:seg=7'b1111_001; //number���Ȭ�3�ɡA�C�q��ܾ����3
   5'd4:seg=7'b0110_011; //number���Ȭ�4�ɡA�C�q��ܾ����4
   5'd5:seg=7'b1011_011; //number���Ȭ�5�ɡA�C�q��ܾ����5
   5'd6:seg=7'b1011_111; //number���Ȭ�6�ɡA�C�q��ܾ����6
   5'd7:seg=7'b1110_000; //number���Ȭ�7�ɡA�C�q��ܾ����7
   5'd8:seg=7'b1111_111; //number���Ȭ�8�ɡA�C�q��ܾ����8
   5'd9:seg=7'b1111_011; //number���Ȭ�9�ɡA�C�q��ܾ����9
  default:seg=7'b0001_111; //number���Ȭ���L���ȮɡA��ܭ˹L�Ӫ�f
 endcase //����case
endmodule   //�����Ҳ�

module debounce(out, kHz, in); //�����u�����Ҳիŧi
 input kHz, in; //��J��kHz,in
 output out; //��X��out
 reg [10:0]d; //�O�dd[0]~d[10]���Ȩ�U�@�����w�s��
 always@(posedge kHz) //��kHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|����
  begin //�}�l
   d[10]<=d[9]; //d[10]�����ܬ�d[9]����
   d[9]<=d[8]; //d[9]�����ܬ�d[8]����
   d[8]<=d[7]; //d[8]�����ܬ�d[7]����
   d[7]<=d[6]; //d[7]�����ܬ�d[6]����
   d[6]<=d[5]; //d[6]�����ܬ�d[5]����
   d[5]<=d[4]; //d[5]�����ܬ�d[4]����
   d[4]<=d[3]; //d[4]�����ܬ�d[3]����
   d[3]<=d[2]; //d[3]�����ܬ�d[2]����
   d[2]<=d[1]; //d[2]�����ܬ�d[1]����
   d[1]<=d[0]; //d[1]�����ܬ�d[0]����
   d[0]<=in; //d[0]�����ܬ�in����
  end //����
 and(out,d[10],d[9],d[8],d[7],d[6],d[5],d[4],d[3],d[2],d[1],d[0]); //�޿�hAND�A��J��d[0]~d[10]�F��X��out
endmodule   //�����u�����Ҳյ���

module div10000(out, in); //���W�����H10000���Ҳիŧi
 input in; //��J��in
 output reg out; //�O�d��Xout���Ȩ�U�@�����w�s��
 reg [12:0]counter; //�O�d��Xcounter[0]~[12]���Ȩ�U�@�����w�s��
 always@(posedge in) //��in���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter==13'd4999) //�p�Gcounter���ȵ���4999�ɡA����H�U�ԭz
   begin //�}�l
    counter<=13'd0; //counter�����ܬ�0
    out<=~out; //out�Ϭ�
   end //����
  else //��L���p
   counter<=counter+13'd1; //conuter����+1
endmodule  //�����Ҳ�

module div10(out, in); //���W�����H10���Ҳիŧi
 input in; //��J��in
 output reg out; //�O�d��Xout���Ȩ�U�@�����w�s��
 reg [2:0]counter; //�O�d��Xcounter[0]~[2]���Ȩ�U�@�����w�s��
 always@(posedge in) //��in���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter==3'd4) //�p�Gcounter���ȵ���4�ɡA����H�U�ԭz
   begin //�}�l
    counter<=3'd0; //counter�����ܬ�0
    out<=~out; //out�Ϭ�
   end //����
  else //��L���p
   counter<=counter+3'd1; //conuter����+1
endmodule   //�����Ҳ�