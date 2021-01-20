package vehicle_management;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;  

@WebServlet("/login")
public class login extends HttpServlet  {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException{
		String user=req.getParameter("username");
		String pass=req.getParameter("password");
		PrintWriter out=res.getWriter();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q2="select *from gate where emp_code=?;";
			PreparedStatement st2=con.prepareStatement(q2);
			st2.setString(1,user);
			ResultSet rs3=st2.executeQuery();
			int rowcount = 0;
			if (rs3.last()) {
			  rowcount = rs3.getRow();
			  rs3.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
			}
			rs3.next();
			if(rowcount>0) {
				if(pass.compareTo(rs3.getString("password"))==0) {
					 HttpSession session = req.getSession();
		    		  session.setAttribute("emp_code", user);
		    		  session.setAttribute("admin",0);
		    		  session.setAttribute("gate", 1);
		    		  out.println("<script type=\"text/javascript\">");
		    		  out.println("location='gate.jsp';");
		    		  out.println("</script>");
		    		  return;
				}
			}
			
			Statement st=con.createStatement();
			String q1="select * from employee where emp_code='"+user+"'";
			ResultSet rs2=st.executeQuery(q1);
			 int rowCount = 0;
		      while (rs2.next()) {
		           rowCount++;
		      }
		      if(rowCount>0){
		    	  ResultSet rs=st.executeQuery(q1);
		    	  rs.next();
		    	  String check=rs.getString("password");
		    	  if(pass.compareTo(check)==0){
		    		  HttpSession session = req.getSession();
		    		  session.setAttribute("emp_code", user);
		    		  //System.out.println("SUCcsss");
		    		  session.setAttribute("gate", 0);
		    		  if(rs.getInt("admin")==0) {
		    			  session.setAttribute("admin",0);
		    		  out.println("<script type=\"text/javascript\">");
		    		  out.println("location='user_index.jsp';");
		    		  out.println("</script>");
		    		  }
		    		  else {
		    			  session.setAttribute("admin",1);
		    			  out.println("<script type=\"text/javascript\">");
			    		  out.println("location='admin_index.jsp';");
			    		  out.println("</script>");
		    		  }
		    	  }
		    	  else{
		    		  out.println("<script type=\"text/javascript\">");
			    	   out.println("alert('User or password incorrect');");
			    	   out.println("location='login.jsp';");
			    	   out.println("</script>");
		    	  }
		      }
		      else{
		    	   out.println("<script type=\"text/javascript\">");
		    	   out.println("alert('User or password incorrect');");
		    	   out.println("location='login.jsp';");
		    	   out.println("</script>");
		      }

		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("noooo");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		//System.out.println(user+" "+pass);
	}
}