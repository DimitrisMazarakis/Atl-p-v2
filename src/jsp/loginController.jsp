<%@ page language="java" contentType="text/html;
   charset=UTF-8" pageEncoding="UTF-8"%>
   <%@ page import="team40.*" %>

   <%
   String username = request.getParameter("username");
   String password = request.getParameter("password");
   UserDAO userd= new UserDAO();
   try {
   
      User usr=userd.authenticate(username,password);
   
      session.setAttribute("userObj",usr);
      if(usr.getDep().equals("Accounting")){
         %>
         <jsp:forward page="Accounting.jsp"/>
      <%
      }else if(usr.getDep().equals("Car")){
         %>
         <jsp:forward page="Vehicles.jsp"/>
         <%
      }else if(usr.getDep().equals("Administration")){
          %>
          <jsp:forward page="Management.jsp"/>
          <%
      }
   } catch(Exception e) {
      request.setAttribute( "message", e.getMessage() );
   
   %>
       <jsp:forward page="login.jsp"/>
   <%    
   } 
   %>
