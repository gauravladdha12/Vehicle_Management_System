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

@WebServlet("/add_driver")
public class add_driver extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into driver values(?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1,req.getParameter("driver_code"));
			st.setString(2,req.getParameter("name"));
			st.setString(3,req.getParameter("father_name"));
			st.setString(4,req.getParameter("license_no"));
			st.setString(5,req.getParameter("number"));
			st.setString(6,req.getParameter("dob"));
			st.setString(7,req.getParameter("doj"));
			st.setInt(8,Integer.parseInt(req.getParameter("live")));
			st.setString(9,req.getParameter("company_flag"));
			st.setString(10,req.getParameter("license_valid"));
			st.setString(11,req.getParameter("address"));
			st.setInt(12,1);
			int i=st.executeUpdate();
			System.out.print(i);
			con.close();

			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
			  out.println("location='admin_index.jsp';");
			  out.println("</script>");
			// message sent
			
			  
		} catch (Exception e) {
			// TODO Auto-generated catch block
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('Enter valid data');");
	    	   out.println("location='add_vehicle.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
