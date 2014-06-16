/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.mvc.facade;

import org.lifeng.mvc.command.ParseDiscriptionCommand;
import org.lifeng.mvc.command.ParseHTMLForSometingCommand;
import org.lifeng.mvc.command.StartupCommand;
import org.puremvc.java.multicore.patterns.facade.Facade;

/**
 *
 * @author lifeng
 */


public class MainFacade extends Facade {

    public static final String NAME="MainrFacade";
    private static MainFacade _instance;


    public static final String START_UP="start_up";
    public static final String PARSE_HTML_SOMETING="parse_html_someting";
    public static final String PARSE_DISCRIPTION="parse_discription";
    protected  MainFacade(){
        super(NAME);
    }
    @Override
   protected void  initializeController(){
       super.initializeController();
       registerCommand(START_UP, new StartupCommand());
       registerCommand(PARSE_HTML_SOMETING, new ParseHTMLForSometingCommand());
       registerCommand(PARSE_DISCRIPTION, new ParseDiscriptionCommand());
   }
    @Override
    protected void initializeModel(){
        super.initializeModel();
    }
    @Override
    protected  void initializeView(){
        super.initializeView();
    }
    public static MainFacade getInstance(){
        if(_instance==null){
            _instance=new MainFacade();
        }
        return _instance;
    }
    public void  Startup(){
        sendNotification(START_UP);
    }
}
