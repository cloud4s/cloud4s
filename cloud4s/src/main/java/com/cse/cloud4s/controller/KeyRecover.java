package com.cse.cloud4s.controller;


import com.cse.cloud4s.model.Recover;
import com.cse.cloud4s.service.Impl.RecoverApiImpl;
import com.cse.cloud4s.service.RecoverApi;
import com.twilio.sdk.TwilioRestException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by hp on 2/10/2015.
 */

@Controller
public class KeyRecover {

    @Qualifier("RecoverApi")
    @Autowired
    private RecoverApi recoverApi;


    @RequestMapping(value = { "/keyrecovery_req" }, method = RequestMethod.GET)
    public ModelAndView recoverKey(@ModelAttribute("name")String username,
                                   @ModelAttribute("shares")String shareCount,
                                   @ModelAttribute("requires")String requireCount,
                                   @ModelAttribute("keysArray")String[] keyArray,
                                   @ModelAttribute("emailArray")String[] emailArray,
                                   BindingResult result) {


        int shares=Integer.parseInt(shareCount);
        int requires = Integer.parseInt(requireCount);
        String addresses = this.collectEmails(emailArray);

        System.out.println(username);
        System.out.println(shareCount);
        System.out.println(requireCount);
        System.out.println(addresses);
        this.sendMessages(keyArray,emailArray,username);

        recoverApi.saveRecover(username,requires,shares,addresses);

        ModelAndView model = new ModelAndView();

        model.setViewName("login");
        return model;
    }

    @RequestMapping(value = { "/getKeyRecoveryDetails" }, method = RequestMethod.GET)
    @ResponseBody
    public String constructKey(@ModelAttribute("name")String username,
                                      BindingResult result) {


        JSONObject results= new JSONObject();
        Recover details;
        details=  recoverApi.getRecover(username);

        int shares = details.getShares();
        int requires = details.getRequires();
        String emails = details.getDetails();

        results.put("shares", Integer.toString(shares));
        results.put("requires", Integer.toString(requires));
       results.put("details", details.getDetails());


        return results.toString();

    }


    public String collectEmails(String[] emails){
        String collection="";
        for(int i=0;i<emails.length;i++){
            collection=collection+emails[i]+",";
        }

        return collection.substring(0,collection.length()-1);
    }

    public void sendMessages(String[] keys,String emails[],String user){
        RecoverApiImpl recovery = RecoverApiImpl.getOb();
        for(int i=0 ; i<keys.length ; i++){

            if(isEmailValid(emails[i])==true){
                if(recovery.sendMail(emails[i],keys[i],user))
                    System.out.println("Email sent successfully....!");
                else
                    System.out.println("Email sending failed....!");
            }

            else
                try {
                    recovery.sendMessage( standardFormat(emails[i]), keys[i], user);
                    System.out.println("Message sent successfully...!");
                } catch (TwilioRestException e) {
                    e.printStackTrace();
                    System.out.println("Error message sending...!");
                }

        }
    }

    /** isEmailValid: Validate email address using Java reg ex.
     * This method checks if the input string is a valid email address.
     * @param email String. Email address to validate
     * @return boolean: true if email address is valid, false otherwise.
     */

    public static boolean isEmailValid(String email){
        boolean isValid = false;

              //Initialize reg ex for email.
        String expression = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
        CharSequence inputStr = email;
        //Make the comparison case-insensitive.
        Pattern pattern = Pattern.compile(expression,Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(inputStr);
        if(matcher.matches()){
            isValid = true;
        }
        return isValid;
    }


    public static boolean isPhoneNumberValid(String phoneNumber){
        boolean isValid = false;

        //Initialize reg ex for phone number.
        String expression = "^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$";
        CharSequence inputStr = phoneNumber;
        Pattern pattern = Pattern.compile(expression);
        Matcher matcher = pattern.matcher(inputStr);
        if(matcher.matches()){
            isValid = true;
        }
        return isValid;
    }

    public String standardFormat(String num){
        String newNumber;
        newNumber ="+94"+num.substring(num.length()-9);
        System.out.println("--------------------------"+newNumber);
        return newNumber;
    }




}
