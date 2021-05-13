macro "ASCII art Tool - C000T0f06AT5f06ST9f06CLd9dfLf9ff" {
  print('\\Clear');
  eval('script','WindowManager.getWindow("Log").getTextPanel().setFont(new Font("Monospaced",Font.PLAIN,12),true);');
  s=' .:-=+*#%@';
  setBatchMode(1);
  getCursorLoc(x, y, z, modifiers);
  while (modifiers&16>0) {
    run('Remove Overlay');
    getCursorLoc(x, y, z, modifiers);
    makeRectangle(x-64, y-64, 128, 128);
    run('Add Selection...','');
    run('Duplicate...','title=temp');
    run('Invert');
    run('Divide...', 'value=27');
    ps='';
    for (i=0;i<128;i=i+3){
      makeLine(0,i,getWidth,i);
      p=getProfile();
      for (j=0;j<p.length;j++)
        ps=ps+s.substring(p[j],p[j]+1);
      ps=ps+'\n';
    }
    print('\\Clear');
    print(ps);
    close();
  }
}
