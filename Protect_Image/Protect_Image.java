import ij.*;
import ij.process.*;
import ij.gui.*;
import java.awt.*;
import ij.plugin.filter.*;
import java.awt.Window;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

public class Protect_Image implements PlugInFilter {
  ImagePlus imp;

  public int setup(String arg, ImagePlus imp) {
    this.imp = imp;
    return DOES_ALL;
  }

  public void run(ImageProcessor ip) {
    Window w = imp.getWindow();
    w.setBackground(new Color(255,200,200));
    WindowListener[] wls = (WindowListener[])(w.getListeners(WindowListener.class));
    
    for (int i = 0;i<wls.length;i++) {
      w.removeWindowListener(wls[i]);
    }
    imp.getWindow().addWindowListener(new WindowAdapter() {
      public void windowClosing(WindowEvent ev) {
        GenericDialog gd = new GenericDialog("Confirm closing image");
        gd.addCheckbox("I'm sure",false);
        gd.addCheckbox("This was a mistake",true);
        gd.addCheckbox("I'm sure af",false);
        gd.addCheckbox("I'm really really sure",false);
        gd.addCheckbox("This image must stay open",true);
        gd.addCheckbox("I know there's no going back",false);
        gd.addCheckbox("I won't sue anyone",false);
        gd.showDialog();
        if (gd.wasCanceled())
          return;
        if (gd.getNextBoolean()
          && !gd.getNextBoolean()
          &&  gd.getNextBoolean()
          &&  gd.getNextBoolean()
          && !gd.getNextBoolean()
          &&  gd.getNextBoolean()
          &&  gd.getNextBoolean() ) {
            imp.changes=false;
            imp.close();
        }
      }
    });
  }
}
