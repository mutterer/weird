#@ String(label="Username", value='JeromeMutterer2') user
#@ String(style="password", label="Enter your password", persist = false) pass
#@ String(label="Host", value='demo.openmicroscopy.org') host
#@ Integer(label="Port", value=4064) port
#@ Integer(label="Dataset ID", value=5889) dataset_id

run("MacrOmero ext");

Ext.openServer(user,pass,host,port);
images = split(Ext.getImagesFromDataset(dataset_id),";");
for (i = 0; i < images.length; i++) {
	Ext.getImageFromId(images[i]);
}

Ext.closeServer();
