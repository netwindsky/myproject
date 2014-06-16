/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.spring;
/**
 *
 * @author Administrator
 */


import java.io.IOException;   
import java.util.*;   
import javax.servlet.*;   
import javax.servlet.http.*;   
import javax.sql.DataSource;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.mvc.Controller;   
import org.springframework.web.servlet.ModelAndView;   
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.socket.server.RequestUpgradeStrategy;

public class HelloUserAction extends AbstractController{
    private String helloworld;
    private String viewpage;
    private DataSource pm25datasource;
    public ModelAndView handleRequestInternal(HttpServletRequest rq,HttpServletResponse res) throws ServletException,IOException{
        setSupportedMethods(new String[]{"GET","POST"});//定义支持的模式
        rq.setCharacterEncoding("UTF-8");//get 中文乱码
        String user=rq.getParameter("user");//获取参数值
        //ServletRequestUtils.getIntParameter(rq, "user"); //获取参数。
        
        //服务器session用法------------------------------------
        HttpSession session =rq.getSession(true);
        String heading;
        Integer accessCount=(Integer)session.getAttribute("accessCount");
        if(accessCount==null){
            accessCount=new Integer(0);
            heading="Welcome,NewCommer";
        }else{
            accessCount=new Integer(accessCount.intValue()+1);
            heading="welcom,back!";
        }
        session.setAttribute("accessCount", accessCount);
        //服务器session用法------------------------------------
        
        
        //-----------------------数据连接池用法--------------------------------
        
        
        
        //--------------------------------------------------------
        Map model=new HashMap();
        model.put("helloWorld", "<xml><a>first</a></xml>");//HelloWorld和user值应用在对应的jsp文件内调用的变量
        model.put("user", user);
        model.put("count", accessCount);
        model.put("session", rq.getSession().getId());
        
        
        
        
        return new ModelAndView(getViewPage(),model);
    }
    public void handleRequestInternal(){
        
    }
    public void setViewPage(String viewPage) {   
       this.viewpage = viewPage;   
    }   
    public String getViewPage() {   
       return viewpage;   
    }   
  
    public void setHelloWord(String helloWord) {   
       this.helloworld = helloWord;   
    }   
      
    public String getHelloWord() {   
       return helloworld;   
    }  
}
