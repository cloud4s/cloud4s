package com.cse.cloud4s.service.Impl;

/**
 * Created by hp on 12/5/2014.
 */

import com.cse.cloud4s.dao.UserDao;
//import com.cse.cloud4s.dao.UserDaoImpl;
import com.cse.cloud4s.model.User;
import com.cse.cloud4s.service.MyUserDetailsService;
import com.cse.cloud4s.service.addUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;



public class addUserImpl implements addUser {

    @Qualifier("userDao")
    @Autowired
    private UserDao userDao;

    @Override
    public  void addUser(com.cse.cloud4s.model.User user){
            userDao.saveUser(user.getUsername(),user.getPassword(), user.getEmail());
    }



    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public UserDao getUserDao() {
        return userDao;
    }
}
