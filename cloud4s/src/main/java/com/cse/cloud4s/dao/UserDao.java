package com.cse.cloud4s.dao;

/**
 * Created by hp on 12/3/2014.
 */
import com.cse.cloud4s.model.User;

public interface UserDao {

    User findByUserName(String username);

}