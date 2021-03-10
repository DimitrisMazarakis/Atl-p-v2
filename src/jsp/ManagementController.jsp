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
<jsp:forward page="Management.jsp" />
<%
   }
   if (!dep.equals("ena") && !dep.equals("duo") && !dep.equals("tria") && !dep.equals("tessera")) { 
   request.setAttribute("message","Δεν έχει επιλεχθεί Ανάλυση");
   %> 
<jsp:forward page="Management.jsp" />
<%
   }%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <%@ include file="Header.jsp" %>
      <%@ include file="Car_diagrams.jsp" %>
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
		<a href="Management.jsp" >Αναλύσεις Διοίκησης</a>
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
         response.sendRedirect("Management.jsp");
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
            %>
      </table>
      <%
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
            %>
      </table>
      <%
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
            %>
      </table>
      <%
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
            %>
      </table>
      <%
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
            %>
      </table>
      <%
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
         if(dep.equals("tria") || dep.equals("tessera")){
			Analysis an1 = new Analysis();
			notnot an22 = new notnot();
			third th1 = new third();
			int etos1;
         	float[][] pinakas11= new float[3][1];
			Date[][] packageyear= new Date[3][1];
			List<Contract> contracts2 =  new ArrayList<Contract>();
			List<Contract> contracts1 =  new ArrayList<Contract>();
			List<Contract> contracts0 =  new ArrayList<Contract>();
			ContractDAO condao0 =new ContractDAO();
			contracts1=condao0.getContracts();
			contracts2 = an1.gain_per_contract();
			contracts0=an1.gain_per_contract();
			List<Customer> ages =new ArrayList<Customer>(); 
			List<Customer> ages1 =new ArrayList<Customer>();
			pinakas11 = an1.kerdhanapaketopososto(contracts2,etos);

			String[][] gain1 = new String[13][6];
			String[][] percen1= new String[gain1.length][6];
			
                           
         String[][] gain = new String[13][2];
         String[][] percen= new String[13][2];
         if(etos!=null){
            etos="yes";                        
         }else{
            etos="no";
         }
         notnot age_not = new notnot();
         if(persi!=null){
			etos="yes";
			ages1 =    an22.groupby_ages();
			gain1 = an22.gain_per_age(etos);
			float sum1 = an22.summarize_gain(gain1);  
			percen1 = an22.percentance(sum1,gain1,etos);
         etos="no";
         
         }
         if(etos.equals("no")){
                                ages =    an22.groupby_ages();
                                gain = an22.gain_per_age(etos);
                                float sum = an22.summarize_gain(gain);
         percen = an22.percentance(sum,gain,etos);
                                }else{                           
                                ages1 =    an22.groupby_ages();
                                gain1 = an22.gain_per_age(etos);
                                float sum1 = an22.summarize_gain(gain1);  
                                percen1 = an22.percentance(sum1,gain1,etos);
                            }
         String[][] res = new String[100000][4];
                            res = th1.packages_per_agency();
                            String[][] re = new String[100000][4];
                            re = th1.summarize_counts(res);
                            List<String> packages =  new ArrayList<String>();
                            String package0 = contracts0.get(0).getPackage();
                            packages.add(package0);
                            String packagei;
                            float ammountperpackage;
                            int year0 = contracts0.get(0).getStarting_date().getYear();
                            List<Integer> years =  new ArrayList<Integer>();
                            years.add(year0);
                            int yeari;
                            for(int i=1; i< contracts0.size(); i++){
                                yeari = contracts0.get(i).getStarting_date().getYear();
                                if(years.contains(yeari)){
                                // nothing to see here
                                }else{
                                    years.add(yeari);
                                }
                            }
                            float[][] paketoanaetos = new float[5][3];
                            for(int u=0; u<=4; u++){
                                for(int v=0; v<=2;v++){
                                     paketoanaetos[u][v]=0;
                                }
                            }
                            for(int z=0; z< years.size(); z++){
                                if(z<=4){
                                for(int x=0; x< contracts0.size();x++){
                                    if(contracts0.get(x).getPackage().equals("eco")){
                                        if(contracts0.get(x).getStarting_date().getYear()==years.get(z)){
                                            paketoanaetos[z][0]+=contracts0.get(x).getAmount();
                                        }
                                    }else if(contracts0.get(x).getPackage().equals("max")){
                                        if(contracts0.get(x).getStarting_date().getYear()==years.get(z)){
                                            paketoanaetos[z][1]+=contracts0.get(x).getAmount();
                                        }
                                    }else if(contracts0.get(x).getPackage().equals("basic")){
                                        if(contracts0.get(x).getStarting_date().getYear()==years.get(z)){
                                            paketoanaetos[z][2]+=contracts0.get(x).getAmount();
                                        }
                                    }
                                }
                                }
                            }
                            for(int h=1; h< contracts0.size();h++){
                                for(int j=1; j< packages.size(); j++){
                                    ammountperpackage=0;
                                    for(int m=1; m< contracts0.size(); m++){
                                        if(contracts0.get(h).getPackage().equals(packages.get(j))){
                                            ammountperpackage+= contracts0.get(h).getAmount();
                                        }
                                    }
                                    packageyear[j][0]=contracts0.get(h).getStarting_date();
                                    
                
                                }
                                            
                            }
            if(dep.equals("tria")){
        		if(etos.equals("no")){ 
                if(persi!=null){ 
                    if(diagramma!=null){%>
						<div  id="char_div" style="width: 800px; height: 600px; margin:0 auto;"></div>
						<%}else{%>
						<h2 style="text-align:center">Σύγκριση κερδών ανά πακέτο σε ποσοστό</h2>
						<table class="table table-bordered" >
							<tr>
								<th>Packages </th>
								<th>Package Eco</th>
								<th>Package Max</th>
								<th>Package Basic</th>
							</tr>
							<%for (int i = 3; i < years.size(); i++) { %>
							<tr>
								<th>Year <%=years.get(i)+1900 %></th>
								<th><%=paketoanaetos[i][0]%> </th>
								<th><%=paketoanaetos[i][1]%> </th>
								<th><%=paketoanaetos[i][2]%> </th>
							</tr>
							<%}%>
						</table>
						<%
         }}else{%>
      <%if(diagramma!=null){%>
      <div  id="Car_prwti" style="width: 800px; height: 600px; margin:0 auto;"></div>
      <%}else{%>
      <h2 style="text-align:center">Κέρδη ανά πακέτο σε ποσοστό</h2>
      <table class="table table-bordered" >
      <tr>
         <th>Package Eco</th>
         <th>Package Max</th>
         <th>Package Basic</th>
      <tr class="success">
         <% float pos1 = pinakas11[0][0]/(pinakas11[0][0]+ pinakas11[1][0]+ pinakas11[2][0])*100;
            float pos2 = pinakas11[1][0]/(pinakas11[0][0]+ pinakas11[1][0]+ pinakas11[2][0])*100;
            float pos3 = pinakas11[2][0]/(pinakas11[0][0]+ pinakas11[1][0]+ pinakas11[2][0])*100;
            %>
         <th>Profit: <%= pinakas11[0][0]%>  Percantage of profit: <%= pos1 %> % </th>
         <th>Profit: <%= pinakas11[1][0]%>  Percantage of profit: <%= pos2 %> % </th>
         <th>Profit: <%= pinakas11[2][0]%>  Percantage of profit: <%= pos3 %> % </th>
      </tr>
      </tr>
      <%}}%>
      <%}%>
      <%if(etos.equals("yes")){ 
         if(diagramma!=null){%>
      <div  id="car_prwti_etos" style="width: 800px; height: 600px; margin:0 auto;"></div>
      <%}else{%> 
      <h2 style="text-align:center">Σύγκριση ετήσιων κερδών σε ποσοστό</h2>
      <table class="table table-bordered" >
         <tr>
            <th>Packages </th>
            <th>Package Eco</th>
            <th>Package Max</th>
            <th>Package Basic</th>
         </tr>
         <%for (int i = 0; i < years.size(); i++) { %>
         <tr>
            <th>Year <%=years.get(i)+1900 %></th>
            <th><%=paketoanaetos[i][0]%> </th>
            <th><%=paketoanaetos[i][1]%> </th>
            <th><%=paketoanaetos[i][2]%> </th>
         </tr>
         <%}%>
      </table>
      <%}}
         %>
      <%}
         if(dep.equals("tessera")){
         if(etos.equals("yes")){
                         if(diagramma!=null){%>
      <div  id="car_deuteri_etos" style="width: 800px; height: 600px; margin:0 auto;"></div>
      <%}else{%>
      <h2 style="text-align:center">Σύγκριση κερδών ηλικιακής ομάδας ανά έτος</h2>
      <table class="table table-bordered" >
         <tr>
            <th>Age group</th>
            <th>2018</th>
            <th>2017</th>
            <th>2020</th>
            <th>2019</th>
         </tr>
         <% for(int i = 0 ; i<percen.length;i++){ %>
         <tr class="success">
            <td><%=percen1[i][0] %></td>
            <td><%=percen1[i][1] %></td>
            <td><%=percen1[i][2] %></td>
            <td><%=percen1[i][4] %></td>
            <td><%=percen1[i][5] %></td>
         </tr>
         <% }
            %>
      </table>
      <%
         }}else{
         if(persi!=null){
         if(diagramma!=null){%>
      <div  id="chart_div" style="width: 800px; height: 600px; margin:0 auto;"></div>
      <%}else{%>
      <h2 style="text-align:center">Σύγκριση κερδών ανά ηλικιακή ομάδα με πέρσυ</h2>
      <table class="table table-bordered" >
         <tr>
            <th>Age group</th>
            <th>2020</th>
            <th>2019</th>
         </tr>
         <% for(int i = 0 ; i<percen.length;i++){ %>
         <tr class="success">
            <td><%=percen1[i][0] %></td>
            <td><%=percen1[i][4] %></td>
            <td><%=percen1[i][5] %></td>
         </tr>
         <% }
            %>
      </table>
      <%
         }}else{
             if(diagramma!=null){%>
      <div  id="car_deuteri" style="width: 800px; height: 600px; margin:0 auto;"></div>
      <%}else{%>          
      <h2 style="text-align:center">Κέρδη ανά ηλικιακή ομάδα σε ποσοστό</h2>
      <table  class="table table-bordered" >
         <tr>
            <th>Age group</th>
            <th>Ratio</th>
         </tr>
         <%for(int i=0;i<percen.length;i++){ %>
         <tr class="success">
            <td><%=percen[i][0] %></td>
            <td><%=percen[i][1] %></td>
         </tr>
         <% 
            }
            %>
      </table>
      <%
         }
         %>
      <%}}%>
      <%}}%>
      <script src="js/jquery.min.js"></script>
      <!-- Bootstrap core JavaScript -->
      <script	src="js/bootstrap.min.js"></script>
   </body>
</html>
