var gamma=0.8;
var intensityMax=255;
function lambdaToColor(l) {
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
	return ""+Color.toString(r,g,b);
}

function adjust(color,factor) {
	if (color==0) return 0;
	else return round(intensityMax *pow(color*factor,gamma));
}
