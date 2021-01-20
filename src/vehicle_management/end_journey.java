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

@WebServlet("/end_journey")
public class end_journey extends HttpServlet {
	
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

	        mailMessage.setSubject("Journey Completed !");
	        
	        
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
	        email.append("Your journey for application no "+code+" has been completed . <br>.  You can check the journey cost and other details of journey using the link below !<br> ");
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
			String q2="select *from journey where app_no=?";
			PreparedStatement st2=con.prepareStatement(q2);
			st2.setString(1, req.getParameter("app_no"));
			ResultSet results=st2.executeQuery();
			results.next();
			
			double final_km=Double.parseDouble(req.getParameter("final_km"));
			double rate=Double.parseDouble(req.getParameter("rate"));
			double payable=(final_km-results.getDouble("present_km"))*rate;
			
			//System.out.println(final_km+" "+rate+" "+payable+" "+results.getDouble("present_km"));
			//System.out.println(req.getParameter("app_no"));
			
			String q="update journey set end_date=? , final_km= ? ,rate=? , completed=1 ,payable=? where app_no= ?";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1, req.getParameter("end_date"));
			st.setDouble(2, Double.parseDouble(req.getParameter("final_km")));
			st.setString(3, req.getParameter("rate"));
			st.setDouble(4, payable);
			st.setString(5, req.getParameter("app_no"));
			int j=st.executeUpdate();
			//System.out.println(j);
			
			q2="select *from journey where app_no=?";
			st2=con.prepareStatement(q2);
			st2.setString(1, req.getParameter("app_no"));
			results=st2.executeQuery();
			results.next();
			
			String q6="update vehicle set present_km=? where registeration_no=?";
			PreparedStatement st6=con.prepareStatement(q6);
			st6.setDouble(1,final_km);
			st6.setString(2, results.getString("registeration_no"));
			int u=st6.executeUpdate();
			
			String q5="select *from journey where driver_code=? and completed=0";
			st2=con.prepareStatement(q5);
			st2.setString(1, results.getString("driver_code"));
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
			
			String q9="select *from journey where registeration_no=? and completed=0";
			st2=con.prepareStatement(q9);
			st2.setString(1, results.getString("registeration_no"));
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
			end_journey mail=new end_journey();
			mail.mail_user(req.getParameter("app_no"));
			
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
			  out.println("location='admin_index.jsp';");
			  out.println("</script>");
			
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('Enter valid data');");
	    	   out.println("location='end_journey.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
