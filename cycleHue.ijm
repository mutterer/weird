setBatchMode(1);
for (i=0;i<200;i++){
run("Duplicate...","title=hsb");
run("HSB Stack");
run("Macro...", "code=v=(v+5)%256 slice");
run("RGB Color");
run("Copy");
close();
run("Paste");
wait(10);
}
