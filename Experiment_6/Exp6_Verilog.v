module exp6(row,col,MHz,Dir,Enable,Reset); //�]���O�Ҳիŧi
 input MHz,Dir,Enable,Reset; //��J��MHz,Dir,Enable,Reset
 output reg [7:0]row,col; //��X��8-bits�@16�Ӽ�row[0]~[7],col[0]~[7]
 wire kHz,Hz; //�]���O���޿�q���Ϥ��|�Ψ�2���u�s�����P�Ҳ�
 reg [1:0]counter; //�O�dcounter[0]~[1]���Ȩ�U�@�����w�s��
 reg [2:0]count; //�O�dcount[0]~[2]���Ȩ�U�@�����w�s��
 div1 d1(kHz,MHz); //�ϥΰ��W��1���ҲաA��X��kHz�A��J��MHz
 div2 d2(Hz,MHz); //�ϥΰ��W��2���ҲաA��X��Hz�A��J��MHz
 wire out; //�]���O���޿�q���Ϥ��|�Ψ�1���u�s�����P�Ҳ�
 debounce de1(MHz,Reset,out); //�ϥή����u�����ҲաA��X��out�A��J��MHz,Reset
 always@(posedge Hz or negedge out) //��Hz���tĲ�o��out�t�tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //Behavioral Model�}�l
   if(~out) //�p�Gout�Ϭ۬�true�A����H�U�ԭz
    counter=0; //counter���ȵ���0
   else //��L���p
    begin //�}�l
     if(~Enable) //�p�GEnable�Ϭ۬�true�A����H�U�ԭz
      begin //�}�l
         if(~Dir) //�p�GDir�Ϭ۬�true�A����H�U�ԭz
           counter<=counter+1; //counter����+1
         else //��L���p
           counter<=counter-1; //counter����-1
      end //����
     end //����
  end //Behavioral Model����
  
 always@(posedge kHz) //��kHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //Behavioral Model�}�l
   count<=count+1; //counter����+1
   case(counter) //counter���Ȭ�true�ɡA����H�U�ԭz
    2'd0: //2�줸,�Q�i��,�ƭȬ�0
         case(count) //count���Ȭ�true�ɡA����H�U�ԭz
          3'd0:	//3�줸,�Q�i��,�ƭȬ�0
               begin //�}�l
                row=8'b1000_0000; //row��1�C��1�A��l��0
                col=8'b1111_1110; //col��1,2,3,4,5,6,7�欰1�A��l��0
               end //����
          3'd1: //3�줸,�Q�i��,�ƭȬ�1
               begin //�}�l
		row=8'b0001_0000; //row��4�C��1�A��l��0
                col=8'b0111_1100; //col��2,3,4,5,6�欰1�A��l��0
               end //����
          default: //��L
                 begin //�}�l
		  row=8'b1111_1111; //row��1,2,3,4,5,6,7,8�C��1
                  col=8'b0100_0000; //col��2�欰1�A��l��0
                 end //����
         endcase  //����case
    2'd1: //2�줸,�Q�i��,�ƭȬ�1
         case(count) //count���Ȭ�true�ɡA����H�U�ԭz
          3'd0:	 //3�줸,�Q�i��,�ƭȬ�0
               begin //�}�l
                row=8'b1000_0000; //row��1�C��1�A��l��0
                col=8'b0111_1110; //col��2,3,4,5,6,7�欰1�A��l��0
               end //����
          3'd1: //3�줸,�Q�i��,�ƭȬ�1
               begin //�}�l
		row=8'b0001_0000; //row��4�C��1�A��l��0
                col=8'b0111_1110; //col��2,3,4,5,6,7�欰1�A��l��0
               end //����
          3'd2: //3�줸,�Q�i��,�ƭȬ�2
               begin //�}�l
		row=8'b1111_0000; //row��1,2,3,4�C��1�A��l��0
                col=8'b0000_0010; //col��7�欰1�A��l��0
          default: //��L
                  begin //�}�l
		   row=8'b1111_1111; //row��1,2,3,4,5,6,7,8�C��1
                   col=8'b0100_0000; //col��2�欰1�A��l��0
                  end //����
         endcase  //����case
    2'd2: //2�줸,�Q�i��,�ƭȬ�2
         case(count) //count���Ȭ�true�ɡA����H�U�ԭz
	  3'd0:	//3�줸,�Q�i��,�ƭȬ�0
               begin //�}�l
                row=8'b1000_0000; //row��1�C��1�A��l��0
                col=8'b0111_1110; //col��2,3,4,5,6,7�欰1�A��l��0
               end //����
          3'd1: //3�줸,�Q�i��,�ƭȬ�1
               begin //�}�l
		row=8'b0001_0000; //row��4�C��1�A��l��0
                col=8'b0001_1110; //col��4,5,6,7�欰1�A��l��0
               end //����
          3'd2: //3�줸,�Q�i��,�ƭȬ�2
               begin //�}�l
		row=8'b0001_1111; //row��4,5,6,7,8�C��1�A��l��0
                col=8'b0000_0010; //col��7�欰1�A��l��0
               end //����
          3'd3: //3�줸,�Q�i��,�ƭȬ�3
               begin //�}�l
                row=8'b0000_0001; //row��8�C��1�A��l��0
                col=8'b0111_1110; //col��2,3,4,5,6,7�欰1�A��l��0
               end  //����
          default: //��L
                  begin //�}�l
		   row=8'b1111_1111; //row��1,2,3,4,5,6,7,8�C��1
                   col=8'b0100_0000; //col��2�欰1�A��l��0
                  end  //����
         endcase   //����case
    2'd3: //2�줸,�Q�i��,�ƭȬ�3
         case(count) //count���Ȭ�true�ɡA����H�U�ԭz
	  3'd0:	//3�줸,�Q�i��,�ƭȬ�0
               begin //�}�l
                row=8'b1000_0000; //row��1�C��1�A��l��0
                col=8'b0111_1110; //col��2,3,4,5,6,7�欰1�A��l��0
               end //����
          3'd1: //3�줸,�Q�i��,�ƭȬ�1
               begin //�}�l
		row=8'b0001_0000; //row��4�C��1�A��l��0
                col=8'b0111_1110; //col��2,3,4,5,6,7�欰1�A��l��0
               end //����
          3'd2: //3�줸,�Q�i��,�ƭȬ�2
               begin //�}�l
		row=8'b1111_1111; //row��1,2,3,4,5,6,7,8�C��1
                col=8'b0000_0010; //col��7�欰1�A��l��0
               end //����
          default: //��L
                  begin //�}�l
		   row=8'b1111_1111; //row��1,2,3,4,5,6,7,8�C��1
                   col=8'b0100_0000; //col��2�欰1�A��l��0
                  end //����
         endcase //����case
   endcase //����case
  end //Behavioral Model����
