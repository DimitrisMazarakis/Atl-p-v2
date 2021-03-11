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

    public static float[][] kerdhanapaketopososto(List<Contract> contracts2,String etos) throws Exception{
		float[][] pinakaskerdwnanapaketo;
        Analysis an2 = new Analysis();
        List<Contract> contracts =  new ArrayList<Contract>();
        List<String> packages =  new ArrayList<String>();
        contracts = an2.gain_per_contract();
        String package0 = contracts.get(0).getPackage();
        packages.add(package0);
        String packagei;
        for(int i=1; i< contracts.size(); i++){
            packagei = contracts.get(i).getPackage();
            if(packages.contains(packagei)){
                // nothing to see here
            }else{
                packages.add(packagei);
            }
        }

        if(etos=="yes"){
            int year0 = contracts.get(0).getStarting_date().getYear();
            List<Integer> years =  new ArrayList<Integer>();
            years.add(year0);
            int yeari;
            for(int i=1; i< contracts.size(); i++){
                yeari = contracts.get(i).getStarting_date().getYear();
                if(years.contains(yeari)){
                    // nothing to see here
                }else{
                    years.add(yeari);
                }
            }
            float ammountperpackage;
            pinakaskerdwnanapaketo = new float[packages.size()][1];
            for(int k=1; k< years.size();k++){
                for(int h=1; h< contracts.size();h++){
                    if(contracts.get(h).getStarting_date().getYear()==(years.get(k))){
                        for(int j=1; j< packages.size(); j++){
                            ammountperpackage=0;
                            for(int m=1; m< contracts.size(); m++){
                                if(contracts.get(m).getPackage().equals(packages.get(j))){
                                    ammountperpackage+= contracts.get(m).getAmount();
                                }
                            }
                            pinakaskerdwnanapaketo[j][0]=ammountperpackage;
                        }
                    }
                    return pinakaskerdwnanapaketo;
                }
            }
        }else{
            float ammountperpackage;
            pinakaskerdwnanapaketo = new float[packages.size()][1];
            for(int j=0; j< packages.size(); j++){
                ammountperpackage=0;
                for(int k=1; k< contracts.size(); k++){
                    if(contracts.get(k).getPackage().equals(packages.get(j))){
                        ammountperpackage+= contracts.get(k).getAmount();
                    }
                }
                pinakaskerdwnanapaketo[j][0]=ammountperpackage;
            }

         }
         return pinakaskerdwnanapaketo;
     }



     public static float[][] kerdh_ana_paketo_pososto_diagrams() throws Exception{
		
        notnot analys2 = new notnot();
        List<Contract> contracts_second =  new ArrayList<Contract>();
        List<String> packages_second =  new ArrayList<String>();
        contracts_second = analys2.gain_per_contract();
        String package0 = contracts_second.get(0).getPackage();
        packages_second.add(package0);
        String packagei;
        for(int i=1; i< contracts_second.size(); i++){
            packagei = contracts_second.get(i).getPackage();
            if(packages_second.contains(packagei)){
                // nothing to see here
            }else{
                packages_second.add(packagei);
            }
        }
            int year0 = contracts_second.get(0).getStarting_date().getYear();
            List<Integer> years =  new ArrayList<Integer>();
            years.add(year0);
            int yeari;
            for(int i=1; i< contracts_second.size(); i++){
                yeari = contracts_second.get(i).getStarting_date().getYear();
                if(years.contains(yeari)){
                    // nothing to see here
                }else{
                    years.add(yeari);
                }
            }
            float[][] paketoanaetos = new float[5][3];
                        for(int u=0; u<=4; u++){
                            for(int v=0; v<=2;v++){
                                 paketoanaetos[u][v]=0;
                            }
                        }
                        for(int y=0; y< years.size(); y++){
                            
                                for(int x=0; x< contracts_second.size();x++){
                                    if(contracts_second.get(x).getPackage().equals("eco")){
                                        if(contracts_second.get(x).getStarting_date().getYear()==years.get(y)){
                                            paketoanaetos[y][0]+=contracts_second.get(x).getAmount();
                                        }
                                    }else if(contracts_second.get(x).getPackage().equals("max")){
                                        if(contracts_second.get(x).getStarting_date().getYear()==years.get(y)){
                                            paketoanaetos[y][1]+=contracts_second.get(x).getAmount();
                                        }
                                    }else if(contracts_second.get(x).getPackage().equals("basic")){
                                        if(contracts_second.get(x).getStarting_date().getYear()==years.get(y)){
                                            paketoanaetos[y][2]+=contracts_second.get(x).getAmount();
                                        }
                                    }
                                }
                            
                        }
                        return paketoanaetos;
            
        }
     

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
   public static String[][] gain_per_age(String etos) throws Exception{

        List<Contract> contracts =  new ArrayList<Contract>();
        List<Customer> customer =  new ArrayList<Customer>();
        List<Customer> finally_list =  new ArrayList<Customer>();

        customer = groupby_ages();
        contracts=gain_per_contract();
        String[][] results  = new String[67][2];

        int current_afm;
        int current_age=customer.get(0).getAge();
        int count = 0;
        boolean found = false;
        float sum =0;
        if(etos!="yes"){

            for (Customer cm: customer){
                if(current_age==cm.getAge()){
                    for (Contract con: contracts){
                        sum = sum +con.getAmount();
                    }
                }else{
                    found = true;
                    results[count][0]=""+current_age;
                    current_age = cm.getAge();
                    results[count][1]=""+sum;
                    count++;
                    sum=0;
                }
            }
	}else if(etos.equals("yes")){

		    int year0 = contracts.get(0).getStarting_date().getYear();
		    List<Integer> years =  new ArrayList<Integer>();
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
		   results = new String[67][5];

		   for(int y=1; y< years.size(); y++){

		       for (Customer cm: customer){
		           if(current_age==cm.getAge()){
		               for (Contract con: contracts){
		                   if(con.getStarting_date().getYear()==years.get(y)){
		                       sum = sum +con.getAmount();
		                   }
		               }
		           }else{
		               found = true;
		               results[count][0]=""+current_age;
		               current_age = cm.getAge();

		               if(y<5){

		                   results[count][y]=""+sum;
		               }
		               if(count<66){
		                   count++;
		               }
		               sum=0;
		           }
		       }

		   }
        }
        return results;
    }
    public static float summarize_gain(String[][] results,String etos) throws Exception{

        float total_sum = 0;

        for (int i=0;i<=results.length - 1;i++){
            if(results[i]==null){
                break;
            }
            else{
	        if(etos==null){
                    float sum = Float.parseFloat(results[i][1]);
                    total_sum+= sum;
                }else{
					float sum = Float.parseFloat(results[i][1]);
					float sum1 = Float.parseFloat(results[i][2]);
					float sum2 = Float.parseFloat(results[i][3]);
					float sum3 = Float.parseFloat(results[i][4]);
                    total_sum = total_sum +sum+sum1+sum2+sum3;
			    }
            }

        }

        return total_sum;
    }
    public static void main(String args[]){
        String etos ="yes";
        String[][] results  = new String[67][2];
        try {
            results = gain_per_age(etos);
            System.out.print(results);
        } catch (Exception e) {
            //TODO: handle exception
        }
    }
    public static String[][] percentance(float total_sum,String[][] results,String etos) throws Exception{

        float percent = 0;

        String[][] total_results = new String[results.length][2];
        for (int i=0;i<=results.length-1;i++){
            if(results[i]==null){
                break;
            }
            else{
				if(etos==null){
                    float sum1 = Float.parseFloat(results[i][1]);
                    String current_age = results[i][0];
                    if(total_sum!=0){
                        percent = sum1/total_sum;
                        total_results[i][0]=current_age;
                        total_results[i][1]=""+percent;
                    }
                }else{
					float sum1 = Float.parseFloat(results[i][1]);
					float sum2 = Float.parseFloat(results[i][2]);
					float sum3 = Float.parseFloat(results[i][3]);
					float sum4 = Float.parseFloat(results[i][4]);
					String current_age = results[i][0];
					if(total_sum!=0){
					    percent = sum1/total_sum;
					    total_results[i][0]=current_age;
                        total_results[i][1]=""+percent;
                        total_results[i][2]=""+sum2/total_sum;
                        total_results[i][3]=""+sum3/total_sum;
                        total_results[i][4]=""+sum4/total_sum;
				    }
			    }
	       }

        }
        return total_results;
    }

}