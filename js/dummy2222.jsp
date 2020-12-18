<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team40.*"%>
<%@ page import="java.time.*"%>
<%@ page import="java.util.*"%>
<html>
  <head>
   <h2>Συγκριση με πέρυσι</h2>
					<table class="table table-bordered">
						<tr class="warning">
							<th>Agency Name</th>
							<th>1st Month</th>
							<th>1st Month Prev. Year</th>
							<th>2nd Month</th>
							<th>2nd Month Prev. Year</th>
							<th>3rd Month</th>
							<th>3rd Month Prev. Year</th>
							<th>4th Month</th>
							<th>4th Month Prev. Year</th>
							<th>5th Month</th>
							<th>5th Month Prev. Year</th>
							<th>6th Month</th>
							<th>6th Month Prev. Year</th>
						</tr>
						<%
                        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO ag= new AgencyDAO();

        agencies= ag.getAgencies();
        contracts=condao.getContracts();
                        Analysis an = new Analysis();
						float[][] con_by_agency = new float[agencies.size()][7];
						float[][] con_by_agencyprpr = new float[agencies.size()][7];
						con_by_agency = an.performanceAnalysis(0);
						con_by_agencyprpr = an.performanceAnalysis(1);
						for (int row = 0; row < con_by_agency.length; row++){
							%>
								<tr class="success">
									<%
									for(int col = 0; col < con_by_agency[row].length; col++){
										if(col==0){
											%>
											<th><%=ag.findName(con_by_agency[row][col])%></th>
										<%
										}else if(col!=1){
											%>
											<th><%=con_by_agency[row][col]%></th>
											<th><%=con_by_agencyprpr[row][col]%></th>
											<%
										}
									}
									%>
								</tr>
								<%
							}
					%></table>
  </head>
  <body>
  

  </body>
</html>