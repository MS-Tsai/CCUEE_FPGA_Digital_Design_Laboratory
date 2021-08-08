module exp7(DE, seg, MHz, Enable, Speed, Reset); //�p�ɾ��Ҳիŧi
 input MHz, Enable, Speed, Reset; //��J��MHz,Enable,Speed,Reset
 output reg [2:0]DE; //��X��3-bits�@3�Ӽ�DE[0]~[2]�A�åB�O�dDE[0]~[2]���Ȩ�U�@�����w�s��
 output reg [6:0]seg; //��X��7-bits�@7�Ӽ�seg[0]~[6]�A�åB�O�dseg[0]~[6]���Ȩ�U�@�����w�s��
 wire kHz, Hz1, Hz100, Sresult; //�p�ɾ����޿�q���Ϥ��|�Ψ�4���u�s�����P�Ҳ�
 reg H1; //�O�dH1���Ȩ�U�@�����w�s��
 reg [3:0]Cresult; //�O�dCresult[0]~[3]���Ȩ�U�@�����w�s��
 reg [3:0]S2, M2, H2; //�O�dS2[0]~[3],M2[0]~[3],H2[0]~[3]���Ȩ�U�@�����w�s��
 reg [2:0]S1, M1; //�O�dS1[0]~[2],M1[0]~[2]���Ȩ�U�@�����w�s��
 
 div10000 d1(kHz, MHz); //�ϥΰ��W��1���ҲաA��X��kHz�A��J��MHz
 div10	  d2(Hz100, kHz); //�ϥΰ��W��2���ҲաA��X��Hz100�A��J��kHz
 div100   d3(Hz1, Hz100); //�ϥΰ��W��3���ҲաA��X��Hz1�A��J��Hz100
 
 always@(posedge kHz) //��kHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(DE == 5) //�p�GDE���Ȭ�5�A����H�U�ԭz
   DE<=0; //DE�����ܬ�0
  else //��L���p
   DE<=DE+3'd1; //DE����+1
   
 assign Sresult = Speed ? Hz1 : Hz100; //��Speed=1��,Sresult=Hz1�A��Speed=0��,Sresult=Hz100
   
 always@(posedge Sresult or negedge Reset) //��Sresult���tĲ�o��Reset�t�tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //�}�l
   if(~Reset) //�p�GReset�Ϭ۬�true�A����H�U�ԭz
    begin //�}�l
     S1<=0; //S1�����ܬ�0
     S2<=0; //S2�����ܬ�0
     M1<=0; //M1�����ܬ�0
     M2<=0; //M2�����ܬ�0
     H1<=0; //H1�����ܬ�0
     H2<=0; //H2�����ܬ�0
    end //����
   else //��L���p
    begin //�}�l
     if(~Enable) //�p�GEnable�Ϭ۬�true�A����H�U�ԭz
      begin //�}�l
       if(S1 == 5 && S2 == 9) //�p�GS1���Ȭ�5�BS2���Ȭ�9�A����H�U�ԭz
        begin //�}�l
         S1<=0; //S1�����ܬ�0
         S2<=0; //S2�����ܬ�0
        end //����
       else //��L���p
        begin //�}�l
         if(S2 == 9) //�p�GS2���Ȭ�9�A����H�U�ԭz
          begin //�}�l
           S2<=0; //S2�����ܬ�0
           S1<=S1+3'd1; //S1����+1
          end //����
         else //��L���p
          S2<=S2+4'd1; //S2����+1
        end //����
               
       if(M1 == 5 && M2 == 9 && S1 == 5 && S2 == 9) //�p�GM1���Ȭ�5�BM2���Ȭ�9�BS1���Ȭ�5�BS2���Ȭ�9�A����H�U�ԭz
        begin //�}�l
         M1<=0; //M1�����ܬ�0
         M2<=0; //M2�����ܬ�0
        end //����
       else //��L���p
        begin //�}�l
         if(M2 == 9 && S1 == 5 && S2 == 9) //�p�GM2���Ȭ�9�BS1���Ȭ�5�BS2���Ȭ�9�A����H�U�ԭz
          begin //�}�l
           M2<=0; //M2�����ܬ�0
           M1<=M1+3'd1; //M1����+1
          end //����
         else if(S1 == 5 && S2 == 9) //��L�p�GS1���Ȭ�5�BS2���Ȭ�9�A����H�U�ԭz
          M2<=M2+4'd1; //M2����+1
        end //����
        
       if(H1 == 0 && H2 == 9 && M1 == 5 && M2 == 9 && S1 == 5 && S2 == 9) //�p�GH1���Ȭ�0�BH2���Ȭ�9�BM1���Ȭ�5�BM2���Ȭ�9�BS1���Ȭ�5�BS2���Ȭ�9�A����H�U�ԭz
        begin //�}�l
         H2<=0; //H2�����ܬ�0
         H1<=H1+1'd1; //H1����+1
        end //����
       else //��L���p
        begin //�}�l
         if(H1 == 1 && H2 == 1 && M1 == 5 && M2 == 9 && S1 == 5 && S2 == 9) //�p�GH1���Ȭ�1�BH2���Ȭ�1�BM1���Ȭ�5�BM2���Ȭ�9�BS1���Ȭ�5�BS2���Ȭ�9�A����H�U�ԭz
          begin //�}�l
           H1<=0; //H1�����ܬ�0
           H2<=0; //H2�����ܬ�0
          end //����
         else if(M1 == 5 && M2 == 9 && S1 == 5 && S2 == 9) //��L�p�GM1���Ȭ�5�BM2���Ȭ�9�BS1���Ȭ�5�BS2���Ȭ�9�A����H�U�ԭz
          H2<=H2+4'd1; //H2����+1
        end //����
      end //����
      
      case(DE) //DE���Ȭ�true�ɡA����H�U�ԭz
        3'd0:Cresult<=H1; //DE���Ȭ�0�ACresult�����ܬ�H1����
        3'd1:Cresult<=H2; //DE���Ȭ�1�ACresult�����ܬ�H2����
        3'd2:Cresult<=M1; //DE���Ȭ�2�ACresult�����ܬ�M1����
        3'd3:Cresult<=M2; //DE���Ȭ�3�ACresult�����ܬ�M2����
        3'd4:Cresult<=S1; //DE���Ȭ�4�ACresult�����ܬ�S1����
        3'd5:Cresult<=S2; //DE���Ȭ�5�ACresult�����ܬ�S2����
      endcase //����case
       
      case(Cresult) //Cresult���Ȭ�true�ɡA����H�U�ԭz
       4'd0 : seg = 7'b1111_110; //�ϤC�q��ܾ����0
	   4'd1 : seg = 7'b0110_000; //�ϤC�q��ܾ����1
	   4'd2 : seg = 7'b1101_101; //�ϤC�q��ܾ����2
   	   4'd3 : seg = 7'b1111_001; //�ϤC�q��ܾ����3
	   4'd4 : seg = 7'b0110_011; //�ϤC�q��ܾ����4
	   4'd5 : seg = 7'b1011_011; //�ϤC�q��ܾ����5
	   4'd6 : seg = 7'b1011_111; //�ϤC�q��ܾ����6
	   4'd7 : seg = 7'b1110_000; //�ϤC�q��ܾ����7
	   4'd8 : seg = 7'b1111_111; //�ϤC�q��ܾ����8
	   4'd9 : seg = 7'b1111_011; //�ϤC�q��ܾ����9
      endcase //����case
    end //����
  end //����
