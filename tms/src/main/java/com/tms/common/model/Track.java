package com.tms.common.model;

import javax.persistence.Column;
import java.util.Date;

/**
 * Created by hp on 9/17/2017.
 */
public class Track {

    @Column(name = "createdTime")
    private Date createdTimeStamp;

    @Column(name = "modifiedTime")
    private Date modifiedTimeStamp;

    @Column(name = "version")
    private int version;

}
