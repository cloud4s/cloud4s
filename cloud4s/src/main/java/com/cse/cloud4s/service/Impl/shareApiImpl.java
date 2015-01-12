package com.cse.cloud4s.service.Impl;

import com.cse.cloud4s.dao.SharedDao;
import com.cse.cloud4s.dao.UserDao;
import com.cse.cloud4s.model.Shared;
import com.cse.cloud4s.service.shareApi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import java.util.List;

/**
 * Created by hp on 1/3/2015.
 */


public class shareApiImpl implements shareApi {

    @Qualifier("SharedDao")
    @Autowired
    private SharedDao sharedDao;

    @Override
    public  void shareLink(String username, String filename, String link, String filekey){
            sharedDao.saveLink(username, filename, link, filekey);
    }
    @Override
    public List<Shared> getAllShareLink( String username){
            return sharedDao.getLink(username);
    }

    public void setSharedDao(SharedDao sharedDao) {
        this.sharedDao = sharedDao;
    }

    public SharedDao getSharedDao() {
        return sharedDao;
    }
}
