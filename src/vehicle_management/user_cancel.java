package vehicle_management;
import java.io.IOException;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Properties;

@WebServlet("/user_cancel")
public class user_cancel extends HttpServlet {
	public void mail_user(String code) {
		try{
			Properties mailAccessCredentials = System.getProperties();
	        mailAccessCredentials.put("mail.smtp.port", "587"); // TLS Port
	        mailAccessCredentials.put("mail.smtp.auth", "true"); // Enable Authentication
	        mailAccessCredentials.put("mail.smtp.starttls.enable", "true"); // Enable StartTLS
	        System.out.println("Mail Server Properties have been setup successfully..");
	        
	        
	        Session mailSession = Session.getDefaultInstance(mailAccessCredentials, null);
	        MimeMessage mailMessage = new MimeMessage(mailSession);
	        mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress("gauravladdha.learn@gmail.com"));

	        mailMessage.setSubject("Application Cancelled !");
	        
	        
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
	        email.append("Your application for vehicle has been cancelled <br>. You can check status of your application using below link !<br> ");
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
	public void mail_admin(String code) {
		try{
			Properties mailAccessCredentials = System.getProperties();
	        mailAccessCredentials.put("mail.smtp.port", "587"); // TLS Port
	        mailAccessCredentials.put("mail.smtp.auth", "true"); // Enable Authentication
	        mailAccessCredentials.put("mail.smtp.starttls.enable", "true"); // Enable StartTLS
	        System.out.println("Mail Server Properties have been setup successfully..");
	        
	        
	        Session mailSession = Session.getDefaultInstance(mailAccessCredentials, null);
	        MimeMessage mailMessage = new MimeMessage(mailSession);
	        mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress("gauravladdha.learn@gmail.com"));

	        mailMessage.setSubject("Application Cancelled !");
	        
	        
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
	        email.append("Application no "+code+"has been cancelled. <br> You can check status of your application using below link !<br> ");
	        email.append("Application no is "+code);
	        email.append("<br>");
	        email.append("<br>");
	        email.append("<form action=\"http://localhost:8080/vehicle_management/filter_appno.jsp\" method=\"post\">");
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
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			int alloted=Integer.parseInt(req.getParameter("alloted"));
			//System.out.println("hellooo"+alloted);
			if(alloted==1)
			{
				
				String q2="select *from journey where app_no=?";
				PreparedStatement st2=con.prepareStatement(q2);
				st2.setString(1, req.getParameter("app_no"));
				ResultSet results=st2.executeQuery();
				results.next();
				
				
				String q5="select *from journey where not app_no=? and driver_code=? and completed=0 ;";
				st2=con.prepareStatement(q5);
				st2.setString(2, results.getString("driver_code"));
				st2.setString(1, req.getParameter("app_no"));
				ResultSet results5=st2.executeQuery();
				int c1=0;
				while(results5.next()){
					c1++;
				}
				if(c1==0){
				String q3="update driver set available=1 where driver_code=?";
				PreparedStatement st3=con.prepareStatement(q3);
				st3.setString(1,results.getString("driver_code"));
				int i=st3.executeUpdate();
				}
				
				String q9="select *from journey where not app_no=? and registeration_no=? and completed=0 ;";
				st2=con.prepareStatement(q9);
				st2.setString(2, results.getString("registeration_no"));
				st2.setString(1, req.getParameter("app_no"));
				ResultSet results6=st2.executeQuery();
				int c2=0;

				while(results6.next()){
					c2++;
				}

				if(c2==0){
				String q4="update vehicle set available=1 where registeration_no=?";
				PreparedStatement st4=con.prepareStatement(q4);
				st4.setString(1, results.getString("registeration_no"));
				int i=st4.executeUpdate();
				}
				
		
			String q4="delete from journey where app_no=?";
			PreparedStatement st=con.prepareStatement(q4);
			st.setString(1, req.getParameter("app_no"));
			int i=st.executeUpdate();
			
			q5="update application set cancel=1 , alloted=0, cancel_remark_user=? where app_no=?";
			st=con.prepareStatement(q5);
			st.setString(1, req.getParameter("cancel_remarks"));
			st.setString(2, req.getParameter("app_no"));
			i=st.executeUpdate();
			
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
			  out.println("location='user_index.jsp';");
			  out.println("</script>");
			}
			else{
				String q5="update application set cancel=1 , alloted=0 , cancel_remark_user=? where app_no=?";
				PreparedStatement st=con.prepareStatement(q5);
				st.setString(1, req.getParameter("cancel_remarks"));
				st.setString(2, req.getParameter("app_no"));
				int i=st.executeUpdate();
				PrintWriter out=res.getWriter();
				  out.println("<script type=\"text/javascript\">");
				  out.println("location='user_index.jsp';");
				  out.println("</script>");
			}
			user_cancel mail=new user_cancel();
			mail.mail_user((req.getParameter("app_no")));
			mail.mail_admin((req.getParameter("app_no")));
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('Enter valid data');");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}

}
