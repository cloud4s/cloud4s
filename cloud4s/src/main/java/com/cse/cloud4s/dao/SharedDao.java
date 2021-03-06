package com.cse.cloud4s.dao;

/**
 * Created by hp on 1/3/2015.
 */

import com.cse.cloud4s.model.Shared;

import java.util.List;

public interface SharedDao {

    public void saveLink(String username, String filename, String link, String filekey,String sharedBy,boolean revoke);

    public List<Shared> getLink(String username);
    public List<Shared> getShareOut(String username);
    public String revoke_access(String filename,String receiver, String username);
    public String grant_access(String filename,String receiver, String username);
    public String delete_access(String filename,String receiver, String username);
}
