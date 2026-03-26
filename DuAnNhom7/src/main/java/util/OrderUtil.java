package util;

import dao.BillDAO;
import dao.BillDetailDAO;
import entity.*;
import jakarta.servlet.http.HttpSession;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class OrderUtil {

    private static BillDAO billDAO = new BillDAO();
    private static BillDetailDAO billDetailDAO = new BillDetailDAO();

    public static Bill createOrder(HttpSession session, User user) {
        Map<Integer, CartUtil.CartItem> cart = CartUtil.getCart(session);

        if (cart == null || cart.isEmpty()) {
            return null;
        }

        // Tạo bill
        Bill bill = new Bill();
        bill.setUser(user);
        bill.setCreatedAt(new Date());

        // Tạo mã đơn hàng
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        bill.setCode("BILL" + sdf.format(new Date()));

        int total = 0;

        // Tính tổng tiền
        for (CartUtil.CartItem item : cart.values()) {
            total += item.getSubtotal();
        }
        bill.setTotal(total);

        // Lưu bill
        billDAO.create(bill);

        // Tạo bill details
        for (CartUtil.CartItem item : cart.values()) {
            BillDetail detail = new BillDetail();
            detail.setBill(bill);
            detail.setDrink(item.getDrink());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getDrink().getPrice());
            billDetailDAO.create(detail);
        }

        // Xóa giỏ hàng
        CartUtil.clearCart(session);

        return bill;
    }
}