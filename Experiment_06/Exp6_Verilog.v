module exp6(row,col,MHz,Dir,Enable,Reset); //跑馬燈模組宣告
 input MHz,Dir,Enable,Reset; //輸入為MHz,Dir,Enable,Reset
 output reg [7:0]row,col; //輸出為8-bits共16個數row[0]~[7],col[0]~[7]
 wire kHz,Hz; //跑馬燈的邏輯電路圖中會用到2條線連接不同模組
 reg [1:0]counter; //保留counter[0]~[1]的值到下一次指定新值
 reg [2:0]count; //保留count[0]~[2]的值到下一次指定新值
 div1 d1(kHz,MHz); //使用除頻器1的模組，輸出為kHz，輸入為MHz
 div2 d2(Hz,MHz); //使用除頻器2的模組，輸出為Hz，輸入為MHz
 wire out; //跑馬燈的邏輯電路圖中會用到1條線連接不同模組
 debounce de1(MHz,Reset,out); //使用消除彈跳的模組，輸出為out，輸入為MHz,Reset
 always@(posedge Hz or negedge out) //當Hz正緣觸發或out負緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //Behavioral Model開始
   if(~out) //如果out反相為true，執行以下敘述
    counter=0; //counter的值等於0
   else //其他情況
    begin //開始
     if(~Enable) //如果Enable反相為true，執行以下敘述
      begin //開始
         if(~Dir) //如果Dir反相為true，執行以下敘述
           counter<=counter+1; //counter的值+1
         else //其他情況
           counter<=counter-1; //counter的值-1
      end //結束
     end //結束
  end //Behavioral Model結束
  
 always@(posedge kHz) //當kHz正緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //Behavioral Model開始
   count<=count+1; //counter的值+1
   case(counter) //counter的值為true時，執行以下敘述
    2'd0: //2位元,十進制,數值為0
         case(count) //count的值為true時，執行以下敘述
          3'd0:	//3位元,十進制,數值為0
               begin //開始
                row=8'b1000_0000; //row第1列為1，其餘為0
                col=8'b1111_1110; //col第1,2,3,4,5,6,7行為1，其餘為0
               end //結束
          3'd1: //3位元,十進制,數值為1
               begin //開始
		row=8'b0001_0000; //row第4列為1，其餘為0
                col=8'b0111_1100; //col第2,3,4,5,6行為1，其餘為0
               end //結束
          default: //其他
                 begin //開始
		  row=8'b1111_1111; //row第1,2,3,4,5,6,7,8列為1
                  col=8'b0100_0000; //col第2行為1，其餘為0
                 end //結束
         endcase  //結束case
    2'd1: //2位元,十進制,數值為1
         case(count) //count的值為true時，執行以下敘述
          3'd0:	 //3位元,十進制,數值為0
               begin //開始
                row=8'b1000_0000; //row第1列為1，其餘為0
                col=8'b0111_1110; //col第2,3,4,5,6,7行為1，其餘為0
               end //結束
          3'd1: //3位元,十進制,數值為1
               begin //開始
		row=8'b0001_0000; //row第4列為1，其餘為0
                col=8'b0111_1110; //col第2,3,4,5,6,7行為1，其餘為0
               end //結束
          3'd2: //3位元,十進制,數值為2
               begin //開始
		row=8'b1111_0000; //row第1,2,3,4列為1，其餘為0
                col=8'b0000_0010; //col第7行為1，其餘為0
          default: //其他
                  begin //開始
		   row=8'b1111_1111; //row第1,2,3,4,5,6,7,8列為1
                   col=8'b0100_0000; //col第2行為1，其餘為0
                  end //結束
         endcase  //結束case
    2'd2: //2位元,十進制,數值為2
         case(count) //count的值為true時，執行以下敘述
	  3'd0:	//3位元,十進制,數值為0
               begin //開始
                row=8'b1000_0000; //row第1列為1，其餘為0
                col=8'b0111_1110; //col第2,3,4,5,6,7行為1，其餘為0
               end //結束
          3'd1: //3位元,十進制,數值為1
               begin //開始
		row=8'b0001_0000; //row第4列為1，其餘為0
                col=8'b0001_1110; //col第4,5,6,7行為1，其餘為0
               end //結束
          3'd2: //3位元,十進制,數值為2
               begin //開始
		row=8'b0001_1111; //row第4,5,6,7,8列為1，其餘為0
                col=8'b0000_0010; //col第7行為1，其餘為0
               end //結束
          3'd3: //3位元,十進制,數值為3
               begin //開始
                row=8'b0000_0001; //row第8列為1，其餘為0
                col=8'b0111_1110; //col第2,3,4,5,6,7行為1，其餘為0
               end  //結束
          default: //其他
                  begin //開始
		   row=8'b1111_1111; //row第1,2,3,4,5,6,7,8列為1
                   col=8'b0100_0000; //col第2行為1，其餘為0
                  end  //結束
         endcase   //結束case
    2'd3: //2位元,十進制,數值為3
         case(count) //count的值為true時，執行以下敘述
	  3'd0:	//3位元,十進制,數值為0
               begin //開始
                row=8'b1000_0000; //row第1列為1，其餘為0
                col=8'b0111_1110; //col第2,3,4,5,6,7行為1，其餘為0
               end //結束
          3'd1: //3位元,十進制,數值為1
               begin //開始
		row=8'b0001_0000; //row第4列為1，其餘為0
                col=8'b0111_1110; //col第2,3,4,5,6,7行為1，其餘為0
               end //結束
          3'd2: //3位元,十進制,數值為2
               begin //開始
		row=8'b1111_1111; //row第1,2,3,4,5,6,7,8列為1
                col=8'b0000_0010; //col第7行為1，其餘為0
               end //結束
          default: //其他
                  begin //開始
		   row=8'b1111_1111; //row第1,2,3,4,5,6,7,8列為1
                   col=8'b0100_0000; //col第2行為1，其餘為0
                  end //結束
         endcase //結束case
   endcase //結束case
  end //Behavioral Model結束
