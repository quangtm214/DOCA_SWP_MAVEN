/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.doca_java.ProcessDetails;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

/**
 *
 * @author Admin
 */
public class ProcessImg {

    private Cloudinary cloudinary;

    public ProcessImg() {
        // Initialize the Cloudinary object
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dy2t6fuqj",
                "api_key", "895449815491482",
                "api_secret", "ohztXubIe66oY6J6NE_nAtgU7Hw"));
    }

    public String uploadImageToFolder(InputStream imageStream, String folder) throws IOException {
        // Read the image content into a byte array
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = imageStream.read(buffer)) != -1) {
            byteArrayOutputStream.write(buffer, 0, bytesRead);
        }
        byte[] fileBytes = byteArrayOutputStream.toByteArray();

        // Set the folder parameter for uploading to a specific folder
        Map<String, Object> uploadParams = ObjectUtils.asMap(
                "folder", folder
        );

        // Upload the image to Cloudinary with the specified folder
        Map<String, Object> uploadResult = cloudinary.uploader().upload(fileBytes, uploadParams);

        // Get the public URL of the uploaded image
        return (String) uploadResult.get("url");
    }

}
