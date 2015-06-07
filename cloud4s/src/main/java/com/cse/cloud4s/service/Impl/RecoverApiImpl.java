package com.cse.cloud4s.service.Impl;


import com.cse.cloud4s.dao.RecoverDao;
import com.cse.cloud4s.model.Recover;
import com.cse.cloud4s.service.RecoverApi;
import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.TwilioRestException;
import com.twilio.sdk.resource.factory.MessageFactory;
import com.twilio.sdk.resource.instance.Message;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;


/**
 * Created by hp on 2/10/2015.
 */
public class RecoverApiImpl implements RecoverApi {

    @Qualifier("RecoverDao")
    @Autowired
    private RecoverDao recoverDao;
    private static final String ACCOUNT_SID = "AC61caf52fba51ac240d1f93c8156c4b53";
    private static final String AUTH_TOKEN = "f18952ee9822e9f82cd3a05c630323d8";

    private RecoverApiImpl(){

    }

    public static RecoverApiImpl getOb(){
        return new RecoverApiImpl();
    }

     public  void saveRecover(String username,int requires, int shares, String details){
         recoverDao.saveRecover(username,requires,shares,details);
        }

    public Recover getRecover( String username) {
         return  recoverDao.getRecover(username);
      }

    public void setRecoverDao(RecoverDao recoverDao) {
        this.recoverDao = recoverDao;
    }

    public RecoverDao getRecoverDao() {
        return recoverDao;
    }

    public void sendMessage(String to,String code,String user) throws TwilioRestException{
        TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);

        String message = "Cloud4S Key piece from "+user+" is \n"+code+"\nPlease keep this safe..!";

        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("Body", message));
        params.add(new BasicNameValuePair("To", to));
        params.add(new BasicNameValuePair("From", "+12012975581"));

        MessageFactory messageFactory = client.getAccount().getMessageFactory();
        Message sms = messageFactory.create(params);
        System.out.println(sms.getSid());

    }

    public boolean sendMail(String to,String code,String user) {
        final String username = "cloud4s.cse@gmail.com";
        final String password = "cloud4s@cse";

        String content ="Cloud4S Key piece from "+user+" is "+code+". Please keep this safe..!";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        javax.mail.Session session1;
        session1 = javax.mail.Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                        return new javax.mail.PasswordAuthentication(username,password);
                    }
                });

        try {
            MimeMessage message = new MimeMessage(session1);
            InternetAddress recipientAddress = new InternetAddress();

            message.setSubject("Cloud4S User :  "+user+" Key Recovery option");
            message.setText(content);

            recipientAddress = new InternetAddress(to);
            message.setRecipient(javax.mail.Message.RecipientType.TO, recipientAddress);
            Transport.send(message);


            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }


}
