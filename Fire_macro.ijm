run("Appearance...", "black no");
call('ij.gui.ImageWindow.centerNextImage');
newImage("Fire", "8-bit", screenWidth/5, screenHeight/5, 1);
run("Maximize");
run("Smart");
run("Invert LUT");
id=getImageID;
setBatchMode(1);
run("Duplicate...","title=t");
id2=getImageID;
while (true) {
  selectImage(id2);
  run("Add Specified Noise...", "standard=40");
  run("Median...", "radius=2");
  run("Translate...", "x=0 y=-1 interpolation=None");
  Image.copy();
  if (isOpen(id)) {
    selectImage(id);
    Image.paste(0,0);
  } else {
    break; // thanks NicoDF!
  }
}
