package org.lifeng.events;

import java.util.EventListener;

public interface EventHandler extends EventListener{
	public void handler(Event e);
}
