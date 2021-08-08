module timer (mclk, enable, speed, rst, seg, de);
	input mclk, enable, speed, rst;
	output reg [2:0]de;
	output reg [6:0]seg;
	reg [3:0] h_1, h_0, m_1, m_0, s_1, s_0;
	wire kclk, de_rst, clk, timer_clk;
	wire [3:0] decode;
	div khz (mclk, kclk);
	debounce d (kclk, rst, de_rst);
	always @ (posedge kclk)
	begin
	if (de == 5)
		de = 0;
	else
		de = de+1;
	end
//	assign h_1 = 0;
//	assign h_0 = 1;
//	assign m_1 = 2;
//	assign m_0 = 3;
//	assign s_1 = 4;
//	assign s_0 = 5;
	div_2 d_2 (kclk, clk);
	assign timer_clk = speed ? kclk : clk;
	always @ (posedge timer_clk or posedge rst)
	begin
	if (rst == 1)
		begin
		h_1 = 0;
		h_0 = 0;
		m_1 = 0;
		m_0 = 0;
		s_1 = 0;
		s_0 = 0;
		end
	else if (enable == 1)
		begin
		if(s_0 == 4'd9 && s_1 == 4'd5)
			begin
			s_1 = 4'd0;
			s_0 = 4'd0;
			end
		else if (s_0 == 4'd9)
			begin
			s_1 = s_1 + 4'd1;
			s_0 = 4'd0;
			end
		else 
			s_0 = s_0 + 4'd1;
        
		if(m_0 == 4'd9 && m_1 == 4'd5 && s_0 == 4'd9 && s_1 == 4'd5)
			begin
			m_1 = 4'd0;
			m_0 = 4'd0;
			end
		else if (m_0 == 4'd9 && s_0 == 4'd9 && s_1 == 4'd5)
			begin
			m_1 = m_1 + 4'd1;
			m_0 = 4'd0;
			end
        else if (s_0 == 4'd9 && s_1 == 4'd5)
            m_0 = m_0 + 4'd1;
			
		if(h_0 == 4'd1 && h_1 == 4'd1 && m_0 == 4'd9 && m_1 == 4'd5 && s_0 == 4'd9 && s_1 == 4'd5)
			begin
			h_1 = 4'd0;
			h_0 = 4'd0;
			end
		else if (h_0 == 9 && m_0 == 4'd9 && m_1 == 4'd5 && s_0 == 4'd9 && s_1 == 4'd5)
			begin 
			h_0 = 4'd0;
			h_1 = h_1 + 4'd1;
			end
        else if (m_0 == 4'd9 && m_1 == 4'd5 && s_0 == 4'd9 && s_1 == 4'd5)
            h_0 = h_0 + 4'd1;
            
		end
	end
	assign decode = de[2]?(de[1]?(de[0]?s_0:s_0):(de[0]?s_0:s_1)):(de[1]?(de[0]?m_0:m_1):(de[0]?h_0:h_1));
	always @(decode)
		case (decode)
			4'd0 : seg = 7'b1111_110;
			4'd1 : seg = 7'b0110_000;
			4'd2 : seg = 7'b1101_101;
			4'd3 : seg = 7'b1111_001;
			4'd4 : seg = 7'b0110_011;
			4'd5 : seg = 7'b1011_011;
			4'd6 : seg = 7'b1011_111;
			4'd7 : seg = 7'b1110_000;
			4'd8 : seg = 7'b1111_111;
			4'd9 : seg = 7'b1111_011;
			default : seg = 7'b0011_111;
		endcase

endmodule

module div(in,out);
	input in;
	output reg out;
	reg [12:0]counter;
	always@(posedge in)
	if (counter==4999)
		begin
		counter<=0;
		out<=~out;
		end
	else
		counter<=counter+1;
endmodule

module div_2(in,out);
	input in;
	output reg out;
	reg [8:0]counter;
	always@(posedge in)
	if (counter == 499)
		begin
		counter<=0;
		out<=~out;
		end
	else
		counter<=counter+1;
endmodule

module debounce(kHz,in,out);
	input kHz,in;
	output out;
	reg [6:0]d;
	always@(posedge kHz)
		begin
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

