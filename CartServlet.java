package murach.cart;

import java.io.IOException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // Simple in-memory product catalog
    private static final Map<String, Product> catalog = new LinkedHashMap<>();
    static {
        catalog.put("p1", new Product("p1", "86 (the band) - True Life Songs and Pictures", 14.95));
        catalog.put("p2", new Product("p2", "Paddlefoot - The first CD", 12.95));
        catalog.put("p3", new Product("p3", "Paddlefoot - The second CD", 14.95));
        catalog.put("p4", new Product("p4", "Joe Rut - Genuine Wood Grained Finish", 14.95));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Simply forward to cart view
        request.setAttribute("catalog", catalog.values());
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // action: add / update / remove
        String action = request.getParameter("action");
        if (action == null) action = "view";

        HttpSession session = request.getSession(true);
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action)) {
            String productId = request.getParameter("productId");
            String qtyStr = request.getParameter("quantity");
            int qty = 1;
            try { qty = Integer.parseInt(qtyStr); } catch (Exception e) {}
            Product p = catalog.get(productId);
            if (p != null) cart.addItem(p, qty);
        } else if ("update".equals(action)) {
            String productId = request.getParameter("productId");
            String qtyStr = request.getParameter("quantity");
            int qty = 1;
            try { qty = Integer.parseInt(qtyStr); } catch (Exception e) {}
            cart.updateItem(productId, qty);
        } else if ("remove".equals(action)) {
            String productId = request.getParameter("productId");
            cart.removeItem(productId);
        }

        // update cookie with cart size (optional demo for cookies)
        int cartSize = cart.getSize();
        Cookie c = new Cookie("cartSize", Integer.toString(cartSize));
        c.setMaxAge(60*60*24); // 1 day
        response.addCookie(c);

        // After change, forward to cart page showing current cart
        request.setAttribute("catalog", catalog.values());
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}
