package model;

public class Account {
    private final String name;
    private final String email;
    private final String phone;

    public Account(String name, String email, String phone) {
        this.name = name;
        this.email = email;
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }
}
/*
Примечания
Для каждого объекта Account поля задаются
один раз и не меняются
private final String name;
 */