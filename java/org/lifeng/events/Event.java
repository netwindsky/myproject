package org.lifeng.events;

import java.util.EventObject;

public class Event{
	Object _source;
	String _type;
	Object _obj;
	public Event(String type){
		_type=type;
	}
	public Event(String type,Object body){
		_type=type;
		_obj=body;
	}
	public Event(Object source,String type){
		//super(source);
		_source=source;
		_type=type;
	}
	public Event(Object source,String type,Object body){
		//super(source);
		_source=source;
		_type=type;
		_obj=body;
	}

	public Object getTarget(){
		return _source;
	}
	public String getType(){
		return _type;
	}
	public Object getBody(){
		return _obj;
	}
}
