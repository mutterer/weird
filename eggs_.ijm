newImage("Easter Eggs", "8-bit noise", 640, 480, 1);
setForegroundColor(255, 255, 255);
run("Spectrum");
getLut(r, g, b);
run("Green");
run("RGB Color");
makePolygon(100,25, 80,40,75,90,100,105,125,90,120,40);
run("Fit Spline");
roiManager("Add");
for (i=0;i<100;i++) {
  roiManager("Select", 0);
  f = random+0.3;
  run("Scale... ", "x=&f y=&f");
  Roi.move((getWidth-100)*random, (getHeight-100)*random);
  c = 255*random;
  setColor(r[c], g[c], b[c]);
  run("Fill");
  run("Draw");
}
run("Select None");
