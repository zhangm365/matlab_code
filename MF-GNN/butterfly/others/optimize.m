% clear all;


syms q1 q2 q3 q4 q5 q6
global d;
d = 50;
qs = [q1, q2, q3, q4, q5, q6];
tic
[x, y, z] = position(qs);
dxdq1 = diff(x, q1);dxdq2 = diff(x, q2);dxdq3 = diff(x, q3);dxdq4 = diff(x, q4);dxdq5 = diff(x, q5);dxdq6 = diff(x, q6);
dydq1 = diff(y, q1);dydq2 = diff(y, q2);dydq3 = diff(y, q3);dydq4 = diff(y, q4);dydq5 = diff(y, q5);dydq6 = diff(y, q6);
dzdq1 = diff(z, q1);dzdq2 = diff(z, q2);dzdq3 = diff(z, q3);dzdq4 = diff(z, q4);dzdq5 = diff(z, q5);dzdq6 = diff(z, q6);
dxdq1Char = char(dxdq1);dxdq2Char = char(dxdq2);dxdq3Char = char(dxdq3);dxdq4Char = char(dxdq4);dxdq5Char = char(dxdq5);dxdq6Char = char(dxdq6);
dydq1Char = char(dydq1);dydq2Char = char(dydq2);dydq3Char = char(dydq3);dydq4Char = char(dydq4);dydq5Char = char(dydq5);dydq6Char = char(dydq6);
dzdq1Char = char(dzdq1);dzdq2Char = char(dzdq2);dzdq3Char = char(dzdq3);dzdq4Char = char(dzdq4);dzdq5Char = char(dzdq5);dzdq6Char = char(dzdq6);

DJ11_1 = diff(dxdq1, q1); DJ11_2 = diff(dxdq1, q2); DJ11_3 = diff(dxdq1, q3); DJ11_4 = diff(dxdq1, q4); DJ11_5 = diff(dxdq1, q5); DJ11_6 = diff(dxdq1, q6);
DJ12_1 = diff(dxdq2, q1); DJ12_2 = diff(dxdq2, q2); DJ12_3 = diff(dxdq2, q3); DJ12_4 = diff(dxdq2, q4); DJ12_5 = diff(dxdq2, q5); DJ12_6 = diff(dxdq2, q6);
DJ13_1 = diff(dxdq3, q1); DJ13_2 = diff(dxdq3, q2); DJ13_3 = diff(dxdq3, q3); DJ13_4 = diff(dxdq3, q4); DJ13_5 = diff(dxdq3, q5); DJ13_6 = diff(dxdq3, q6);
DJ14_1 = diff(dxdq4, q1); DJ14_2 = diff(dxdq4, q2); DJ14_3 = diff(dxdq4, q3); DJ14_4 = diff(dxdq4, q4); DJ14_5 = diff(dxdq4, q5); DJ14_6 = diff(dxdq4, q6);
DJ15_1 = diff(dxdq5, q1); DJ15_2 = diff(dxdq5, q2); DJ15_3 = diff(dxdq5, q3); DJ15_4 = diff(dxdq5, q4); DJ15_5 = diff(dxdq5, q5); DJ15_6 = diff(dxdq5, q6);
DJ16_1 = diff(dxdq6, q1); DJ16_2 = diff(dxdq6, q2); DJ16_3 = diff(dxdq6, q3); DJ16_4 = diff(dxdq6, q4); DJ16_5 = diff(dxdq6, q5); DJ16_6 = diff(dxdq6, q6);

DJ11_1Char = char(DJ11_1); DJ11_2Char = char(DJ11_2); DJ11_3Char = char(DJ11_3); DJ11_4Char = char(DJ11_4); DJ11_5Char = char(DJ11_5); DJ11_6Char = char(DJ11_6);
DJ12_1Char = char(DJ12_1); DJ12_2Char = char(DJ12_2); DJ12_3Char = char(DJ12_3); DJ12_4Char = char(DJ12_4); DJ12_5Char = char(DJ12_5); DJ12_6Char = char(DJ12_6);
DJ13_1Char = char(DJ13_1); DJ13_2Char = char(DJ13_2); DJ13_3Char = char(DJ13_3); DJ13_4Char = char(DJ13_4); DJ13_5Char = char(DJ13_5); DJ13_6Char = char(DJ13_6);
DJ14_1Char = char(DJ14_1); DJ14_2Char = char(DJ14_2); DJ14_3Char = char(DJ14_3); DJ14_4Char = char(DJ14_4); DJ14_5Char = char(DJ14_5); DJ14_6Char = char(DJ14_6);
DJ15_1Char = char(DJ15_1); DJ15_2Char = char(DJ15_2); DJ15_3Char = char(DJ15_3); DJ15_4Char = char(DJ15_4); DJ15_5Char = char(DJ15_5); DJ15_6Char = char(DJ15_6);
DJ16_1Char = char(DJ16_1); DJ16_2Char = char(DJ16_2); DJ16_3Char = char(DJ16_3); DJ16_4Char = char(DJ16_4); DJ16_5Char = char(DJ16_5); DJ16_6Char = char(DJ16_6);

