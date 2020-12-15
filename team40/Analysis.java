package team40;

import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;



public class Analysis {
    public static void main(String[] args) throws Exception{
        AgencyDAO ag = new AgencyDAO();
        float t[][]= commissionComparison();
        for(int i=0; i<t.length; i++){
            System.out.println(ag.findName(t[i][0])+" "+ t[i][1]+" "+t[i][2]+" "+t[i][3]);
        }
        
        String s = ag.findName(t[0][0]);
        System.out.println(s);
    }


    
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
            con_by_agency[i][3]=con_by_agency[i][2]/(con_by_agency[i][1]*con_by_agency[i][2]);//upologizei to ratio
            i++;
        }
        return con_by_agency;
    }

    public static Float[][] commissionComparison_byYear() throws Exception{
        LocalDate myObj = LocalDate.now().minusDays(365); //wra (persi)
        Date date = Date.from(myObj.atStartOfDay(ZoneId.systemDefault()).toInstant());

        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();

        agencies= adao.getAgencies();
        contracts=condao.getContracts();

        Float[][] con_by_agency = new Float[agencies.size()][4];
        int i=0;
        for(Agency ag: agencies){
            con_by_agency[i][0]=(float)ag.getId_agency();
            con_by_agency[i][1]=ag.getCommission();
            for(Contract cond: contracts){
                if(cond.getId_agency()==con_by_agency[i][0] && cond.getStarting_date().after(date)){
                    con_by_agency[i][2]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }
            }
            con_by_agency[i][3]=con_by_agency[i][2]/(con_by_agency[i][1]*con_by_agency[i][2]);//upologizei to ratio
            i++;
        }
        return con_by_agency;
    }

    public static Float[][] compareWithLastYear(Date date, Date date_last) throws Exception{
        
        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();

        agencies= adao.getAgencies();
        contracts=condao.getContracts();


        Float[][] con_by_agency = new Float[agencies.size()][4];
        int i=0;
        for(Agency ag: agencies){
            con_by_agency[i][0]=(float)ag.getId_agency();
            con_by_agency[i][1]=ag.getCommission();
            for(Contract cond: contracts){
                if(cond.getId_agency()==con_by_agency[i][0] && cond.getStarting_date().after(date) && cond.getStarting_date().before(date_last)){
                    con_by_agency[i][2]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }
            }
            con_by_agency[i][3]=con_by_agency[i][2]/(con_by_agency[i][1]*con_by_agency[i][2]);//upologizei to ratio
            i++;
        }
        return con_by_agency;
    }

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

        Float[][] con_by_agency = new Float[agencies.size()][4];
        Float[][] con_by_agency_prev = new Float[agencies.size()][4];

        con_by_agency=compareWithLastYear(date,date_now);
        con_by_agency_prev=compareWithLastYear(date_prev,date);
    }

    public static Float[][] performanceAnalysis() throws Exception{    //to date tha to pairnei apo tin jsp
        LocalDate myObj = LocalDate.now().minusMonths(6); //wra (persi)
        Date date = Date.from(myObj.atStartOfDay(ZoneId.systemDefault()).toInstant());
        List<Agency> agencies =  new ArrayList<Agency>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO condao =new ContractDAO();
        AgencyDAO adao= new AgencyDAO();

        agencies= adao.getAgencies();
        contracts=condao.getContracts();

        Float[][] con_by_agency = new Float[agencies.size()][7];
        int i=0;
        int month=myObj.getMonthValue();
        for(Agency ag: agencies){
            con_by_agency[i][0]=(float)ag.getId_agency();
            for(Contract cond: contracts){
                
                if((cond.getStarting_date()).getMonth()==myObj.getMonthValue() && cond.getId_agency()==con_by_agency[i][0]){
                    con_by_agency[i][1]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }
                if((cond.getStarting_date()).getMonth()==myObj.plusMonths(1).getMonthValue() && cond.getId_agency()==con_by_agency[i][0]){
                    con_by_agency[i][2]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }else{
                    myObj.minusMonths(1);
                }
                if((cond.getStarting_date()).getMonth()==myObj.plusMonths(2).getMonthValue() && cond.getId_agency()==con_by_agency[i][0]){
                    con_by_agency[i][3]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }else{
                    myObj.minusMonths(2);
                }
                if((cond.getStarting_date()).getMonth()==myObj.plusMonths(3).getMonthValue() && cond.getId_agency()==con_by_agency[i][0]){
                    con_by_agency[i][4]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }else{
                    myObj.minusMonths(3);
                }
                if((cond.getStarting_date()).getMonth()==myObj.plusMonths(4).getMonthValue() && cond.getId_agency()==con_by_agency[i][0]){
                    con_by_agency[i][5]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }else{
                    myObj.minusMonths(4);
                }
                if((cond.getStarting_date()).getMonth()==myObj.plusMonths(5).getMonthValue() && cond.getId_agency()==con_by_agency[i][0]){
                    con_by_agency[i][6]+=cond.getAmount();//upologizei tin paragwgi kathe pratoreiou
                }else{
                    myObj.minusMonths(5);
                }
            }
            i++;
        }
        return con_by_agency;
    }
    
  

    //to date tha to pairnei apo tin jsp
}