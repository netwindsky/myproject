package org.lifeng.protocol;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author lifeng
 */

public class ParseProtocol{
   // private String _messageS="";

    //private String[] arrayList=null;
    private ArrayList<String> arrayList=new ArrayList<String>();
    public ParseProtocol(){
        
    }
    public ParseProtocol(String message) {
        //_messageS=message;
        String[] ses=message.split(" ");
        for(int i=0;i<ses.length;i++){
            arrayList.add(ses[i]);
        }
    }
    public String getValue(String key){
        String string=null;
        Pattern p=Pattern.compile(key);
        for(int i=0;i<arrayList.size();i++){
            Matcher m=p.matcher(arrayList.get(i));
            if(m.find()){
                String s=arrayList.get(i).split(":")[1];
                string=s;
            }
        }
        return string;
    }
    public void addElem(String keyS,String valueS){
        arrayList.add(keyS+":"+valueS);
    }
    public String getWarpInfo(){
        String string="";
         for(int i=0;i<arrayList.size();i++){
             if(i==arrayList.size()-1){
                string+=arrayList.get(i);
             }else{
                string+=arrayList.get(i)+" ";
             }
         }
        return string;
    }
}
