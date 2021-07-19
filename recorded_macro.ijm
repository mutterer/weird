run("Blobs (25K)");
run("Duplicate...", "title=copy");
run("Find Maxima...", "prominence=100 light output=[Segmented Particles]");
run("Analyze Particles...", "  show=[Count Masks]");
run("Glasbey");
run("RGB Color");
selectWindow("copy");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Select All");
run("Copy");
close();
selectWindow("Count Masks of copy Segmented");
setPasteMode("Blend");
run("Paste");

