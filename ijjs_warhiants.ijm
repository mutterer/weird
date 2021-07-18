setBatchMode(1);
run("Duplicate...","title=temp");
Color.setForeground("blue");floodFill(0, 0);
run("Size...", "width="+Image.width+" height="+Image.height+" depth="+hues+" constrain average interpolation=Bilinear");
run("HSB Stack");
Stack.getDimensions(width, height, channels, slices, frames);
Stack.setChannel(1);
for(i=1; i<=slices; i++) {
      Stack.setSlice(i);
      run("Macro...", "code=v=(v+"+i*256/hues+")%256 slice");
}
run("RGB Color", "slices keep");
run("Make Montage...", "scale=1");
setBatchMode(0);
