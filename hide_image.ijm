
c="https://upload.wikimedia.org/wikipedia/commons/";

// open image and make it 1-bit dither
open(c+"3/30/ZX81.jpg");
run("8-bit");
run("Size...", "width=256 constrain average interpolation=Bilinear");
run("Floyd Steinberg Dithering");
run("Divide...", "value=255");
run("Copy");

// open char map image and merge with previous image
open(c+"3/35/ZX81_characters_0x00-3F%2C_0x80-BF.png");
setBackgroundColor(255, 255, 255);
run("Canvas Size...", "width=256 height=254 position=Top-Center zero");
Image.paste(0,64,"copy");
run("Macro...", "code=v=(v+1)%2");
run("Select All");
run("Copy");

// open blobs and inject hidden image
run("Blobs (25K)");
Image.paste(0,0,"add");

// extract least significant bit image
run("Macro...", "code=v=255*(v&1)");
wait(2000);
run("Undo");
