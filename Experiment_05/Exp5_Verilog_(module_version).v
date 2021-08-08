module exp5(counter,led,MHz,PS3);
 input MHz,PS3;
 output led;
 output [2:0]counter;
 wire kHz,nb;
 
 divi di1(kHz,MHz);
  
 debounce de1(nb,kHz,PS3);
 
 count c1(counter[2:0],PS3,nb);
  
 assign led=1'b1;
endmodule 

module divi(kHz,MHz);
 input MHz;
 output reg kHz;
 reg [12:0]counter;
 always@(posedge MHz)
  begin
	if (counter==4999)
	 begin
	  counter<=0;
      kHz<=~kHz;
	 end
	else
	 counter<=counter+1;
  end
endmodule 

module debounce(out,kHz,in);
 input kHz,in;
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
 and(out,d[6],d[5],d[4],d[3],d[2],d[1],d[0]);
endmodule

module count(counter,PS3,nb);
 input PS3,nb;
 output reg [2:0]counter;
 always@(posedge PS3)
  begin
	if(nb==1)
	 begin
	   if (counter==7)
		counter<=0;
	   else
		counter<=counter+1;
	 end
  end
endmodule 