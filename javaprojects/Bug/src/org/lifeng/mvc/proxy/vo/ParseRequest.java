/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.mvc.proxy.vo;

import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author lifeng
 */
public class ParseRequest {
    public String url="";
    public HashMap<String,String> map=new HashMap<String, String>();
    public  ParseRequest(String path){
        url=path;
        //_arrtList=array;
    }
}