endmodule //�����Ҳ�

module div10000(out, in); //���W�����H10000���Ҳիŧi
 input in; //��J��in
 output reg out; //�O�d��Xout���Ȩ�U�@�����w�s��
 reg [12:0]counter; //�O�d��Xcounter[0]~[12]���Ȩ�U�@�����w�s��
 always@(posedge in) //��in���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter == 4999) //�p�Gcounter���ȵ���4999�ɡA����H�U�ԭz
   begin //�}�l
    counter<=0; //counter�����ܬ�0
    out<=~out; //out�Ϭ�
   end //����
  else //��L���p
   counter<=counter+13'd1; //conuter����+1
endmodule //�����Ҳ�

module div10(out, in); //���W�����H10���Ҳիŧi
 input in; //��J��in
 output reg out; //�O�d��Xout���Ȩ�U�@�����w�s��
 reg [2:0]counter; //�O�d��Xcounter[0]~[2]���Ȩ�U�@�����w�s��
 always@(posedge in) //��in���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter == 4) //�p�Gcounter���ȵ���4�ɡA����H�U�ԭz
   begin //�}�l
    counter<=0; //counter�����ܬ�0
    out<=~out; //out�Ϭ�
   end //����
  else //��L���p
   counter<=counter+3'd1; //conuter����+1
endmodule //�����Ҳ�

module div100(out, in); //���W�����H100���Ҳիŧi
 input in; //��J��in
 output reg out; //�O�d��Xout���Ȩ�U�@�����w�s��
 reg [5:0]counter; //�O�d��Xcounter[0]~[5]���Ȩ�U�@�����w�s��
 always@(posedge in) //��in���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter == 49) //�p�Gcounter���ȵ���49�ɡA����H�U�ԭz
   begin //�}�l
    counter<=0; //counter�����ܬ�0
    out<=~out; //out�Ϭ�
   end//����
  else //��L���p
   counter<=counter+6'd1; //conuter����+1
endmodule //�����Ҳ