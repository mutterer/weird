// create autostereogram image
// this was the first version, create your own using ImageJ.JS
// link: https://ij.imjoy.io/?run=https://github.com/mutterer/weird/blob/master/create_template.ijm&open=https://github.com/mutterer/weird/blob/master/autostereogram2.ijm
//

run("Fresh Start");
setBatchMode(1);

// create a random pattern
size=10;
newImage("pattern", "8-bit white", 140, 700, 1);
for (i=0;i<10000;i++) {
setColor(255*random);
makeOval(-10+150*random,800*random,size+5*random,size+5*random);
fill();
}
run("Select None");
run("Copy");
close();

// create a ROI from the ImageJ icon image
open("https://github.com/mutterer/weird/raw/master/ImageJ.tif");
run("8-bit");
run("Size...", "width=600 height=600 depth=1 constrain average interpolation=Bilinear");
run("Canvas Size...", "width=1400 height=700 position=Center zero");
setThreshold(10,255);
run("Create Selection");
roiManager("add");
run("Select None");
close();

// patch pattern over image, shifting intersecting ROI part
depth=10;
shift=0;
newImage("autostereogram", "8-bit white", 140*10, 700, 1);
Image.paste(0,0); // initialise with pattern
for (i=0;i<10;i++) {
roiManager("Select", 0);
makeRectangle(140*i-shift*depth,0,140,700);
roiManager("add");
roiManager("Select", newArray(0,roiManager('count')-1));
roiManager("AND");
if (selectionType>-1){
run("Copy");
Roi.getBounds(x, y, width, height);
Image.paste(x-depth, y);
shift++;
}
makeRectangle(140*i-shift*depth,0,140,700);
run("Copy");
makeRectangle(140*(i+1)-shift*depth,0,140,700);
run("Paste");
}
run("Select None");
setBatchMode(0);
