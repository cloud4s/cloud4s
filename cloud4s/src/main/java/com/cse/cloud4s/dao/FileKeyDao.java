package com.cse.cloud4s.dao;

import com.cse.cloud4s.model.FileKey;

/**
 * Created by udeshi-p on 1/3/2015.
 */
public interface FileKeyDao {

    public String getFileKey(String filename, String username);
    public void saveFileKey(String username,String fileName,String key);
    public String deleteFile(String filename,String username);

}
