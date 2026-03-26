package entity;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Bills")
public class Bill {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "code", length = 20, nullable = false, unique = true)
    private String code;

    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "total", nullable = false)
    private int total;

    @Column(name = "status", nullable = false)
    private String status;  // Dùng String thay vì BillStatus enum

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @OneToMany(mappedBy = "bill", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<BillDetail> billDetails;

    public Bill() {
        this.createdAt = new Date();
        this.status = "NEW";
    }

    // Getters & Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public List<BillDetail> getBillDetails() { return billDetails; }
    public void setBillDetails(List<BillDetail> billDetails) { this.billDetails = billDetails; }
}