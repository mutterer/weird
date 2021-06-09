run("MacrOmero ext");

user = "JeromeMutterer2";
pass = "yourpassword";
host = "demo.openmicroscopy.org";
port = 4064;
dataset_id = 5889;

Ext.openServer(user,pass,host,port);
images = split(Ext.getImagesFromDataset(dataset_id),";");
for (i = 0; i < images.length; i++) {
	Ext.getImageFromId(images[i]);
}

Ext.closeServer();
