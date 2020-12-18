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
      float[][] con_by_agency3 = new float[30][7];
      con_by_agency3 = an3.performanceAnalysis(0);

      //float[][] w_agency = new float[5][7];
      float[][] min_values =new float[5][8];
      for (int row = 0; row < min_values.length; row++){
        for (int col = 0; col < min_values[row].length; col++)
        {
          min_values[row][col] = 10000000.0f; //Whatever value you want to set them to
    }
}
      /*for (float[] row: min_values)
          Arrays.fill(row, 0.0);
      /*for(int i = 0; i<5;i++){
        min_values[i]=0.0;
      }*/
      float k;
      for(int i=0; i<30; i++){
        k=(con_by_agency3[i][6] - con_by_agency3[i][1])/con_by_agency3[i][1];
        for(int j=0;j<5;j++){
          if(k<min_values[j][1]){
            min_values[j][0]=con_by_agency3[i][0];//id παρακτοριεου
            min_values[j][1]=k;//ποσοστό
            min_values[j][2]=con_by_agency3[i][1];//1ος μηνας
            min_values[j][3]=con_by_agency3[i][2];
            min_values[j][4]=con_by_agency3[i][3];
            min_values[j][5]=con_by_agency3[i][4];
            min_values[j][6]=con_by_agency3[i][5];
            min_values[j][7]=con_by_agency3[i][6];//6ο μηνας
            break;
          } 
        }
      } 
      %>
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Month');
      data.addColumn('number', '<%=ag.findName(min_values[0][0])%>');
      data.addColumn('number', '<%=ag.findName(min_values[1][0])%>');
      data.addColumn('number', '<%=ag.findName(min_values[2][0])%>');
      data.addColumn('number', '<%=ag.findName(min_values[3][0])%>');
      data.addColumn('number', '<%=ag.findName(min_values[4][0])%>');
      data.addRows([
       // [1,  37.8, 80.8, 41.8],
       // [2, 3, 4, 5],
       /*
        [3, <%=min_values[0][2]%>, <%=min_values[1][2]%>, <%=min_values[2][2]%>],
        [4, <%=min_values[0][3]%>, <%=min_values[1][3]%>, <%=min_values[2][3]%>],
        [5, <%=min_values[0][4]%>, <%=min_values[1][4]%>, <%=min_values[2][4]%>],
        [6, <%=min_values[0][5]%>, <%=min_values[1][5]%>, <%=min_values[2][5]%>],
        [7, <%=min_values[0][6]%>, <%=min_values[1][6]%>, <%=min_values[2][6]%>],
        [8, <%=min_values[0][7]%>, <%=min_values[1][7]%>, <%=min_values[2][7]%>]
        */
        [1, <%=min_values[0][2]%>, <%=min_values[1][2]%>, <%=min_values[2][2]%>, <%=min_values[3][2]%>, <%=min_values[4][2]%>],
        [2, <%=min_values[0][3]%>, <%=min_values[1][3]%>, <%=min_values[2][3]%>, <%=min_values[3][3]%>, <%=min_values[4][3]%>],
        [3, <%=min_values[0][4]%>, <%=min_values[1][4]%>, <%=min_values[2][4]%>, <%=min_values[3][4]%>, <%=min_values[4][4]%>],
        [4, <%=min_values[0][5]%>, <%=min_values[1][5]%>, <%=min_values[2][5]%>, <%=min_values[3][5]%>, <%=min_values[4][5]%>],
        [5, <%=min_values[0][6]%>, <%=min_values[1][6]%>, <%=min_values[2][6]%>, <%=min_values[3][6]%>, <%=min_values[4][6]%>],
        [6, <%=min_values[0][7]%>, <%=min_values[1][7]%>, <%=min_values[2][7]%>, <%=min_values[3][7]%>, <%=min_values[4][7]%>]

          
      ]);

      var options = {
        chart: {
          title: ' Ανάλυση πρακτορείων με μειωμένη απόδοση ',
          subtitle: 'in euro'
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
//sorry

  <script type="text/javascript">
    google.charts.load('current', {'packages':['line']});
    google.charts.setOnLoadCallback(drawChart);

  function drawChart() {
    <%        
    
    LocalDate myObj1 = LocalDate.now().minusDays(365); //wra (persi)
    Date date1 = Date.from(myObj1.atStartOfDay(ZoneId.systemDefault()).toInstant());
    LocalDate myObj_prev1 = LocalDate.now().minusDays(730); //wra (propersi)
    Date date_prev1 = Date.from(myObj_prev1.atStartOfDay(ZoneId.systemDefault()).toInstant());
    LocalDate myObj_now1 = LocalDate.now(); //wra (fetos)
    Date date_now1 = Date.from(myObj_now1.atStartOfDay(ZoneId.systemDefault()).toInstant());
    LocalDate myObj_prpr1 = LocalDate.now().minusDays(1095); //wra (propropersu)
    Date date_prpr1 = Date.from(myObj_now1.atStartOfDay(ZoneId.systemDefault()).toInstant());
    float[][] con_by_agency4 = new float[30][4];      
    float[][] con_by_agency4prev = new float[30][4];
    float[][] con_by_agency4prpr = new float[30][4];

    Analysis an4 = new Analysis();
    AgencyDAO ad4= new AgencyDAO();

    con_by_agency4 = an4.compareWithLastYear(date1,date_now1);
    con_by_agency4prev = an4.compareWithLastYear(date_prev1,date1);
    //con_by_agency4prpr = an4.compareWithLastYear(date_prpr1,date_prev1);


    //float[][] w_agency = new float[5][7];
    float[][] min_values4 =new float[5][4];
    for (int row = 0; row < min_values4.length; row++){
      for (int col = 0; col < min_values4[row].length; col++){
        min_values4[row][col] = 0.0f; //Whatever value you want to set them to
      }
    }
    /*for (float[] row: min_values)
        Arrays.fill(row, 0.0);
    /*for(int i = 0; i<5;i++){
      min_values[i]=0.0;
    }*/
    float k1;
    for(int i=0; i<30; i++){
      k1=(con_by_agency4[i][2] - con_by_agency4prev[i][2])/con_by_agency4prev[i][2];
      for(int j=0;j<5;j++){
        if(k1<min_values4[j][1]){
          min_values4[j][0]=con_by_agency4[i][0];//id παρακτοριεου
          min_values4[j][1]=k1;//ποσοστό
          min_values4[j][2]=con_by_agency4[i][2];//1os
          min_values4[j][3]=con_by_agency4prev[i][2];//2os xronos
          break;
        } 
      }
    } 
    %>
    var data1 = new google.visualization.DataTable();
    data1.addColumn('number', 'Year');
    data1.addColumn('number', '<%=ad4.findName(min_values4[0][0])%>');
    data1.addColumn('number', '<%=ad4.findName(min_values4[1][0])%>');
    data1.addColumn('number', '<%=ad4.findName(min_values4[2][0])%>');
    data1.addColumn('number', '<%=ad4.findName(min_values4[3][0])%>');
    data1.addColumn('number', '<%=ad4.findName(min_values4[4][0])%>');
    data1.addRows([
     // [1,  37.8, 80.8, 41.8],
     // [2, 3, 4, 5],
     /*
      [3, <%=min_values[0][2]%>, <%=min_values[1][2]%>, <%=min_values[2][2]%>],
      [4, <%=min_values[0][3]%>, <%=min_values[1][3]%>, <%=min_values[2][3]%>],
      [5, <%=min_values[0][4]%>, <%=min_values[1][4]%>, <%=min_values[2][4]%>],
      [6, <%=min_values[0][5]%>, <%=min_values[1][5]%>, <%=min_values[2][5]%>],
      [7, <%=min_values[0][6]%>, <%=min_values[1][6]%>, <%=min_values[2][6]%>],
      [8, <%=min_values[0][7]%>, <%=min_values[1][7]%>, <%=min_values[2][7]%>]
      */
      [1, <%=min_values4[0][2]%>, <%=min_values4[1][2]%>, <%=min_values4[2][2]%>, <%=min_values4[3][2]%>, <%=min_values4[4][2]%>],
      [2, <%=min_values4[0][3]%>, <%=min_values4[1][3]%>, <%=min_values4[2][3]%>, <%=min_values4[3][3]%>, <%=min_values4[4][3]%>]


        
    ]);

    var options = {
      chart: {
        title: ' Ανάλυση πρακτορείων με μειωμένη απόδοση ',
        subtitle: 'in euro'
      },
      width: 900,
      height: 500,
      axes: {
        x: {
          0: {side: 'top'}
        }
      }
    };

    var chart = new google.charts.Line(document.getElementById('2h_ana_etos'));

    chart.draw(data1, google.charts.Line.convertOptions(options));
  }
</script>

//persi

<script type="text/javascript">
  google.charts.load('current', {'packages':['line']});
  google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  <%
  Analysis anpr = new Analysis();
  float[][] con_by_agencypr = new float[30][7];
  con_by_agencypr = anpr.performanceAnalysis(1);

  //float[][] w_agency = new float[5][7];
  float[][] min_valuespr =new float[5][8];
  for (int row = 0; row < min_valuespr.length; row++){
    for (int col = 0; col < min_valuespr[row].length; col++)
    {
      min_valuespr[row][col] = 10000000.0f; //Whatever value you want to set them to
}
}
  /*for (float[] row: min_values)
      Arrays.fill(row, 0.0);
  /*for(int i = 0; i<5;i++){
    min_values[i]=0.0;
  }*/
  float kpr;
  for(int i=0; i<30; i++){
    kpr=(con_by_agencypr[i][6] - con_by_agencypr[i][1])/con_by_agencypr[i][1];
    for(int j=0;j<5;j++){
      if(kpr<min_valuespr[j][1]){
        min_valuespr[j][0]=con_by_agencypr[i][0];//id παρακτοριεου
        min_valuespr[j][1]=kpr;//ποσοστό
        min_valuespr[j][2]=con_by_agencypr[i][1];//1ος μηνας
        min_valuespr[j][3]=con_by_agencypr[i][2];
        min_valuespr[j][4]=con_by_agencypr[i][3];
        min_valuespr[j][5]=con_by_agencypr[i][4];
        min_valuespr[j][6]=con_by_agencypr[i][5];
        min_valuespr[j][7]=con_by_agencypr[i][6];//6ο μηνας
        break;
      } 
    }
  } 
  %>
  var data = new google.visualization.DataTable();
  data.addColumn('number', 'Month');
  data.addColumn('number', '<%=ag.findName(min_values[0][0])%>');
  data.addColumn('number', '<%=ag.findName(min_values[1][0])%>');
  data.addColumn('number', '<%=ag.findName(min_values[2][0])%>');
  data.addColumn('number', '<%=ag.findName(min_values[3][0])%>');
  data.addColumn('number', '<%=ag.findName(min_values[4][0])%>');
  data.addRows([
   // [1,  37.8, 80.8, 41.8],
   // [2, 3, 4, 5],
   /*
    [3, <%=min_values[0][2]%>, <%=min_values[1][2]%>, <%=min_values[2][2]%>],
    [4, <%=min_values[0][3]%>, <%=min_values[1][3]%>, <%=min_values[2][3]%>],
    [5, <%=min_values[0][4]%>, <%=min_values[1][4]%>, <%=min_values[2][4]%>],
    [6, <%=min_values[0][5]%>, <%=min_values[1][5]%>, <%=min_values[2][5]%>],
    [7, <%=min_values[0][6]%>, <%=min_values[1][6]%>, <%=min_values[2][6]%>],
    [8, <%=min_values[0][7]%>, <%=min_values[1][7]%>, <%=min_values[2][7]%>]
    */
    [1, <%=min_valuespr[0][2]%>, <%=min_valuespr[1][2]%>, <%=min_valuespr[2][2]%>, <%=min_valuespr[3][2]%>, <%=min_valuespr[4][2]%>],
    [2, <%=min_valuespr[0][3]%>, <%=min_valuespr[1][3]%>, <%=min_valuespr[2][3]%>, <%=min_valuespr[3][3]%>, <%=min_valuespr[4][3]%>],
    [3, <%=min_valuespr[0][4]%>, <%=min_valuespr[1][4]%>, <%=min_valuespr[2][4]%>, <%=min_valuespr[3][4]%>, <%=min_valuespr[4][4]%>],
    [4, <%=min_valuespr[0][5]%>, <%=min_valuespr[1][5]%>, <%=min_valuespr[2][5]%>, <%=min_valuespr[3][5]%>, <%=min_valuespr[4][5]%>],
    [5, <%=min_valuespr[0][6]%>, <%=min_valuespr[1][6]%>, <%=min_valuespr[2][6]%>, <%=min_valuespr[3][6]%>, <%=min_valuespr[4][6]%>],
    [6, <%=min_valuespr[0][7]%>, <%=min_valuespr[1][7]%>, <%=min_valuespr[2][7]%>, <%=min_valuespr[3][7]%>, <%=min_valuespr[4][7]%>]

      
  ]);

  var options = {
    chart: {
      title: ' Ανάλυση πρακτορείων με μειωμένη απόδοση ',
      subtitle: 'in euro'
    },
    width: 900,
    height: 500,
    axes: {
      x: {
        0: {side: 'top'}
      }
    }
  };

  var chart = new google.charts.Line(document.getElementById('persi'));

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
    <!-- 2h ana etos -->
    <div id="2h_ana_etos"></div>
    <!----persi---->
    <div id="persi"></div>

  </body>
</html>