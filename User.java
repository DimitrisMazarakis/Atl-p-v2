package team40;

public class User {

    private int id_user;
    private String username;
    private String password;
    private String dep;


    public User(int id_user, String username, String password, String dep) {
        this.id_user = id_user;
        this.username = username;
        this.password = password;
        this.dep = dep;
    }

    public int getId_user() {
        return id_user;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getDep() {
        return dep;
    }

}
