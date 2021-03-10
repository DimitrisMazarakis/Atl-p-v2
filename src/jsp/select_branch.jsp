<!DOCTYPE html>
<html lang="en">

<head>
    <%@ include file="Header.jsp" %>
  <title>Επιλογή κλάδου</title>

</head>

<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="sidebar">
        <h4 style="color:white">Επιλογή κλάδου</h4>
    </div>
    <!-- /#sidebar-wrapper -->
    <div class="container">
      <div class="row">
        <div class="col-lg-10 col-xl-30 mx-auto" margin-top= "50%" >
          <div class="card card-signin flex-row my-5">
            <div class="card-body">
                <h1 class="text-center">Επιλέξτε κλάδο</h1><br><br><br>
                <div class="btn-group btn-group-justified" role="group" >
                    <div class="btn-group" role="group">
                      <button type="button" class="btn btn-default" onclick="window.location.href='Vehicles.jsp'">Κλαδο αυτοκινήτων</button>
                    </div>
                    <div class="btn-group" role="group">
                      <button type="button" class="btn btn-default" onclick="window.location.href='Accounting.jsp'">Κλάδο λογιστηρίου</button>
                    </div>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-default" onclick="window.location.href='Management.jsp'">Διοίκηση</button>
                      </div>
                  </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- /#page-content-wrapper -->
  </div>

</body>

</html>
