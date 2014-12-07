package com.cse.cloud4s.controller;

import com.cse.cloud4s.service.DropBoxApi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by hp on 12/5/2014.
 */

@Controller
public class DropBox {

    @Autowired(required =true)
    @Qualifier(value = "DropBox")
    public DropBoxApi dropboxapi;

    @RequestMapping(value = "/upload",method = RequestMethod.GET)
    public void upload(){

    }
}
