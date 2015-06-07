package com.cse.cloud4s.dao;

import com.cse.cloud4s.model.Recover;

/**
 * Created by hp on 2/10/2015.
 */
public interface RecoverDao{

    public Recover getRecover(String username);

    public void saveRecover(String username,int requires, int shares, String details);
}
