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


@WebServlet("/modify_driver")
public class modify_driver extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="update driver set  name=?, father_name=?, license_no=?, contact_no=?, dob=?, doj=?, live=?, company_flag=?, license_valid=?, address=?, available=? where driver_code=?";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(12,req.getParameter("driver_code"));
			st.setString(1,req.getParameter("name"));
			st.setString(2,req.getParameter("father_name"));
			st.setString(3,req.getParameter("license_no"));
			st.setString(4,req.getParameter("number"));
			st.setString(5,req.getParameter("dob"));
			st.setString(6,req.getParameter("doj"));
			st.setInt(7,Integer.parseInt(req.getParameter("live")));
			st.setString(8,req.getParameter("company_flag"));
			st.setString(9,req.getParameter("license_valid"));
			st.setString(10,req.getParameter("address"));
			st.setInt(11,Integer.parseInt(req.getParameter("available")));
			
			int i=st.executeUpdate();
			System.out.print(i);
			con.close();

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
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
