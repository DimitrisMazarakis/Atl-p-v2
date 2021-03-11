package team40;

public class Customer{

    private int afm;
    private int age;
    private String namesurname;
    private String sex;
    private String county;

    public Customer(int afm, int age, String namesurname, String sex, String county) {
        this.afm = afm;
        this.age = age;
        this.namesurname = namesurname;
        this.sex = sex;
        this.county = county;
    }

    public int getAfm() {
        return afm;
    }

    public int getAge() {
        return age;
    }

    public String getNamesurname() {
        return namesurname;
    }

    public String getSex() {
        return sex;
    }

    public String getCounty() {
        return county;
    }

}