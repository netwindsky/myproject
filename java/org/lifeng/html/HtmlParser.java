/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.html;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.jsoup.nodes.Element;
import org.lifeng.events.Event;
import org.lifeng.events.EventSource;
import org.lifeng.unit.MapObject;


/**
 *
 * @author lifeng
 * 解析工具
 */
public class HtmlParser extends EventSource{

    private String _path;
    private HashMap _selectMap;

    public static String PARSE_OVER="parse_over";
    public HtmlParser(String path,HashMap map){
        _path=path;
        _selectMap=map;
        //load();
    }
    public HtmlParser(String path){
        _path=path;
    }
    public void  setURL(String path){
        _path=path;
    }
    public void addSelect(String key,String xpath){
        if(_selectMap==null){
            _selectMap=new HashMap();
        }
        _selectMap.put(key, xpath);
    }
    public void load(){
        try {
            Document doc = Jsoup.connect(_path+"?"+Math.random()).get();
            Iterator iter = _selectMap.entrySet().iterator();
            HashMap map=new HashMap();
            while (iter.hasNext()) {
                Map.Entry entry = (Map.Entry) iter.next();
                String key = (String)entry.getKey();
                String val = (String)entry.getValue();
                Elements links=doc.select(val);
                map.put(key, links);
            }
            dispatchEvent(new Event(PARSE_OVER, map));
        } catch (Exception e) {
            //System.out.println("fffffffffff");
            System.out.println(e);
        }
    }
    public static ArrayList getHtmlArray(Elements elemntE){
        ArrayList al=new ArrayList();
        for(Element link:elemntE){
                //System.out.println("AAAAAAAAA----->>>"+link.html());
                al.add(link.html());
            }
       
       return al;
    }
    public static ArrayList getTextArray(Elements elemntE){
        ArrayList al=new ArrayList();
        for(Element link:elemntE){
                //System.out.println("AAAAAAAAA----->>>"+link.text());
                al.add(link.text());
            }

       return al;
    }
}
