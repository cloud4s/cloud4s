package com.cse.cloud4s.service;



import com.cse.cloud4s.model.Recover;
import com.twilio.sdk.TwilioRestException;

/**
 * Created by hp on 2/10/2015.
 */
public interface RecoverApi {

    public  void saveRecover(String username,int requires, int shares, String details);

    public Recover getRecover(String username);

    public void sendMessage(String to,String code,String User) throws TwilioRestException;

    public boolean sendMail(String to,String code,String User);
}
