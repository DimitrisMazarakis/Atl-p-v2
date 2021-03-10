<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team40.*" %>
<%
    User user = (User) session.getAttribute("userObj");
    if(user==null){
    request.setAttribute("message","You are not authorized to access this resource. Please login.");
   %>
    <jsp:forward page="login.jsp" />
<%}%>
<!DOCTYPE html>
<html lang="en">

<head>
  <%@ include file="Header.jsp" %>
  <title>Αναλύσεις Αυτοκινήτων</title>

</head>

<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="sidebar">
      <a href="Vehicles.jsp" >Αναλύσεις Αυτοκινήτων</a>
      <div class="back">
        <a href="logout.jsp" >Έξοδος</a>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->
    <div class="container">
      <div class="row">
        <div class="col-lg-10 col-xl-9 mx-auto">
          <div class="card card-signin flex-row my-5">
            <div class="card-body">
              <h5 class="card-title text-center">Αναλύσεις Αυτοκινήτων</h5>
              <form class="form-signin">
                <div class="form-list">
                  <select name="Department" id="Department">
                    <option value="Τμήμα" selected hidden> Αναλύσεις </option>
                    <option value="Α1"> Κέρδη ανά πακέτο και σε ποσοστό </option>
                    <option value="Α2"> Κέρδη ανά ηλικιακή ομάδα και σε ποσοστό </option>
                    <option value="Α3"> Ανάλυση πακέτων ανά πράκτορα και σε ποσοστό </option>
                  </select>
                </div>
                <label class="container"> 
                    <input type="checkbox"> Ανά έτος
                    <span class="checkmark"></span>
                </label>
                <label class="container"> 
                    <input type="checkbox"> Σύγκριση με πέρυσι
                    <span class="checkmark"></span>
                </label>
                <label class="container"> 
                    <input type="checkbox"> Δημιουργία διαγράμματος
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
