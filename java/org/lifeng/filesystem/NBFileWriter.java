/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.filesystem;

import java.io.File;
import java.io.FileWriter;

/**
 *
 * @author lifeng
 */
public class NBFileWriter {
    public void write(File file,String str){
         try {
            if(!file.exists()){
                //System.out.println("AAA--->>>"+file.getPath()+file.getParentFile().getPath());
                file.getParentFile().mkdirs();
                file.createNewFile();
                //System.out.println("AAA--->>>"+file.getPath());
            }
            FileWriter fileWriter=new FileWriter(file,true);
            fileWriter.write(str);
            //System.out.println("*log: "+str+"  time:["+dfFormat.format(date)+"]");
            fileWriter.close();
            //FileInputStream inputStream=new FileInputStream(file);
            //FileOutputStream outputStream =new FileOutputStream(file);
            //FileChannel fileChannel=outputStream.getChannel();
            //ByteBuffer buffer=ByteBuffer.allocate(MAX_BUFFER);
            //buffer.clear();
            //outputStream.flush();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
