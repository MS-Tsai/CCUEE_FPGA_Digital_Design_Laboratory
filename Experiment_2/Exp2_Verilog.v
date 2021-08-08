module exp2(s,cout,led,x,y,cin);//4-bits���[���Ҳիŧi
 input [3:0]x,y;//��J��4-bits�@8�ӥ[��x[0]~x[3],y[0]~y[3]
 input cin;//�t�@�ӿ�J���i���cin
 output [3:0]s;//��X��4-bits����Ms[0]~s[3]
 output cout,led;//�t�@�ӿ�X������i��cout
 wire k;//4-bits���[�����޿�q���Ϥ��|�Ψ�@���u�s�����P���Ҳ�
 F2 z3(s[1:0],k,x[1:0],y[1:0],cin);//�ϥ�2-bits���[�����Ҳ�F2 s[0]~s[1],j����X�Fx[0]~x[1],y[0]~y[1],ci����J
 F2 z4(s[3:2],cout,x[3:2],y[3:2],k);//�A�ϥΤ@��2-bits���[�����Ҳ�F2 s[2]~s[3],j����X�Fx[2]~x[3],y[2]~y[3],ci����J
 assign led=1'b1;//��ȵ�led��1�줸2�i���
endmodule //4-bits���[���Ҳյ���

module F2(s,co,a,b,ci);//2-bits���[���Ҳիŧi
 input [1:0]a,b;//��J��2-bits�@�|�ӥ[��a[0],a[1],b[0],b[1]
 input ci;//�t�@�ӿ�J���i���ci
 output [1:0]s;//��X��2-bits����Ms[0],[1]
 output co;//�t�@�ӿ�X������i��co
 wire j;//2-bits���[�����޿�q���Ϥ��|�Ψ�@���u�s�����P���Ҳ�
 F1 z1(s[0],j,a[0],b[0],ci);//�ϥ�1-bit���[�����Ҳ�F1 s[0],j����X�Fa[0],b[0],ci����J
 F1 z2(s[1],co,a[1],b[1],j);//�A�ϥΤ@��1-bit���[�����Ҳ�F1 s[1],co����X�Fa[1],b[1],j����J
endmodule //2-bits���[���Ҳյ���

module F1(s,cout,a,b,cin);//1-bit���[���Ҳիŧi
 input a,b,cin;//��J����ӥ[��a b�M�i���cin
 output s,cout;//��X������Ms�M����i��cout
 wire g,h,i;// 1-bit���[�����޿�q���Ϥ��|�Ψ�T���u�s�����P���޿�h
 xor x1(g,a,b);//�޿�hXOR�A��J��a b�F��X��g
 and a1(h,a,b);//�޿�hAND�A��J��a b�F��X��h
 xor x2(s,g,cin);//�޿�hXOR�A��J��g cin�F��X��s
 and a2(i,g,cin);//�޿�hAND�A��J��g cin�F��X��i
 xor x3(cout,i,h);//�޿�hXOR�A��J��i h�F��X��cout
endmodule //1-bit���[���Ҳյ���
