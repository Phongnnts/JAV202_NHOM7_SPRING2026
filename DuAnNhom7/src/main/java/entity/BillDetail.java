package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "BillDetails")  // Không có dấu gạch ngang
public class BillDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "quantity", nullable = false)
    private int quantity;

    @Column(name = "price", nullable = false)
    private int price;

    @ManyToOne
    @JoinColumn(name = "bill_id", nullable = false)
    private Bill bill;

    @ManyToOne
    @JoinColumn(name = "drink_id", nullable = false)
    private Drink drink;

    public BillDetail() {}

    // Getters & Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public Bill getBill() { return bill; }
    public void setBill(Bill bill) { this.bill = bill; }

    public Drink getDrink() { return drink; }
    public void setDrink(Drink drink) { this.drink = drink; }
}