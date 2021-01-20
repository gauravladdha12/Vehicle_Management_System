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

@WebServlet("/newvehicle_trans")
public class newvehicle_trans extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into vehicle_transaction values(?,?,?,?,?,?,?);";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1,req.getParameter("registeration_no"));
			st.setString(2,req.getParameter("insurance_upto"));
			st.setString(3,req.getParameter("servicing_upto"));
			st.setString(4,req.getParameter("pollution_control_valid"));
			st.setString(5,req.getParameter("certificate_of_fitness"));
			st.setString(6,req.getParameter("servicing_date"));
			st.setDouble(7,Double.parseDouble(req.getParameter("servicing_km")));
			int i=st.executeUpdate();
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
	    	   out.println("location='newvehicle_transaction.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
