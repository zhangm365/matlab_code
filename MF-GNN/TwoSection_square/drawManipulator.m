function drawManipulator(q)

p1 = [0, 0, 0];
p2 = calculateP2(q)';
p3 = calculateP3(q)';
p4 = calculateP4(q)';
p5 = calculateP5(q)';
points = [p1; p2; p3];
% draw arc according three points
arcPlot(points, 0, 1);
points = [p3; p4; p5];
arcPlot(points, 0, 2);

end