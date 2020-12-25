print("Image form https://twitter.com/the_Node");
run("Select None");
nCircles = 48;
selectImage("nodes.jpg");
setBatchMode(true);
if(getWidth>1000){ //speeding up for web, can be rerun on same image
	run("Scale...", "x=.15 y=.15 width=756 height=756 interpolation=Bilinear average");
	run("Canvas Size...", "width=567 height=567 position=Center");
}
alphas = newArray('1f', '3f', '5f', '7f', '9f', 'bf', 'df', 'ff', 'ff', 'ff',  'ff', 'ff', 'ff', 'ff',  'ff',  'ff',  'ff',  'ff', 'df', 'bf', '9f', '7f', '5f', '3f', '1f');
run("Duplicate...", " ");
id=getImageID;
run("8-bit");
//run("Minimum...", "radius=2");
setAutoThreshold("Default");
run("Analyze Particles...", "  circularity=0.9-1.00 clear add");
selectImage(id);
close();
roiManager("Show None");
roiCount=roiManager('count');

selectImage("nodes.jpg");
run("Duplicate...", " ");
run("HSB Stack");
setSlice(3);
run("Multiply...", "value=2 slice");
run("RGB Color");
id=getImageID;
cols=newArray(roiCount);
for (i=0; i < roiCount; i++) {
	roiManager("select", i);
	getSelectionBounds(x, y, width, height);
	v=getPixel(x-1, y+height/2);
	cols[i] = substring(toHex(v), 2); 
}
selectImage(id);
close();

order=Array.getSequence(roiCount);
randomizer=newArray(roiCount);
for (i=0; i < roiCount; i++) {
	randomizer[i]=random();
}
Array.sort(randomizer, order); //to avoid flicker due to duplicates

circles = newArray(nCircles);
phases = newArray(nCircles);
for (r=0; r<nCircles; r++) {
	circles[r] = order[r];
	phases[r] = floor(random * alphas.length);
}

next=nCircles;
while(true){
	t=getTime();
	Overlay.remove();
	for (r=0;r<nCircles;r++) {	
		if (phases[r] > alphas.length-1) {
			phases[r] = 0;
			circles[r] = order[next%roiCount];
			next++;
			}
		roiManager('select', circles[r]);
		Roi.setFillColor("#" + alphas[phases[r]] + cols[circles[r]]);
		Overlay.addSelection;
		Overlay.show;
		phases[r]++;
	}
	run("Select None");
	while(t+30>getTime()) wait(5);
}
