<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="murach.cart.Product, java.util.*" %>
<%
    // Catalog same as servlet; you can also forward catalog from servlet, 
    // but for simplicity we reconstruct same list here or you can call servlet.
    Map<String, Product> catalog = new LinkedHashMap<>();
    catalog.put("p1", new Product("p1", "86 (the band) - True Life Songs and Pictures", 14.95));
    catalog.put("p2", new Product("p2", "Paddlefoot - The first CD", 12.95));
    catalog.put("p3", new Product("p3", "Paddlefoot - The second CD", 14.95));
    catalog.put("p4", new Product("p4", "Joe Rut - Genuine Wood Grained Finish", 14.95));
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>The Index page</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    h1 { color: #0b63d0; }
    table { border-collapse: collapse; width: 780px; }
    th, td { border: 1px solid #444; padding: 8px; }
    th { background: #eee; }
    .price { text-align: right; width:120px; }
    .act { width:120px; text-align: center; }
  </style>
</head>
<body>
  <h1>The Index page</h1>

  <table>
    <tr>
      <th>Description</th>
      <th class="price">Price</th>
      <th class="act"></th>
    </tr>

    <% for (Product p : catalog.values()) { %>
    <tr>
      <td><%= p.getDescription() %></td>
      <td class="price">$<%= String.format("%.2f", p.getPrice()) %></td>
      <td class="act">
        <form action="<%=request.getContextPath()%>/cart" method="post" style="margin:0;">
          <input type="hidden" name="action" value="add">
          <input type="hidden" name="productId" value="<%= p.getId() %>">
          <input type="hidden" name="quantity" value="1">
          <input type="submit" value="Add To Cart">
        </form>
      </td>
    </tr>
    <% } %>

  </table>
</body>
</html>
