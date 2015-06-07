package com.cse.cloud4s.model;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by sameera-PC on 1/3/2015.
 */
@Entity
@Table(name = "files" , catalog = "cloud4s")
public class FileKey {

    //variables.........
    private String filename;
    private String filekey;
    private String username;

    public FileKey(){

    }

    public FileKey(String filename,String filekey, String username){
        this.filename = filename;
        this.filekey = filekey;
        this.username = username;
    }

    @Id
    @Column(name = "username", unique = true, nullable = false, length = 45)
    public String getUsername() {
        return this.username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    @Column(name = "filename" , unique = false, nullable = false,length = 100)
    public String getFilename() {
        return this.filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    @Column(name = "filekey" , unique = false, nullable = false,length = 200)
    public String getFilekey() {
        return this.filekey;
    }

    public void setFilekey(String filekey) {
        this.filekey = filekey;
    }






}
