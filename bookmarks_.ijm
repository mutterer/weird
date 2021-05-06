macro "bookmarks [F1]" {
// captures current display settings 
// as bookmarks
// if a bookmark is selected press F1 and the display is updated
// if no bookmark is selected, anew bookmark is added
// using the current view.

if (isOpen("Bookmarks")) selectWindow("Bookmarks");
else Table.create("Bookmarks");
row=Table.getSelectionStart;
if (row>-1) {
  // restore view
  // window position
  wx=Table.get("winX", row);
  wy=Table.get("winY", row);
  wwidth=Table.get("winW", row);
  wheight=Table.get("winH", row);
  setLocation(wx, wy, wwidth, wheight);

  // displayed area
  x=Table.get("dispX", row);
  y=Table.get("dispY", row);
  width=Table.get("dispW", row);
  height=Table.get("dispH", row);
  makeRectangle(x, y, width, height);
  run("To Selection");
  run("Select None");
  zoom=Table.get("Zoom", row);
  run("Set... ", "zoom=&zoom"); 
  Stack.getDimensions(w, h, cs, ss, fs);
  // mode  
  m=Table.getString("Mode", row);
  if (m!='-') Stack.setDisplayMode(m);
  // czt position
  c=Table.get("C", row);
  s=Table.get("Z", row);
  f=Table.get("T", row);

  // displayed channels
  a=Table.getString("ActChan", row);
  if (cs>1) Stack.setActiveChannels(a);
   for (i=0;i<cs;i++) {
    if (cs>1) Stack.setChannel(i+1);
    setMinAndMax(Table.get("min_"+i+1, row), Table.get("max_"+i+1, row));
  }
    Stack.setPosition(c, s, f);
} else {
  // bookmark view
  row = Table.size;
  bookmark = getString("New Bookmark","Wow_"+row+1);
  Table.showRowIndexes(true);

  // image and bookmark
  Table.set("Bookmark", row, bookmark);
  Table.set("Image", row, getTitle);

  Stack.getDimensions(w, h, cs, ss, fs);

  m="-";
  if (cs*ss*fs>1) Stack.getDisplayMode(m);
  Table.set("Mode", row, m);

  // czt position
  Stack.getPosition(c, s, f);
  Table.set("C", row, c);
  Table.set("Z", row, s);
  Table.set("T", row, f);

  // displayed channels
  a="1";
  if (cs>1) Stack.getActiveChannels(a);
  Table.set("ActChan", row, a);

  // displayed area
  getDisplayedArea(x, y, width, height);
  xc=x+width/2;
  yc=y+height/2;
  zoom=100*getZoom();
  Table.set("dispX", row, x);
  Table.set("dispY", row, y);
  Table.set("dispW", row, width);
  Table.set("dispH", row, height);
  Table.set("Zoom", row, zoom);

  // window location and size
  getLocationAndSize(wx, wy, wwidth, wheight);
  Table.set("winX", row, wx);
  Table.set("winY", row, wy);
  Table.set("winW", row, wwidth);
  Table.set("winH", row, wheight);

  Table.set("Playing", row, is("animated"));
  mins=newArray(cs);
  maxs=newArray(cs);
  for (i=0;i<cs;i++) {
    if (cs>1) Stack.setChannel(i+1);
    getMinAndMax(min, max);
    mins[i] = min;
    Table.set("min_"+i+1, row, min);
    maxs[i] = max;
    Table.set("max_"+i+1, row, max);
  }
  Stack.setPosition(c, s, f);

// copy to clipboard for pasting into inkscape panels
str = "open('"+File.directory+File.name+"');\n";
Stack.getDimensions(w, h, cs, ss, fs)
str=str+"Stack.setDisplayMode('"+m+"');\n";"
for (i=0;i<cs;i++) {
  str=str+"Stack.setChannel('"+i+1+"');\n";
  str=str+"setMinAndMax("+mins[i]+","+maxs[i]+");\n";
}
str=str+"Stack.setActiveChannels('"+a+"');\n";
str=str+"Stack.setPosition("+c+","+s+","+f+");\n";
String.copy(str);

}
}

