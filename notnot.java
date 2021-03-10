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
import static java.lang.System.out;

public class notnot{

    public static List<Contract> gain_per_contract() throws Exception{
        List<Damage> damages =  new ArrayList<Damage>();
        List<Contract> contracts2 =  new ArrayList<Contract>();
        final List<Contract> contracts =  new ArrayList<Contract>();
        final ContractDAO codao =new ContractDAO();
        final DamageDAO adao= new DamageDAO();

        damages= adao.getDamages();
        contracts2=codao.getContracts();
        int current_damage;
        boolean found;
        boolean found_in_contracts;
        for (final Contract con: contracts2){
            found = false;
            float amount = con.getAmount();
            found_in_contracts = false;
            final int current_id_contract = con.getId_contract();
            for (final Damage dm: damages){
                current_damage = dm.getId_contract();
                if (current_id_contract == current_damage){
                    //If it is the first damage of the contract
                    found = true;
                    final int place_in_list = 0;
                    final float amount2 = dm.getAmount();
                    amount = amount - amount2 ;

                }
            }
            final Contract ref = new Contract(con.getId_contract(),con.getPrevious_contract(),con.getAfm(),con.getId_agency(),
                        con.getVehicle_type(),con.getPlate(),con.getPackage(),con.getTransport(),con.getStarting_date(),
                        con.getDuration(),amount);
            contracts.add(ref);
        }
        return contracts;
    }
public static List<Customer> groupby_ages() throws Exception{

    final List<Customer> customers =  new ArrayList<Customer>();
    final DB db = new DB();
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    final String sqlQuery = "SELECT * FROM customers ORDER BY age;";
    try {

        con = db.getConnection();
        stmt = con.prepareStatement(sqlQuery);
        rs = stmt.executeQuery();

        if(!rs.next()) {
            return null;
        }
        while(rs.next()) {
            customers.add( new Customer(rs.getInt("afm"), rs.getInt("age"),rs.getString("namesurname"),rs.getString("sex"),rs.getString("county")));

        }
        rs.close();
        stmt.close();

        return customers;
    } catch (final Exception e) {
        throw new Exception(e.getMessage());
    } finally {

        try {
            db.close();
        } catch (final Exception e) {

        }

    }
}
public static String[][] gain_per_age(final String etos) throws Exception{

    List<Contract> contracts =  new ArrayList<Contract>();
    List<Customer> customer =  new ArrayList<Customer>();
    final List<Customer> finally_list =  new ArrayList<Customer>();

    customer = groupby_ages();
    contracts=gain_per_contract();
    String[][] results = new String[13][2];

    int current_afm;
    int current_age=customer.get(0).getAge();
    int count_years = 1;
    int count = 0;
    float sum =0;
    System.out.printf(etos, "etos");
    if(etos!="yes"){
        for (final Customer cm: customer){
            current_afm = cm.getAfm();
            for (final Contract con: contracts){
                if(current_afm == con.getAfm()){
                    if(count_years<=5){
                        if(current_age==cm.getAge()){
                            sum = sum +con.getAmount();
                        }
                        else{
                            sum = sum +con.getAmount();

                            current_age = cm.getAge();
                            //results[count][1]=""+sum;
                            count_years++;
                        }

                    }else{
                        String first ;
                        int current_age1;
                        if (count == 0){
                            final int first_age = customer.get(0).getAge();
                            first = ""+first_age ;
                            current_age1 = current_age -1;

                        }
                        else{
                            final int prev_current_age = current_age - 4;
                            first = ""+prev_current_age;
                            current_age1 = current_age;
                        }

                        results[count][0]=first + "- "+current_age1;
                        results[count][1]=""+sum;
                        //System.out.println(results[count][0]);
                        //System.out.println(results[count][1]);


                        sum = 0;
                        count++;
                        count_years = 1;
                    }

                }


            }
        }


    }else{
        results = new String[13][6];
        final int year0 = contracts.get(0).getStarting_date().getYear();
        final List<Integer> years =  new ArrayList<Integer>();
        years.add(year0);
        int yeari;
        for(int i=1; i< contracts.size(); i++){
                    if(contracts.get(i)==null){
                        break;
                    }
            yeari = contracts.get(i).getStarting_date().getYear();
            if(years.contains(yeari)){
                // nothing to see here
            }else{
                years.add(yeari);
            }
        }
       System.out.println(years);
       int counter4=0;
       for(final Integer y: years){
		counter4+=1;
        System.out.print("year");
        System.out.println(y);
        current_age=customer.get(0).getAge();
        count_years = 1;
        count = 0;
        sum =0;

        for (final Customer cm: customer){
            current_afm = cm.getAfm();
            for (final Contract con: contracts){
                if(con.getStarting_date().getYear()==y){
                    if(current_afm == con.getAfm()){
                        if(count_years<=5){
                            if(current_age==cm.getAge()){
                                sum = sum +con.getAmount();
                            }
                            else{
                                sum = sum +con.getAmount();

                                current_age = cm.getAge();
                                //results[count][1]=""+sum;
                                count_years++;
                            }

                        }else{

                            String first ;
                            int current_age1;
                            if (count == 0){
                            final int first_age = customer.get(0).getAge();
                            first = ""+first_age ;
                            current_age1 = current_age -1;

                            }
                            else{
                                final int prev_current_age = current_age - 4;
                                first = ""+prev_current_age;
                                current_age1 = current_age;
                            }


                            results[count][0]=first + "- "+current_age1;

			                if(y==118){
                                results[count][1]=""+sum;
                            }else if(y==117){
                                results[count][2]=""+sum;
                            }else if(y==116){
                                results[count][3]=""+sum;
                            }else if(y==120){
                                results[count][4]=""+sum;
                            }else if(y==119){
                                results[count][5]=""+sum;
                            }
                            sum = 0;
                            count++;
                            count_years = 1;
                        }

                    }
                }

            }
        }
       }

    }
    return results;
  }


public static float summarize_gain(final String[][] results) throws Exception{

    float total_sum = 0;

    for (int i=0;i<=results.length - 1;i++){
        if(results[i][0]==null){
            break;
        }
        else{
            final float sum = Float.parseFloat(results[i][1]);
            total_sum+= sum;
        }

    }

    return total_sum;
}

public static String[][] percentance(final float total_sum,final String[][] results,String etos) throws Exception{
    float[] percent=new float[6];
    float[] sum=new float[6];

     String[][] total_results = new String[results.length][2];
    if(etos.equals("yes")){
        total_results = new String[results.length][6];
    }
    for (int i=0;i<=results.length-1;i++){
        if(results[i][0]==null){
            break;
        }
        else{
            for(int no=1;no<results[i].length;no++){
              if(no==3){
				  total_results[i][3]=""+0;
                 sum[3] = 0;
                 percent[3]=0;
                String current_age = results[i][0];
                }else{
                sum[no] = Float.parseFloat(results[i][no]);
                String current_age = results[i][0];

               if(total_sum!=0){
                percent[no] = sum[no]/total_sum;



                total_results[i][0]=current_age;
                total_results[i][no]=""+percent[no];
             }
             }
            }
        }


    }
    return total_results;
}



}