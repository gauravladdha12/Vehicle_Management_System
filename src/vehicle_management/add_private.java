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

@WebServlet("/add_private")
public class add_private extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into private_expense values(?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1,req.getParameter("registeration_no"));
			st.setString(2,req.getParameter("start"));
			st.setString(3,req.getParameter("upto"));
			st.setDouble(4,Double.parseDouble(req.getParameter("km_run")));
			st.setDouble(5,Double.parseDouble(req.getParameter("liter")));
			st.setDouble(6,Double.parseDouble(req.getParameter("average")));
			st.setDouble(7,Double.parseDouble(req.getParameter("cost_per_km")));
			st.setDouble(8,Double.parseDouble(req.getParameter("opening")));
			st.setDouble(9,Double.parseDouble(req.getParameter("closing")));
			st.setString(10,req.getParameter("last_service_date"));
			st.setDouble(11,Double.parseDouble(req.getParameter("service_km")));
			int i=st.executeUpdate();
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	  out.println("location='admin_index.jsp';");
	    	  out.println("</script>");
			
		}catch (Exception e) {
			// TODO: handle exception
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('ENTER VALID DATA');");
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
		}
	}
}
