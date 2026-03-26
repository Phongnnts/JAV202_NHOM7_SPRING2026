package util;

import entity.Drink;
import jakarta.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;

public class CartUtil {

    private static final String CART_KEY = "cart";

    public static class CartItem {
        private Drink drink;
        private int quantity;

        public CartItem(Drink drink, int quantity) {
            this.drink = drink;
            this.quantity = quantity;
        }

        public Drink getDrink() { return drink; }
        public void setDrink(Drink drink) { this.drink = drink; }

        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }

        public int getSubtotal() {
            return drink.getPrice() * quantity;
        }
    }

    @SuppressWarnings("unchecked")
    public static Map<Integer, CartItem> getCart(HttpSession session) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute(CART_KEY);
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute(CART_KEY, cart);
        }
        return cart;
    }

    public static void addToCart(HttpSession session, Drink drink, int quantity) {
        Map<Integer, CartItem> cart = getCart(session);
        CartItem item = cart.get(drink.getId());

        if (item == null) {
            cart.put(drink.getId(), new CartItem(drink, quantity));
        } else {
            item.setQuantity(item.getQuantity() + quantity);
        }
        session.setAttribute(CART_KEY, cart);
    }

    public static void updateCart(HttpSession session, int drinkId, int quantity) {
        Map<Integer, CartItem> cart = getCart(session);
        if (quantity <= 0) {
            cart.remove(drinkId);
        } else {
            CartItem item = cart.get(drinkId);
            if (item != null) {
                item.setQuantity(quantity);
            }
        }
        session.setAttribute(CART_KEY, cart);
    }

    public static void removeFromCart(HttpSession session, int drinkId) {
        Map<Integer, CartItem> cart = getCart(session);
        cart.remove(drinkId);
        session.setAttribute(CART_KEY, cart);
    }

    public static void clearCart(HttpSession session) {
        session.removeAttribute(CART_KEY);
    }

    public static int getTotal(Map<Integer, CartItem> cart) {
        int total = 0;
        for (CartItem item : cart.values()) {
            total += item.getSubtotal();
        }
        return total;
    }
}