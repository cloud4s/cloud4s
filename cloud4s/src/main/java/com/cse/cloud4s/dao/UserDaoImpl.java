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

    @Override
    public String getPubkeyByEmail(String email) {
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();
        List<User> Users;
        Users = session.createQuery("from User where email=:Email")
                .setParameter("Email", email).list();
        String pubKey= Users.get(0).getPublickey();
        String username = Users.get(0).getUsername();
        String Result = username+"&"+pubKey;
        session.getTransaction().commit();
//        session.flush();
        session.close();

        if (Users.size()>0) {
            System.out.println("Result: " + Result);
            return Result;
        } else {
            return null;
        }
    }

    @Override
    public String getPrivateKeyByUsername(String username) {
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();
        List<User> Users;
        Users = session.createQuery("from User where username=:Username")
                .setParameter("Username", username).list();
        String pubKey= Users.get(0).getPrivateKey();
        String Result = pubKey;
        session.getTransaction().commit();

        session.close();

        if (Users.size()>0) {
            System.out.println("Result: " + Result);
            return Result;
        } else {
            return null;
        }
    }


    @SuppressWarnings("unchecked")
    public void saveUser(String username,String Password, String email, String publickey,String privateKey){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();

        User user=new User();
        UserRole userrole=new UserRole();

        user.setUsername(username);
        user.setPassword(Password);
        user.setEmail(email);
        user.setPublickey(publickey);
        user.setPrivateKey(privateKey);
        user.setEnabled(true);
        userrole.setUser(user);
        userrole.setRole("ROLE_USER");


        session.save(user);
        session.save(userrole);

        session.getTransaction().commit();
        session.close();

    }

    public List<User> allUsers(){
        Session session=this.sessionFactory.openSession();
        session.beginTransaction();

        List<User> allUsers;

        allUsers = session.createQuery("from User").list();

        session.getTransaction().commit();
        session.close();
        return allUsers;
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

}
