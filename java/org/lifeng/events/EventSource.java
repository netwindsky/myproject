package org.lifeng.events;

import java.util.Dictionary;
import java.util.Enumeration;
import java.util.EventListener;
import java.util.EventObject;
import java.util.Hashtable;
import java.util.Vector;


public class EventSource {

	//private Vector repository=new Vector();
	private Hashtable<String, Object> map=new Hashtable<String, Object>();
	EventHandler dl;
	public void addEventListener(String key,Object obj){
		//if(map.containsKey());
		map.put(key, obj);
		
	}
	public void notifyEvent(){
		Enumeration<String> enu=map.keys();
		while(enu.hasMoreElements()){
			dl=(EventHandler)map.get(enu.nextElement());
			//dl.handler(new Event(this));
		}
	}
	public void dispatchEvent(Event e){
		try {
                   // System.out.println("BBBBBBBBBBBB"+e.getType().toString());
			if(map.containsKey(e.getType().toString())){
				//Log.e(e.getBody().toString(), e.getType());
				dl=(EventHandler)map.get(e.getType().toString());
                                //System.out.println("-------------->>>>"+dl);
				dl.handler(new Event(this,e.getType(),e.getBody()));
			}
		} catch (Exception e2) {
			// TODO: handle exception
		}
	}
}
