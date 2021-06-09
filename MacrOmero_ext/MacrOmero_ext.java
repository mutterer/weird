// Omero extensions for the ImageJ macro language
// based on OME demo groovy script at https://omero-guides.readthedocs.io/en/latest/
// Author Jerome Mutterer
// OME Community meeting 2021.

import java.util.ArrayList;
import java.util.Collection;
import java.util.concurrent.ExecutionException;

import ij.IJ;
import ij.macro.ExtensionDescriptor;
import ij.macro.Functions;
import ij.macro.MacroExtension;
import ij.plugin.PlugIn;
// OMERO Dependencies
import omero.gateway.Gateway;
import omero.gateway.LoginCredentials;
import omero.gateway.SecurityContext;
import omero.gateway.exception.DSAccessException;
import omero.gateway.exception.DSOutOfServiceException;
import omero.gateway.facility.BrowseFacility;
import omero.gateway.model.ExperimenterData;
import omero.gateway.model.ImageData;
import omero.log.SimpleLogger;

public class MacrOmero_ext implements PlugIn, MacroExtension {

	Gateway gateway;
	ExperimenterData exp;
	long group_id;
	long exp_id;
	int PORT;
	SecurityContext ctx;
	BrowseFacility browse;
	Collection<ImageData> col;
	String imList,HOST,USER,PASSWORD;
	
	public void run(String arg) {
		if (!IJ.macroRunning()) {
			IJ.showStatus("Cannot install extensions from outside a macro!");
			return;
		}
		Functions.registerExtensions(this);
	}
	
    private ExtensionDescriptor[] extensions = {
		ExtensionDescriptor.newDescriptor("openServer", this, ARG_STRING,ARG_STRING,ARG_STRING,ARG_NUMBER),
		ExtensionDescriptor.newDescriptor("getImagesFromDataset", this, ARG_NUMBER),
		ExtensionDescriptor.newDescriptor("getImageFromId", this,ARG_NUMBER),
		ExtensionDescriptor.newDescriptor("closeServer", this)
	};
	
	public ExtensionDescriptor[] getExtensionFunctions() {
		return extensions;
	}
	
	public String handleExtension(String name, Object[] args) {
		
		if  (name.equals("openServer")){
			USER=((String) args[0]);
			PASSWORD=((String) args[1]);
			HOST=((String) args[2]);
			LoginCredentials credentials = new LoginCredentials();
		    	    credentials.getServer().setHostname(HOST);
		    	    credentials.getUser().setUsername(USER.trim());
		    	    credentials.getUser().setPassword(PASSWORD.trim());
		    	    SimpleLogger   simpleLogger = new SimpleLogger();
		    	    gateway = new Gateway(simpleLogger);
		    	    try {
						gateway.connect(credentials);
					} catch (DSOutOfServiceException e) {
						e.printStackTrace();
					}
		    	    exp = gateway.getLoggedInUser();
		    	    group_id = exp.getGroupId();
		    	    ctx = new SecurityContext(group_id);
		    	    exp_id = exp.getId();


		    PORT = ((Double)args[3]).intValue();
         
		} else if  (name.equals("getImagesFromDataset")){

		    try {
				browse = gateway.getFacility(BrowseFacility.class);
			    ArrayList<Long> ids = new ArrayList<Long>(1);
			    ids.add(new Long(((Double)args[0]).intValue()));
			    col = browse.getImagesForDatasets(ctx, ids);
			    imList="";
			    for (ImageData img : col ) {
			    	imList = imList+img.getId()+";";
			    }
			    if (imList.endsWith(";")) 
			    	imList = imList.substring(0, imList.length() - 1);

			    return imList; 
			} catch (ExecutionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DSOutOfServiceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DSAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    return "";

		}  else if  (name.equals("getImageFromId")){
		    StringBuilder options = new StringBuilder();
		    	    options.append("location=[OMERO] open=[omero:server=");
		    	    options.append(HOST);
		    	    options.append("\nuser=");
		    	    options.append(USER.trim());
		    	    options.append("\nport=");
		    	    options.append(PORT);
		    	    options.append("\npass=");
		    	    options.append(PASSWORD.trim());
		    	    options.append("\ngroupID=");
		    	    options.append(group_id);
		    	    options.append("\niid=");
		    	    options.append(((Double)args[0]).intValue());
		    	    options.append("] ");
		    	    options.append("windowless=true view=Hyperstack ");
		    	    IJ.runPlugIn("loci.plugins.LociImporter", options.toString());
		    	    
			return ""; 			
		}  else if  (name.equals("closeServer")){
			gateway.disconnect();
		}  
		return null;
	}
}

