package entity;

public class Drink {
    private int id;
    private String name;
    private int price;
    private String image;
    private String description;
    private boolean active;
    private int categoryId;

    public Drink() {}

    public Drink(int id, String name, int price, String image, String description, boolean active, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.description = description;
        this.active = active;
        this.categoryId = categoryId;
    }

    // getter setter
}