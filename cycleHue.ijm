setBatchMode(1);
i=0;
while (1){
i=i+5;
run("Duplicate...","title=hsb");
run("HSB Stack");
run("Macro...", "code=v="+i+"%256 slice");
run("RGB Color");
run("Copy");
close();
run("Paste");
wait(10);
}
