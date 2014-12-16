package com.cse.cloud4s.dao;

/**
 * Created by hp on 12/3/2014.
 */
import com.cse.cloud4s.model.User;
import com.cse.cloud4s.model.UserRole;

public interface UserDao {

    User findByUserName(String username);


    public void saveUser(String username,String password, String email);

}