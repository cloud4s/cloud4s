package com.cse.cloud4s.service.Impl;

import com.cse.cloud4s.service.DropBoxApi;
import com.dropbox.core.*;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Locale;

/**
 * Created by hp on 12/5/2014.
 */

@Service("DropBox")
public class DropBoxApiImpl implements DropBoxApi {
    static String url;
    static DbxRequestConfig config;
    static DbxWebAuthNoRedirect webAuth;
    private final String USER_AGENT = "Mozilla/34.0.5";

//    public DbxWebAuthNoRedirect connect() throws IOException,DbxException {         //connect to dropbox .returns object of DbxClient.APP_KEY and APP_SECRET should be developers one.
    public void connect() throws IOException,DbxException {         //connect to dropbox .returns object of DbxClient.APP_KEY and APP_SECRET should be developers one.

        final String APP_KEY = "uthwboamsw1alja";
        final String APP_SECRET = "izzrpf8qfw0veqw";

        DbxAppInfo appInfo = new DbxAppInfo(APP_KEY, APP_SECRET);

      this.config = new DbxRequestConfig("JavaTutorial/1.0",Locale.getDefault().toString());

        DbxWebAuthNoRedirect webAuth = new DbxWebAuthNoRedirect(config, appInfo);

        // Have the user sign in and authorize your app.
        String authorizeUrl = webAuth.start();
        authorizeUrl += "&redirect_uri=http://localhost:8080/dash";
        System.out.println("1. Go to: " + authorizeUrl);
        System.out.println("2. Click \"Allow\" (you might have to log in first)");
        System.out.println("3. Copy the authorization code.");

        try {
            getToken(authorizeUrl);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Desktop.getDesktop().browse(java.net.URI.create(authorizeUrl));

//            String code = this.getCode(authorizeUrl);
        this.webAuth=webAuth;
//        return webAuth;
    }

//     public DbxClient verify(DbxWebAuthNoRedirect webAuth)throws IOException,DbxException{
     public DbxClient verify(String code)throws IOException,DbxException{

//        String code = new BufferedReader(new InputStreamReader(System.in)).readLine().trim(); //Code should be pasted to console

        // This will fail if the user enters an invalid authorization code.
        DbxAuthFinish authFinish = webAuth.finish(code);

        DbxClient client = new DbxClient(config, authFinish.accessToken);

        System.out.println("Linked account: " + client.getAccountInfo().displayName);
        System.out.println("Details: "+ client.getAccountInfo().country);

        return client;

    }

    public void uploadFile(DbxClient client,String name,String path) throws IOException,DbxException{ //uploading file..should identify path name and path


        String fileName = name;
        String localPath = path+fileName;
        String DropboxPath="/Files/"+fileName;
        File inputFile = new File(localPath);
        FileInputStream inputStream = new FileInputStream(inputFile);
        try {
            DbxEntry.File uploadedFile = client.uploadFile(DropboxPath,
                    DbxWriteMode.add(), inputFile.length(), inputStream);
            System.out.println("Uploaded: " + uploadedFile.toString());
            url=uploadedFile.path;
        } finally {
            inputStream.close();
        }
    }

    public void downloadfile(DbxClient client,String filename,String path) throws DbxException,IOException{ //file name should be in string of downloading file.path should be where to be downloaded
        FileOutputStream outputStream = new FileOutputStream("C:/Users/hp/Downloads/"+filename);
        try {
            DbxEntry.File downloadedFile = client.getFile(path,null,outputStream);
            System.out.println("Metadata: " + downloadedFile.toString());
        } finally {
            outputStream.close();
        }
    }

    public DbxEntry.WithChildren loadfiles(DbxClient client) throws DbxException { //loading details of files.  only printing name and icon name.there are other attributes also.eg: child.attr
        DbxEntry.WithChildren listing = client.getMetadataWithChildren("/Files");
        System.out.println("Files in the root path:");
        for (DbxEntry child : listing.children) {
            System.out.println("    " + child.name + ": " + child.iconName+":"+child.path);
        }
        return listing;
    }

    private void getToken(String url) throws Exception {
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        // optional default is GET
        con.setRequestMethod("GET");

        //add request header
        con.setRequestProperty("User-Agent", USER_AGENT);

        int responseCode = con.getResponseCode();

        BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        //print result
        System.out.println("token "+response);

    }

    public void sharefile(DbxClient client,String url)throws IOException, DbxException{


    }

}
