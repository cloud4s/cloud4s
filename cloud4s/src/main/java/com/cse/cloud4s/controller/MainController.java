package com.cse.cloud4s.controller;

/**
 * Created by hp on 12/3/2014.
 */

import com.cse.cloud4s.dao.UserDao;
import com.cse.cloud4s.model.Shared;
import com.cse.cloud4s.service.DropBoxApi;
import com.cse.cloud4s.service.FileKeyApi;
import com.cse.cloud4s.service.JsonResponse;
import com.cse.cloud4s.service.shareApi;
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

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.*;
import java.util.List;
import java.util.Properties;
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

    @Qualifier("shareApi")
    @Autowired
    private shareApi shareapi;

    @Qualifier("FileKey")
    @Autowired
    private FileKeyApi fileKeyApiApi;

    public UserDao userdao;
    public String encryptedFilekey = "";

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
        String LocalPath="C:/Users/hp/Downloads/";
//        String DropboxPath="/"+filename;

        try {
            Thread.sleep(5000);// have to remove wih proper mechanism
            dropboxapi.uploadFile(client,filename,LocalPath);
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

    @RequestMapping(value = { "/share" }, method = RequestMethod.GET)
    public ModelAndView shareFile(@ModelAttribute("fileName")String filename,
                                  @ModelAttribute("path")String path,
                                  @ModelAttribute("username")String username,
                                  @ModelAttribute("filekay")String filekey,
                                  BindingResult result) {

        ModelAndView model = new ModelAndView();

        try {
            String Url_old= client.createShareableUrl(path);
            String Url = Url_old.substring(0, Url_old.length() - 1)+"1";
            shareapi.shareLink(username,filename,Url,filekey);
        } catch (DbxException e) {
            e.printStackTrace();
        }
        model.setViewName("dashboard");
        return model;
    }

    @RequestMapping(value = { "/shareFile**" }, method = RequestMethod.GET)
    @ResponseBody
    public String shareFile( @ModelAttribute("filename")String filename, @ModelAttribute("to")String to) {

        JSONObject results= new JSONObject();
        try {

            String [] toArray = to.split("; ");
            System.out.print(toArray);
            if (sendMail(toArray)){
                results.put("msg","success");
            }
            else{
                results.put("msg","error");
            }
            return results.toString();
        }
        catch (Exception e) {
            results.put("msg", "error");
            return results.toString();
        }
    }

    @RequestMapping(value = { "/getShare**" }, method = RequestMethod.GET)
    @ResponseBody
    public String getShareFiles(@ModelAttribute("username")String username) throws JarException{
        String note;

        int i=0;
        JSONArray listArray = new JSONArray();
        JSONObject results= new JSONObject();

        List<Shared> sharedFileList;
        sharedFileList=shareapi.getAllShareLink(username);

        JSONObject[] fileList= new JSONObject[sharedFileList.size()];

        for (Shared share : sharedFileList) {
            fileList[i] = new JSONObject();
            fileList[i].put("filename", share.getfilename());
            fileList[i].put("url", share.getlink());
            fileList[i].put("filekey", share.getfilekey());
            listArray.add(fileList[i]);
            i++;
        }
        results.put("sharedFiles",listArray);
        System.out.println( results.toString() );
        return results.toString();

    }


    @RequestMapping(value = { "/getFile" }, method = RequestMethod.GET)
    @ResponseBody
    public String readFile(@ModelAttribute("filename")String filename) throws JarException {
        JSONObject[] filejson = new JSONObject[2];
        int i = 0;
        JSONArray listArray = new JSONArray();
        JSONObject results = new JSONObject();
        File file = new File("C:/Users/hp/Downloads/"+filename);
        FileInputStream fin = null;
        try {
            // create FileInputStream object
            fin = new FileInputStream(file);
            byte fileContent[] = new byte[(int) file.length()];
            // Reads up to certain bytes of data from this input stream into an array of bytes.
            fin.read(fileContent);
            //create string from byte array
            String s = new String(fileContent);
            System.out.println("File content: " + s);
            results.put("fileContent", s);
            results.put("encryptedKey",encryptedFilekey);
        } catch (FileNotFoundException e) {
            System.out.println("File not found" + e);
            results.put("fileContent", "FileNotFoundException");
        } catch (IOException ioe) {
            System.out.println("Exception while reading file " + ioe);
            results.put("fileContent", "IOException");
        } finally {
            // close the streams using close method
            try {
                if (fin != null) {
                    fin.close();
                }
            } catch (IOException ioe) {
                System.out.println("Error while closing stream: " + ioe);
            }
        }
        System.out.println(results.toString());
        return results.toString();
    }
    //File downloading function
    @RequestMapping(value = { "/download" }, method = RequestMethod.GET)
    public ModelAndView uploadPage(@ModelAttribute("filename")String filename,
                                   @ModelAttribute("username")String username,
                                   @ModelAttribute("path")String path) {
        String FileName = filename;
        String Username = username;
        String Path = path;
        System.out.println("Filename : "+FileName);
        System.out.println("File path : "+Path);
        try {
            dropboxapi.downloadfile(client,FileName,Path);
        } catch (DbxException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        encryptedFilekey = fileKeyApiApi.getFileKey(FileName,Username);
        System.out.println("File Key from DB :"+ encryptedFilekey);
        ModelAndView model = new ModelAndView();
        model.setViewName("dashboard");
        return model;
    }


    @RequestMapping(value = { "/loadfiles**" }, method = RequestMethod.GET)
    @ResponseBody
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
    @RequestMapping(value = "/popupform", method = RequestMethod.GET)
    public ModelAndView popup() {

        ModelAndView model = new ModelAndView();

        model.setViewName("popupform");

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

    @RequestMapping(value = { "/filekey" }, method = RequestMethod.GET)
    public void uploadKey(@ModelAttribute("enKey")String enKey,
                          @ModelAttribute("fileName")String fileName,
                          @ModelAttribute("username")String username,
                          BindingResult result) {
        System.out.println("fileName:"+fileName +"  "+"enKey:"+enKey+" username:"+username);
        com.cse.cloud4s.model.FileKey fileKey = new com.cse.cloud4s.model.FileKey(fileName+".encrypted",enKey,username);
        fileKeyApiApi.saveFileKey(fileKey);
    }

    public boolean sendMail(String[] to)
    {
        final String username = "cloud4s.cse@gmail.com";
        final String password = "cloud4s@cse";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            InternetAddress[] recipientAddress = new InternetAddress[to.length];

            message.setSubject("Cloud4s File Sharing");
            message.setText("A file is shared with you..!");

            for (int i=0; i<to.length; i++){
                recipientAddress[i] = new InternetAddress(to[i]);
                message.setRecipient(Message.RecipientType.TO, recipientAddress[i]);
                Transport.send(message);
            }

            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

}
