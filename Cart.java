package murach.cart;

import java.util.*;

public class Cart {
    // map productId -> CartItem
    private Map<String, CartItem> items = new LinkedHashMap<>();

    public void addItem(Product product, int qty) {
        CartItem item = items.get(product.getId());
        if (item == null) {
            items.put(product.getId(), new CartItem(product, qty));
        } else {
            item.setQuantity(item.getQuantity() + qty);
        }
    }

    public void updateItem(String productId, int qty) {
        CartItem item = items.get(productId);
        if (item != null) {
            if (qty <= 0) items.remove(productId);
            else item.setQuantity(qty);
        }
    }

    public void removeItem(String productId) {
        items.remove(productId);
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

    public int getSize() {
        int size = 0;
        for (CartItem ci : items.values()) size += ci.getQuantity();
        return size;
    }

    public double getTotal() {
        double total = 0;
        for (CartItem ci : items.values()) total += ci.getAmount();
        return total;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}
