package com.cse.cloud4s.dao;

/**
 * Created by hp on 12/3/2014.
 */
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.cse.cloud4s.model.User;
import com.cse.cloud4s.model.UserRole;
import org.springframework.beans.factory.annotation.Autowired;

//import javax.transaction.Transaction;

public class UserDaoImpl implements UserDao {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")

    public User findByUserName(String username) {

        List<User> users = new ArrayList<User>();

        users = getSessionFactory().getCurrentSession()
                .createQuery("from User where username=?")
                .setParameter(0, username).list();

        if (users.size() > 0) {
            return users.get(0);
        } else {
            return null;
        }

    }



    @SuppressWarnings("unchecked")
    public void saveUser(String username,String Password){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();

        User user=new User();
        UserRole userrole=new UserRole();

        user.setUsername(username);
        user.setPassword(Password);
        user.setEnabled(true);
//        user.setUserRole();
        userrole.setUser(user);
        userrole.setRole("ROLE_USER");


        session.save(user);
        session.save(userrole);

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
