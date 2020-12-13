package team40;

public class Agency {
   
    private int id_agency;
    private String agency_name;
    private String type_of_agency;     
    private float commission;

    /**
     * Constructor
     * 
     * @param id_agency
     * @param agency_name
     * @param type_of_agency
     * @param commission
     */

    public Agency(int id_agency, String agency_name, String type_of_agency, float commission) {
        this.id_agency = id_agency;
        this.agency_name = agency_name;
        this.type_of_agency = type_of_agency;
        this.commission = commission;
    }

    public int getId_agency() {
        return id_agency;
    }

    public String getAgency_name() {
        return agency_name;
    }

    public String getType_of_agency() {
        return type_of_agency;
    }

    public float getCommission() {
        return commission;
    }
    

}