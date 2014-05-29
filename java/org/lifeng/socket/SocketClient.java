package org.lifeng.socket;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.util.HashMap;

import org.lifeng.events.Event;
import org.lifeng.events.EventSource;

public class SocketClient extends EventSource implements Runnable {

	private String Host="172.17.4.221";
	//private String Host="192.168.15.1";
	private int port=1256;
	private Socket socket =null;
	private DataInputStream in;
	private DataOutputStream out;
	public SocketClient(){
		
	}
	public void start(){
		try {
			//dispatchEvent(new Event("Error"));
			//Log.e("client", "ent");
			socket=new Socket(Host, port);
			in=new DataInputStream(socket.getInputStream());
			out=new DataOutputStream(socket.getOutputStream());
			dispatchEvent(new Event("Connected"));
		} catch (Exception e) {
			// TODO: handle exception
			dispatchEvent(new Event("Error"));
		}
	}
	public boolean isConnected(){
		
		return socket.isConnected();
	}
	public void write(String string){

		try {
                        System.out.println(string);
			byte[] bs=string.getBytes("utf-8");
                        System.out.println(bs);
			//byte head=0x02;
			//byte end=0x00;
			//out.writeByte(head);
			//out.writeInt(bs.length);
//
                        out.write(bs, 0, bs.length);
			//out.writeByte(end);
			out.flush();
			//System.out.println("success");
		} catch (Exception e) {
			// TODO: handle exception
			dispatchEvent(new Event("Error"));
		}

	}
	public void run() {
		// TODO Auto-generated method stub
		try {
			while(true){
				//Log.e("available", in.available()+"");
				if(in.available()>0){
					ByteBuffer bs=ByteBuffer.allocate(in.available());
					byte[] bb=bs.array();
                                        System.out.println(bb.length);
                                        in.read(bb, 0, bb.length);
					//bs.flip();
					//bs.put(bb);
					//bs.position(0);
					dispatchEvent(new org.lifeng.events.Event("message",bb));
					//dispatchEvent(new Event("message"));
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
