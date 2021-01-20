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

@WebServlet("/start_journey")
public class start_journey extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="update journey set present_km=?, start=1 where app_no= ?";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1, req.getParameter("present_km"));
			st.setString(2, req.getParameter("app_no"));
			int i=st.executeUpdate();
			
			q="select registeration_no from journey where app_no=?";
			st=con.prepareStatement(q);
			st.setString(1, req.getParameter("app_no"));
			ResultSet results=st.executeQuery();
			results.next();
			
			q="update vehicle set present_km=? where registeration_no=?";
			st=con.prepareStatement(q);
			st.setString(1,req.getParameter("present_km"));
			st.setString(2, results.getString("registeration_no"));
			
			i=st.executeUpdate();
			
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
	    	   out.println("location='start_journey.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