endmodule  //�]���O�Ҳյ���        
     
module debounce(kHz,in,out); //�����u�����Ҳիŧi
 input kHz,in; //��J��kHz,in
 output out; //��X��out
 reg [6:0]d; //�O�dd[0]~d[6]���Ȩ�U�@�����w�s��
 always@(posedge kHz) //��kHz���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  begin //Behavioral Model�}�l
   d[6]<=d[5]; //d[6]�����ܬ�d[5]����
   d[5]<=d[4]; //d[5]�����ܬ�d[4]����
   d[4]<=d[3]; //d[4]�����ܬ�d[3]����
   d[3]<=d[2]; //d[3]�����ܬ�d[2]����
   d[2]<=d[1]; //d[2]�����ܬ�d[1]����
   d[1]<=d[0]; //d[1]�����ܬ�d[0]����
   d[0]<=in; //d[0]�����ܬ�in����
  end //Behavioral Model����
 and(out,d[6],d[5],d[4],d[3],d[2],d[1],d[0]); //�޿�hAND�A��J��d[0]~d[6]�F��X��out         
endmodule  //�����u�����Ҳյ���         

module div1(kHz,clock); //���W��1���Ҳիŧi
 input clock; //��J��clock
 output reg kHz; //�O�d��XkHz���Ȩ�U�@�����w�s��
 reg [12:0]counter; //�O�d��Xcounter[0]~[12]���Ȩ�U�@�����w�s��
 always@(posedge clock) //��clock���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter==4999) //�p�Gcounter���ȵ���4999�ɡA����H�U�ԭz
   begin //�}�l
    counter<=0; //counter�����ܬ�0
    kHz<=~kHz; //kHz�Ϭ�
   end //����
  else //��L���p
   counter<=counter+1; //conuter����+1
endmodule  //���W��1���Ҳյ���

module div2(Hz,clock); //���W��2���Ҳիŧi
 input clock; //��J��clock
 output reg Hz; //�O�d��XHz���Ȩ�U�@�����w�s��
 reg [22:0]counter; //�O�d��Xcounter[0]~[22]���Ȩ�U�@�����w�s��
 always@(posedge clock) //��clock���tĲ�o�ɡA���U��Behavioral Model���ԭz�|�Q����
  if(counter==4999999) //�p�Gcounter���ȵ���4999999�ɡA����H�U�ԭz
   begin //�}�l
    counter<=0; //counter�����ܬ�0
    Hz<=~Hz; //Hz�Ϭ�
   end //����
  else//��L���p
   counter<=counter+1; //conuter����+1
endmodule  //���W��2���Ҳյ���