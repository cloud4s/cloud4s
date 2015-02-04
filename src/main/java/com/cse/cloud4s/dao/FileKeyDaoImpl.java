package com.cse.cloud4s.dao;

import com.cse.cloud4s.model.FileKey;
import com.cse.cloud4s.model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sameera-PC on 1/3/2015.
 */
public class FileKeyDaoImpl implements FileKeyDao {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public String getFileKey(String fileName, String username){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();
        System.out.println("filename:"+fileName+" username:"+username);
        List<FileKey> fileKeys;
        fileKeys= session.createQuery("from FileKey where filename=:Filename and username=:Username")
                .setParameter("Filename", fileName).setParameter("Username",username).list();
        String fileKey=  fileKeys.get(0).getFilekey();

        if (fileKeys.size()>0) {
            System.out.println("Filename: " + fileName + "  filekey:" + fileKey);
            return fileKey;
        } else {
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public void saveFileKey(String username, String filename,String filekey){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();

        FileKey key=new FileKey(username,filename,filekey);

        key.setUsername(username);
        key.setFilename(filename);
        key.setFilekey(filekey);
        session.save(key);

        session.getTransaction().commit();
        session.close();
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
