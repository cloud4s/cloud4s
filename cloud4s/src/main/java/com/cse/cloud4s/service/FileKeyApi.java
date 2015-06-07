package com.cse.cloud4s.service;

/**
 * Created by udeshi-p on 1/3/2015.
 */


public interface FileKeyApi {

    public void saveFileKey(com.cse.cloud4s.model.FileKey fileKey);

    public String getFileKey(String fileKey, String username);

    public String deleteFile(String filename,String username);

}
