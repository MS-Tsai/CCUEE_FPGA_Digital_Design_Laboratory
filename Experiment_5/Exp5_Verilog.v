module exp5(counter,led,MHz,PS3); //三位元計數器模組宣告
 input MHz,PS3; //輸入為MHz,PS3
 output led; //輸出為led燈
 output reg [2:0]counter; //輸出為3-bits共3個數counter[0]~[2]
 reg kHz; //保留kHz的值到下一次指定新值
 reg [12:0]count; //保留count[0]~[12]的值到下一次指定新值
 wire nb; //三位元計數器的邏輯電路圖中會用到1條線連接不同的模組
 always@(posedge MHz) //當MHz正緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //Behavioral Model開始
	if (count==4999) //如果count的值等於4999時，執行以下敘述
	 begin //開始
	  count<=0; //count的值變為0
      kHz<=~kHz; //kHz反相
	 end //結束
	else //其他情況
	 count<=count+1; //count的值+1
  end //Behavioral Model結束
  
  debounce d1(nb,kHz,PS3); //使用消除彈跳的模組，輸出為nb，輸入為kHz,PS3
 
  always@(posedge PS3) //當PS3正緣觸發時，底下的Behavioral Model的敘述會被執行
   begin //Behavioral Model開始
	 if(nb==1) //如果nb的值=1時，執行以下敘述
	  begin //開始
	   if (counter==7) //如果counter的值等於7時，執行以下敘述
		counter<=0; //counter的值變為0
	   else //其他情況
		counter<=counter+1; //counter的值+1
	  end //結束
   end //Behavioral Model結束
 assign led=1'b1; //宣告LED燈為1位元,二進制,數值為1
endmodule //三位元計數器模組結束

module debounce(out,kHz,in); //消除彈跳的模組宣告
 input kHz,in; //輸入為kHz,in
 output out; //輸出為out
 reg [10:0]d; //保留d[0]~d[10]的值到下一次指定新值
 always@(posedge kHz) //當kHz正緣觸發時，底下的Behavioral Model的敘述會被執行
  begin //Behavioral Model開始
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
  end //Behavioral Model結束
 and(out,d[6],d[5],d[4],d[3],d[2],d[1],d[0]); //邏輯閘AND，輸入為d[0]~d[6]；輸出為out
endmodule //消除彈跳的模組結束
