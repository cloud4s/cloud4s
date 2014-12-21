package com.cse.cloud4s.controller;

import com.cse.cloud4s.dao.UserDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cse.cloud4s.service.addUser;
import com.cse.cloud4s.model.User;

import java.util.List;

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
                                 @ModelAttribute("inputKey")String masterkey,
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


}


