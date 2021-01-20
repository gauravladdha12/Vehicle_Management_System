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

@WebServlet("/admin_cancel")
public class admin_cancel extends HttpServlet {
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

	        mailMessage.setSubject("Application Cancelled by Admin !");
	        
	        
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
	        email.append("Your application for vehicle has been cancelled by admin <br>. You can check remark and status of your application using below link !<br> ");
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
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="update application set cancel=1, cancel_remark_admin=? where app_no=?";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1,req.getParameter("cancel_remarks"));
			st.setString(2,req.getParameter("app_no"));
			int i=st.executeUpdate();
			
			admin_cancel mail=new admin_cancel();
			mail.mail_user(req.getParameter("app_no"));
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
		}
		catch (Exception e) {
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('ENTER VALID DATA');");
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
		}
	}
}