DJ21_1 = diff(dydq1, q1); DJ21_2 = diff(dydq1, q2); DJ21_3 = diff(dydq1, q3); DJ21_4 = diff(dydq1, q4); DJ21_5 = diff(dydq1, q5); DJ21_6 = diff(dydq1, q6);
DJ22_1 = diff(dydq2, q1); DJ22_2 = diff(dydq2, q2); DJ22_3 = diff(dydq2, q3); DJ22_4 = diff(dydq2, q4); DJ22_5 = diff(dydq2, q5); DJ22_6 = diff(dydq2, q6);
DJ23_1 = diff(dydq3, q1); DJ23_2 = diff(dydq3, q2); DJ23_3 = diff(dydq3, q3); DJ23_4 = diff(dydq3, q4); DJ23_5 = diff(dydq3, q5); DJ23_6 = diff(dydq3, q6);
DJ24_1 = diff(dydq4, q1); DJ24_2 = diff(dydq4, q2); DJ24_3 = diff(dydq4, q3); DJ24_4 = diff(dydq4, q4); DJ24_5 = diff(dydq4, q5); DJ24_6 = diff(dydq4, q6);
DJ25_1 = diff(dydq5, q1); DJ25_2 = diff(dydq5, q2); DJ25_3 = diff(dydq5, q3); DJ25_4 = diff(dydq5, q4); DJ25_5 = diff(dydq5, q5); DJ25_6 = diff(dydq5, q6);
DJ26_1 = diff(dydq6, q1); DJ26_2 = diff(dydq6, q2); DJ26_3 = diff(dydq6, q3); DJ26_4 = diff(dydq6, q4); DJ26_5 = diff(dydq6, q5); DJ26_6 = diff(dydq6, q6);

DJ21_1Char = char(DJ21_1); DJ21_2Char = char(DJ21_2); DJ21_3Char = char(DJ21_3); DJ21_4Char = char(DJ21_4); DJ21_5Char = char(DJ21_5); DJ21_6Char = char(DJ21_6);
DJ22_1Char = char(DJ22_1); DJ22_2Char = char(DJ22_2); DJ22_3Char = char(DJ22_3); DJ22_4Char = char(DJ22_4); DJ22_5Char = char(DJ22_5); DJ22_6Char = char(DJ22_6);
DJ23_1Char = char(DJ23_1); DJ23_2Char = char(DJ23_2); DJ23_3Char = char(DJ23_3); DJ23_4Char = char(DJ23_4); DJ23_5Char = char(DJ23_5); DJ23_6Char = char(DJ23_6);
DJ24_1Char = char(DJ24_1); DJ24_2Char = char(DJ24_2); DJ24_3Char = char(DJ24_3); DJ24_4Char = char(DJ24_4); DJ24_5Char = char(DJ24_5); DJ24_6Char = char(DJ24_6);
DJ25_1Char = char(DJ25_1); DJ25_2Char = char(DJ25_2); DJ25_3Char = char(DJ25_3); DJ25_4Char = char(DJ25_4); DJ25_5Char = char(DJ25_5); DJ25_6Char = char(DJ25_6);
DJ26_1Char = char(DJ26_1); DJ26_2Char = char(DJ26_2); DJ26_3Char = char(DJ26_3); DJ26_4Char = char(DJ26_4); DJ26_5Char = char(DJ26_5); DJ26_6Char = char(DJ26_6);

DJ31_1 = diff(dzdq1, q1); DJ31_2 = diff(dzdq1, q2); DJ31_3 = diff(dzdq1, q3); DJ31_4 = diff(dzdq1, q4); DJ31_5 = diff(dzdq1, q5); DJ31_6 = diff(dzdq1, q6);
DJ32_1 = diff(dzdq2, q1); DJ32_2 = diff(dzdq2, q2); DJ32_3 = diff(dzdq2, q3); DJ32_4 = diff(dzdq2, q4); DJ32_5 = diff(dzdq2, q5); DJ32_6 = diff(dzdq2, q6);
DJ33_1 = diff(dzdq3, q1); DJ33_2 = diff(dzdq3, q2); DJ33_3 = diff(dzdq3, q3); DJ33_4 = diff(dzdq3, q4); DJ33_5 = diff(dzdq3, q5); DJ33_6 = diff(dzdq3, q6);
DJ34_1 = diff(dzdq4, q1); DJ34_2 = diff(dzdq4, q2); DJ34_3 = diff(dzdq4, q3); DJ34_4 = diff(dzdq4, q4); DJ34_5 = diff(dzdq4, q5); DJ34_6 = diff(dzdq4, q6);
DJ35_1 = diff(dzdq5, q1); DJ35_2 = diff(dzdq5, q2); DJ35_3 = diff(dzdq5, q3); DJ35_4 = diff(dzdq5, q4); DJ35_5 = diff(dzdq5, q5); DJ35_6 = diff(dzdq5, q6);
DJ36_1 = diff(dzdq6, q1); DJ36_2 = diff(dzdq6, q2); DJ36_3 = diff(dzdq6, q3); DJ36_4 = diff(dzdq6, q4); DJ36_5 = diff(dzdq6, q5); DJ36_6 = diff(dzdq6, q6);

