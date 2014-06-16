/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.database.sqllite;
import SQLite.*;

/**
 *
 * @author Administrator
 */
public class SQLiteManager {
    private Database db=new Database();
    static final String strCreate ="create table user (userid integer primary key, username text)";  
    static final String strInsert ="insert into user values (2,'James')";  
    static final String strDisplay ="select * from user";  
    public SQLiteManager(){
        
    }
    public int open(String path){
        try {
            db.open(path, 0666);
            return 1;
        } catch (java.lang.Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
    public void excuteNow(){
        
    }
    public int excute(String sql){
        try {
            db.exec(sql,new TableFmt());
            return 1;
        } catch (java.lang.Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
    public void close(){
        
    }
    
}

class TableFmt implements Callback{  
    public void columns (String[] cols){  
        System.out.println("columns");  
        for (int i = 0; i < cols.length; i++) {  
            System.out.println(cols[i]);  
        }  
    }  
    public boolean newrow(String[] cols){  
        System.out.println("newrow");  
        for (int i = 0; i < cols.length; i++) {  
            System.out.println(cols[i]);  
        }  
        return false;  
    }  
    public void types(String[] cols){  
        System.out.println("types");  
        for (int i = 0; i < cols.length; i++) {  
            System.out.println(cols[i]);  
        }  
    }  
}  
