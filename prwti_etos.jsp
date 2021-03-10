<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawStuff);

 <%   Analysis an2 = new Analysis();
      AgencyDAO ag2 = new AgencyDAO();
      float t2[][]= an2.commissionComparison_byYear();
      int l2 = t2.length;
     %>
    function drawStuff() {
      var data = new google.visualization.arrayToDataTable([
        ['id', 'ratio'],
     <%  for(int i=0;i<l2;i++){%>
        ["<%=ag2.findName(t2[i][0])%>", <%=t2[i][3]%>],
     <%  }%>
      ]);

      var options = {
        width: 800,
        legend: { position: 'none' },
        chart: {
          title: ' Σύγκριση προμήθειας πρακτορείων με την συνολική παραγωγή τους ανά έτος ',
          },
        axes: {
          x: {
            0: { side: 'bottom', label: 'Πρακτορεία'} // Bottom x-axis.
          }
        },
        bar: { groupWidth: "90%" }
      };

      var chart = new google.charts.Bar(document.getElementById('top_x_div'));
      // Convert the Classic options to Material options.
      chart.draw(data, google.charts.Bar.convertOptions(options));
    };
  </script>