package com.cse.cloud4s.dao;

import com.cse.cloud4s.model.Shared;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by hp on 1/3/2015.
 */
public class SharedDaoImpl implements SharedDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void saveLink(String username, String filename, String link){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();

        Shared shared = new Shared();

        shared.setUsername(username);
        shared.setfilename(filename);
        shared.setlink(link);

        session.save(shared);

        session.getTransaction().commit();
        session.close();
    }

    public List<Shared> getLink(String username){

        List<Shared> allShared;

        allShared = getSessionFactory().getCurrentSession().createQuery("from Shared where username=?").list();

        if (allShared.size() > 0) {
            return allShared;
        } else {
            return null;
        }

    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

}
