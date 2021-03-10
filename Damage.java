package team40;

import java.sql.Date;

public class Damage {

    private String id_damage;
    private int id_contract;
    private Float amount;
    private Date damage_date;

    public Damage(String id_damage, int id_contract, Float amount, Date damage_date) {
        this.id_damage = id_damage;
        this.id_contract = id_contract;
        this.amount = amount;
        this.damage_date = damage_date;
    }

    public String getId_damage() {
        return id_damage;
    }

    public int getId_contract() {
        return id_contract;
    }


    public Float getAmount() {
        return amount;
    }


    public Date getDamage_date() {
        return damage_date;
    }


}
