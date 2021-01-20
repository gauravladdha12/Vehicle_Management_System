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

@WebServlet("/get_app")
public class get_app extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="select total_application as prev from employee where emp_code=?;";
			PreparedStatement st=con.prepareStatement(q);
			//HttpSession session = request.getSession();
			st.setString(1,(String)req.getParameter("emp_code"));
			ResultSet results=st.executeQuery();
			int current =-1;
			//System.out.println("okkkk");
			
			while(results.next())
			 current=results.getInt("prev");
			
			if(current==-1) {
				PrintWriter out=res.getWriter();
				 out.println(-1);
			}
			else {
			
			current++;
			String app_no=(String)req.getParameter("emp_code")+current;
			
			System.out.println(app_no);
		
			
			res.setContentType("text/plain");
		    PrintWriter out=res.getWriter();
		    out.print(app_no);
		    out.flush();
		    out.close();
			}
		    
		}
		catch (Exception e) {
			// TODO: handle exception
		}
}
}
