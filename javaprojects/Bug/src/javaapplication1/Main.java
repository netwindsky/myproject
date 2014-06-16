/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

/**
 *
 * @author lifeng
 */
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.lifeng.events.Event;
import org.lifeng.events.EventHandler;
import org.lifeng.html.HtmlParser;
import org.lifeng.html.URLLoader;
import org.lifeng.mvc.facade.MainFacade;
import org.lifeng.mvc.proxy.vo.ParseRequest;
import org.lifeng.mvc.proxy.vo.WriteObject;
import org.lifeng.unit.MapObject;


public class Main {

    /**
     * @param args the command line arguments
     */
    private String time;

    public static void main(String[] args) {
        // TODO code application logic here


        while (true) {
            try {
                /* String path="http://pm25.in/beijing";
                Document doc = Jsoup.connect(path).get();
                //System.out.println(doc.toString());
                //System.out.println(doc.select("html tbody tr"));
                //System.out.println(doc.select("div.listtyle1_page_w>a[href]"));
                Elements links=doc.select("html tbody tr");
                //ArrayList list=new ArrayList();
                for(Element link:links){
                System.out.println("------>>>>"+link.text());

                String[] array=link.text().split(" ");
                System.out.println("----->>>"+array.length);
                System.out.println(array[0]+":"+array[1]);
                //list.add(path+link.attr("href"));
                }*/
                HashMap selectmap = new HashMap();
                selectmap.put("pm25", "html tbody tr");
                selectmap.put("time", "div.live_data_time p");
                HtmlParser parse = new HtmlParser("http://pm25.in/beijing", selectmap);
                parse.addEventListener(HtmlParser.PARSE_OVER, new EventHandler() {

                    public void handler(Event e) {

                        HashMap object = (HashMap) e.getBody();


                        System.out.println();
                        Elements time = (Elements) object.get("time");
                        
                        String timeS=time.text().split("：")[1];
                        System.out.println(timeS);
                        ArrayList htmlArrayList = HtmlParser.getTextArray(time);
                        for (int i = 0; i < htmlArrayList.size(); i++) {
                            String txt = (String) htmlArrayList.get(i);
                            // String[] valarr = txt.split(" ");
                            //String postS = "location=" + valarr[0] + "&aqi=" + valarr[1] + "&aqitype=" + valarr[2] + "&psource=" + valarr[3] + "&pm25v=" + valarr[4] + "&pm10v=" + valarr[5] + "&cov=" + valarr[6] + "&no2v=" + valarr[7] + "&o31hv=" + valarr[8] + "&o38hv=" + valarr[9] + "&so2v=" + valarr[10];
                            System.out.println(txt);
                            //System.out.println("out-->>>" + URLLoader.submitPost("http://203.195.186.89:8080/air_qualities/", postS));
                        }
                        Elements valueE = (Elements) object.get("pm25");
                        //System.out.println(valueE);
                        ArrayList valueArrayList = HtmlParser.getHtmlArray(valueE);
                        System.out.println(valueArrayList.size());
                        for (int i = 0; i < valueArrayList.size(); i++) {
                            String htmlS="<table><tr>"+(String)valueArrayList.get(i)+"</tr></table>";
                            //System.out.println(htmlS);
                            Document jd=Jsoup.parse(htmlS);
                            System.out.println(jd.select("td").size());
                            Elements sj=jd.select("td");
                            System.out.println(sj.get(0).text());

                            String postS = "location=" + sj.get(0).text() + "&aqi=" + sj.get(1).text() + "&aqitype=" + sj.get(2).text() + "&psource=" + sj.get(3).text() + "&pm25v=" + sj.get(4).text() + "&pm10v=" + sj.get(5).text() + "&cov=" + sj.get(6).text() + "&no2v=" + sj.get(7).text() + "&o31hv=" + sj.get(8).text() + "&o38hv=" + sj.get(9).text() + "&so2v=" + sj.get(10).text() + "&motime=" + timeS;
                            System.out.println(postS);
                            System.out.println("out-->>>" + URLLoader.submitPost("http://203.195.186.89:8080/air_qualities/", postS));
                       
                            //System.out.println(jd.outerHtml()+"\n::::"+jd.text());
                            //htmlS=htmlS.replace("<td>", "");
                            //htmlS=htmlS.replace("</td> ", ",");
                            //System.out.println("--->>>"+htmlS);
                            /*String txt = (String) valueArrayList.get(i);
                            System.out.println(txt);
                            String[] valarr = txt.split(" ");
                            System.out.println(valarr.length);
                            String postS = "location=" + valarr[0] + "&aqi=" + valarr[1] + "&aqitype=" + valarr[2] + "&psource=" + valarr[3] + "&pm25v=" + valarr[4] + "&pm10v=" + valarr[5] + "&cov=" + valarr[6] + "&no2v=" + valarr[7] + "&o31hv=" + valarr[8] + "&o38hv=" + valarr[9] + "&so2v=" + valarr[10] + "&motime=" + time;
                            System.out.println(postS);*/
                            //System.out.println("out-->>>" + URLLoader.submitPost("http://203.195.186.89:8080/air_qualities/", postS));
                        }

                        //System.out.println("AAAAAAAAAAAAAAA"+e.getBody());
                        /*ArrayList htmlArrayList=HtmlParser.getTextArray((Elements)e.getBody());

                        for(int i=0;i<htmlArrayList.size();i++){
                        String txt=(String)htmlArrayList.get(i);
                        String[] valarr=txt.split(" ");
                        String postS="location="+valarr[0]+"&aqi="+valarr[1]+"&aqitype="+valarr[2]+"&psource="+valarr[3]+"&pm25v="+valarr[4]+"&pm10v="+valarr[5]+"&cov="+valarr[6]+"&no2v="+valarr[7]+"&o31hv="+valarr[8]+"&o38hv="+valarr[9]+"&so2v="+valarr[10];
                        System.out.println(postS);
                        System.out.println("out-->>>"+URLLoader.submitPost("http://203.195.186.89:8080/air_qualities/", postS));
                        }*/
                        //System.out.println(htmlArrayList.size());
                        //URLLoader.submitPost(null, null);


                        throw new UnsupportedOperationException("Not supported yet.");
                    }
                });
                parse.load();
                Thread.sleep(1800000);


                //MainFacade.getInstance().sendNotification(MainFacade.PARSE_HTML_SOMETING,path);
           /* for(Element link:links){
                System.out.println(path+link.attr("href"));
                list.add(path+link.attr("href"));*/






                /*for(int i=1;i<100;i++){
                ParseRequest req=new ParseRequest("http://www.meishij.net/shicai/shuiguo_list?page="+i);
                //req.map.put("name", "div.listtyle1 div.img a@title");
                req.map.put("href","div.listtyle1 div.img a@href");
                MainFacade.getInstance().sendNotification(MainFacade.PARSE_HTML_SOMETING,req);
                }*/

                /*
                SAXReader saxr=new SAXReader();
                org.dom4j.Document document=saxr.read(new File("all.xml"));
                org.dom4j.Element element=document.getRootElement();
                Iterator childs=element.elementIterator("item");
                while(childs.hasNext()){

                org.dom4j.Element item=(org.dom4j.Element)childs.next();
                int a=(int)Math.floor(Math.random()*2000)+2000;
                Thread.sleep(a);
                WriteObject obj=new WriteObject();
                obj.path="http://www.meishij.net/"+item.attributeValue("name");
                obj.name=item.attributeValue("name");

                MainFacade.getInstance().sendNotification(MainFacade.PARSE_DISCRIPTION,obj);
                }*/
            } catch (Exception e) {
                //System.out.println("fffffffffff");
                System.out.println(e);
            }
        }

    }
}
