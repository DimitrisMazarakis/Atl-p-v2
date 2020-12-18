<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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