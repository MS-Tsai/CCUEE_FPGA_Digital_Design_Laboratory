module exp5(counter,led,MHz,PS3); //�T�줸�p�ƾ��Ҳիŧi
 input MHz,PS3; //��J��MHz,PS3
 output led; //��X��led�O
 output reg [2:0]counter; //��X��3-bits�@3�Ӽ�counter[0]~[2]
 reg kHz; //�O�dkHz���Ȩ�U�@�����w�s��
 reg [12:0]count; //�O�dcount[0]~[12]���Ȩ�U�@�����w�s��
 wire nb; //�T�줸�p�ƾ����޿�q���Ϥ��|�Ψ�1���u�s�����P���Ҳ�
 always@(posedge MHz) //��MHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //Behavioral Model�}�l
	if (count==4999) //�p�Gcount���ȵ���4999�ɡA����H�U�ԭz
	 begin //�}�l
	  count<=0; //count�����ܬ�0
      kHz<=~kHz; //kHz�Ϭ�
	 end //����
	else //��L���p
	 count<=count+1; //count����+1
  end //Behavioral Model����
  
  debounce d1(nb,kHz,PS3); //�ϥή����u�����ҲաA��X��nb�A��J��kHz,PS3
 
  always@(posedge PS3) //��PS3���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
   begin //Behavioral Model�}�l
	 if(nb==1) //�p�Gnb����=1�ɡA����H�U�ԭz
	  begin //�}�l
	   if (counter==7) //�p�Gcounter���ȵ���7�ɡA����H�U�ԭz
		counter<=0; //counter�����ܬ�0
	   else //��L���p
		counter<=counter+1; //counter����+1
	  end //����
   end //Behavioral Model����
 assign led=1'b1; //�ŧiLED�O��1�줸,�G�i��,�ƭȬ�1
endmodule //�T�줸�p�ƾ��Ҳյ���

module debounce(out,kHz,in); //�����u�����Ҳիŧi
 input kHz,in; //��J��kHz,in
 output out; //��X��out
 reg [10:0]d; //�O�dd[0]~d[10]���Ȩ�U�@�����w�s��
 always@(posedge kHz) //��kHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //Behavioral Model�}�l
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
  end //Behavioral Model����
 and(out,d[6],d[5],d[4],d[3],d[2],d[1],d[0]); //�޿�hAND�A��J��d[0]~d[6]�F��X��out
endmodule //�����u�����Ҳյ���
