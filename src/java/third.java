package team40;
import java.lang.Object;
import java.util.ArrayList;
import java.util.List;
//import sun.management.Agent;
import java.time.LocalDate;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.time.temporal.ChronoField;
import java.time.temporal.ChronoUnit;
import java.sql.*;

import java.math.RoundingMode;
import java.text.DecimalFormat;

public class third{
    public static String[][] packages_per_agency() throws Exception{
        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();
        agencies= adao.getAgencies();
        contracts=condao.getContracts();

        String[][] results = new String[10000][4];
        int counter = 0;

        for (Agency ag: agencies){

            int current_id_agency = ag.getId_agency();
            int sum1 = 0;
            int sum2 = 0;
            int sum3 = 0;
            for (Contract con: contracts){

                if(con.getId_agency()==current_id_agency){
                    String current_package = con.getPackage();
                    if(current_package.equals("eco")){
                        sum1++;
                    }else if(current_package.equals("basic")){
                        sum2++;
                    }else{
                        sum3++;
                    }
                }

            }
            results[counter][0] = ""+current_id_agency;
            results[counter][1] = ""+sum1;
            results[counter][2] = ""+sum2;
            results[counter][3] = ""+sum3;
            sum1 = 0;
            sum2 = 0;
            sum3 = 0;
            counter++;

        }
        return results;
    }
    public static String[][] summarize_counts(String[][] results) throws Exception{
        int total_sum;
        int sum1;
        int sum2;
        int sum3;
        DecimalFormat df = new DecimalFormat("0.00");
        String[][] res = new String[10000][4];

        for (int i=0;i<=results.length;i++){

            if(results[i][0]==null){
                break;
            }
            else{
                 sum1 = Integer.parseInt(results[i][1]);
                sum2 = Integer.parseInt(results[i][2]);
                sum3 = Integer.parseInt(results[i][3]);
                 total_sum = sum1 + sum2 + sum3;
                double current_amount1 =(double) sum1/total_sum;
                double current_amount2 = (double)sum2/total_sum;
                double current_amount3 = (double)sum3/total_sum;

                 res[i][0] = results[i][0];
                 res[i][1] = ""+df.format(current_amount1);
                 res[i][2] = ""+df.format(current_amount2);
                 res[i][3] = ""+df.format(current_amount3);

            }

        }

        return res;
    }

    public static String[][] percentance(String[][] results , String[][] res) throws Exception{


        //DecimalFormat df = new DecimalFormat("0.00");
        String[][] total_results = new String[res.length][4];
        for (int i=0;i<=res.length;i++){
            if(results[i][0]==null){
                break;
            }
            else{
                int total_sum = Integer.parseInt(results[i][1]);
                int sum1 = Integer.parseInt(res[i][1]);
                int sum2 = Integer.parseInt(res[i][2]);
                int sum3 = Integer.parseInt(res[i][3]);
                String current_id_agency = results[i][0];
                if(total_sum!=0){

                   float percent1 = sum1/total_sum;
                    float percent2 = 2/total_sum;
                   float percent3 = 3/total_sum;
                    total_results[i][0]=current_id_agency;
                    total_results[i][1]=""+percent1;
                    total_results[i][2]=""+percent2;
                    total_results[i][3]=""+percent3;
                }
            }


        }
        return total_results;
    }


}