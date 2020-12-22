setBatchMode(true);
cols = newArray('red','green','blue','cyan','magenta','yellow','white');
run("Duplicate...", " ");
id=getImageID;
run("8-bit");
setAutoThreshold("Default");
run("Analyze Particles...", "  circularity=0.9-1.00 clear add");
selectImage(id);
close();
while(true){
Overlay.remove();
for (r=0;r<12;r++) {
i = floor(roiManager('count')*random());
roiManager('select',i);
Roi.setFillColor(cols[r%cols.length]);
Overlay.addSelection;
Overlay.show;
}
wait(5);
}
