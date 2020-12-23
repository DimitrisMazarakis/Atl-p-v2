<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
session.invalidate();
%>

<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	
	<!-- automatically will redirect to index_ex2_8180064.jsp after 2 seconds -->
	<meta http-equiv="refresh" content="2;url=<%=request.getContextPath() %>/login.jsp" />
		
	<meta name="description" content="Log out">
	<meta name="author" content="">
	
	<title>2η Ατομική Άσκηση - Sign out</title>
	
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css">

	<!-- Custom styles for this template -->
	<link href="<%=request.getContextPath() %>/css/theme_8180064.css" rel="stylesheet">

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	
	</head>
	<body>	

		<div class="container" role="main">

			<div class="alert alert-success text-center" role="alert">Η έξοδος πραγματοποιηθηκε με επιτυχία</div>		

		</div>
		<!-- /container -->

		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
		<script	src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
		
	</body>
</html>
