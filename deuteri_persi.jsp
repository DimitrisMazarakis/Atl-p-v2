<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packprages':['line']});
      google.charts.setOnLoadCallbackpr(drawChart);

    function drawChart() {
      <%
      float[][] con_by_agencyprlold = new float[30][7];
      AgencyDAO agprlold = new AgencyDAO();
      Analysis anprlold = new Analysis();
      con_by_agencyprlold = anprlold.performanceAnalysis(0);


      float[][] min_valuesprlold =new float[5][8];
      for (int row = 0; row < min_valuesprlold.length; row++){
        for (int col = 0; col < min_valuesprlold[row].length; col++)
        {
        min_valuesprlold[row][col] = 10000000.0f; //Whatever value you want to set them to
        }
      }
      float kprlold;
      for(int i=0; i<30; i++){
        kprlold=(con_by_agencyprlold[i][6] - con_by_agencyprlold[i][1])/con_by_agencyprlold[i][1];
        for(int j=0;j<5;j++){
        if(kprlold<min_valuesprlold[j][1]){
          min_valuesprlold[j][0]=con_by_agencyprlold[i][0];//id παρακτοριεου
          min_valuesprlold[j][1]=kprlold;//ποσοστό
          min_valuesprlold[j][2]=con_by_agencyprlold[i][1];//1ος μηνας
          min_valuesprlold[j][3]=con_by_agencyprlold[i][2];
          min_valuesprlold[j][4]=con_by_agencyprlold[i][3];
          min_valuesprlold[j][5]=con_by_agencyprlold[i][4];
          min_valuesprlold[j][6]=con_by_agencyprlold[i][5];
          min_valuesprlold[j][7]=con_by_agencyprlold[i][6];//6ο μηνας
          break;
        } 
        }
      } 
      %>
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Month');
      data.addColumn('number', '<%=agprlold.findName(min_valuesprlold[0][0])%>');
      data.addColumn('number', '<%=agprlold.findName(min_valuesprlold[1][0])%>');
      data.addColumn('number', '<%=agprlold.findName(min_valuesprlold[2][0])%>');
      data.addColumn('number', '<%=agprlold.findName(min_valuesprlold[3][0])%>');
      data.addColumn('number', '<%=agprlold.findName(min_valuesprlold[4][0])%>');
      data.addRows([

        [1, <%=min_valuesprlold[0][2]%>, <%=min_valuesprlold[1][2]%>, <%=min_valuesprlold[2][2]%>, <%=min_valuesprlold[3][2]%>, <%=min_valuesprlold[4][2]%>],
        [2, <%=min_valuesprlold[0][3]%>, <%=min_valuesprlold[1][3]%>, <%=min_valuesprlold[2][3]%>, <%=min_valuesprlold[3][3]%>, <%=min_valuesprlold[4][3]%>],
        [3, <%=min_valuesprlold[0][4]%>, <%=min_valuesprlold[1][4]%>, <%=min_valuesprlold[2][4]%>, <%=min_valuesprlold[3][4]%>, <%=min_valuesprlold[4][4]%>],
        [4, <%=min_valuesprlold[0][5]%>, <%=min_valuesprlold[1][5]%>, <%=min_valuesprlold[2][5]%>, <%=min_valuesprlold[3][5]%>, <%=min_valuesprlold[4][5]%>],
        [5, <%=min_valuesprlold[0][6]%>, <%=min_valuesprlold[1][6]%>, <%=min_valuesprlold[2][6]%>, <%=min_valuesprlold[3][6]%>, <%=min_valuesprlold[4][6]%>],
        [6, <%=min_valuesprlold[0][7]%>, <%=min_valuesprlold[1][7]%>, <%=min_valuesprlold[2][7]%>, <%=min_valuesprlold[3][7]%>, <%=min_valuesprlold[4][7]%>]

          
      ]);

      var options = {
        chart: {
          title: ' Ανάλυση πρακτορείων με μειωμένη απόδοση σε σχέση με πέρυσι ',
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

      var chart = new google.charts.Line(document.getElementById('2h_persi'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }
  </script>