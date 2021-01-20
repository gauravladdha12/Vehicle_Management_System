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

@WebServlet("/user_modify")
public class user_modify extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="update application set name=?, purpose=?, destination=?,passenger=?,address=?, start_date=?, end_date=?, start_time=?, remarks=?, number=? where app_no=?";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1, req.getParameter("name"));
			st.setString(2, req.getParameter("purpose"));
			st.setString(3,req.getParameter("destination"));
			st.setString(4,req.getParameter("passenger"));
			st.setString(5,req.getParameter("address"));
			st.setString(6,req.getParameter("start_date"));
			st.setString(7,req.getParameter("end_date"));
			st.setString(8,req.getParameter("start_time"));
			st.setString(9,req.getParameter("remarks"));
			st.setString(10, req.getParameter("phone"));
			st.setString(11,req.getParameter("app_no"));
			int i=st.executeUpdate();
			
			String q2="select *from application where app_no=?";
			PreparedStatement st2=con.prepareStatement(q2);
			st2.setString(1,req.getParameter("app_no"));
			ResultSet result=st2.executeQuery();
			result.next();
			
			if(result.getInt("outs")==0 &&result.getInt("alloted")==1) {
				 q2="select *from journey where app_no=?";
				 st2=con.prepareStatement(q2);
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
				
				String q4="update application set alloted=0 where app_no=?";
				PreparedStatement st4=con.prepareStatement(q4);
				st4.setString(1, req.getParameter("app_no"));
				i=st4.executeUpdate();
				
				q4="delete from journey where app_no=?";
				st4=con.prepareStatement(q4);
				st4.setString(1, req.getParameter("app_no"));
				i=st4.executeUpdate();
				
			}
			
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
		}
		catch (Exception e) {
			// TODO: handle exception
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('ENTER VALID DATA');");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
		}
	}
}
