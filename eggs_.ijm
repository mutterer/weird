newImage("Easter Eggs", "8-bit noise", 320, 24, 1);
run("Spectrum");
getLut(r, g, b);
run("Green");
run("Divide...", "value=2");
run("Macro...", "code=v=v+255*(random<0.1)");
run("Size...", "width=640 height=480 depth=1 average interpolation=Bilinear");
makePolygon(100,25, 80,40,75,90,100,105,125,90,120,40);
run("Fit Spline");
Overlay.addSelection;
for (i=0; i<75; i++) {
  Overlay.activateSelection(0);
  f = 1+0.5*random;
  run("Scale... ", "x=&f y=&f");
  a = 180*random;
  run("Rotate...", "  angle=&a");
  Roi.move((getWidth-100)*random, (getHeight-100)*random);
  c = 255*random;
  Roi.setFillColor(r[c], g[c], b[c]);
  Overlay.addSelection;
  Roi.copy; Roi.paste; //clone
  Roi.setFillColor("none");
  Roi.setStrokeColor("white");
  Roi.setStrokeWidth(2);
  Overlay.addSelection;
}
run("Select None");
Overlay.removeSelection(0);
