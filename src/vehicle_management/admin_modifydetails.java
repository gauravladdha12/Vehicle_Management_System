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

@WebServlet("/modify_details")
public class admin_modifydetails extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		
	
		try {
			
			System.out.println(req.getParameter("driver_code"));
			System.out.println(req.getParameter("registeration_no"));
			System.out.println(req.getParameter("app_no"));
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			
			int i;
			
			String q2="select *from journey where app_no=?";
			PreparedStatement st2=con.prepareStatement(q2);
			st2.setString(1, req.getParameter("app_no"));
			ResultSet results=st2.executeQuery();
			results.next();
			
			
			String q5="select *from journey where not app_no=? and driver_code=? and completed=0 ;";
			st2=con.prepareStatement(q5);
			st2.setString(2, results.getString("driver_code"));
			st2.setString(1, req.getParameter("app_no"));
			ResultSet results5=st2.executeQuery();
			int c1=0;
			while(results5.next()){
				c1++;
			}
			if(c1==0){
			String q3="update driver set available=1 where driver_code=?";
			PreparedStatement st3=con.prepareStatement(q3);
			st3.setString(1,results.getString("driver_code"));
			i=st3.executeUpdate();
			}
			
			String q9="select *from journey where not app_no=? and registeration_no=? and completed=0 ;";
			st2=con.prepareStatement(q9);
			st2.setString(2, results.getString("registeration_no"));
			st2.setString(1, req.getParameter("app_no"));
			ResultSet results6=st2.executeQuery();
			int c2=0;

			while(results6.next()){
				c2++;
			}

			if(c2==0){
			String q4="update vehicle set available=1 where registeration_no=?";
			PreparedStatement st4=con.prepareStatement(q4);
			st4.setString(1, results.getString("registeration_no"));
			i=st4.executeUpdate();
			}
			
			
			
			String q="update journey set driver_code=? , registeration_no=? where app_no=?";
			PreparedStatement st=con.prepareStatement(q);
	
			st.setString(1, req.getParameter("driver_code"));
			st.setString(2, req.getParameter("registeration_no"));
			st.setString(3, req.getParameter("app_no"));
			i=st.executeUpdate();
			
			
			String p1="update vehicle set available=0 where registeration_no=?";
			PreparedStatement sp1=con.prepareStatement(p1);
			sp1.setString(1,req.getParameter("registeration_no"));
			i=sp1.executeUpdate();
			
			
			
			String p2="update driver set available=0 where driver_code=?";
			PreparedStatement sp2=con.prepareStatement(p2);
			sp2.setString(1,req.getParameter("driver_code"));
			i=sp2.executeUpdate();
			
	
				
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
	    	   out.println("location='allocate.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
}
}
