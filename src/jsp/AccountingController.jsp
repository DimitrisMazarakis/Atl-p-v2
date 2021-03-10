<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.time.*"%>
<%@ page import="team40.*" %>
<%@ page import= "java.time.LocalDate, java.time.Instant, java.time.LocalDateTime, java.time.LocalDateTime, java.util.Date" %>
<%
         String dep = request.getParameter("Department");
         String etos = request.getParameter("etos");
         String persi = request.getParameter("persi");
         String diagramma = request.getParameter("diagramma"); 
         Boolean den_mphke=true;
         Analysis analysis1 = new Analysis();
         Analysis analysis2 = new Analysis();
		 float[][] pinakas1= new float[30][4];
		 if(etos!=null && persi!=null){
			request.setAttribute("message","Δεν είναι εφικτό να είναι ταυτόχρονα επιλεγμένα τα κουμπιά 'Ανά έτος' και 'Σύγκριση με πέρυσι' ");
			%> 
    		<jsp:forward page="Accounting.jsp" />
			<%
		 }
		 if (!dep.equals("ena") && !dep.equals("duo")) { 
			request.setAttribute("message","Δεν έχει επιλεχθεί Ανάλυση");
			%> 
    		<jsp:forward page="Accounting.jsp" />
			<%
		 }%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <%@ include file="Header.jsp" %>
      <%@ include file="Accounting_diagrams.jsp" %>


   </head>
   <body>
		<!-- Sidebar -->
		<script>
			function closeNav() {
				document.getElementById("sidebarr").style.width = "0";
				}
			function openNav() {
			document.getElementById("sidebarr").style.width = "150px";
			}
			</script>
		<div id="sidebarr" class="sidebar" style=" position: fixed; transition: 0.5s; width: 0;">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<a href="Accounting.jsp" >Αναλύσεις Λογιστηρίου</a>
		<div class="back">
			<a href="logout.jsp" >Έξοδος</a>
		</div>
		</div>
		<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; Μενού</span>

		<!-- /#sidebar-wrapper -->
      <div class="container theme-showcase" role="main">
         <!-- Main jumbotron for a primary marketing message or call to action -->
         <div class="jumbotron">
            <h1 style="text-align:center">Analysis Results</h1>
         </div>
      </div>
      <%
         if (dep == null) { 
			response.sendRedirect("Accounting.jsp");
            return;
		 }

         if( dep.equals("ena")){
			 
         	%>
      		<h1 style="text-align:center">Σύγκριση προμήθειας πρακτορείων με την συνολική παραγωγή τους</h1>
      		<%
         	if(diagramma==null){
         		if(etos==null && persi==null){
					 pinakas1 = analysis1.commissionComparison();
					 %>
					 <table class="table table-bordered" >
						 <tr class="shrink">
							 <th>Agency Name</th>
							 <th>Commission</th>
							 <th>Amount in euro</th>
							 <th>Ratio</th>
						 </tr>
					 <%
					 for (int row = 0; row < pinakas1.length; row++){
						 %>
							 <tr class="success">
								 <%
								 for(int col = 0; col < pinakas1[row].length; col++){
									 if(col==0){
										 %>
										 <th><%=ag.findName(pinakas1[row][col])%></th>
									 <%
									 }else{
										 %>
									 <th><%=pinakas1[row][col]%></th>
									 <%
									 }
								 }
								 %>
							 </tr>
							 <%
					 }
					%></table><%
         		}
            	if(etos!=null && persi==null){
         			%>
					<h2 style="text-align:center">Ανα έτος</h2>
					<table class="table table-bordered" >
						<tr class="shrink">
							<th>Agency Name</th>
							<th>Commission</th>
							<th>Amount 2020</th>
							<th>Amount 2019</th>
							<th>Amount 2018</th>
							<th>Amount 2017</th>
							<th>Ratio 2020</th>
							<th>Ratio 2019</th>
							<th>Ratio 2018</th>
							<th>Ratio 2017</th>
						</tr>
					<%
						%>
							<tr class="success">
								<%
								for(int i=0;i<l;i++){
									%>
										<tr class="success">
											<td><%=ag.findName(con[i][0])%></td>
											<td><%=con[i][1]%></td>
											<td><%=con[i][2]%></td>
											<td><%=con_prev[i][2]%></td>
											<td><%=con_prev1[i][2]%></td>
											<td><%=con_prev2[i][2]%></td>
											<td><%=con[i][3]%></td>
											<td><%=con_prev[i][3]%></td>
											<td><%=con_prev1[i][3]%></td>
											<td><%=con_prev2[i][3]%></td>
										</tr>
									<% } %>
							</tr>
							<%
					%></table><%
					// prwto checkbox ana etos
				}
				if(etos==null && persi!=null){
				den_mphke=false;
				%>
				<h2 style="text-align:center">Συγκριση με πέρυσι</h2>
				<table class="table table-bordered" >
					<tr class="shrink">
						<th>Agency Name</th>
						<th>Current year Ratio</th>
						<th>Previous year Ratio</th>
						<%
						for(int i=0;i<l;i++){
						%>
							<tr class="success">
								<td><%=ag.findName(con[i][0])%></td>
								<td><%=con[i][3]%></td>
								<td><%=con_prev[i][3]%></td>
							</tr>
						<% } %>
				</table>
				<%
				//deutero checkbox sugkrish mee persu
         		}
			}else{
				den_mphke=false;
				if(etos==null && persi==null){
					%>
					<div  id="top_x" style="width: 800px; height: 600px; margin:0 auto;"></div>
					<%
				}
				if(etos!=null && persi==null){
					%>
					<h2 style="text-align:center">Ανα έτος</h2>
					<div id="columnchart_material" style="width: auto; height: 900px;"></div>
					<%
					// prwto checkbox ana etos
				}
				if(etos==null && persi!=null){
					%>
					<h2 style="text-align:center">Συγκριση με πέρυσι</h2>
					<div id="chart_div" style="width: 800px; height: 600px; margin:0 auto;"></div>
					<%
					//deutero checkbox sugkrish mee persu
         		}
         	}
         	%>
			<div class="container theme-showcase" role="main">
			<!-- Main jumbotron for a primary marketing message or call to action -->
			<style>
				.table-bordered{
				border-collapse:collapse;
				margin: 25px 0;
				font-size: 0.9em;
				}
				.table-bordered tr{
				background-color:rgb(206, 206, 206);
				color:rgb(48, 48, 48);
				font-color:rgb(44, 44, 44);
				padding:12px 15px;
				}
				.h1{
				text-align:center;
				}
				.table-bordered tr.shrink{
				white-space:nowrap
				}
			</style>
			<%
      	}
      	
        if(dep.equals("duo")){
         	%>
			<h1 style="text-align:center">Ανάλυση πρακτορείων με αυξημένη απόδοση</h1>
			<%
			if(diagramma==null){
				if(etos==null && persi==null){%>
					<table class="table table-bordered">
						<tr class="warning">
							<th>Agency Name</th>
							<th>1 Month before</th>
							<th>2 Months before</th>
							<th>3 Months before</th>
							<th>4 Months before</th>
							<th>5 Months before</th>
							<th>6 Months before</th>
						</tr>
						<%
						for (int row = 0; row < min_values.length; row++){
							%>
								<tr class="success">
									<%
									for(int col = 0; col < min_values[row].length; col++){
										if(col==0){
											%>
											<th><%=ag.findName(min_values[row][col])%></th>
										<%
										}else if(col!=1){
											%>
											<th><%=min_values[row][col]%></th>
											<%
										}
									}
									%>
								</tr>
								<%
							}
					%></table><%
				}
				if(etos!=null && persi==null){
					%>
					<h2 style="text-align:center">Ανα έτος</h2>
					<table class="table table-bordered">
						<tr class="warning">
							<th>Agency Name</th>
							<th>Previous Year</th>
							<th>Current Year</th>
						</tr>
						<%
						for (int row = 0; row < min_values4.length; row++){
							%>
								<tr class="success">
									<%
									for(int col = 0; col < min_values4[row].length; col++){
										if(col==0){
											%>
											<th><%=ag.findName(min_values4[row][col])%></th>
										<%
										}else if(col!=1){
											%>
											<th><%=min_values4[row][col]%></th>
											<%
										}
									}
									%>
								</tr>
								<%
							}
					%></table><%
					// prwto checkbox ana etos
				}
				if(etos==null && persi!=null){
					den_mphke=false;//logika
					%>
					<h2 style="text-align:center">Συγκριση με πέρυσι</h2>
					<table class="table table-bordered">
						<tr class="warning">
							<th>Agency Name</th>
							<th>1 Month before</th>
							<th>1 Month before Prev. Year</th>
							<th>2 Months before</th>
							<th>2 Months before Prev. Year</th>
							<th>3 Months before</th>
							<th>3 Months before Prev. Year</th>
							<th>4 Months before</th>
							<th>4 Months before Prev. Year</th>
							<th>5 Months before</th>
							<th>5 Months before Prev. Year</th>
							<th>6 Months before</th>
							<th>6 Months before Prev. Year</th>
						</tr>
						<%
						
						for (int row = 0; row < min_valueslol.length; row++){
							%>
								<tr class="success">
									<%
									for(int col = 0; col < min_valueslol[row].length; col++){
										if(col==0){
											%>
											<th><%=ag.findName(min_valueslol[row][col])%></th>
										<%
										}else if (col!=1){
											%>
											<th><%=min_valueslol[row][col]%></th>
											<th><%=min_valuesprlol[row][col]%></th>
											<%
										}
									}
									%>
								</tr>
								<%
							}
					%></table><%
					//deutero checkbox sugkrish mee persu
				}
			}else{
				den_mphke=false;
				if(etos==null && persi==null){
					%>
					<div style="width:800px; margin:0 auto;" id="line_to"></div>
					<%
				}
				if(etos!=null && persi==null){
					%>
					<h2 style="text-align:center">Ανα έτος</h2>
					<div style="width:800px; margin:0 auto;" id="2h_ana_etos"></div>
					<%
					// prwto checkbox ana etos
				}
				if(etos==null && persi!=null){
					%>
					<h2 style="text-align:center">Συγκριση με πέρυσι</h2>
					<div style="width:800px; margin:0 auto;" id="line_to"></div>
					<div style="width:800px; margin:0 auto;" id="line_prlol"></div>
					<%
					//deutero checkbox sugkrish mee persu
				}
			}
		}
            %>
      <script src="js/jquery.min.js"></script>
      <!-- Bootstrap core JavaScript -->
	  <script	src="js/bootstrap.min.js"></script>
   </body>
</html>
