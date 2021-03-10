<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <!-- Κέρδος ανά πακέτο -->
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawStuff);

   <%   
   Analysis an5 = new Analysis();
        List<Contract> contracts_first =  new ArrayList<Contract>();
        ContractDAO con4  = new ContractDAO();
        contracts_first = con4.getContracts();
        float package_profit[][]= an5.kerdhanapaketopososto(contracts_first,"no");
       %>
      function drawStuff() {
        var data = new google.visualization.arrayToDataTable([
          ['name', 'percentance'],
        ['eco',<%=package_profit[0][0]%>],
          ['max',<%=package_profit[1][0]%>],
          ['basic',<%=package_profit[2][0]%>]
       
        ]);

        var options = {
          width: 800,
          legend: { position: 'none' },
          chart: {
            title: ' Κέρδη ανά πακέτο και σε ποσοστό ',
            },
          axes: {
            x: {
              0: { side: 'bottom', label: 'Πακέτα'} // Bottom x-axis.
            }
          },
          bar: { groupWidth: "90%" }
        };

        var chart = new google.charts.Bar(document.getElementById('Car_prwti'));
        // Convert the Classic options to Material options.
        chart.draw(data, google.charts.Bar.convertOptions(options));
      };
    </script>
    <!-- Κέρδος ανά πακέτο ανά έτος-->
    <script type="text/javascript">
      google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);
      
    function drawChart() {
      <%  Analysis an_first = new Analysis();
      List<Contract> contracts_second =  new ArrayList<Contract>();
      ContractDAO con6  = new ContractDAO();
      contracts_second = con6.getContracts();
      float[][] pinakas_kerdwn_ana_paketo =  an_first.kerdh_ana_paketo_pososto_diagrams();
      %>
      var data = new google.visualization.DataTable();
        data.addColumn('number', 'Year');
        data.addColumn('number', 'Eco');
        data.addColumn('number', 'Max');
        data.addColumn('number', 'Basic');
      
      data.addRows([
       
        [20, <%=pinakas_kerdwn_ana_paketo[3][0]%>, <%=pinakas_kerdwn_ana_paketo[3][1]%>, <%=pinakas_kerdwn_ana_paketo[3][2]%>],
        [19,  <%=pinakas_kerdwn_ana_paketo[4][0]%>, <%=pinakas_kerdwn_ana_paketo[4][1]%>, <%=pinakas_kerdwn_ana_paketo[4][2]%>],
        [18,  <%=pinakas_kerdwn_ana_paketo[0][0]%>, <%=pinakas_kerdwn_ana_paketo[0][1]%>, <%=pinakas_kerdwn_ana_paketo[0][2]%>],
        [17,  <%=pinakas_kerdwn_ana_paketo[1][0]%>, <%=pinakas_kerdwn_ana_paketo[1][1]%>, <%=pinakas_kerdwn_ana_paketo[1][2]%>],
        [16, <%=pinakas_kerdwn_ana_paketo[2][0]%>, <%=pinakas_kerdwn_ana_paketo[2][1]%>, <%=pinakas_kerdwn_ana_paketo[2][2]%>]
        
          
      ]);
    
      var options = {
        chart: {
          title: ' Κέρδη ανά πακέτο και σε ποσοστό ανά έτος',
          subtitle: 'Φετινό έτος'
        },
        width: 900,
        height: 500,
        axes: {
          x: {
            0: {side: 'top'}
          }
        }
      };
    
      var chart = new google.charts.Line(document.getElementById('car_prwti_etos'));
    
      chart.draw(data, google.charts.Line.convertOptions(options));
    }
    </script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart', 'bar']});
        google.charts.setOnLoadCallback(drawStuff);
        <%List<Contract> contracts_p =  new ArrayList<Contract>();
            ContractDAO con_p  = new ContractDAO();
            contracts_p = con_p.getContracts();
            Analysis an_p = new Analysis();
            float t_p[][]= an_p.kerdh_ana_paketo_pososto_diagrams();
      
        %>
      
        function drawStuff() {
      
          var button = document.getElementById('change-chart');
          var chartDiv = document.getElementById('car_prwti_persi');
      
          var data = google.visualization.arrayToDataTable([
            ['Πακέτα', 'Φέτος', 'Πέρυσι'],
            
            ['eco', <%=t_p[3][0]%>, <%=t_p[4][0]%>],
            
            ['max', <%=t_p[3][1]%>, <%=t_p[4][1]%>],
            
            ['basic', <%=t_p[3][2]%>, <%=t_p[4][2]%>],
         
          ]);
      
          var materialOptions = {
            width: 900,
            chart: {
              title: 'Κέρδη ανά πακέτο και σε ποσοστό σε σχέση με πέρυσι',
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
            var materialChart = new google.charts.Bar(char_div);
            materialChart.draw(data, google.charts.Bar.convertOptions(materialOptions));
            button.innerText = 'Change to Classic';
            button.onclick = drawClassicChart;
          }
      
          function drawClassicChart() {
            var classicChart = new google.visualization.ColumnChart(char_div);
            classicChart.draw(data, classicOptions);
            button.innerText = 'Change to Material';
            button.onclick = drawMaterialChart;
          }
      
          drawMaterialChart();
      };
      </script>
    <!-- Κέρδος ανά ηλικιακή όμαδα -->
    <script type="text/javascript">
        google.charts.load('current', {'packages':['bar']});
        google.charts.setOnLoadCallback(drawStuff);

        <%   
        notnot not = new notnot();
        String gain_perage[][]= not.gain_per_age("no");
        int array_size = gain_perage.length;
        %>
        function drawStuff() {
        var data = new google.visualization.arrayToDataTable([
            ['age','percentance'],
        <%  for(int i=0;i<array_size;i++){%>
            ["<%=gain_perage[i][0]%>",<%=gain_perage[i][1]%>],
        <%  }%>
        ]);

        var options = {
            width: 800,
            legend: { position: 'none' },
            chart: {
            title: ' Κέρδη ανά ηλικιακή ομάδα και σε ποσοστό ',
            },
            axes: {
            x: {
                0: { side: 'bottom', label: 'Ηλικιακές ομάδες'} // Bottom x-axis.
            }
            },
            bar: { groupWidth: "90%" }
        };

        var chart = new google.charts.Bar(document.getElementById('car_deuteri'));
        // Convert the Classic options to Material options.
        chart.draw(data, google.charts.Bar.convertOptions(options));
        };
    </script>

    <!-- Κέρδος ανά ηλικιακή όμαδα ανά έτος -->
    <script type="text/javascript">
        google.charts.load('current', {'packages':['line']});
        google.charts.setOnLoadCallback(drawChart);
        
    function drawChart() {
        <%
        notnot not_etos = new notnot();
        String gain_etos[][]= not_etos.gain_per_age("yes");
        Float total_gainage[][] = new Float[13][5];
        for (int row = 0; row < total_gainage.length; row++){
            for (int col = 0; col < total_gainage[row].length; col++){
              total_gainage[row][col] = 0.0f; 
            }
        }
        for (int i=0;i< 13;i++){
            for(int j=0;j< 5;j++){
                if (gain_etos[i][j+1]!=null){
                
                  total_gainage[i][j] = Float.parseFloat(gain_etos[i][j+1]);
                }
            }
        }
        %>
        var data = new google.visualization.DataTable();
        data.addColumn('number', 'Year');
        data.addColumn('number', '<%=gain_etos[0][0]%>');
        data.addColumn('number', '<%=gain_etos[1][0]%>');
        data.addColumn('number', '<%=gain_etos[2][0]%>');
        data.addColumn('number', '<%=gain_etos[3][0]%>');
        data.addColumn('number', '<%=gain_etos[4][0]%>');
        data.addColumn('number', '<%=gain_etos[5][0]%>');
        data.addColumn('number', '<%=gain_etos[6][0]%>');
        data.addColumn('number', '<%=gain_etos[7][0]%>');
        data.addColumn('number', '<%=gain_etos[8][0]%>');
        data.addColumn('number', '<%=gain_etos[9][0]%>');
        data.addColumn('number', '<%=gain_etos[10][0]%>');
        data.addColumn('number', '<%=gain_etos[11][0]%>');
        data.addColumn('number', '<%=gain_etos[12][0]%>');
        
        data.addRows([
        
        [20, <%=total_gainage[0][3]%>, <%=total_gainage[1][3]%>, <%=total_gainage[2][3]%>, <%=total_gainage[3][3]%>, <%=total_gainage[4][3]%>, <%=total_gainage[5][3]%>, <%=total_gainage[6][3]%>, <%=total_gainage[7][3]%>, <%=total_gainage[8][3]%>, <%=total_gainage[9][3]%>, <%=total_gainage[10][3]%>, <%=total_gainage[11][3]%>, <%=total_gainage[12][3]%>],
        [19,  <%=total_gainage[0][4]%>, <%=total_gainage[1][4]%>, <%=total_gainage[2][4]%>, <%=total_gainage[3][4]%>, <%=total_gainage[4][4]%>, <%=total_gainage[5][4]%>, <%=total_gainage[6][4]%>, <%=total_gainage[7][4]%>, <%=total_gainage[8][4]%>, <%=total_gainage[9][4]%>, <%=total_gainage[10][4]%>, <%=total_gainage[11][4]%>, <%=total_gainage[12][4]%>],
        [18, <%=total_gainage[0][0]%>, <%=total_gainage[1][0]%>, <%=total_gainage[2][0]%>, <%=total_gainage[3][0]%>, <%=total_gainage[4][0]%>, <%=total_gainage[5][0]%>, <%=total_gainage[6][0]%>, <%=total_gainage[7][0]%>, <%=total_gainage[8][0]%>, <%=total_gainage[9][0]%>, <%=total_gainage[10][0]%>, <%=total_gainage[11][0]%>, <%=total_gainage[12][0]%>],
        [17, <%=total_gainage[0][1]%>, <%=total_gainage[1][1]%>, <%=total_gainage[2][1]%>, <%=total_gainage[3][1]%>, <%=total_gainage[4][1]%>, <%=total_gainage[5][1]%>, <%=total_gainage[6][1]%>, <%=total_gainage[7][1]%>, <%=total_gainage[8][1]%>, <%=total_gainage[9][1]%>, <%=total_gainage[10][1]%>, <%=total_gainage[11][1]%>, <%=total_gainage[12][1]%>],
        [16, <%=total_gainage[0][2]%>, <%=total_gainage[1][2]%>, <%=total_gainage[2][2]%>, <%=total_gainage[3][2]%>, <%=total_gainage[4][2]%>, <%=total_gainage[5][2]%>, <%=total_gainage[6][2]%>, <%=total_gainage[7][2]%>, <%=total_gainage[8][2]%>, <%=total_gainage[9][2]%>, <%=total_gainage[10][2]%>, <%=total_gainage[11][2]%>, <%=total_gainage[12][2]%>]

        
        ]);

        var options = {
        chart: {
            title: ' Κέρδη ανά ηλικιακή ομάδα και σε ποσοστό ανά έτος',
            subtitle: 'Φετινό έτος'
        },
        width: 900,
        height: 500,
        axes: {
            x: {
            0: {side: 'top'}
            }
        }
        };

        var chart = new google.charts.Line(document.getElementById('car_deuteri_etos'));

        chart.draw(data, google.charts.Line.convertOptions(options));
    }
    </script>

    <!-- Κέρδος ανά ηλικιακή όμαδα σύγκριση με πέρσι-->
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart', 'bar']});
        google.charts.setOnLoadCallback(drawStuff);
        <%

            
            notnot second_not = new notnot();
            String persi_age[][]= second_not.gain_per_age("yes");
            int len = persi_age.length;
    %>

    function drawStuff() {

    var button = document.getElementById('change-chart');
    var chartDiv = document.getElementById('car_deuteri_persi');

    var data = google.visualization.arrayToDataTable([
    ['Ηλικιακές Ομάδες', 'Φέτος', 'Πέρυσι'],
    <%  for(int i=0;i<len;i++){%>
    ["<%=persi_age[i][0]%>", <%=persi_age[i][4]%>, <%=persi_age[i][5]%>],
    <%  }%>
    ]);

    var materialOptions = {
    width: 900,
    chart: {
    title: 'Κέρδη ανά ηλικιακή ομάδα και σε ποσοστό σε σχέση με πέρυσι',
    subtitle: ''
    },
    series: {
    0: { axis: 'distance' }, // Bind series 0 to an axis named 'distance'.
    1: { axis: 'brightness' } // Bind series 1 to an axis named 'brightness'.
    },
    axes: {
    y: {
        distance: {label: 'percentance φέτος'}, // Left y-axis.
        brightness: {side: 'right', label: 'percentance πέρυσι'} // Right y-axis.
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
    0: {title: 'percentance φέτος'},
    1: {title: 'percentance πέρυσι'}
    }
    };

    function drawMaterialChart() {
    var materialChart = new google.charts.Bar(chart_div);
    materialChart.draw(data, google.charts.Bar.convertOptions(materialOptions));
    button.innerText = 'Change to Classic';
    button.onclick = drawClassicChart;
    }

    function drawClassicChart() {
    var classicChart = new google.visualization.ColumnChart(chart_div);
    classicChart.draw(data, classicOptions);
    button.innerText = 'Change to Material';
    button.onclick = drawMaterialChart;
    }

    drawMaterialChart();
    };
    </script>
