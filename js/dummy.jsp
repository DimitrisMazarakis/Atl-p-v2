<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team40.*"%>
<%@ page import="java.time.*"%>
<%@ page import="java.util.*"%>
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

        var chart = new google.charts.Bar(document.getElementById('top_x'));
        // Convert the Classic options to Material options.
        chart.draw(data, google.charts.Bar.convertOptions(options));
      };
    </script>
    <!-- Σύκριση ανά έτος -->
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
    <!-- Σύκριση με πέρυσι -->
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart', 'bar']});
      google.charts.setOnLoadCallback(drawStuff);
      <%
        LocalDate myObj = LocalDate.now().minusDays(365); //wra (persi)
        Date date = Date.from(myObj.atStartOfDay(ZoneId.systemDefault()).toInstant());
        LocalDate myObj_prev = LocalDate.now().minusDays(730); //wra (persi)
        Date date_prev = Date.from(myObj_prev.atStartOfDay(ZoneId.systemDefault()).toInstant());
        LocalDate myObj_now = LocalDate.now(); //wra (persi)
        Date date_now = Date.from(myObj_now.atStartOfDay(ZoneId.systemDefault()).toInstant());

        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();

        agencies= adao.getAgencies();
        contracts=condao.getContracts();

        float[][] con = new float[agencies.size()][4];
        float[][] con_prev = new float[agencies.size()][4];
        Analysis ann = new Analysis();
        con=ann.compareWithLastYear(date,date_now);
        con_prev=ann.compareWithLastYear(date_prev,date);
      %>

      function drawStuff() {

        var button = document.getElementById('change-chart');
        var chartDiv = document.getElementById('chart_div');

        var data = google.visualization.arrayToDataTable([
          ['Πρακτορεία', 'Φέτος', 'Πέρυσι'],
           <%  for(int i=0;i<l;i++){%>
          ["<%=ag.findName(con[i][0])%>", <%=con[i][3]%>, <%=con_prev[i][3]%>],
       <%  }%>
        ]);

        var materialOptions = {
          width: 900,
          chart: {
            title: 'Σύγκριση προμήθειας πρακτορείων με την συνολική παραγωγή τους σε σχέση με πέρυσι',
            subtitle: ''
          },
          series: {
            0: { axis: 'distance' }, // Bind series 0 to an axis named 'distance'.
            1: { axis: 'brightness' } // Bind series 1 to an axis named 'brightness'.
          },
          axes: {
            y: {
              distance: {label: 'ratio φέτος'}, // Left y-axis.
              brightness: {side: 'right', label: 'ratio πέρυσι'} // Right y-axis.
            }
          }
        };

        var classicOptions = {
          width: 900,
          series: {
            0: {targetAxisIndex: 0},
            1: {targetAxisIndex: 1}
          },
          title: 'Nearby galaxies - distance on the left, brightness on the right',
          vAxes: {
            // Adds titles to each axis.
            0: {title: 'ratio φέτος'},
            1: {title: 'ratio πέρυσι'}
          }
        };

        function drawMaterialChart() {
          var materialChart = new google.charts.Bar(chartDiv);
          materialChart.draw(data, google.charts.Bar.convertOptions(materialOptions));
          button.innerText = 'Change to Classic';
          button.onclick = drawClassicChart;
        }

        function drawClassicChart() {
          var classicChart = new google.visualization.ColumnChart(chartDiv);
          classicChart.draw(data, classicOptions);
          button.innerText = 'Change to Material';
          button.onclick = drawMaterialChart;
        }

        drawMaterialChart();
    };
    </script>
<!-- 2h -->
      <script type="text/javascript">
      google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      <%
      Analysis an3 = new Analysis();
      float[][] con_by_agency3 = new float[agencies.size()][7];
      con_by_agency3 = an3.performanceAnalysis();
      %>
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Day');
      data.addColumn('number', 'Guardians of the Galaxy');
      data.addColumn('number', 'The Avengers');
      data.addColumn('number', 'Transformers: Age of Extinction');
      <%
      float[][] w_agency = new float[5][7];
      for(int i=0; i<30; i++){
        (con_by_agency3[1][7] - con_by_agency3[1][1])/con_by_agency3[1][1]; 
      }
      %>
      data.addRows([
        [1,  37.8, 80.8, 41.8],
        [2, 3, 4, 5],
        [3, <%=con_by_agency3[1][1]%>, <%=con_by_agency3[1][2]%>, <%=con_by_agency3[1][3]%>]

          
      ]);

      var options = {
        chart: {
          title: 'Box Office Earnings in First Two Weeks of Opening',
          subtitle: 'in millions of dollars (USD)'
        },
        width: 900,
        height: 500,
        axes: {
          x: {
            0: {side: 'top'}
          }
        }
      };

      var chart = new google.charts.Line(document.getElementById('line_top_x'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }
  </script>

  </head>
  <body>
    <div id="top_x" style="width: 800px; height: 600px;"></div>
    <!-- Σύκριση ανά έτος -->
    <div id="top_x_div" style="width: 800px; height: 600px;"></div>
    <!-- Σύκριση με πέρυσι -->
    <div id="chart_div" style="width: 800px; height: 500px;"></div>
    <!-- 2h -->
    <div id="line_top_x"></div>

  </body>
</html>