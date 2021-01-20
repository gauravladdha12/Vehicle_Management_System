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

@WebServlet("/add_vehicle")
public class add_vehicle extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="insert into vehicle values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement st=con.prepareStatement(q);
			st.setString(1, req.getParameter("chassis_no"));
			st.setString(2, req.getParameter("registeration_no").toUpperCase());
			st.setString(3, req.getParameter("engine_no"));
			st.setString(4, req.getParameter("mfg_date"));
			st.setString(5, req.getParameter("wheel_base"));
			st.setInt(6, Integer.parseInt(req.getParameter("cubic_cap")));
			st.setInt(7, Integer.parseInt(req.getParameter("engine_cap")));
			st.setInt(8, Integer.parseInt(req.getParameter("seat_cap")));
			st.setString(9, req.getParameter("vehicle_class"));
			st.setString(10, req.getParameter("model_name"));
			st.setString(11, req.getParameter("vehicle_make"));
			st.setString(12, req.getParameter("pur_date"));
			st.setString(13, req.getParameter("reg_date"));
			st.setString(14, req.getParameter("body_type"));
			st.setString(15, req.getParameter("fuel_type"));
			st.setString(16, req.getParameter("color"));
			st.setInt(17, Integer.parseInt(req.getParameter("live")));
			st.setString(19, req.getParameter("company_flag"));
			st.setInt(20, Integer.parseInt(req.getParameter("cylinder")));
			st.setString(21, req.getParameter("reg_valid"));
			st.setString(22, req.getParameter("remark"));
			st.setInt(18,1);
			st.setDouble(23,Double.parseDouble(req.getParameter("present_km")));
			st.setString(24, req.getParameter("user"));
			st.setInt(25, Integer.parseInt(req.getParameter("usable")));
			int i=st.executeUpdate();
			System.out.print(i);
			con.close();

			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
			  out.println("location='admin_index.jsp';");
			  out.println("</script>");
			// message sent
			
			  
		} catch (Exception e) {
			// TODO Auto-generated catch block
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('Enter valid data');");
	    	   out.println("location='add_vehicle.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}

}
