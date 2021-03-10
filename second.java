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
public class second{

    public static List<Contract> gain_per_contract() throws Exception{
        List<Damage> damages =  new ArrayList<Damage>();
        List<Contract> contracts2 =  new ArrayList<Contract>();
        List<Contract> contracts =  new ArrayList<Contract>();
        ContractDAO codao =new ContractDAO();
        DamageDAO adao= new DamageDAO();

        damages= adao.getDamages();
        contracts2=codao.getContracts();
        int current_damage;
        boolean found;
        boolean found_in_contracts;
        for (Contract con: contracts2){
            found = false;
            found_in_contracts = false;
            int current_id_contract = con.getId_contract();
            for (Damage dm: damages){
                current_damage = dm.getId_contract();
                if (current_id_contract == current_damage){
                    //If it is the first damage of the contract
                    found = true;
                    int place_in_list = 0;
                    for (Contract cn :contracts){

                        if (cn.getId_contract()==con.getId_contract()){
                           float amount1 = contracts.get(place_in_list).getAmount();
                            float amount2 = dm.getAmount();
                            float amount = amount1 - amount2 ;
                            Contract ref = new Contract(con.getId_contract(),con.getPrevious_contract(),con.getAfm(),con.getId_agency(),
                                con.getVehicle_type(),con.getPlate(),con.getPackage(),con.getTransport(),con.getStarting_date(),
                                con.getDuration(),amount);
                            contracts.set(place_in_list,ref);
                            found_in_contracts = true;
                            break;
                        }
                        place_in_list++;
                    }
                    if (found_in_contracts==false){
                        float amount1 = con.getAmount();
                        float amount2 = dm.getAmount();
                        float amount = amount1 - amount2 ;

                        contracts.add( new Contract(con.getId_contract(),con.getPrevious_contract(),con.getAfm(),con.getId_agency(),
                            con.getVehicle_type(),con.getPlate(),con.getPackage(),con.getTransport(),con.getStarting_date(),
                            con.getDuration(),amount) );
                    }

                }
            }
            if (found==false){
                contracts.add(con);
            }
        }
        return contracts;
    }
public static List<Customer> groupby_ages() throws Exception{

    List<Customer> customers =  new ArrayList<Customer>();
    DB db = new DB();
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sqlQuery = "SELECT * FROM customers ORDER BY age;";
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
    } catch (Exception e) {
        throw new Exception(e.getMessage());
    } finally {

        try {
            db.close();
        } catch (Exception e) {

        }

    }
}
public static String[][] gain_per_age() throws Exception{

    List<Contract> contracts =  new ArrayList<Contract>();
    List<Customer> customer =  new ArrayList<Customer>();
    List<Customer> finally_list =  new ArrayList<Customer>();

    customer = groupby_ages();
    contracts=gain_per_contract();
    String[][] results = new String[customer.size()][2];

    int current_afm;
    int current_age=customer.get(0).getAge();
    int count_years = 1;
    int count = 0;
    float sum =0;
    for (Customer cm: customer){
        current_afm = cm.getAfm();
        for (Contract con: contracts){
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
                       int first_age = customer.get(0).getAge();
                       first = ""+first_age ;
                       current_age1 = current_age -1;

                    }
                    else{
                        int prev_current_age = current_age - 4;
                        first = ""+prev_current_age;
                        current_age1 = current_age;
                    }

                    results[count][0]=first + "- "+current_age1;
                    results[count][1]=""+sum;
                    sum = 0;
                    count++;
                    count_years = 1;
                }

            }


        }
    }

    return results;
}
public static float summarize_gain(String[][] results) throws Exception{

    float total_sum = 0;

    for (int i=0;i<=results.length - 1;i++){
        if(results[i][0]==null){
            break;
        }
        else{
            float sum = Float.parseFloat(results[i][1]);
            total_sum+= sum;
        }

    }

    return total_sum;
}

public static String[][] percentance(float total_sum,String[][] results) throws Exception{

    float percent = 0;

    String[][] total_results = new String[results.length][2];
    for (int i=0;i<=results.length-1;i++){
        if(results[i][0]==null){
            break;
        }
        else{
            float sum1 = Float.parseFloat(results[i][1]);
            String current_age = results[i][0];
            if(total_sum!=0){
                percent = sum1/total_sum;
                total_results[i][0]=current_age;
                total_results[i][1]=""+percent;
            }
        }


    }
    return total_results;
}
}