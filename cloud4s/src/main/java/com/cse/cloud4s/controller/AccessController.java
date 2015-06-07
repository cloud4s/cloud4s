package com.cse.cloud4s.controller;

import com.cse.cloud4s.service.shareApi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by hasitha on 2/12/15.
 */

@Controller
public class AccessController {

    @Qualifier("shareApi")
    @Autowired
    private shareApi shareapi;

    @RequestMapping(value = { "/grant_access" }, method = RequestMethod.GET)
    @ResponseBody
    public String grant_access(@ModelAttribute("filename")String filename,
                               @ModelAttribute("receiver")String receiver,
                               @ModelAttribute("username")String username) {
        System.out.println("grant_access");
        System.out.println("filename:"+filename +"  "+"receiver:"+receiver+" username:"+username);
        String response = shareapi.grant_access(filename,receiver,username);
        return response;
    }

    @RequestMapping(value = { "/revoke_access" }, method = RequestMethod.GET)
    @ResponseBody
    public String revoke_access(@ModelAttribute("filename")String filename,
                                @ModelAttribute("receiver")String receiver,
                                @ModelAttribute("username")String username) {
        System.out.println("revoke_access");
        System.out.println("filename:"+filename +"  "+"receiver:"+receiver+" username:"+username);
        String response = shareapi.revoke_access(filename,receiver,username);
        return  response;
    }

    @RequestMapping(value = { "/delete_access" }, method = RequestMethod.GET)
    @ResponseBody
    public String delete_access(@ModelAttribute("filename")String filename,
                                @ModelAttribute("receiver")String receiver,
                                @ModelAttribute("username")String username) {
        System.out.println("delete_access");
        System.out.println("filename:"+filename +"  "+"receiver:"+receiver+" username:"+username);
        String response = shareapi.delete_access(filename,receiver,username);
        return response;
    }
}
