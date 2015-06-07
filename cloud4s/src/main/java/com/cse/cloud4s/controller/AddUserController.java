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

import java.io.IOException;
import java.io.StringWriter;
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
                                 @ModelAttribute("publicKey")String publicKey,
                                 @ModelAttribute("privateKey")String privateKey,
                                 BindingResult result) {
        ModelAndView model = new ModelAndView();
        User user = new User();
        System.out.println("Private key : "+privateKey);

        if (result.hasErrors()) {
            model.setViewName("welcome");
            return model;
        } else {
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPublickey(publicKey);
            user.setPrivateKey(privateKey);
            addUser.addUser(user);
            model.addObject("username",username);
            model.setViewName("keyrecovery");
            return model;
        }
    }

    @RequestMapping(value = { "/getAllUsers**" }, method = RequestMethod.GET)
    @ResponseBody
    public String[] getAllUsers() throws JarException {
        JSONObject[] allUsers;
        int i=0;

        JSONArray listArray = new JSONArray();
        JSONObject results= new JSONObject();

        String []userString;
        List<User> allUserList;
        allUserList=addUser.getAllUsers();
        userString=new String[allUserList.size()];
        try {

            allUsers=new JSONObject[allUserList.size()];
            for (User user : allUserList) {
                userString[i]=user.getUsername();
                allUsers[i]=new JSONObject();
                allUsers[i].put("username",user.getUsername());
                listArray.add(allUsers[i]);
                i++;
            }
//            results.put("users",listArray);
        } catch (Exception e) {
            e.printStackTrace();
            results.put("users","error");
        }
        System.out.println( results.toString() );
//        return results.toString();
        return userString;
    }

    @RequestMapping(value = { "/getPubKey**" })
    @ResponseBody
    public String getPublicKey(@ModelAttribute("Email")String Email,
                               BindingResult result) throws JarException {
        StringWriter out = new StringWriter();
        try {
            String PubKey = addUser.getPubKey(Email);
            String[] BEResult=PubKey.split("&");
            JSONObject obj=new JSONObject();
            obj.put("username",new String(BEResult[0]));
            obj.put("PubKey",new String(BEResult[1]));
            System.out.println("Pub key in AddUserController : "+BEResult[1]);
            obj.writeJSONString(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String jsonText = out.toString();
        System.out.println(jsonText);
        return jsonText;
    }


    @RequestMapping(value = { "/signup**" }, method = RequestMethod.GET)
    public ModelAndView signup() {

        ModelAndView model = new ModelAndView();


        model.setViewName("signup");
        return model;

    }

    @RequestMapping(value = { "/getPrivateKey**" })
    @ResponseBody
    public String getPrivateKey(@ModelAttribute("Username")String Username) throws JarException {
        StringWriter out = new StringWriter();
        try {
            String PrvKey = addUser.getPrivateKey(Username);
            JSONObject obj=new JSONObject();
            obj.put("PrvKey",new String(PrvKey));
            System.out.println("Prv key in AddUserController : "+PrvKey);
            obj.writeJSONString(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String jsonText = out.toString();
        System.out.println(jsonText);
        return jsonText;
    }
}


