/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.mvc.command;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.lifeng.mvc.proxy.vo.ParseRequest;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import org.omg.PortableServer.REQUEST_PROCESSING_POLICY_ID;
import org.puremvc.java.multicore.interfaces.INotification;
import org.puremvc.java.multicore.patterns.command.SimpleCommand;

/**
 *
 * @author lifeng
 */
public class ParseHTMLForSometingCommand extends SimpleCommand {
    public void execute(INotification notification){
        ParseRequest request=(ParseRequest)notification.getBody();
        
        //System.out.println(string);
        //HashMap map=new HashMap();
        getValue(request);
    }
    private void getValue(ParseRequest request){
        try {
            Document document=Jsoup.connect(request.url).get();
            if(!request.map.isEmpty()){
               //mS=request.map.keySet();
               Iterator iterator=request.map.entrySet().iterator();
               while(iterator.hasNext()){
                Map.Entry entry=(Map.Entry) iterator.next();
                //System.out.println(entry.getKey()+"_____"+entry.getValue());

                String nameS=(String)entry.getValue();
                String query=nameS.split("@")[0];
                String arrtS=nameS.split("@")[1];
                //System.out.println(query+"__"+arrtS);
                Elements elements=document.select(query);
                Iterator it=elements.iterator();
                while(it.hasNext()){
                    Element ele=(Element)it.next();
                    System.out.println(ele.attr(arrtS));
                    //System.out.println(ele.attr(multitonKey));
                }
               }
            } 

            //Elements list=document.select(query);
            //System.out.println(list);
        } catch (Exception e) {
        }
    }
    
}
