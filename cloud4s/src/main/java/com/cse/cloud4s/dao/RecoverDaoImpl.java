package com.cse.cloud4s.dao;


import com.cse.cloud4s.model.Recover;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by hp on 2/10/2015.
 */
public class RecoverDaoImpl implements RecoverDao {

    @Autowired
    private SessionFactory sessionFactory;


    public Recover getRecover(String username){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();

        List<Recover> recover = new ArrayList<Recover>();

        recover=session.createQuery("from Recover where username=?")
        .setParameter(0, username).list();

        session.getTransaction().commit();
        session.close();
        if (recover.size() > 0) {
            return recover.get(0);
        } else {
            return null;
        }
    }

    public void saveRecover(String username,int requires, int shares, String details){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();

        Recover recover=new Recover(username,requires,shares,details);

        recover.setUsername(username);
        recover.setRequires(requires);
        recover.setShares(shares);
        recover.setDetails(details);
        try {
            session.save(recover);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            session.getTransaction().commit();
            session.close();
        }


    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
