package com.cse.cloud4s.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

/**
 * Created by hp on 1/27/2015.
 */

@Controller
public class FileUploadController {

    @RequestMapping(value = { "/fileupload" }, method = RequestMethod.GET)
    @ResponseBody
    public void uploadFileToServer(MultipartHttpServletRequest request){
//        ModelAndView model = new ModelAndView();

        String baseUploadDirectory = "C:/Users/hp/Desktop/test";
        Iterator<String> itr = request.getFileNames();
        MultipartFile multipartFile;
        String filePath = "";

        while (itr.hasNext()) {
            multipartFile = request.getFile(itr.next());
            filePath = multipartFile.getOriginalFilename();
            try {
                multipartFile.transferTo(new File(baseUploadDirectory+ File.separator + filePath));
                System.out.println("file successfully uploadeddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");

            } catch (IOException e) {
                e.printStackTrace();

                continue;
            }
        }



    }

    @RequestMapping(value = { "/uploadTest" }, method = RequestMethod.GET)
    public ModelAndView setupload(){
        ModelAndView model= new ModelAndView();
        model.setViewName("uploadTest");

        return model;
    }
}
