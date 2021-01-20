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

@WebServlet("/modify_vehicle")
public class modify_vehicle extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
			String q="update vehicle set chassis_no=?, engine_no=?, manufacturing_date=?, wheel_base=?, cubic_capacity=?, engine_capacity=?, sitting_capacity=?, vehicle_class =?, model_name=?, vehicle_make=?, purchase_date=?, registeration_date=?, body_type=?, fuel_type=?, color=?, live=?, available=?, company_flag=?, cylinder=?, registeration_validity=?, remark=?, present_km=?,user=?,usable=? where registeration_no=?";
			
			PreparedStatement st=con.prepareStatement(q);
			st.setString(25, req.getParameter("registeration_no"));
			st.setString(1, req.getParameter("chassis_no"));
			st.setString(2, req.getParameter("engine_no"));
			st.setString(3, req.getParameter("mfg_date"));
			st.setString(4, req.getParameter("wheel_base"));
			st.setInt(5, Integer.parseInt(req.getParameter("cubic_cap")));
			st.setInt(6, Integer.parseInt(req.getParameter("engine_cap")));
			st.setInt(7, Integer.parseInt(req.getParameter("seat_cap")));
			st.setString(8, req.getParameter("vehicle_class"));
			st.setString(9, req.getParameter("model_name"));
			st.setString(10, req.getParameter("vehicle_make"));
			st.setString(11, req.getParameter("pur_date"));
			st.setString(12, req.getParameter("reg_date"));
			st.setString(13, req.getParameter("body_type"));
			st.setString(14, req.getParameter("fuel_type"));
			st.setString(15, req.getParameter("color"));
			st.setInt(16, Integer.parseInt(req.getParameter("live")));
			st.setString(18, req.getParameter("company_flag"));
			st.setInt(19, Integer.parseInt(req.getParameter("cylinder")));
			st.setString(20, req.getParameter("reg_valid"));
			st.setString(21, req.getParameter("remark"));
			st.setInt(17,Integer.parseInt(req.getParameter("available")));
			st.setDouble(22,Double.parseDouble(req.getParameter("present_km")));
			st.setString(23, req.getParameter("user"));
			st.setInt(24, Integer.parseInt(req.getParameter("usable")));
			int i=st.executeUpdate();
			System.out.print(i);
			con.close();

			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
			  out.println("location='admin_index.jsp';");
			  out.println("</script>");
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('Enter valid data');");
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
