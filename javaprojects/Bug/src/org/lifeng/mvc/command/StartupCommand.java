/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.mvc.command;

import org.puremvc.java.multicore.interfaces.INotification;
import org.puremvc.java.multicore.patterns.command.SimpleCommand;

/**
 *
 * @author lifeng
 */
public class StartupCommand extends SimpleCommand {
    public void execute(INotification notification){
        System.out.println("startup");
        //new ServerConnetor().startUp();
    }
}
