module exp3(P,led,A,B);//�L���ƭ��k���Ҳիŧi
 input [3:0]A,B;//��J��4-bits�@8�Ӽ�A[0]~A[3],B[0]~B[3]
 output [7:0]P;//��X��8-bits�@8�Ӽ�P[0]~P[7]
 output led;//��XLED�O
 wire [15:0]a;//�L���ƭ��k�����޿�q���Ϥ��|�Ψ�16���u�s�����P���Ҳ�
 wire [9:0]s;//�L���ƭ��k�����޿�q���Ϥ��|�Ψ�10���u�s�����P���Ҳ�
 and a1(P[0],A[0],B[0]);//�޿�hAND�A��J��A[0] B[0]�F��X��P[0]
 and a2(a[0],A[1],B[0]);//�޿�hAND�A��J��A[1] B[0]�F��X��a[0]
 and a3(a[1],A[2],B[0]);//�޿�hAND�A��J��A[2] B[0]�F��X��a[1]
 and a4(a[2],A[3],B[0]);//�޿�hAND�A��J��A[3] B[0]�F��X��a[2]
 assign a[3]=1'b0;//�ŧia[3]��1�줸,2�i��,�ƭȬ�0
 and a5(a[4],A[0],B[1]);//�޿�hAND�A��J��A[0] B[1]�F��X��a[4]
 and a6(a[5],A[1],B[1]);//�޿�hAND�A��J��A[1] B[1]�F��X��a[5]
 and a7(a[6],A[2],B[1]);//�޿�hAND�A��J��A[2] B[1]�F��X��a[6]
 and a8(a[7],A[3],B[1]);//�޿�hAND�A��J��A[3] B[1]�F��X��a[7]
 and a9(a[8],A[0],B[2]);//�޿�hAND�A��J��A[0] B[2]�F��X��a[8]
 and a10(a[9],A[1],B[2]);//�޿�hAND�A��J��A[1] B[2]�F��X��a[9]
 and a11(a[10],A[2],B[2]);//�޿�hAND�A��J��A[2] B[2]�F��X��a[10]
 and a12(a[11],A[3],B[2]);//�޿�hAND�A��J��A[3] B[2]�F��X��a[11]
 and a13(a[12],A[0],B[3]);//�޿�hAND�A��J��A[0] B[3]�F��X��a[12]
 and a14(a[13],A[1],B[3]);//�޿�hAND�A��J��A[1] B[3]�F��X��a[13]
 and a15(a[14],A[2],B[3]);//�޿�hAND�A��J��A[2] B[3]�F��X��a[14]
 and a16(a[15],A[3],B[3]);//�޿�hAND�A��J��A[3] B[3]�F��X��a[15]
 exp2 z5(s[3:0],s[4],a[3:0],a[7:4],0);//�ϥ�4-bits���[�����Ҳ�exp2 s[0]~s[3],s[4]����X;a[0]~a[3],a[4]~a[7]����J,cin�Ȭ�0
 assign P[1]=s[0];//�ŧiP[1]���ȵ���s[0]����
 exp2 z6(s[8:5],s[9],s[4:1],a[11:8],0);//�A�ϥ�4-bits���[�����Ҳ�exp2 s[5]~s[8],s[9]����X;s[1]~s[4],a[8]~a[11]����J,cin�Ȭ�0
 assign P[2]=s[5];//�ŧiP[2]���ȵ���s[5]����
 exp2 z7(P[6:3],P[7],s[9:6],a[15:12],0);//�A�ϥ�4-bits���[�����Ҳ�exp2 P[3]~P[6],P[7]����X;s[6]~a[9],a[12]~a[15]����J,cin�Ȭ�0
 assign led=1'b1;//�ŧiLED�O��1�줸,�G�i��,�ƭȬ�1
endmodule //�L���ƭ��k���Ҳյ���
 
module exp2(sum,cout,x,y,cin);//4-bits���[���Ҳիŧi
 input [3:0]x,y;//��J��4-bits�@8�ӥ[��x[0]~x[3],y[0]~y[3]
 input cin;//�t�@�ӿ�J���i���cin
 output [3:0]sum;//��X��4-bits����Msum[0]~sum[3]
 output cout;//�t�@�ӿ�X������i��cout
 wire k;//4-bits���[�����޿�q���Ϥ��|�Ψ�@���u�s�����P���Ҳ�
 F2 z3(sum[1:0],k,x[1:0],y[1:0],cin);//�ϥ�2-bits���[�����Ҳ�F2 sum[0]~sum[1],j����X�Fx[0]~x[1],y[0]~y[1],ci����J
 F2 z4(sum[3:2],cout,x[3:2],y[3:2],k);//�A�ϥΤ@��2-bits���[�����Ҳ�F2 sum[2]~sum[3],j����X�Fx[2]~x[3],y[2]~y[3],ci����J
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
