module exp8(Z,led,MHz,PS3,W,Reset); //�������A���Ҳիŧi
 input MHz,PS3,W,Reset; //��J��MHz,PS3,W,Reset
 output Z,led; //��X��Z,led
 wire kHz,clk; //�������A�����޿�q���Ϥ��|�Ψ�2���u�s�����P�Ҳ�
 reg [3:0]state,STATE; //�O�dstate[0]~[3],STATE[0]~[3]���Ȩ�U�@�����w�s��
 parameter s0=4'd0,s1=4'd1,s2=4'd2,s3=4'd4,s4=4'd9,s5=4'd3,s6=4'd7,s7=4'd15; //�w�q�T�w����s0��0,s1��1,s2��2,s3��4,s4��9,s5��3,s6��7,s7��15
 div10000 d1 (kHz,MHz); //�ϥΰ��W��1���ҲաA��X��kHz�A��J��MHz
 debounce d2 (clk,PS3,kHz); //�ϥή����u���ҲաA��X��clk�A��J��PS3,kHz
 always@(state,W) //��state,W���Ȧ����ܮɡA���U��Behavioral Model���ԭz�|�Q����
  case(state) //state���Ȭ�true�ɡA����H�U�ԭz
   s0:STATE=W?s1:s0; //��state��s0�ɡAW=1,STATE=s1�AW=0,STATE=s0
   s1:STATE=W?s5:s2; //��state��s1�ɡAW=1,STATE=s5�AW=0,STATE=s2
   s2:STATE=W?s1:s3; //��state��s2�ɡAW=1,STATE=s1�AW=0,STATE=s3
   s3:STATE=W?s4:s0; //��state��s3�ɡAW=1,STATE=s4�AW=0,STATE=s0
   s4:STATE=W?s5:s2; //��state��s4�ɡAW=1,STATE=s5�AW=0,STATE=s2
   s5:STATE=W?s6:s2; //��state��s5�ɡAW=1,STATE=s6�AW=0,STATE=s2
   s6:STATE=W?s7:s2; //��state��s6�ɡAW=1,STATE=s7�AW=0,STATE=s2
   s7:STATE=W?s7:s2; //��state��s7�ɡAW=1,STATE=s7�AW=0,STATE=s2
   default:STATE=s0; //state����L�ȮɡASTATE=s0
  endcase //����case
 always@(posedge clk or negedge Reset) //��clk���tĲ�o��Reset�t�tĲ�o�A���U��Behavioral Model���ԭz�|�Q����
  if(~Reset) //�p�GReset�Ϭ۬�true�A����H�U�ԭz
   state<=s0; //state�����ܬ�s0
  else //��L���p
   state<=STATE; //state�����ܬ�STATE����
 assign Z=(state==s4 || state==s7); //�ŧiZ���Ȭ�state==s4�Bstate==s7���޿�P�_
 assign led=1'b1; //�ŧiled���Ȭ�1
endmodule  //�����Ҳ�    

module div10000(out,in); //���W�����H10000���Ҳիŧi
 input in; //��J��in
 output reg out; //�O�d��Xout���Ȩ�U�@�����w�s��
 reg [12:0]counter; //�O�d��Xcounter[0]~[12]���Ȩ�U�@�����w�s��
 always@(posedge in) //��in���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter==4999) //�p�Gcounter���ȵ���4999�ɡA����H�U�ԭz
   begin //�}�l
    counter<=0; //counter�����ܬ�0
    out<=~out; //out�Ϭ�
   end //����
  else //��L���p
   counter<=counter+13'd1; //conuter����+1
endmodule //�����Ҳ�

module debounce(out,in,kHz); //�����u�����Ҳիŧi
 input kHz,in; //��J��kHz,in
 output out; //��X��out
 reg [10:0]d; //�O�dd[0]~d[10]���Ȩ�U�@�����w�s��
 always@(posedge kHz) //��kHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|
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
endmodule  //�����u�����Ҳյ���  