function [J, DJ] = Jacobian2(q, dq)

load data\JacobianData1.mat
load data\JacobianData2.mat


syms q1 q2 q3 q4 q5 q6

q1 = q(1);q2=q(2);q3=q(3);q4=q(4);q5=q(5);q6=q(6);

DJ11 = [eval(DJ11_1Char),eval(DJ11_2Char), eval(DJ11_3Char), eval(DJ11_4Char), eval(DJ11_5Char), eval(DJ11_6Char)]*dq;
DJ12 = [eval(DJ12_1Char),eval(DJ12_2Char), eval(DJ12_3Char), eval(DJ12_4Char), eval(DJ12_5Char), eval(DJ12_6Char)]*dq;
DJ13 = [eval(DJ13_1Char),eval(DJ13_2Char), eval(DJ13_3Char), eval(DJ13_4Char), eval(DJ13_5Char), eval(DJ13_6Char)]*dq;
DJ14 = [eval(DJ14_1Char),eval(DJ14_2Char), eval(DJ14_3Char), eval(DJ14_4Char), eval(DJ14_5Char), eval(DJ14_6Char)]*dq;
DJ15 = [eval(DJ15_1Char),eval(DJ15_2Char), eval(DJ15_3Char), eval(DJ15_4Char), eval(DJ15_5Char), eval(DJ15_6Char)]*dq;
DJ16 = [eval(DJ16_1Char),eval(DJ16_2Char), eval(DJ16_3Char), eval(DJ16_4Char), eval(DJ16_5Char), eval(DJ16_6Char)]*dq;
DJ21 = [eval(DJ21_1Char),eval(DJ21_2Char), eval(DJ21_3Char), eval(DJ21_4Char), eval(DJ21_5Char), eval(DJ21_6Char)]*dq;
DJ22 = [eval(DJ22_1Char),eval(DJ22_2Char), eval(DJ22_3Char), eval(DJ22_4Char), eval(DJ22_5Char), eval(DJ22_6Char)]*dq;
DJ23 = [eval(DJ23_1Char),eval(DJ23_2Char), eval(DJ23_3Char), eval(DJ23_4Char), eval(DJ23_5Char), eval(DJ23_6Char)]*dq;
DJ24 = [eval(DJ24_1Char),eval(DJ24_2Char), eval(DJ24_3Char), eval(DJ24_4Char), eval(DJ24_5Char), eval(DJ24_6Char)]*dq;
DJ25 = [eval(DJ25_1Char),eval(DJ25_2Char), eval(DJ25_3Char), eval(DJ25_4Char), eval(DJ25_5Char), eval(DJ25_6Char)]*dq;
DJ26 = [eval(DJ26_1Char),eval(DJ26_2Char), eval(DJ26_3Char), eval(DJ26_4Char), eval(DJ26_5Char), eval(DJ26_6Char)]*dq;
DJ31 = [eval(DJ31_1Char),eval(DJ31_2Char), eval(DJ31_3Char), eval(DJ31_4Char), eval(DJ31_5Char), eval(DJ31_6Char)]*dq;
DJ32 = [eval(DJ32_1Char),eval(DJ32_2Char), eval(DJ32_3Char), eval(DJ32_4Char), eval(DJ32_5Char), eval(DJ32_6Char)]*dq;
DJ33 = [eval(DJ33_1Char),eval(DJ33_2Char), eval(DJ33_3Char), eval(DJ33_4Char), eval(DJ33_5Char), eval(DJ33_6Char)]*dq;
DJ34 = [eval(DJ34_1Char),eval(DJ34_2Char), eval(DJ34_3Char), eval(DJ34_4Char), eval(DJ34_5Char), eval(DJ34_6Char)]*dq;
DJ35 = [eval(DJ35_1Char),eval(DJ35_2Char), eval(DJ35_3Char), eval(DJ35_4Char), eval(DJ35_5Char), eval(DJ35_6Char)]*dq;
DJ36 = [eval(DJ36_1Char),eval(DJ36_2Char), eval(DJ36_3Char), eval(DJ36_4Char), eval(DJ36_5Char), eval(DJ36_6Char)]*dq;


dxdq = [eval(dxdq1Char), eval(dxdq2Char), eval(dxdq3Char), eval(dxdq4Char), eval(dxdq5Char), eval(dxdq6Char)];
dydq = [eval(dydq1Char), eval(dydq2Char), eval(dydq3Char), eval(dydq4Char), eval(dydq5Char), eval(dydq6Char)];
dzdq = [eval(dzdq1Char), eval(dzdq2Char), eval(dzdq3Char), eval(dzdq4Char), eval(dzdq5Char), eval(dzdq6Char)];

J = [dxdq; dydq; dzdq];
DJ = [DJ11, DJ12, DJ13, DJ14, DJ15, DJ16;
      DJ21, DJ22, DJ23, DJ24, DJ25, DJ26;
      DJ31, DJ32, DJ33, DJ34, DJ35, DJ36];