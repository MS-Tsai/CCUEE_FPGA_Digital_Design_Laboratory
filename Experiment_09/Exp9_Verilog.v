module exp9(Z,led,W,PS3,MHz,Reset); //�H Gate Level �]�p�������A���Ҳիŧi
 input W,PS3,MHz,Reset; //��J��W,PS3,MHz,Reset
 output Z,led; //��X��Z,led
 reg a,b; //�O�da,b���Ȩ�U�@�����w�s��
 wire A,B,clk,kHz; //�޿�q���Ϥ��|�Ψ�4���u�s�����P�Ҳ�
 div10000 d1(kHz,MHz); //�ϥΰ��W��1���ҲաA��X��kHz�A��J��MHz
 debounce d2(clk,kHz,PS3); //�ϥή����u���ҲաA��X��clk�A��J��kHz,PS3
 always@(posedge clk or negedge Reset) //��clk���tĲ�o��Reset�t�tĲ�o�A���U��Behavioral Model���ԭz�|�Q����
  if(~Reset) //�p�GReset�Ϭ۬�true�A����H�U�ԭz
   begin //�}�l
    a=0; //a�����ܬ�0
    b=0; //b�����ܬ�0
   end //����
  else //��L���p
   begin //�}�l
    a=A; //a�����ܬ�A����
    b=B; //b�����ܬ�B����
   end //����
 assign A=b; //�ŧiA�����ܬ�b����
 assign B=W; //�ŧiB�����ܬ�W����
 xor x1(Z,a,b); //�޿�hXOR�A��J��a,b�A��X��Z
 assign led=1'b1; //�ŧiled���Ȭ�1
endmodule  //�����Ҳ�

module div10000(out,in); //���W�����H10000���Ҳիŧi
 input in; //��J��in
 output reg out; //�O�d��Xout���Ȩ�U�@�����w�s��
 reg [12:0]counter; //�O�d��Xcounter[0]~[12]���Ȩ�U�@�����w�s��
 always@(posedge in) //��in���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter == 13'd4999) //�p�Gcounter���ȵ���4999�ɡA����H�U�ԭz
   begin //�}�l
    counter<=13'd0; //counter�����ܬ�0
    out<=~out; //out�Ϭ�
   end //����
  else //��L���p
   counter<=counter+13'd1; //conuter����+1
endmodule //�����Ҳ�
 
module debounce(out,kHz,in); //�����u�����Ҳիŧi
 input in,kHz; //��J��in,kHz
 output out; //��X��out
 reg [10:0]d; //�O�dd[0]~d[10]���Ȩ�U�@�����w�s��
 always@(posedge kHz) //��kHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
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