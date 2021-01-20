package vehicle_management;

import java.util.*;
import java.sql.*;
public class validate  {
	public boolean isvalid(String app_no,String emp){
		if(app_no.length()<4)
			return false;
		 String f=app_no.substring(0,4);
		 if(f.compareTo(emp)!=0)
			 return false;
		 return true;
	}
}
