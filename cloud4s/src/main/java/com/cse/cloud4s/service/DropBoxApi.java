package com.cse.cloud4s.service;

import com.dropbox.core.*;

import java.io.IOException;

/**
 * Created by hp on 12/5/2014.
 */
public interface DropBoxApi {

//    public DbxWebAuthNoRedirect connect()throws IOException,DbxException;
    public String connect()throws IOException,DbxException;

//    public DbxClient verify(DbxWebAuthNoRedirect webAuth)throws IOException,DbxException;
    public DbxClient verify(String code)throws IOException,DbxException;

    public void uploadFile(DbxClient client,String name,String path) throws IOException,DbxException;

    public void downloadfile(DbxClient client,String filename,String dest_path) throws DbxException,IOException;

    public DbxEntry.WithChildren loadfiles(DbxClient client) throws DbxException;

    public void sharefile(DbxClient client,String url) throws IOException, DbxException;
}
