package team40;
import java.sql.Date;

public class Contract{

    private int id_contract;
    private int previous_contract ;
    private int afm ;
    private int id_agency;
    private String vehicle_type;
    private String plate;
    private String packag;
    private String transport;
    private Date starting_date;
    private int duration;
    private float amount;

    public Contract(int id_contract, int previous_contract, int afm, int id_agency, String vehicle_type, String plate,
        String packag, String transport, Date starting_date, int duration, float amount) {
        this.id_contract = id_contract;
        this.previous_contract = previous_contract;
        this.afm = afm;
        this.id_agency = id_agency;
        this.vehicle_type = vehicle_type;
        this.plate = plate;
        this.packag = packag;
        this.transport = transport;
        this.starting_date = starting_date;
        this.duration = duration;
        this.amount = amount;
    }

    public int getId_contract() {
        return id_contract;
    }

    public int getPrevious_contract() {
        return previous_contract;
    }

    public int getAfm() {
        return afm;
    }

    public int getId_agency() {
        return id_agency;
    }

    public String getVehicle_type() {
        return vehicle_type;
    }


    public String getPlate() {
        return plate;
    }


    public String getPackage() {
        return packag;
    }

    public String getTransport() {
        return transport;
    }

    public Date getStarting_date() {
        return starting_date;
    }

    public int getDuration() {
        return duration;
    }

    public float getAmount() {
        return amount;
    }






}