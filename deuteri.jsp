<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['line']});
    google.charts.setOnLoadCallback(drawChart);

  function drawChart() {
    <%


    con_by_agency3 = an3.performanceAnalysis(0);

    //float[][] w_agency = new float[5][7];

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
      [6, <%=min_values[0][2]%>, <%=min_values[1][2]%>, <%=min_values[2][2]%>, <%=min_values[3][2]%>, <%=min_values[4][2]%>],
      [5, <%=min_values[0][3]%>, <%=min_values[1][3]%>, <%=min_values[2][3]%>, <%=min_values[3][3]%>, <%=min_values[4][3]%>],
      [4, <%=min_values[0][4]%>, <%=min_values[1][4]%>, <%=min_values[2][4]%>, <%=min_values[3][4]%>, <%=min_values[4][4]%>],
      [3, <%=min_values[0][5]%>, <%=min_values[1][5]%>, <%=min_values[2][5]%>, <%=min_values[3][5]%>, <%=min_values[4][5]%>],
      [2, <%=min_values[0][6]%>, <%=min_values[1][6]%>, <%=min_values[2][6]%>, <%=min_values[3][6]%>, <%=min_values[4][6]%>],
      [1, <%=min_values[0][7]%>, <%=min_values[1][7]%>, <%=min_values[2][7]%>, <%=min_values[3][7]%>, <%=min_values[4][7]%>]

        
    ]);

    var options = {
      chart: {
        title: ' Ανάλυση πρακτορείων με μειωμένη απόδοση ',
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

    var chart = new google.charts.Line(document.getElementById('line_to'));

    chart.draw(data, google.charts.Line.convertOptions(options));
  }
</script>