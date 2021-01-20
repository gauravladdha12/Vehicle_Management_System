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

@WebServlet("/add_maintenance")
public class add_maintenance extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into maintenance values(?,?,?,?);";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1, req.getParameter("registeration_no"));
			st.setString(2, req.getParameter("start_date"));
			st.setString(3, req.getParameter("end_date"));
			st.setDouble(4, Double.parseDouble(req.getParameter("cost")));
			int i=st.executeUpdate();
			
		
			
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	  out.println("location='admin_index.jsp';");
	    	  out.println("</script>");
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('ENTER VALID DATA');");
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
		}
	}
}
