package entity;

public class BillDetail {
    private int id;
    private int quantity;
    private int price;
    private int billId;
    private int drinkId;

    public BillDetail() {}

    public BillDetail(int id, int quantity, int price, int billId, int drinkId) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.billId = billId;
        this.drinkId = drinkId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getDrinkId() { return drinkId; }
    public void setDrinkId(int drinkId) { this.drinkId = drinkId; }
}
