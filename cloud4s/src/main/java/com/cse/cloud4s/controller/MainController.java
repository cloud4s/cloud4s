package com.cse.cloud4s.controller;

/**
 * Created by hp on 12/3/2014.
 */
import com.cse.cloud4s.dao.UserDao;
import com.cse.cloud4s.service.DropBoxApi;
import com.cse.cloud4s.service.JsonResponse;
import com.dropbox.core.DbxClient;
import com.dropbox.core.DbxEntry;
import com.dropbox.core.DbxException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.jar.JarException;

@Controller
public class MainController {

    private static Logger LOG = LoggerFactory.getLogger(MainController.class);

    @Qualifier("DropBox")
    @Autowired
    private DropBoxApi dropboxapi;

    @Qualifier("JsonResponse")
    @Autowired
    public JsonResponse jasonresponse;

    public UserDao userdao;

    DbxClient client;

    @RequestMapping(value = { "/","welcome" }, method = RequestMethod.GET)
    public ModelAndView defaultPage() {

        ModelAndView model = new ModelAndView();
        model.setViewName("hello");
        return model;

    }

    @RequestMapping(value = { "/selection**" }, method = RequestMethod.GET)
    public ModelAndView selectionPage() {

        ModelAndView model = new ModelAndView();

        model.setViewName("selection");
        return model;

    }
    @RequestMapping(value = { "/dropbox**" }, method = RequestMethod.GET)
    public ModelAndView popupform() {

        ModelAndView model = new ModelAndView();
        try {
            dropboxapi.connect();
            LOG.info("created connnection to dropbox");

        } catch (IOException e) {
            e.printStackTrace();
        } catch (DbxException e) {
            e.printStackTrace();
        }
        model.setViewName("dropbox");
        return model;

    }

    @RequestMapping(value = { "/dash" }, method = RequestMethod.GET)
    public ModelAndView dashboardPage(@ModelAttribute("inputkey")String code, BindingResult result) {

        ModelAndView model = new ModelAndView();

        if (result.hasErrors()) {
            model.setViewName("welcome");
            return model;
        } else {
            try {
                client=dropboxapi.verify(code);
//                dropboxapi.uploadFile(client,"C:/Users/hp/Downloads/dashboard.jsp","/dashboard.jsp");
//                dropboxapi.loadfiles(client);
            } catch (IOException e) {
                e.printStackTrace();
            } catch (DbxException e) {
                e.printStackTrace();
            }

            model.setViewName("dashboard");
            return model;
        }
    }


    @RequestMapping(value = { "/upload" }, method = RequestMethod.GET)
    public ModelAndView uploadPage(@ModelAttribute("fileName")String filename,
                                   BindingResult result) {

        ModelAndView model = new ModelAndView();
        String LocalPath="C:/Users/hp/Downloads/"+filename;
        String DropboxPath="/"+filename;

        try {
            Thread.sleep(5000);// have to remove wih proper mechanism
            dropboxapi.uploadFile(client,LocalPath,DropboxPath);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (DbxException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        model.setViewName("dashboard");
        return model;
    }

    //File downloading function
    @RequestMapping(value = { "/download" }, method = RequestMethod.GET)
    public ModelAndView uploadPage(@ModelAttribute("filename")String filename,
                                   @ModelAttribute("path")String path) {
        String FileName = filename;
        String Path = path;
        System.out.println("Filename : "+FileName);
        System.out.println("File path : "+Path);
        try {
            //String LocalPath="/home/hasitha/Downloads/"+filename;
            //Thread.sleep(5000);// have to remove wih proper mechanism
            dropboxapi.downloadfile(client,FileName,Path);
        } catch (DbxException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        ModelAndView model = new ModelAndView();
        model.setViewName("dashboard");
        return model;
    }

//    @RequestMapping(value = { "/saveuser**" }, method = RequestMethod.POST)
////    @RequestMapping(value =“/result”, method = RequestMethod.POST)
//
//    public ModelAndView saveUser(@ModelAttribute("inputName")String username,
//                                 @ModelAttribute("inputEmail")String email,
//                                 @ModelAttribute("inputPassword")String password,
//                                 @ModelAttribute("inputKey")String masterkey,
//                                 BindingResult result) {
//
//        ModelAndView model = new ModelAndView();
//        userdao=new UserDaoImpl();
//
//        if(result.hasErrors()){
//            model.setViewName("welcome");
//            return model;
//        }else{
//            userdao.saveUser(username,password);
//            model.setViewName("login");
//            return model;
//        }
//
//
//    }
    @RequestMapping(value = { "/loadfiles**" }, method = RequestMethod.GET)
    @ResponseBody
//    public DbxEntry.WithChildren loadFiles() {
//    public JsonResponse loadFiles() {
    public String loadFiles() throws JarException{
        String note;
        DbxEntry.WithChildren list;
        JSONObject[] fileList;
        int i=0;
        JSONArray listArray = new JSONArray();
        JSONObject results= new JSONObject();

        try {
            list= dropboxapi.loadfiles(client);
            fileList=new JSONObject[list.children.size()];
            for (DbxEntry child : list.children) {
                      fileList[i]=new JSONObject();
                      fileList[i].put("filename",child.name);
                      fileList[i].put("iconname",child.iconName);
                      fileList[i].put("path",child.path);
                      listArray.add(fileList[i]);
                        i++;
            }
            results.put("files",listArray);
        } catch (DbxException e) {
            e.printStackTrace();
            results.put("files","error");
        }
        System.out.println( results.toString() );
    return results.toString();

}
    @RequestMapping(value = { "/signup**" }, method = RequestMethod.GET)
    public ModelAndView signup() {

        ModelAndView model = new ModelAndView();


        model.setViewName("signup");
        return model;

    }

    @RequestMapping(value = "/admin**", method = RequestMethod.GET)
    public ModelAndView adminPage() {

        ModelAndView model = new ModelAndView();
        model.addObject("title", "Spring Security Login Form - Database Authentication");
        model.addObject("message", "This page is for ROLE_ADMIN only!");
        model.setViewName("admin");

        return model;

    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(@RequestParam(value = "error", required = false) String error,
                              @RequestParam(value = "logout", required = false) String logout) {

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Invalid username and password!");
        }

        if (logout != null) {
            model.addObject("msg", "You've been logged out successfully.");
        }
        model.setViewName("login");

        return model;

    }

    //for 403 access denied page
    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public ModelAndView accesssDenied() {

        ModelAndView model = new ModelAndView();

        //check if user is login
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            System.out.println(userDetail);

            model.addObject("username", userDetail.getUsername());

        }
        model.addObject("message", "You do not have permission to access this page!");
        model.setViewName("403");
        return model;

    }

}
