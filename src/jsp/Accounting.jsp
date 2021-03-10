<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team40.*" %>
<%
User user = (User)session.getAttribute("userObj");
if(user==null){
  request.setAttribute("message","You are not authorized to access this resource. Please login.");
  %>
  <jsp:forward page="login.jsp" />
    <%}%>
<!DOCTYPE html>
<html lang="en">

<head>
    <%@ include file="Header.jsp" %>
  <title>Αναλύσεις Λογιστηρίου</title>


</head>

<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="sidebar">
      <a href="Accounting.jsp" >Αναλύσεις Λογιστηρίου</a>
      <div class="back">
        <a href="logout.jsp" >Έξοδος</a>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->
    <div class="container">
      <% if(request.getAttribute("message") != null) { %>		
        <div class="alert alert-danger text-center" role="alert"><%=(String)request.getAttribute("message") %></div>
      <% } %>
      <div class="row">
        <div class="col-lg-10 col-xl-9 mx-auto">
          <div class="card card-signin flex-row my-5">
            <div class="card-body">
              <h5 class="card-title text-center">Αναλύσεις Λογιστηρίου</h5>
              <form action="AccountingController.jsp" method="POST" class="form-signin">
                <div class="form-list">
                  <select name="Department" id="Department">
                    <option value="Τμήμα" selected hidden> Αναλύσεις </option>
                    <option value="ena"> Σύγκριση προμήθειας πρακτορείων με την συνολική παραγωγή τους </option>
                    <option value="duo"> Ανάλυση πρακτορείων με αυξημένη απόδοση </option>
                  </select>
                </div>
                <label class="container"> 
                    <input type="checkbox" name = "etos" > Ανά έτος
                    <span class="checkmark"></span>
                </label>
                <label class="container"> 
                    <input type="checkbox" name = "persi" > Σύγκριση με πέρυσι
                    <span class="checkmark"></span>
                </label>
                <label class="container"> 
                    <input type="checkbox" name = "diagramma" > Δημιουργία διαγράμματος
                    <span class="checkmark"></span>
                </label>
                <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Παραγωγή Ανάλυσης</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- /#page-content-wrapper -->
  </div>

</body>

</html>
