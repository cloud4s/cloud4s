package com.cse.cloud4s.model;

/**
 * Created by hp on 1/3/2015.
 */
import javax.persistence.*;


@Entity
@Table(name = "shared" , catalog = "cloud4s")
public class Shared {


    private String link;
    private  SharedPK sharedPK = null;
    private  String filekey;
    private  boolean revoke;

    public Shared() {
    }

    public Shared(SharedPK sharedPK,String link, String filekey,boolean revoke) {
        super();
        this.sharedPK   = sharedPK;
        this.link       = link;
        this.filekey    = filekey;
        this.revoke = revoke;
    }

    @Id
    public SharedPK getSharedPK() {
        return sharedPK;
    }
    public void setSharedPK(SharedPK sharedPK) {
        this.sharedPK = sharedPK;
    }

    @Column(name = "link", nullable = false, length = 255)
    public String getlink() {
        return this.link;
    }

    public void setlink(String link) {
        this.link = link;
    }

    @Column(name = "filekey", nullable = false, length = 255)
    public String getfilekey() {
        return this.filekey;
    }

    public void setfilekey(String filekey) {
        this.filekey = filekey;
    }

    @Column(name = "revoked", nullable = false)
    public boolean getAccess() {
        return this.revoke;
    }

    public void setAccess(boolean revoke) {
        this.revoke = revoke;
    }

}
