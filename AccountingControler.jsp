<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.util.*"%>
<%@ page import="team40.*" %>
<%@page import java.time.LocalDate, java.time.Instant,java.time.LocalDateTime,java.time.LocalDateTime,java.util.Date" %>

<!DOCTYPE html>
    <html lang="en">
	<head>
	<%@ include file="Header.jsp" %>
	</head>
	<body>
        
<%
String a1 = request.getParameter("A1");
String a2 = request.getParameter("A1");
String etos = request.getParameter("etos");
String persi = request.getParameter("persi");
String diagramma = request.getParameter("diagramma"); 
 Analysis analysis1 = new Analysis();
 Analysis analysis2 = new Analysis();
if (a1== null && a2==null) { 
   response.sendRedirect("Accounting.jsp");
   return;
}
if( a1!= null){
	%>
<h1>Σύγκριση προμήθειας πρακτορείων με την συνολική παραγωγή τους</h1>
	<%
	float[][] pinakas1 = analysis1.commisionComparison();
    if(etos!=null){
		%>
		<h2>Ανα έτος</h2>
		<%
   // prwto checkbox ana etos
    
    }
    if(persi!=null){
		%>
		<h2>Συγκριση με πέρυσι</h2>
		<%
   //deutero checkbox sugkrish mee persu
	}
    if(diagramma!=null){
		%>
		<h2>Διάγραμμα</h2>
		<%
    //trito checkbox diagramma
    
    }
	%>
<table class="table table-bordered">
	<%
	for (int row = 0; row < pinakas1.length; row++){
		for(int col = 0; col < pinakas1[row].length; col++){
			<tr class="success">
						  <th><%=pinakas1[row][col]%></th>
		}
	}
}
%>
</tr>
	 </table>
}
<%
if( a2!= null){
	%>
<h1>Ανάλυση πρακτορείων με μειωμένη απόδοση</h1>
	<%
	float[][] pinakas2 = analysis1.commisionComparison();
    if(etos!=null){
		%>
		<h2>Ανα έτος</h2>
		<%
   // prwto checkbox ana etos
    
    }
    if(persi!=null){
		%>
		<h2>Σύγκριση με πέρυσι</h2>
		<%
   //deutero checkbox sugkrish m persu
	}
    if(diagramma!=null){
		%>
		<h2>Διάγραμμα</h2>
		<%
    //trito checkbox diagramma
    
    }
	%>
<table class="table table-bordered">
	<%
	for (int row = 0; row < pinakas2.length; row++){
		for(int col = 0; col < pinakas2[row].length; col++){
			<tr class="success">
						  <th><%=pinakas2[row][col]%></th>
		}
	}
}
%>
</tr>
	 </table>

       </body>
      </html>
 