package vehicle_management;


import javax.print.attribute.standard.MediaSize.NA;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Response;

import org.apache.jasper.tagplugins.jstl.core.Out;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;  

@WebServlet("/register")
public class register extends HttpServlet  {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException{
		String user=req.getParameter("username").toLowerCase();
		String email=req.getParameter("email").toLowerCase();
		String emp_code=req.getParameter("emp_code").toLowerCase();
		String dept=req.getParameter("emp_dept").toLowerCase();
		String pass=req.getParameter("password");
		//System.out.println(user+" "+pass+" "+email+" "+emp_code+" "+dept);
		//database
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
		Statement st=con.createStatement();
		String q1="insert into employee(emp_code,name,email,password,emp_dept) values('"+emp_code+"','"+user+"' , '"+email+"' , '"+pass+"' , '"+dept+"')";
		//String q1="insert into employee(emp_code,name,email,password,emp_dept) values("+emp_code+","+user+","+email+","+pass+","+dept+")";
		int x = st.executeUpdate(q1); 
		res.sendRedirect("http://localhost:8080/vehicle_management/login.jsp");
		con.close();
		} catch (Exception e) {
			PrintWriter out=res.getWriter();
			out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('user already exist');");
	    	   out.println("location='register.jsp';");
	    	   out.println("</script>");
		} 
	}
}

