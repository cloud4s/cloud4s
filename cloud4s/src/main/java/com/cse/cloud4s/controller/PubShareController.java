package com.cse.cloud4s.controller;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.net.URL;

/**
 * Created by hasitha on 2/13/15.
 */

@Controller
public class PubShareController {
    @RequestMapping(value = { "/publicShareDownload**" }, method = RequestMethod.GET)
    public ModelAndView publicShareDownload(@ModelAttribute("fileUrl")String fileUrl,
                                            @ModelAttribute("enFileKey")String enFileKey,
                                            @ModelAttribute("fileName")String fileName) {

        ModelAndView model = new ModelAndView();

        model.addObject("fileName",fileName);
        model.addObject("fileUrl",fileUrl);
        model.addObject("enFileKey",enFileKey);

        model.setViewName("pubShare");
        return model;
    }

    //read encrypted shared file data and send to sharein.jsp
    @RequestMapping(value = { "/getPublicShareFileContent" }, method = RequestMethod.GET)
    @ResponseBody
    public String getPublicShareFile(@ModelAttribute("fileUrl")String fileURL) throws IOException {
        JSONObject results = new JSONObject();
        FileInputStream fin = null;
        URL url = new URL(fileURL);
        InputStream in = url.openStream();
        try {
            String fileContent = getStringFromInputStream(in);
            System.out.println("File content: " + fileContent);
            results.put("fileContent", fileContent);
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

    // convert InputStream to String
    private  String getStringFromInputStream(InputStream is) {
        BufferedReader br = null;
        StringBuilder sb = new StringBuilder();
        String line;
        try {

            br = new BufferedReader(new InputStreamReader(is));
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return sb.toString();
    }
}
