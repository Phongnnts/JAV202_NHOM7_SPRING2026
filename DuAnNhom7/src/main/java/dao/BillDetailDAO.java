package dao;

import entity.BillDetail;

public class BillDetailDAO extends BaseDAO<BillDetail> {

    public BillDetailDAO() {
        super(BillDetail.class);
    }

    // Không cần viết lại CRUD vì đã có trong BaseDAO
}