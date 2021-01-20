package vehicle_management;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;  

@WebServlet("/logout")
public class logout extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException{
		try {
		HttpSession session = req.getSession();
		session.removeAttribute("emp_code");
		session.removeAttribute("admin");
		session.removeAttribute("gate");
		PrintWriter out=res.getWriter();
		  out.println("<script type=\"text/javascript\">");
  	 
  	   out.println("location='login.jsp';");
  	   out.println("</script>");
		
		}
		catch (Exception e) {
			// TODO: handle exception
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	 
	    	   out.println("location='login.jsp';");
	    	   out.println("</script>");
		}
	}
}
