var gamma=0.8;
var intensityMax=255;
var r,g,b;

min = 380;
max = 780;
width = 512;
height = 60;
smooth = 4;
dash = 10;
ticks = newArray(405,488,561);

setBatchMode(true);
newImage("Spectrum "+min+"-"+max+"nm", "RGB", width, height, 1);
for (i=0;i<getWidth;i++) {
  lambdaToRgb(min+i*(max-min)/width);
  setColor(r,g,b);
  drawLine(i, 0, i, height);
}
if (smooth>0) run("Gaussian Blur...","sigma=&smooth");
for (i=0;i<ticks.length;i++) {
x=width*(ticks[i]-min)/(max-min);
for (j=0;j<height/dash;j++)
{
setColor("white");
drawLine(x, j*dash, x, (j+0.5)*dash);
setColor("black");
drawLine(x, (j+0.5)*dash, x, (j+1)*dash);
}
setFont("SansSerif", 12, "bold antialiased");
setColor("black");
Overlay.drawString(ticks[i],x, getStringWidth(ticks[i]), -90.0);
Overlay.show();
setColor("white");
Overlay.drawString(ticks[i],x-1, getStringWidth(ticks[i])-1, -90.0);
Overlay.show();
}
setBatchMode(false);

function lambdaToRgb(l) {
  // adapted from efg2.com/Lab/ScienceAndEngineering/Spectra.htm
  if ((l>=380)&&(l<440)) { r=-(l-440)/(440-380); g=0; b=1; }
  else if ((l>=440)&&(l<490)) { r=0; g=(l-440)/(490-440); b=1; }
  else if ((l>=490)&&(l<510)) { r=0; g=1; b=-(l-510)/(510-490); }
  else if ((l>=510)&&(l<580)) { r=(l-510)/(580-510); g=1; b=0; }
  else if ((l>=580)&&(l<645)) { r=1; g=-(l-645)/(645-580); b=0; }
  else if ((l>=645)&&(l<780)) { r=1; g=0; b=0; }
  else { r=0; g=0; b=0; }
  if ((l>=380)&&(l<420)) { factor=0.3+0.7*(l-380)/(420-380);}
  else if ((l>=420)&&(l<701)) { factor=1;}
  else if ((l>=701)&&(l<780)) { factor=0.3+0.7*(780-l)/(780-700);}
  else factor=0;
  r=adjust(r, factor);
  g=adjust(g, factor);
  b=adjust(b, factor);
}

function adjust(color,factor) {
  if (color==0) return 0;
  else return round(intensityMax *pow(color*factor,gamma));
}
