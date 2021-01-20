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

@WebServlet("/approve")
public class outs_approve extends HttpServlet  {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try{
		String s1=req.getParameter("arr1");
		String s2=req.getParameter("arr2");
		String approve[]=s1.split(",");
		String reject[]=s2.split(",");
		int i;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
		for(i=0;i<approve.length;i++){
		String q="update application set approve=1 where app_no=?";
		PreparedStatement st=con.prepareStatement(q);
		st.setString(1,approve[i]);
		int j=st.executeUpdate();
		}
		
		for(i=0;i<reject.length;i++){
			String q="update application set approve=2 where app_no=?";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1,reject[i]);
			int j=st.executeUpdate();
			}
		PrintWriter out=res.getWriter();
		  out.println("<script type=\"text/javascript\">");
  	   out.println("location='approve.jsp';");
  	   out.println("</script>");
		}
		catch (Exception e) {
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('ERROR');");
	    	   out.println("location='approve.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}

