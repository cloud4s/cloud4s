package com.cse.cloud4s.service.Impl;

import com.cse.cloud4s.dao.SharedDao;
import com.cse.cloud4s.dao.UserDao;
import com.cse.cloud4s.model.Shared;
import com.cse.cloud4s.service.shareApi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by hp on 1/3/2015.
 */


public class shareApiImpl implements shareApi {

    @Qualifier("SharedDao")
    @Autowired
    private SharedDao sharedDao;

    @Override
    public  void shareLink(String username, String filename, String link, String filekey,String sharedBy,boolean revoke){
        sharedDao.saveLink(username, filename, link, filekey,sharedBy,revoke);
    }
    @Override
    public List<Shared> getAllShareLink( String username){
        return sharedDao.getLink(username);
    }

    @Override
    public List<Shared> getAllShareOut( String username){
        return sharedDao.getShareOut(username);
    }

    @Override
    @Transactional
    public String revoke_access(String filename, String receiver, String username) {
        return  sharedDao.revoke_access(filename,receiver,username);
    }

    @Override
    @Transactional
    public String grant_access(String filename, String receiver, String username) {
        return  sharedDao.grant_access(filename,receiver,username);
    }

    @Override
    @Transactional
    public String delete_access(String filename, String receiver, String username) {
        return  sharedDao.delete_access(filename,receiver,username);
    }

    public void setSharedDao(SharedDao sharedDao) {
        this.sharedDao = sharedDao;
    }

    public SharedDao getSharedDao() {
        return sharedDao;
    }
}
