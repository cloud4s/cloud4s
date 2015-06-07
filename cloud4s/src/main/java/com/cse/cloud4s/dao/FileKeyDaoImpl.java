package com.cse.cloud4s.dao;

import com.cse.cloud4s.model.FileKey;
import com.cse.cloud4s.model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
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

        session.getTransaction().commit();
        session.close();
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

    public String deleteFile(String filename,String username){

        System.out.println("File name : "+filename);
        System.out.println("User name : "+username);

        Session session=this.sessionFactory.openSession();
        Transaction tx =  session.beginTransaction();
        Query query;

        query = session.createQuery("delete FileKey where username= :Username" +
                " and filename= :Filename");
        query.setParameter("Filename",filename);
        query.setParameter("Username", username);

        int result = query.executeUpdate();
        System.out.println("Update Status="+result);
        tx.commit();
        session.close();
        return  "success";
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
