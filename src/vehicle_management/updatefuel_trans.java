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

@WebServlet("/updatefuel_trans")
public class updatefuel_trans extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="update fuel_transaction set registeration_no=?, filling_date=?, name_of_party=?, present_km=?, liter=?, cost=?, average=?, cost_per_km=?,remark=? where bill_no=?";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(10,req.getParameter("bill_no"));
			st.setString(1,req.getParameter("registeration_no"));
			st.setString(2,req.getParameter("filling_date"));
			st.setString(3,req.getParameter("name_of_party"));
			st.setDouble(4,Double.parseDouble(req.getParameter("present_km")));
			st.setDouble(5,Double.parseDouble(req.getParameter("liter")));
			st.setDouble(6,Double.parseDouble(req.getParameter("cost")));
			st.setDouble(7,Double.parseDouble(req.getParameter("average")));
			st.setDouble(8,Double.parseDouble(req.getParameter("cost_per_km")));
			st.setString(9,req.getParameter("remark"));
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
	    	   out.println("location='fuel_trans.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
