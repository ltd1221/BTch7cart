<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="murach.cart.Cart, murach.cart.CartItem, java.util.*" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) cart = new Cart();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>The Cart page</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    h1 { color: #0b63d0; }
    table { border-collapse: collapse; width: 820px; }
    th, td { border: 1px solid #444; padding: 8px; }
    th { background: #eee; text-align: left; }
    .qty { width:80px; }
    .price { width:90px; text-align:right; }
    .amt { width:100px; text-align:right; }
    .act { width:140px; text-align:center; }
    .note { margin-top:12px; font-size:0.95em; color:#333; }
    .btn { padding:6px 10px; margin:2px; }
    input[type=number] {
        border: 1px solid #999;
    }

    .btn {
        background: #f5f5f5;
        border: 1px solid #555;
        cursor: pointer;
    }
  </style>
</head>
<body>
  <h1>The Cart page</h1>

  <h3>Your cart</h3>

  <table>
    <tr>
      <th class="qty">Quantity</th>
      <th>Description</th>
      <th class="price">Price</th>
      <th class="amt">Amount</th>
      <th class="act"></th>
    </tr>

    <% for (CartItem item : cart.getItems()) { %>
    <tr>
      <td>
        <form action="<%=request.getContextPath()%>/cart" method="post"
      style="display:flex; align-items:center; gap:6px; margin:0;">

    <input type="hidden" name="action" value="update">
    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">

    <input type="number" name="quantity"
           value="<%= item.getQuantity() %>"
           min="0"
           style="width:50px; height:28px;">

    <input class="btn" type="submit" value="Update"
           style="height:28px; padding:0 10px;">
        </form>
      </td>
      <td><%= item.getProduct().getDescription() %></td>
      <td class="price">$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
      <td class="amt">$<%= String.format("%.2f", item.getAmount()) %></td>
      <td class="act">
          <form action="<%=request.getContextPath()%>/cart" method="post" style="display:inline;">
            <input type="hidden" name="action" value="remove">
            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
            <input class="btn" type="submit" value="Remove Item">
          </form>
      </td>
    </tr>
    <% } %>

    <tr>
      <td colspan="3" style="text-align:right; font-weight:bold;">Total:</td>
      <td class="amt">$<%= String.format("%.2f", cart.getTotal()) %></td>
      <td></td>
    </tr>
  </table>

  <p class="note">To change the quantity, enter the new quantity and click on the Update button.</p>

  <form action="index.jsp" method="get" style="display:inline;">
    <input class="btn" type="submit" value="Continue Shopping">
  </form>

  <form action="checkout.jsp" method="get" style="display:inline; margin-left:8px;">
    <input class="btn" type="submit" value="Checkout">
  </form>

</body>
</html>
