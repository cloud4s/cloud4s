package com.cse.cloud4s.controller;

import com.cse.cloud4s.dao.UserDaoImpl;
import com.dropbox.core.DbxEntry;
import com.dropbox.core.DbxException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cse.cloud4s.service.addUser;
import com.cse.cloud4s.model.User;

import java.util.List;
import java.util.jar.JarException;

/**
 * Created by hp on 12/5/2014.
 */

@Controller
public class AddUserController {

    @Qualifier("addUser")
    @Autowired
    private addUser addUser;


    @RequestMapping(value = { "/saveuser" }, method = RequestMethod.GET)
    public ModelAndView saveUser(@ModelAttribute("inputName")String username,
                                 @ModelAttribute("inputEmail")String email,
                                 @ModelAttribute("inputPassword")String password,
                                 @ModelAttribute("publicKey")String masterkey,
                                 BindingResult result) {
        ModelAndView model = new ModelAndView();
        User user = new User();


        if (result.hasErrors()) {
            model.setViewName("welcome");
            return model;
        } else {

            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPublickey(masterkey);
            addUser.addUser(user);
            model.setViewName("login");
            return model;
        }
    }

    @RequestMapping(value = { "/getAllUsers**" }, method = RequestMethod.GET)
    @ResponseBody
    public String getAllUsers() throws JarException {
        JSONObject[] allUsers;
        int i=0;
        JSONArray listArray = new JSONArray();
        JSONObject results= new JSONObject();

        List<User> allUserList;
        allUserList=addUser.getAllUsers();

        try {

            allUsers=new JSONObject[allUserList.size()];
            for (User user : allUserList) {
                allUsers[i]=new JSONObject();
                allUsers[i].put("username",user.getUsername());
                listArray.add(allUsers[i]);
                i++;
            }
            results.put("users",listArray);
        } catch (Exception e) {
            e.printStackTrace();
            results.put("users","error");
        }
        System.out.println( results.toString() );
        return results.toString();

    }


}


