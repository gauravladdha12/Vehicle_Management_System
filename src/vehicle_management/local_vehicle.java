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

@WebServlet("/local_vehicle")
public class local_vehicle extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into application(name,purpose,destination,passenger,address,start_date,end_date,start_time,remarks,alloted,emp_code,cancel,app_no,approve) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1, "admin");
			st.setString(2, "OFFICIAL");
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
			st.setInt(14,1);
			int i=st.executeUpdate();

			String q2="select *from employee where emp_code=?;";
			PreparedStatement st2=con.prepareStatement(q2);
			st2.setString(1, req.getParameter("emp_code"));
			ResultSet r1=st2.executeQuery();
			r1.next();
			int p=r1.getInt("total_application");
			p++;
			String q3="update employee set total_application=? where emp_code=?;";
			PreparedStatement st3=con.prepareStatement(q3);
			st3.setInt(1, p);
			st3.setString(2, req.getParameter("emp_code"));
			i=st3.executeUpdate();
			
			System.out.println(p+" okkkkk");
			
			PrintWriter out=res.getWriter();
		    out.println("<script type=\"text/javascript\">");
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
		}
		catch (Exception e) {
			// TODO: handle exception
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('Enter valid data');");
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
			e.printStackTrace();
		}
	}
}
