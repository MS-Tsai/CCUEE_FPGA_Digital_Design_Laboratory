module exp10(money,enough,led,MHz,PS3,PS4,Reset,buy); //�۰ʳc����Ҳիŧi
 input MHz,PS3,PS4,Reset,buy; //��J��MHz,PS3,PS4,Reset,buy
 output reg [3:0]money; //�O�d��Xmoney[0]~[3]���Ȩ�U�@�����w�s��
 output enough,led; //��X��enough,led
 wire kHz,Hz,five,ten; //�۰ʳc������޿�q���Ϥ��|�Ψ�4���u�s�����P�Ҳ�
 reg [2:0]current,next; //�O�dcurrent[0]~[2],next[0]~[2]���Ȩ�U�@�����w�s��
 parameter s0=3'd0,s1=3'd1,s2=3'd2,s3=3'd3,s4=3'd4; //�w�q�T�w����s0��0,s1��1,s2��2,s3��3,s4��4
 
 div10000 d1(kHz,MHz); //�ϥΰ��W��1���ҲաA��X��kHz�A��J��MHz
 div1000 d2(Hz,kHz); //�ϥΰ��W��2���ҲաA��X��Hz�A��J��kHz
 debounce d3(five,PS3,kHz); //�ϥή����u���ҲաA��X��five�A��J��PS3,kHz
 debounce d4(ten,PS4,kHz); //�ϥή����u���ҲաA��X��ten�A��J��PS4,kHz

 always@(current,five,ten,buy) //��current,five,ten,buy���Ȧ����ܮɡA���U��Behavioral Model���ԭz�|�Q����
  begin //�}�l
   if(five==1) //�p�Gfive���ȵ���1�A����H�U�ԭz
    case(current) //current���Ȭ�true�ɡA����H�U�ԭz
     s0:next=s1; //current��s0�ɡAnext=s1
     s1:next=s2; //current��s1�ɡAnext=s2
     s2:next=s3; //current��s2�ɡAnext=s3
     s3:next=s4; //current��s3�ɡAnext=s4
     s4:next=s4; //current��s4�ɡAnext=s4
     default: next=s0; //��current����L�ȮɡAnext=s0
    endcase //����case
   else if(ten==1) //��L�p�Gten���ȵ���1�A����H�U�ԭz
    case(current) //current���Ȭ�true�ɡA����H�U�ԭz
     s0:next=s2; //current��s0�ɡAnext=s2
     s1:next=s3; //current��s1�ɡAnext=s3
     s2:next=s4; //current��s2�ɡAnext=s4
     s3:next=s4; //current��s3�ɡAnext=s4
     s4:next=s4; //current��s4�ɡAnext=s4
     default: next=s0; //��current����L�ȮɡAnext=s0
    endcase //����case
   else if(buy==0) //��L�p�Gbuy���ȵ���0�A����H�U�ԭz
    case(current)  //current���Ȭ�true�ɡA����H�U�ԭz
     s0:next=s0; //current��s0�ɡAnext=s0
     s1:next=s1; //current��s1�ɡAnext=s1
     s2:next=s2; //current��s2�ɡAnext=s2
     s3:next=s0; //current��s3�ɡAnext=s0
     s4:next=s1; //current��s4�ɡAnext=s1
     default: next=s0; //��current����L�ȮɡAnext=s0
    endcase //����case
   else //��L���p
    next=current; //next�����ܬ�current����
  end //����
  
 always@(posedge Hz or negedge Reset) //��Hz���tĲ�o��Reset�t�tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(~Reset) //�p�GReset�Ϭ۬�true�A����H�U�ԭz
   current<=s0; //current�����ܬ�s0
  else //��L���p
   current<=next; //current�����ܬ�next����
 assign enough=(current==s3 || current==s4); //�ŧienough���Ȭ�current==s3��current==s4���޿�P�_
 always@(current) //��current���Ȧ��ܰʮɡA���U��Behavioral Model���ԭz�|�Q����
  case(current) //current���Ȭ�true�ɡA����H�U�ԭz
   s0:money=4'b0000; //current��s0�ɡAmoney���Ȭ��G�i��0000
   s1:money=4'b0001; //current��s1�ɡAmoney���Ȭ��G�i��0001
   s2:money=4'b0011; //current��s2�ɡAmoney���Ȭ��G�i��0011
   s3:money=4'b0111; //current��s3�ɡAmoney���Ȭ��G�i��0111
   s4:money=4'b1111; //current��s4�ɡAmoney���Ȭ��G�i��1111
   default: money=4'b0000; //current����L�ȮɡAmoney���Ȭ��G�i��0000
  endcase //����case
 assign led=1'b1;  //�ŧiled���Ȭ�1
endmodule   //�����Ҳ� 
       
module div1000(out,in); //���W�����H1000���Ҳիŧi
 input in; //��J��in
 output reg out; //�O�d��Xout���Ȩ�U�@�����w�s��
 reg [8:0]counter; //�O�d��Xcounter[0]~[8]���Ȩ�U�@�����w�s��
 always@(posedge in) //��in���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
 if(counter==9'd499) //�p�Gcounter���ȵ���499�ɡA����H�U�ԭz
  begin //�}�l
   counter<=9'd0; //counter�����ܬ�0
   out<=~out; //out�Ϭ�
  end //����
 else //��L���p
  counter<=counter+9'd1; //conuter����+1
endmodule  //�����Ҳ�

module div10000(out,in); //���W�����H10000���Ҳիŧi
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

module debounce(out,in,kHz); //�����u�����Ҳիŧi
 input kHz,in; //��J��kHz,in
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