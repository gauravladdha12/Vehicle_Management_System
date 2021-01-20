package vehicle_management;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;

@WebServlet("/add_journey")
public class add_journey extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		//System.out.print("helllllllo");
	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into journey(app_no,emp_code,driver_code,registeration_no,completed) values(?,?,?,?,?)";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1, req.getParameter("app_no"));
			st.setString(2, req.getParameter("emp_code"));
			st.setString(3, req.getParameter("driver_code"));
			st.setString(4, req.getParameter("registeration_no"));
			st.setInt(5, 0);
			int i=st.executeUpdate();
			
			String q2="update application set alloted=1 where app_no=?";
			PreparedStatement st2=con.prepareStatement(q2);
			st2.setString(1, req.getParameter("app_no"));
			i=st2.executeUpdate();
			
			 
			String q3="update driver set available=0 where driver_code=?";
			PreparedStatement st3=con.prepareStatement(q3);
			st3.setString(1, req.getParameter("driver_code"));
			i=st3.executeUpdate();
			
			String q4="update vehicle set available=0 where registeration_no=?";
			PreparedStatement st4=con.prepareStatement(q4);
			st4.setString(1, req.getParameter("registeration_no"));
			i=st4.executeUpdate();
			
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
	    	   out.println("location='allocate.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
