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

@WebServlet("/p_entry")
public class p_entry extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into application values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1,req.getParameter("app_no"));
			st.setString(2,req.getParameter("name"));
			st.setString(3,req.getParameter("purpose"));
			st.setString(4,req.getParameter("destination"));
			st.setInt(5,Integer.parseInt(req.getParameter("passenger")));
			st.setString(6,req.getParameter("address"));
			st.setString(7,req.getParameter("start_date"));
			st.setString(8,req.getParameter("end_date"));
			st.setString(9,req.getParameter("start_time"));
			st.setString(10,req.getParameter("remarks"));
			st.setInt(11, 1);
			st.setString(12,req.getParameter("emp_code"));
			st.setInt(13, 1);
			st.setInt(14, 0);
			st.setString(15,null);
			st.setString(16,null);
			st.setInt(17,Integer.parseInt(req.getParameter("outs")));
			st.setString(18,req.getParameter("phone"));
			int i=st.executeUpdate();
			
			String q2="insert into journey values(?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement st2=con.prepareStatement(q2);
			st2.setString(1, req.getParameter("app_no"));	
			st2.setString(2,req.getParameter("emp_code"));
			st2.setString(3,req.getParameter("driver_code"));
			st2.setString(4,req.getParameter("registeration_no"));
			st2.setString(5,req.getParameter("end_date"));
			st2.setDouble(6,Double.parseDouble(req.getParameter("final_km")));
			st2.setInt(7, 1);
			st2.setDouble(8,Double.parseDouble(req.getParameter("present_km")));
			st2.setDouble(9,Double.parseDouble(req.getParameter("rate")));
			st2.setDouble(10,Double.parseDouble(req.getParameter("payable")));
			st2.setInt(11, 1);
			i=st2.executeUpdate();
			
			if(i==1) {
				String p1="select *from employee where emp_code=?;";
				PreparedStatement pt1=con.prepareStatement(p1);
				pt1.setString(1,req.getParameter("emp_code"));
				ResultSet n=pt1.executeQuery();
				n.next();
				int c=n.getInt("total_application");
				String p2="update employee set total_application=? where emp_code=?;";
				PreparedStatement pt2=con.prepareStatement(p2);
				pt2.setInt(1, c+1);
				pt2.setString(2,req.getParameter("emp_code"));
				int j=pt2.executeUpdate();
			}
			
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	  out.println("location='admin_index.jsp';");
	    	  out.println("</script>");
		}
		catch (Exception e) {
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
