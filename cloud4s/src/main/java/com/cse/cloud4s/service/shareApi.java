package com.cse.cloud4s.service;

import com.cse.cloud4s.model.Shared;


import java.util.List;

/**
 * Created by hp on 1/3/2015.
 */
public interface shareApi {

    public  void shareLink(String username, String filename, String link, String filekey,String sharedBy,boolean revoke);

    public List<Shared> getAllShareLink( String username);

    public List<Shared> getAllShareOut( String username);

    public String revoke_access(String filename,String receiver, String username);

    public String grant_access(String filename,String receiver, String username);

    public String delete_access(String filename,String receiver, String username);
}
