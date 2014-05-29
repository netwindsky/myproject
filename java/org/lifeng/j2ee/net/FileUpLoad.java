/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.j2ee.net;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
/**
 *
 * @author lifeng
 */
public class FileUpLoad extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out=response.getWriter();
        
        if(ServletFileUpload.isMultipartContent(request)){
           // Create a factory for disk-based file items
            DiskFileItemFactory  factory = new DiskFileItemFactory();
            ServletFileUpload fileUpload = new ServletFileUpload(factory);
            fileUpload.setHeaderEncoding("UTF-8");
            
            try {
               List list=fileUpload.parseRequest(request);
               Iterator<FileItem> iter = list.iterator();
                while (iter.hasNext()) {
                    FileItem item = iter.next();
                    String name = item.getFieldName();
                    if (item.isFormField()) {
                        String value = item.getString() ;
                        request.setAttribute(name, value);
                        out.print(value);
                    } else {
                        String value = item.getName();
                        out.println("文件名："+value);
                        item.write(new File("D:\\"+value));
                    }
                    //out.print(item.);
                }
               //fileUpload.getFileItemFactory();
               
            } catch (Exception e) {
                e.printStackTrace();
            }
       }
        out.print("fffffffffffffffffffffffffff");
        out.close();
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
