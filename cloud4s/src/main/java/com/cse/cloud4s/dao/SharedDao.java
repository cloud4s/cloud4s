package com.cse.cloud4s.dao;

/**
 * Created by hp on 1/3/2015.
 */

import com.cse.cloud4s.model.Shared;

import java.util.List;

public interface SharedDao {

    public void saveLink(String username, String filename, String link);

    public List<Shared> getLink(String username);
}
