package dao;

import entity.Bill;

public class BillDAO extends BaseDAO<Bill> {

    public BillDAO() {
        super(Bill.class);
    }

    // Không cần viết lại CRUD vì đã có trong BaseDAO
}