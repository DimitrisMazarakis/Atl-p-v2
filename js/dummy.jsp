<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team40.*"%>
<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawStuff);

   <%   Analysis an = new Analysis();
        AgencyDAO ag = new AgencyDAO();
        float t[][]= an.commissionComparison();
    /*    Float[][] t = new Float[2][2];
        t[0][0]=8.0f;
        t[0][1]=8.0f;
        t[1][0]=3.0f;
        t[1][1]=4.0f;*/
        int l = t.length;
        float y = t[0][0];
        String s = ag.findName(y);
       %>
      function drawStuff() {
        var data = new google.visualization.arrayToDataTable([
          ['id', 'ratio'],
         // [<%=t[0][0]%>, <%=t[0][1]%>],
         // [<%=t[1][0]%>, <%=t[1][1]%>],
       <%  for(int i=0;i<l;i++){%>
          ["<%=ag.findName(t[i][0])%>", <%=t[i][3]%>],
       <%  }%>
        ]);

        var options = {
          width: 800,
          legend: { position: 'none' },
          chart: {
            title: ' Σύγκριση προμήθειας πρακτορείων με την συνολική παραγωγή τους ',
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
  </head>
  <body>
    <div id="top_x_div" style="width: 800px; height: 600px;"></div>
  </body>
</html>