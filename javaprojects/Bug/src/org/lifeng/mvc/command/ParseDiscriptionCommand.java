/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.mvc.command;

import java.io.File;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.lifeng.filesystem.NBFileWriter;
import org.lifeng.mvc.proxy.vo.ParseRequest;
import org.lifeng.mvc.proxy.vo.WriteObject;
import org.puremvc.java.multicore.interfaces.INotification;
import org.puremvc.java.multicore.patterns.command.SimpleCommand;

/**
 *
 * @author lifeng
 */
public class ParseDiscriptionCommand extends SimpleCommand {
        public void execute(INotification notification){
            WriteObject request=(WriteObject)notification.getBody();
            System.out.println(request.name+":"+request.path);

            try {
                Document document=Jsoup.connect(request.path).get();
                File file=new File("E://快盘/个人/工具开发/数据抓取/info/"+request.name+"/"+request.name+"_基本信息.txt");
                File file1=new File("E://快盘/个人/工具开发/数据抓取/info/"+request.name+"/"+request.name+"_详细信息.txt");
                Elements elements=document.select("div.sc_header");
                NBFileWriter fileWriter=new NBFileWriter();
                fileWriter.write(file, elements.toString());
                //File file=new File("info/"+request.name+"/"+request.name+"基本信息.txt");
                Elements elements1=document.select("div.sccon_right_con");
                NBFileWriter fileWriter1=new NBFileWriter();
                fileWriter1.write(file1, elements1.toString());
            } catch (Exception e) {
                
            }
                
            


        }
}
