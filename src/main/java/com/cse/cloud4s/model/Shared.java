package com.cse.cloud4s.model;

/**
 * Created by hp on 1/3/2015.
 */
import javax.persistence.*;


@Entity
@Table(name = "shared" , catalog = "cloud4s")
public class Shared {

    private String username;
    private String filename;
    private String link;
    private String filekey;

    public Shared() {
    }

    public Shared(String username, String filename, String link, String filekey) {
        this.username = username;
        this.filename = filename;
        this.link    = link;
        this.filekey = filekey;

    }

    @Id
    @Column(name = "username" , unique = true, nullable = false,length = 45)
    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Column(name = "filename", nullable = false, length = 60)
    public String getfilename() {
        return this.filename;
    }

    public void setfilename(String filename) {
        this.filename = filename;
    }

    @Column(name = "link", nullable = false, length = 70)
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
}
