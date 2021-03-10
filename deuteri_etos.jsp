<%@ page language="java" pageEncoding="UTF-8"%>
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