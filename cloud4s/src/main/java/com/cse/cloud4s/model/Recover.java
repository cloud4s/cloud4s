package com.cse.cloud4s.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by hp on 2/10/2015.
 */

@Entity
@Table(name = "key_recovery" , catalog = "cloud4s")
public class Recover {

        private String username;
        private int requires;
        private int shares;
        private String details;

        public Recover() {
        }

        public Recover(String username,int requires, int shares, String details) {
//            super();
            this.username   = username;
            this.requires   = requires;
            this.shares     = shares;
            this.details    = details;
        }

        @Id
        @Column(name = "username" , unique = true, nullable = false,length = 255)
        public String getUsername() {
            return username;
        }
        public void setUsername(String username) {
            this.username = username;
        }

        @Column(name = "requires", nullable = false, length = 10)
        public int getRequires() {
            return this.requires;
        }

        public void setRequires(int requires) {
            this.requires = requires;
        }

        @Column(name = "shares", nullable = false, length = 10)
        public int getShares() {
            return this.shares;
        }

        public void setShares(int shares) {
            this.shares = shares;
        }


        @Column(name = "details", nullable = false, length = 255)
        public String getDetails() {
            return this.details;
        }

        public void setDetails(String details) {
            this.details = details;
        }




}
