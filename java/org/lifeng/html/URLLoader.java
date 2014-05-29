/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lifeng.html;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

/**
 *
 * @author lifeng
 */
public class URLLoader {

    public static StringBuffer submitPost(String url, String paramContent) {
        StringBuffer responseMessage = null;
        java.net.URLConnection connection = null;
        java.net.URL reqUrl = null;
        OutputStreamWriter reqOut = null;
        InputStream in = null;
        BufferedReader br = null;
        String param = paramContent;
        try {

            System.out.println("url=" + url + "?" + paramContent + "\n");
            System.out.println("===========post method start=========");
            responseMessage = new StringBuffer();
            reqUrl = new java.net.URL(url);
            connection = reqUrl.openConnection();
            connection.setDoOutput(true);
            reqOut = new OutputStreamWriter(connection.getOutputStream());
            reqOut.write(param);
            reqOut.flush();
            int charCount = -1;
            in = connection.getInputStream();

            br = new BufferedReader(new InputStreamReader(in, "GBK"));
            while ((charCount = br.read()) != -1) {
                responseMessage.append((char) charCount);
            }

            System.out.println(responseMessage);
            System.out.println("===========post method end=========");
        } catch (Exception ex) {
            System.out.println("url=" + url + "?" + paramContent + "\n e=" + ex);
        } finally {
            try {
                in.close();
                reqOut.close();
            } catch (Exception e) {
                System.out.println("paramContent=" + paramContent + "|err=" + e);
            }

        }
        return responseMessage;
    }

    /**
     * java.net实现 HTTP或HTTPs GET方法提交
     *
     * @param strUrl
     *            提交的地址及参数
     * @return 返回的response信息
     */
    public static String submitGet(String strUrl) {
        URLConnection connection = null;
        BufferedReader reader = null;
        String str = null;
        try {
            System.out.println("send getmethod=" + strUrl);
            URL url = new URL(strUrl);
            connection = url.openConnection();
            connection.setDoInput(true);
            connection.setDoOutput(false);
            // 取得输入流，并使用Reader读取
            reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            System.out.println("============Contents of get request===============");
            String lines;
            StringBuffer linebuff = new StringBuffer("");
            while ((lines = reader.readLine()) != null) {
                linebuff.append(lines);
            }
            System.out.println(linebuff);
            System.out.println("============Contents of get request ends==========");
            str = linebuff.toString();
        } catch (Exception e) {
            System.out.println("getmethod is err=" + e);
            e.printStackTrace();
        } finally {
            try {
                reader.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return str;
    }
}
