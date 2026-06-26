<%-- 
    Document   : list
    Created on : Jun 22, 2026, 12:15:10 PM
    Author     : HP
--%>

<%@page import="model.Products"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>

<%
    List<Products> list = (List<Products>) request.getAttribute("products");
%>

<div class="container mt-5">
    <div class="card shadow p-4">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Mirai's Store</h2>

            <a href="<%= request.getContextPath()%>/admin/product?view=create"
               class="btn btn-success">
                Add new product
            </a>
        </div>

        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Image</th>
                    <th>Product Name</th>
                    <th>SKU</th>
                    <th>Category</th>
                    <th>Brand</th>
                    <th>Views</th>
                    <th>Sold</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
                <%
                    for (Products p : list) {
                %>
                <tr>
                    <td>
                        <img src="<%= request.getContextPath()%>/assets/images/products/<%= p.getProductImg().getImageUrl()%>"
                             style="width:60px;height:60px;object-fit:cover;border-radius:8px;">
                    </td>

                    <td><%= p.getProductName()%></td>
                    <td><%= p.getBaseSKU()%></td>

                    <td><%= p.getCategory() != null ? p.getCategory().getCategoryName() : ""%></td>
                    <td><%= p.getBrand() != null ? p.getBrand().getBrandName() : ""%></td>

                    <td><%= p.getViews()%></td>
                    <td><%= p.getSold()%></td>

                    <%--
                    <td>
                        <% if (p.isFeatured() != null && p.isFeatured()) { %>
                        <span class="badge bg-warning text-dark">Yes</span>
                        <% } else { %>
                        <span class="badge bg-secondary">No</span>
                        <% } %>
                    </td>

                    <td>
                        <% if (p.isNew() != null && p.isNew()) { %>
                        <span class="badge bg-info">New</span>
                        <% } else { %>
                        <span class="badge bg-secondary">No</span>
                        <% } %>
                    </td>
                    --%>

                    <td>
                        <% if (p.getStatus() == 1) { %>
                        <span class="badge bg-success">Yes</span>
                        <% } else { %>
                        <span class="badge bg-secondary">No</span>
                        <% }%>
                    </td>

                    <%--
                    <td><%= p.getCreatedAt()%></td>
                    --%>

                    <td>
                        <a href="<%= request.getContextPath()%>/admin/product?view=edit&id=<%= p.getProductId()%>"
                           class="btn btn-primary btn-sm me-2">
                            Edit
                        </a>

                        <a href="<%= request.getContextPath()%>/admin/product?view=delete&id=<%= p.getProductId()%>"
                           class="btn btn-danger btn-sm">
                            Delete
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<%@include file="/WEB-INF/include/footer.jsp"%>