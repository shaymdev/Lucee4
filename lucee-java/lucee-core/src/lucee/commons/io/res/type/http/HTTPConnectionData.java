/**
 *
 * Copyright (c) 2014, the Railo Company Ltd. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either 
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public 
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 * 
 **/
package lucee.commons.io.res.type.http;

import lucee.commons.lang.StringUtil;
import lucee.runtime.Info;
import lucee.runtime.net.proxy.ProxyData;

public final class HTTPConnectionData {
	
	public static final String DEFAULT_USER_AGENT = "Lucee "+Info.getVersionAsString()+" "+Info.getStateAsString();
	

	public String username="";
	public String password="";
	public String host="localhost";
	public int port=0;
    public ProxyData proxyData;
	public String path;
	public String userAgent=DEFAULT_USER_AGENT;


	public int timeout;

	public HTTPConnectionData(String username, String password, String host, int port, String path,ProxyData proxyData, String userAgent) {
		this.username = username;
		this.password = password;
		this.host = host;
		this.port = port;
		this.proxyData = proxyData;
		this.path = path;
		if(!StringUtil.isEmpty(userAgent))this.userAgent = userAgent;
	}



	public HTTPConnectionData(String path,int timeout) {
		load(path);
		this.timeout=timeout;
		
	}
	public HTTPConnectionData(String path) {
		load(path);
	}



	public void load(String path) {
		username="";
		password="";
		host=null;
		port=-1;
		// TODO impl proxy
		
		int atIndex=path.indexOf('@');
		int slashIndex=path.indexOf('/');
		if(atIndex>slashIndex)atIndex=-1;
		
		if(slashIndex==-1){
			slashIndex=path.length();
			path+="/";
		}
		int index;
		
		// username/password
		if(atIndex!=-1) {
			index=path.indexOf(':');
			if(index!=-1 && index<atIndex) {
				username=path.substring(0,index);
				password=path.substring(index+1,atIndex);
			}
			else username=path.substring(0,atIndex);
		}
		// host port
		if(slashIndex>atIndex+1) {
			index=path.indexOf(':',atIndex+1);
			if(index!=-1 && index>atIndex && index<slashIndex) {
				host=path.substring(atIndex+1,index);
				port=Integer.parseInt(path.substring(index+1,slashIndex));
			}
			else host=path.substring(atIndex+1,slashIndex);
		}
		
		this.path= path.substring(slashIndex);
	}



	@Override
	public String toString() {
		return "username:"+username+";password:"+password+";hostname:"+host+";port:"+port+";path:"+path;
	}
	
	public String key() {
		if(StringUtil.isEmpty(username))
				return host+_port();
		return username+":"+password+"@"+host+_port();
	}



	private String _port() {
		if(port>0) return ":"+port;
		return "";
	}



	public boolean hasProxyData() {
		return proxyData!=null && proxyData.getServer()!=null;
	}



	
	@Override
	public boolean equals(Object obj) {
		if(this==obj)return true;
		if(!(obj instanceof HTTPConnectionData)) return false;
		return key().equals(((HTTPConnectionData)obj).key());
	}



	public void setProxyData(ProxyData proxyData) {
		this.proxyData=proxyData;
	}

	/*public static void main(String[] args) {
		test("search.twitter.com/search.atom?q=@mktweetup");
		test("search.twitter.com/search.atom?q=mktweetup");
		test("u@search.twitter.com/search.atom?q=mktweetup");
		test("u:p@search.twitter.com/search.atom?q=mktweetup");
	}
	private static void test(String string) {
		print.out(string);
		HTTPConnectionData data = new HTTPConnectionData(string);
		print.out(data.toString());
	}*/
}
