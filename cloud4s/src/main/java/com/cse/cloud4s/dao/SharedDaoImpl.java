package com.cse.cloud4s.dao;

import com.cse.cloud4s.model.Shared;
import com.cse.cloud4s.model.SharedPK;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by hp on 1/3/2015.
 */
public class SharedDaoImpl implements SharedDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void saveLink(String username, String filename, String link, String filekey,String sharedBy,boolean revoke){
        System.out.println("username:"+username);
        System.out.println("filename:"+filename);
        System.out.println("link:"+link);
        System.out.println("filekey:"+filekey);
        System.out.println("sharedBy:"+sharedBy);
        System.out.println("Access revoke :"+revoke);
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();

        Shared shared = new Shared();

        SharedPK sharedpk = new SharedPK(username, filename, sharedBy);

        shared.setSharedPK(sharedpk);
        shared.setlink(link);
        shared.setfilekey(filekey);
        shared.setAccess(revoke);

        session.save(shared);

        session.getTransaction().commit();
        session.close();
    }

    public List<Shared> getLink(String username){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();
        List<Shared> allShared;

        allShared = session.createQuery("from Shared where username=:Username and revoked=:Revoked ")
                .setParameter("Username", username).setBoolean("Revoked",false).list();


        session.getTransaction().commit();
        session.close();
        if (allShared.size() > 0) {
            return allShared;
        } else {
            return allShared;
        }
    }

    public List<Shared> getShareOut(String username){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();
        List<Shared> allShared;

        allShared = session.createQuery("from Shared where sharedBy=:Username")
                .setParameter("Username", username).list();

        session.getTransaction().commit();
        session.close();

        if (allShared.size() > 0) {
            return allShared;
        } else {

            return allShared;
        }
    }

    @Transactional
    public String revoke_access(String filename,String receiver,String username){

        System.out.println("File name : "+filename);
        System.out.println("Receiver : "+receiver);
        System.out.println("User name : "+username);

        Session session=this.sessionFactory.openSession();
        Transaction tx =  session.beginTransaction();
        Query query;

        query = session.createQuery("update Shared  set revoked=:Revoked  where username= :Receiver" +
                " and filename= :Filename and sharedBy= :Username ");

        query.setBoolean("Revoked", true);//value set to revoked=1..
        query.setParameter("Receiver", receiver);
        query.setParameter("Filename",filename);
        query.setParameter("Username", username);

        int result = query.executeUpdate();
        System.out.println("Update Status="+result);
        tx.commit();
        session.close();
        return  "success";
    }

    @Transactional
    public String grant_access(String filename,String receiver,String username){

        System.out.println("File name : "+filename);
        System.out.println("Receiver : "+receiver);
        System.out.println("User name : "+username);

        Session session=this.sessionFactory.openSession();
        Transaction tx =  session.beginTransaction();
        Query query;

        query = session.createQuery("update Shared  set revoked=:Revoked  where username= :Receiver" +
                " and filename= :Filename and sharedBy= :Username ");

        query.setBoolean("Revoked", false);//value set to revoked=0..
        query.setParameter("Receiver", receiver);
        query.setParameter("Filename",filename);
        query.setParameter("Username", username);

        int result = query.executeUpdate();
        System.out.println("Update Status="+result);
        tx.commit();
        session.close();
        return  "success";
    }

    @Transactional
    public String delete_access(String filename,String receiver,String username){

        System.out.println("File name : "+filename);
        System.out.println("Receiver : "+receiver);
        System.out.println("User name : "+username);

        Session session=this.sessionFactory.openSession();
        Transaction tx =  session.beginTransaction();
        Query query;

        query = session.createQuery("delete Shared where username= :Receiver" +
                " and filename= :Filename and sharedBy= :Username ");
        query.setParameter("Receiver", receiver);
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
