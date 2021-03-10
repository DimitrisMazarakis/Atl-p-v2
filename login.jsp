<%@ page language="java" contentType="text/html;
   charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
    <%@ include file="Header.jsp" %>
    <title>Login</title>
    <link rel="stylesheet" href="css/login-style.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
    <body>
        
        <% if(request.getAttribute("message") != null) { %>		
			<div class="alert alert-danger text-center" role="alert"><%=(String)request.getAttribute("message") %></div>
        <% } %>
        <form class="form-signin" method="post" action="<%=request.getContextPath() %>/loginController.jsp">
        <div class="loginbox">
            <h1>Login</h1>
            <label for="inputusername" class="sr-only">Username</label> 
			<input type="text" name="username" id="inputusername" class="form-control" placeholder="username" required>
			<label for="inputpassword" class="sr-only">Password</label>
			<input name="password" type="password" id="inputpassword" class="form-control" placeholder="password" required>
                <button class="btn" type="submit" name="" value="Sign in">Sign in</button>
        </div><br>
        </form>
        <div class="alert alert-info"><strong>Help: </strong>
            <ul>
                <li>For Accounting: NotisLap Password: 7p</li>
                <li>For Car: ChriKar Password: 3c</li>
                <li>For Administration: KonBou Password: 20A</li>
            </ul>
    </div>
     </div>
    </body>
</html>
