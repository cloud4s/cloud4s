package com.cse.cloud4s.service;

/**
 * Created by hp on 12/5/2014.
 */

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.cse.cloud4s.dao.UserDao;
import com.cse.cloud4s.model.UserRole;


public interface addUser {

    public  void addUser(com.cse.cloud4s.model.User user);

    public List<com.cse.cloud4s.model.User> getAllUsers();
}
