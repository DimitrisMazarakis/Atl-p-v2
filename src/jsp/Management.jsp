<!DOCTYPE html>
<html lang="en">

<head>
    <%@ include file="Header.jsp" %>
  <title>Αναλύσεις Διοίκησης</title>
</head>

<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="sidebar">
      <a href="Accounting.jsp" >Αναλύσεις Λογιστηρίου</a>
      <a href="Vehicles.jsp" >Αναλύσεις Αυτοκινήτων</a>
      <a href="Managment.jsp" >Αναλύσεις Διοίκησης</a>
      <div class="back">
        <a href="login.jsp" >Έξοδος</a>
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
              <h5 class="card-title text-center">Αναλύσεις Διοίκησης</h5>
              <form class="form-signin">
                <div class="form-list">
                  <select name="Department" id="Department">
                    <option value="Τμήμα" selected hidden> Αναλύσεις </option>
                    <option value="Α1"> Σύγκριση προμήθειας πρακτορείων με την συνολική παραγωγή τους </option>
                    <option value="Α2"> Ανάλυση πρακτορείων με μειωμένη απόδοση </option>
                    <option value="Α3"> Κέρδη ανά πακέτο και σε ποσοστό </option>
                    <option value="Α4"> Κέρδη ανά ηλικιακή ομάδα και σε ποσοστό </option>
                    <option value="Α5"> Ανάλυση πακέτων ανά πράκτορα και σε ποσοστό </option>
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
