function drawManipulator(q)

p1 = [0, 0, 0];
p2 = calculateP2(q)';
p3 = calculateP3(q)';
p4 = calculateP4(q)';
p5 = calculateP5(q)';
points = [p1; p2; p3];
% draw arc according three points
arcPlot(points, 0, 1);
scatter3(p3(1)*1000, p3(2)*1000, p3(3)*1000,  'm', 'filled');
points = [p3; p4; p5];
arcPlot(points, 0, 2);

end