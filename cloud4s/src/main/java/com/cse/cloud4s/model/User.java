package com.cse.cloud4s.model;

/**
 * Created by hp on 12/3/2014.
 */
import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users" , catalog = "cloud4s")
public class User {

    private String username;
    private String password;
    private String email;
    private String publickey;
    private String privateKey;
    private boolean enabled;
    private Set<UserRole> userRole = new HashSet<UserRole>(0);

    public User() {
    }

    public User(String username, String password, String email, String publickey,String privateKey, boolean enabled) {
        this.username = username;
        this.password = password;
        this.email    = email;
        this.publickey = publickey;
        this.privateKey = privateKey;
        this.enabled = enabled;
    }

    public User(String username, String password, String email, String publickey,String privateKey, boolean enabled, Set<UserRole> userRole) {
        this.username = username;
        this.password = password;
        this.email    = email;
        this.publickey = publickey;
        this.privateKey = privateKey;
        this.enabled = enabled;
        this.userRole = userRole;
    }

    @Id
    @Column(name = "username" , unique = true, nullable = false,length = 45)
    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Column(name = "password", nullable = false, length = 60)
    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "publickey", nullable = false, length = 70)
    public String getPublickey() {
        return this.publickey;
    }

    public void setPublickey(String publickey) {
        this.publickey = publickey;
    }

    @Column(name = "privateKey", nullable = false, length = 70)
    public String getPrivateKey() {return this.privateKey;}

    public void setPrivateKey(String privateKey) {
        this.privateKey = privateKey;
    }

    @Column(name = "email", nullable = false, length = 70)
    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isEnabled() {
        return this.enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    public Set<UserRole> getUserRole() {
        return this.userRole;
    }

    public void setUserRole(Set<UserRole> userRole) {
        this.userRole = userRole;
    }
}