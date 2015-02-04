package com.cse.cloud4s.service.Impl;

import com.cse.cloud4s.dao.FileKeyDao;
import com.cse.cloud4s.service.FileKeyApi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

/**
 * Created by sameera-PC on 1/3/2015.
 */
public class FileKeyApiImpl implements FileKeyApi {

    @Qualifier("fileKeyDao")
    @Autowired
    private FileKeyDao fileKeyDao;

    @Override
    public void saveFileKey(com.cse.cloud4s.model.FileKey fileKey){
        fileKeyDao.saveFileKey(fileKey.getUsername(), fileKey.getFilename(),fileKey.getFilekey());
    }

    @Override
    public String getFileKey(String fileKey, String username){
        return fileKeyDao.getFileKey(fileKey,username);
    }

    public void setFileKeyDao(FileKeyDao fileKeyDao) {
        this.fileKeyDao = fileKeyDao;
    }

    public FileKeyDao getFileKeyDao() {
        return fileKeyDao;
    }
}
