package vehicle_management;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;  
import java.sql.Date;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.InternetAddress;
import javax.mail.Authenticator;
import javax.activation.*;

@WebServlet("/application_request")
public class user_application extends HttpServlet {
	public void mail2(int code) {
		try{
			Properties mailAccessCredentials = System.getProperties();
	        mailAccessCredentials.put("mail.smtp.port", "587"); // TLS Port
	        mailAccessCredentials.put("mail.smtp.auth", "true"); // Enable Authentication
	        mailAccessCredentials.put("mail.smtp.starttls.enable", "true"); // Enable StartTLS
	        System.out.println("Mail Server Properties have been setup successfully..");
	        
	        
	        Session mailSession = Session.getDefaultInstance(mailAccessCredentials, null);
	        MimeMessage mailMessage = new MimeMessage(mailSession);
	        mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress("gauravladdha.learn@gmail.com"));

	        mailMessage.setSubject("Application Recieved !");
	        
	        
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	       
	        String f="gaurav";
	        String y='\u0022' + f + '\u0022';
	      
	        StringBuilder email = new StringBuilder();
	        email.append("<html><head>");
	        email.append("<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css\">");
	        email.append("<script src=\"https://code.jquery.com/jquery-3.1.1.min.js\" integrity=\"sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=\" crossorigin=\"anonymous\"></script>");
	        email.append("<script src=\"https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js\"></script>");
	        email.append("</hrad>");
	        email.append("<body>");
	        email.append("Your application for vehicle has been recieved <br>. You can check status of your application using below link !<br> ");
	        email.append("Application no is "+code);
	        email.append("<br>");
	        email.append("<br>");
	        email.append("<form action=\"http://localhost:8080/vehicle_management/status.jsp\" method=\"post\">");
	        email.append("<input type=\"hidden\" name=\"app_no\" value='"+code+"'>");
	        email.append("<input type=\"submit\">");
	        email.append("</form>");
	        email.append("</body></head></html>");
	        String u=email.toString();
	        mailMessage.setContent(u, "text/html");
	        System.out.println("Mail Session has been created successfully..");
	        
	        System.out.println("\n\n 3rd ===> Get Session and Send mail");
	        Transport transport = mailSession.getTransport("smtp");
	        transport.connect("smtp.gmail.com", "gauravladdha12@gmail.com", "gauravladdha12");
	        transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
	        transport.close();
	        
			}
			catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
	}
	public void sendmail(int code){
		try{
			Properties mailAccessCredentials = System.getProperties();
	        mailAccessCredentials.put("mail.smtp.port", "587"); // TLS Port
	        mailAccessCredentials.put("mail.smtp.auth", "true"); // Enable Authentication
	        mailAccessCredentials.put("mail.smtp.starttls.enable", "true"); // Enable StartTLS
	        System.out.println("Mail Server Properties have been setup successfully..");
	        
	        
	        Session mailSession = Session.getDefaultInstance(mailAccessCredentials, null);
	        MimeMessage mailMessage = new MimeMessage(mailSession);
	        mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress("gauravladdha.learn@gmail.com"));

	        mailMessage.setSubject("Application for approval of vehicle allotment");
	        
	        
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	        String q="select emp_code,name,purpose,destination,passenger,address,start_date,end_date,start_time from application where app_no=?";
	        PreparedStatement st=con.prepareStatement(q);
	        String f="gaurav";
	        String y='\u0022' + f + '\u0022';
	       // System.out.println(y);
	        st.setInt(1,code);
	        ResultSet results=st.executeQuery();
	        
	        
	        
	        StringBuilder email = new StringBuilder();
	        email.append("<html><head>");
	        email.append("<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css\">");
	        email.append("<script src=\"https://code.jquery.com/jquery-3.1.1.min.js\" integrity=\"sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=\" crossorigin=\"anonymous\"></script>");
	        email.append("<script src=\"https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js\"></script>");
	        email.append("</hrad>");
	        email.append("<body>");
	        email.append("<table style=\"background-repeat:no-repeat; width:450px;margin:0;\" cellpadding=\"0\" cellspacing=\"0\" border=\"2px\">");
	        email.append("<tr><thead><td>Emp_code</td><td>NAME</td><td>purpose</td><td>destination</td><td>passenger</td><td>address</td><td>Start_date</td><td>End_date</td><td>Start_time</td></thead></tr>");
	        int count=0;
	        while(results.next()){
	        	
	        	email.append("<tr>");
	        	email.append("<td>");
	        	email.append(results.getString("emp_code"));
	        	email.append("</td>");
	        	email.append("<td>");
	        	email.append(results.getString("name"));
	        	email.append("</td>");
	        	email.append("<td>");
	        	email.append(results.getString("purpose"));
	        	email.append("</td>");
	        	email.append("<td>");
	        	email.append(results.getString("destination"));
	        	email.append("</td>");
	        	email.append("<td>");
	        	email.append(results.getInt("passenger"));
	        	email.append("</td>");
	        	email.append("<td>");
	        	email.append(results.getString("address"));
	        	email.append("</td>");
	        	email.append("<td>");
	        	email.append(results.getString("start_date"));
	        	email.append("</td>");
	        	email.append("<td>");
	        	email.append(results.getString("end_date"));
	        	email.append("</td>");
	        	email.append("<td>");
	        	email.append(results.getString("start_time"));
	        	email.append("</td>");
	        	email.append("</tr>");
	        	count++;
	        }
	        System.out.println(count+" yooooo");
	        email.append("</table>");
	        email.append("<br>");
	        email.append("<br>");
	        email.append("<form action=\"http://localhost:8080/vehicle_management/approve.jsp\" method=\"post\">");
	        email.append("<input type=\"hidden\" name=\"id\" value='"+code+"'>");
	        email.append("<input type=\"submit\">");
	        email.append("</form>");
	        email.append("</body></head></html>");
	        String u=email.toString();
	        mailMessage.setContent(u, "text/html");
	        System.out.println("Mail Session has been created successfully..");
	        
	        System.out.println("\n\n 3rd ===> Get Session and Send mail");
	        Transport transport = mailSession.getTransport("smtp");
	        transport.connect("smtp.gmail.com", "gauravladdha12@gmail.com", "gauravladdha12");
	        transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
	        transport.close();
	        
			}
			catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		String p=req.getParameter("st_date");
		//System.out.print(p);
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into application(name,purpose,destination,passenger,address,start_date,end_date,start_time,remarks,alloted,emp_code,cancel,app_no,approve,outs,number) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1, req.getParameter("name"));
			st.setString(2, req.getParameter("purpose"));
			st.setString(3,req.getParameter("dest"));
			st.setInt(4,Integer.parseInt(req.getParameter("no_passenger")));
			st.setString(5,req.getParameter("address"));
			st.setString(6,req.getParameter("st_date"));
			st.setString(7,req.getParameter("end_date"));
			st.setString(8,req.getParameter("st_time"));
			st.setString(9,req.getParameter("remark"));
			st.setInt(10,0);
			st.setString(11,req.getParameter("emp_code"));
			st.setInt(12,0);
			st.setString(13,req.getParameter("app_no"));
			
			if(Integer.parseInt(req.getParameter("outs"))==1){
				st.setInt(14,0);
				st.setInt(15, 1);
			}
			else{
				st.setInt(14,1);
				st.setInt(15, 0);
			}
			
			st.setString(16,req.getParameter("phone"));
			int i=st.executeUpdate();
			System.out.print(i);
			
				/*if(req.getParameter("outs")!=null)
			System.out.println(req.getParameter("outs")+" yoooofoooo");*/
			user_application mail=new user_application();
			
			if(i==1 ){
				HttpSession session = req.getSession();
				q="update employee set total_application=? where emp_code=?";
				st=con.prepareStatement(q);
				st.setString(1, req.getParameter("current"));
				
				st.setString(2,(String)session.getAttribute("emp_code"));
				i=st.executeUpdate();
				mail.mail2(Integer.parseInt(req.getParameter("app_no")));
			}
			
			// message sent
			con.close();
			if(Integer.parseInt(req.getParameter("outs"))==1){
			
			mail.sendmail(Integer.parseInt(req.getParameter("app_no")));
			
			PrintWriter out=res.getWriter();
		    out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('APPLICATION SENT FOR APPROVAL');");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
			}
			else{
				PrintWriter out=res.getWriter();
				 out.println("<script type=\"text/javascript\">");
		    	 //  out.println("alert('APPLICATION SENT FOR APPROVAL');");
		    	   out.println("location='user_index.jsp';");
		    	   out.println("</script>");
			}
		    System.out.println("mail sent");
		    
		    
		} catch (Exception e) {
			// TODO Auto-generated catch block
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('Enter valid data');");
	    	   out.println("location='application.jsp';");
	    	   out.println("</script>");
			e.printStackTrace();
		}
		
	}
}