DJ31_1Char = char(DJ31_1); DJ31_2Char = char(DJ31_2); DJ31_3Char = char(DJ31_3); DJ31_4Char = char(DJ31_4); DJ31_5Char = char(DJ31_5); DJ31_6Char = char(DJ31_6);
DJ32_1Char = char(DJ32_1); DJ32_2Char = char(DJ32_2); DJ32_3Char = char(DJ32_3); DJ32_4Char = char(DJ32_4); DJ32_5Char = char(DJ32_5); DJ32_6Char = char(DJ32_6);
DJ33_1Char = char(DJ33_1); DJ33_2Char = char(DJ33_2); DJ33_3Char = char(DJ33_3); DJ33_4Char = char(DJ33_4); DJ33_5Char = char(DJ33_5); DJ33_6Char = char(DJ33_6);
DJ34_1Char = char(DJ34_1); DJ34_2Char = char(DJ34_2); DJ34_3Char = char(DJ34_3); DJ34_4Char = char(DJ34_4); DJ34_5Char = char(DJ34_5); DJ34_6Char = char(DJ34_6);
DJ35_1Char = char(DJ35_1); DJ35_2Char = char(DJ35_2); DJ35_3Char = char(DJ35_3); DJ35_4Char = char(DJ35_4); DJ35_5Char = char(DJ35_5); DJ35_6Char = char(DJ35_6);
DJ36_1Char = char(DJ36_1); DJ36_2Char = char(DJ36_2); DJ36_3Char = char(DJ36_3); DJ36_4Char = char(DJ36_4); DJ36_5Char = char(DJ36_5); DJ36_6Char = char(DJ36_6);
toc


save JacobianData1 dxdq1Char dxdq2Char dxdq3Char dxdq4Char dxdq5Char dxdq6Char dydq1Char dydq2Char dydq3Char dydq4Char dydq5Char dydq6Char dzdq1Char dzdq2Char dzdq3Char dzdq4Char dzdq5Char dzdq6Char
save JacobianData2 DJ11_1Char DJ11_2Char DJ11_3Char DJ11_4Char DJ11_5Char DJ11_6Char DJ12_1Char DJ12_2Char DJ12_3Char DJ12_4Char DJ12_5Char DJ12_6Char DJ13_1Char DJ13_2Char DJ13_3Char DJ13_4Char DJ13_5Char DJ13_6Char DJ14_1Char DJ14_2Char DJ14_3Char DJ14_4Char DJ14_5Char DJ14_6Char DJ15_1Char DJ15_2Char DJ15_3Char DJ15_4Char DJ15_5Char DJ15_6Char DJ16_1Char DJ16_2Char DJ16_3Char DJ16_4Char DJ16_5Char DJ16_6Char DJ21_1Char DJ21_2Char DJ21_3Char DJ21_4Char DJ21_5Char DJ21_6Char DJ22_1Char DJ22_2Char DJ22_3Char DJ22_4Char DJ22_5Char DJ22_6Char DJ23_1Char DJ23_2Char DJ23_3Char DJ23_4Char DJ23_5Char DJ23_6Char DJ24_1Char DJ24_2Char DJ24_3Char DJ24_4Char DJ24_5Char DJ24_6Char DJ25_1Char DJ25_2Char DJ25_3Char DJ25_4Char DJ25_5Char DJ25_6Char DJ26_1Char DJ26_2Char DJ26_3Char DJ26_4Char DJ26_5Char DJ26_6Char DJ31_1Char DJ31_2Char DJ31_3Char DJ31_4Char DJ31_5Char DJ31_6Char DJ32_1Char DJ32_2Char DJ32_3Char DJ32_4Char DJ32_5Char DJ32_6Char DJ33_1Char DJ33_2Char DJ33_3Char DJ33_4Char DJ33_5Char DJ33_6Char DJ34_1Char DJ34_2Char DJ34_3Char DJ34_4Char DJ34_5Char DJ34_6Char DJ35_1Char DJ35_2Char DJ35_3Char DJ35_4Char DJ35_5Char DJ35_6Char DJ36_1Char DJ36_2Char DJ36_3Char DJ36_4Char DJ36_5Char DJ36_6Char 