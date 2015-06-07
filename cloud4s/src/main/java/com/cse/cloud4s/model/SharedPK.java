package com.cse.cloud4s.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

/**
 * Created by hp on 2/7/2015.
 */
@Embeddable
public class SharedPK implements Serializable {

    private String username;
    private String filename;
    private  String sharedBy;

    public SharedPK(){

    }

    public SharedPK(String username,String filename,String sharedBy){
        this.username = username;
        this.filename = filename;
        this.sharedBy = sharedBy;

    }

    @Column(name = "username" , unique = true, nullable = false,length = 255)
    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Column(name = "filename", nullable = false, length = 255)
    public String getfilename() {
        return this.filename;
    }

    public void setfilename(String filename) {
        this.filename = filename;
    }

    @Column(name = "sharedBy", nullable = false, length = 255)
    public String getsharedBy() {
        return this.sharedBy;
    }

    public void setsharedBy(String sharedBy) {
        this.sharedBy = sharedBy;
    }



}
