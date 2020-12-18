package team40;
import java.lang.Object;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.time.temporal.ChronoField;
import java.time.temporal.ChronoUnit;
import java.sql.*;


public class Analysis {

    /*min dwseis simasia
    public static void main(String[] args) throws Exception{//min dwseis sima
        
        AgencyDAO ag = new AgencyDAO();
        float t[][]= commissionComparison();
        for(int i=0; i<t.length; i++){
            System.out.println(ag.findName(t[i][0])+" "+ t[i][1]+" "+t[i][2]+" "+t[i][3]);
        }
        
        String s = ag.findName(t[0][0]);
        System.out.println(s);
        */
        //List<Agency> agencies =  new ArrayList<Agency>();
        /*
        float[][] con_by_agency = new float[30][7];
        con_by_agency=performanceAnalysis();
        
        for(int i=0;i<30;i++){
            for(int j=0;j<7;j++){
                System.out.println(con_by_agency[i][j]);
            }
        }
        
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
    con_by_agency4prpr = an4.compareWithLastYear(date_prpr1,date_prev1);


    //float[][] w_agency = new float[5][7];
    float[][] min_values4 =new float[5][5];
    for (int row = 0; row < min_values4.length; row++){
      for (int col = 0; col < min_values4[row].length; col++){
        min_values4[row][col] = 100000000.0f; //Whatever value you want to set them to
      }
    }
    /*for (float[] row: min_values)
        Arrays.fill(row, 0.0);
    /*for(int i = 0; i<5;i++){
      min_values[i]=0.0;
    }
    float k1;
    for(int i=0;i<30;i++){
        for(int j=0;j<4;j++){
            //System.out.println(con_by_agency4[i][j]+"con");
            System.out.println(con_by_agency4prpr[i][2]+"conprpr");
            //System.out.println(con_by_agency4prev[i][j]+"conprev");
        }
    }
    for(int i=0; i<30; i++){
        if (con_by_agency4prpr[i][2]!=0.0f){
      k1=(con_by_agency4[i][2] - con_by_agency4prpr[i][2])/con_by_agency4prpr[i][2];
      System.out.println(k1);

      for(int j=0;j<5;j++){
        if(k1<min_values4[j][1]){
            System.out.println("poutsaaaaaaaaaaaaaaaaaaa");

          min_values4[j][0]=con_by_agency4[i][0];
          min_values4[j][1]=k1;
          min_values4[j][2]=con_by_agency4prpr[i][2];
          min_values4[j][3]=con_by_agency4prev[i][2];
          min_values4[j][4]=con_by_agency4[i][2];
          break;
        } 
      }
    }
    } 
    
    for(int i=0;i<5;i++){
        for(int j=0;j<5;j++){
            System.out.println(min_values4[i][j]);
        }
    }
       
    }
*/

//1η Ανάλυση
    // 1η Ανάλυση xoris kapoio checkbox
    public static float[][] commissionComparison() throws Exception{
        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();

        agencies= adao.getAgencies();
        contracts=condao.getContracts();


        float[][] con_by_agency = new float[agencies.size()][4];
        int i=0;
        for(Agency ag: agencies){
            con_by_agency[i][0]=(float)ag.getId_agency();
            con_by_agency[i][1]=ag.getCommission();
            con_by_agency[i][2]=0.0f;
            for(Contract cond: contracts){
                if(cond.getId_agency()==con_by_agency[i][0]){
                    con_by_agency[i][2]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }
            }
            con_by_agency[i][3]=(con_by_agency[i][1]/con_by_agency[i][2])*10000;//upologizei to ratio
            i++;
        }
        return con_by_agency;
    }
 //1η Ανάλυση με κουbί ανα ετος
    public static float[][] commissionComparison_byYear() throws Exception{
        LocalDate myObj = LocalDate.now().minusDays(365); //wra (persi)
        Date date = Date.from(myObj.atStartOfDay(ZoneId.systemDefault()).toInstant());

        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();

        agencies= adao.getAgencies();
        contracts=condao.getContracts();

        float[][] con_by_agency = new float[agencies.size()][4];
        int i=0;
        for(Agency ag: agencies){
            con_by_agency[i][0]=(float)ag.getId_agency();
            con_by_agency[i][1]=ag.getCommission();
            for(Contract cond: contracts){
                if(cond.getId_agency()==con_by_agency[i][0] && cond.getStarting_date().after(date)){
                    con_by_agency[i][2]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }
            }
            con_by_agency[i][3]=(con_by_agency[i][1]/con_by_agency[i][2])*10000;//upologizei to ratio
            i++;
        }
        return con_by_agency;
    }
//1η sugkrisi me persi και 2η ανάλυση ανα ετος kai sugkrisi me persi  MiN ASXOLITHEIS
    public static float[][] compareWithLastYear(Date date, Date date_last) throws Exception{
        
        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();

        agencies= adao.getAgencies();
        contracts=condao.getContracts();


        float[][] con_by_agency = new float[agencies.size()][4];
        int i=0;
        for(Agency ag: agencies){
            con_by_agency[i][0]=(float)ag.getId_agency();
            con_by_agency[i][1]=ag.getCommission();
            for(Contract cond: contracts){
                if(cond.getId_agency()==con_by_agency[i][0] && cond.getStarting_date().after(date) && cond.getStarting_date().before(date_last)){
                    con_by_agency[i][2]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }
            }
            con_by_agency[i][3]=(con_by_agency[i][1]/con_by_agency[i][2])*10000;//upologizei to ratio
            i++;
        }
        return con_by_agency;
    }
// μην δωσεις σημασια σε αυτη τη μεθοδο
    public static void comparisonWithLast() throws Exception{//tha mpei sthn jsp ths accountingController

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

        float[][] con_by_agency = new float[agencies.size()][4];
        float[][] con_by_agency_prev = new float[agencies.size()][4];

        con_by_agency=compareWithLastYear(date,date_now);
        con_by_agency_prev=compareWithLastYear(date_prev,date);
    }
//2η Ανάλυση xoris kapoio koumpi
    public static float[][] performanceAnalysis(int duration) throws Exception{    //to date tha to pairnei apo tin jsp
        LocalDate date = LocalDate.now().minusMonths(6); //wra (persi)
        if(duration==1){
            date = date.minusMonths(12);
        }
        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();

        agencies= adao.getAgencies();
        contracts=condao.getContracts();

        float[][] con_by_agency = new float[agencies.size()][7];
        for(int k=0; k<agencies.size(); k++){
            for(int kj=0; kj<7; kj++){
                con_by_agency[k][kj]=0;
            }
        }
        int j=0;
        for(Agency ag: agencies){
            con_by_agency[j][0]=(float)ag.getId_agency();
            for(Contract cond: contracts){
                LocalDate datecon = cond.getStarting_date().toLocalDate();
                for(int i=0; i<6; i++){
                    if(ChronoUnit.MONTHS.between(datecon/*contract date*/, date.minusMonths(i)) == 0 && cond.getId_agency()==ag.getId_agency()){
                        con_by_agency[j][i+1]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                    }
                  }
            }
            j++;
        }
        return con_by_agency;
    }
    
  

    //to date tha to pairnei apo tin jsp
}