endmodule  //跑馬燈模組結束        
     
module debounce(kHz,in,out); //消除彈跳的模組宣告
 input kHz,in; //輸入為kHz,in
 output out; //輸出為out
 reg [6:0]d; //保留d[0]~d[6]的值到下一次指定新值
 always@(posedge kHz) //當kHz正緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //Behavioral Model開始
   d[6]<=d[5]; //d[6]的值變為d[5]的值
   d[5]<=d[4]; //d[5]的值變為d[4]的值
   d[4]<=d[3]; //d[4]的值變為d[3]的值
   d[3]<=d[2]; //d[3]的值變為d[2]的值
   d[2]<=d[1]; //d[2]的值變為d[1]的值
   d[1]<=d[0]; //d[1]的值變為d[0]的值
   d[0]<=in; //d[0]的值變為in的值
  end //Behavioral Model結束
 and(out,d[6],d[5],d[4],d[3],d[2],d[1],d[0]); //邏輯閘AND，輸入為d[0]~d[6]；輸出為out         
endmodule  //消除彈跳的模組結束         

module div1(kHz,clock); //除頻器1的模組宣告
 input clock; //輸入為clock
 output reg kHz; //保留輸出kHz的值到下一次指定新值
 reg [12:0]counter; //保留輸出counter[0]~[12]的值到下一次指定新值
 always@(posedge clock) //當clock正緣觸發時，底下的Behavioral Model的敘述會被執行
  if(counter==4999) //如果counter的值等於4999時，執行以下敘述
   begin //開始
    counter<=0; //counter的值變為0
    kHz<=~kHz; //kHz反相
   end //結束
  else //其他情況
   counter<=counter+1; //conuter的值+1
endmodule  //除頻器1的模組結束

module div2(Hz,clock); //除頻器2的模組宣告
 input clock; //輸入為clock
 output reg Hz; //保留輸出Hz的值到下一次指定新值
 reg [22:0]counter; //保留輸出counter[0]~[22]的值到下一次指定新值
 always@(posedge clock) //當clock正緣觸發時，底下的Behavioral Model的敘述會被執行
  if(counter==4999999) //如果counter的值等於4999999時，執行以下敘述
   begin //開始
    counter<=0; //counter的值變為0
    Hz<=~Hz; //Hz反相
   end //結束
  else//其他情況
   counter<=counter+1; //conuter的值+1
endmodule  //除頻器2的模組結束