/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import model.Brands;
import model.Categories;
import model.ProductVariants;
import model.Products;

/**
 *
 * @author PC
 */
@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/product"})
@MultipartConfig
public class AdminProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");

        if (view == null || view.equals("list")) {
            AdminProductDAO dao = new AdminProductDAO();

            String pageParam = request.getParameter("page");

            int page = 1;

            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);

                    if (page <= 0) {
                        page = 1;
                    }

                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            List<Products> list = dao.getProductsByPage(page);

            request.setAttribute("products", list);

            request.setAttribute("currentPage", page);

            request.setAttribute("totalPages", dao.getTotalPages());

            request.getRequestDispatcher("/WEB-INF/admin/product/list.jsp").forward(request, response);

        } else if (view.equals("create")) {

            AdminProductDAO dao = new AdminProductDAO();

            List<Categories> categories = dao.getCategories();

            List<Brands> brands = dao.getBrands();

            request.setAttribute("categories", categories);

            request.setAttribute("brands", brands);

            request.getRequestDispatcher("/WEB-INF/admin/product/create.jsp").forward(request, response);

        } else if (view.equals("edit")) {

            AdminProductDAO dao = new AdminProductDAO();

            int id = Integer.parseInt(request.getParameter("id"));

            Products product = dao.getProductById(id);

            List<Categories> categories = dao.getCategories();

            List<Brands> brands = dao.getBrands();

            request.setAttribute("product", product);

            request.setAttribute("categories", categories);

            request.setAttribute("brands", brands);

            request.getRequestDispatcher("/WEB-INF/admin/product/update.jsp").forward(request, response);

        } else if (view.equals("delete")) {

            int id = Integer.parseInt(request.getParameter("id"));

            AdminProductDAO dao = new AdminProductDAO();

            Products product = dao.getProductById(id);

            request.setAttribute("product", product);

            request.getRequestDispatcher("/WEB-INF/admin/product/delete.jsp").forward(request, response);

        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {

            AdminProductDAO dao = new AdminProductDAO();

            //==================== Product ====================
            Products product = new Products();

            product.setProductName(request.getParameter("productName"));

            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            product.setBrandId(Integer.parseInt(request.getParameter("brandId")));
            product.setDescription(request.getParameter("description"));
            product.setStatus(Integer.parseInt(request.getParameter("status")));

            // BaseSKU và Slug tự tạo
            String sku = request.getParameter("variantSKU");
            product.setBaseSKU(sku);

            String slug = request.getParameter("productName").trim().toLowerCase().replaceAll("\\s+", "-");

            product.setSlug(slug);

            //==================== Upload Image ====================
            Part part = request.getPart("productImage");

            String imageUrl = "";

            if (part != null && part.getSize() > 0) {

                String fileName = part.getSubmittedFileName();

                String uploadPath = getServletContext().getRealPath("/assets/images/products");

                File folder = new File(uploadPath);

                if (!folder.exists()) {
                    folder.mkdirs();
                }

                part.write(uploadPath + File.separator + fileName);

                imageUrl = fileName;
            }

            //==================== Variant ====================
            ProductVariants variant = new ProductVariants();

            variant.setVariantSKU(sku);
            variant.setPrice(Double.parseDouble(request.getParameter("price")));
            variant.setOriginalPrice(Double.parseDouble(request.getParameter("price")));
            variant.setVariantName(request.getParameter("productName"));
            variant.setImageUrl(imageUrl);
            if (product.getStatus() == 1) {
                variant.setStatus("Active");
            } else {
                variant.setStatus("Inactive");
            }

            String stock = request.getParameter("stock");

            if (stock == null || stock.isBlank()) {
                variant.setStock(0);
            } else {
                variant.setStock(Integer.parseInt(stock));
            }

            String discount = request.getParameter("discountPercent");

            if (discount == null || discount.isBlank()) {
                variant.setDiscountPercent(0);
            } else {
                variant.setDiscountPercent(Integer.parseInt(discount));
            }

            //==================== Save ====================
            int productId = dao.createProduct(product);

            if (productId > 0) {

                variant.setProductId(productId);

                dao.createVariant(variant);

                response.sendRedirect(request.getContextPath() + "/admin/product");

            } else {

                response.sendRedirect(request.getContextPath() + "/admin/product?view=create");

            }
        } else if ("update".equals(action)) {

            AdminProductDAO dao = new AdminProductDAO();

            Products product = new Products();

            product.setProductId(Integer.parseInt(request.getParameter("productId")));

            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));

            product.setBrandId(Integer.parseInt(request.getParameter("brandId")));

            product.setProductName(request.getParameter("productName"));

            product.setDescription(request.getParameter("description"));

            product.setStatus(Integer.parseInt(request.getParameter("status")));

            dao.updateProduct(product);

            String[] variantIds = request.getParameterValues("variantId");
            String[] skus = request.getParameterValues("variantSKU");
            String[] names = request.getParameterValues("variantName");
            String[] prices = request.getParameterValues("price");
            String[] originalPrices = request.getParameterValues("originalPrice");
            String[] discounts = request.getParameterValues("discountPercent");
            String[] stocks = request.getParameterValues("stock");
            String[] oldImageUrls = request.getParameterValues("oldImageUrl");
            String[] variantStatus = request.getParameterValues("variantStatus");

            List<Part> imageParts = (List<Part>) request.getParts()
                    .stream()
                    .filter(p -> "variantImage".equals(p.getName()))
                    .toList();

            if (variantIds != null) {

                for (int i = 0; i < variantIds.length; i++) {

                    ProductVariants variant = new ProductVariants();

                    variant.setVariantId(Integer.parseInt(variantIds[i]));
                    variant.setProductId(product.getProductId());

                    variant.setVariantSKU(skus[i]);
                    variant.setVariantName(names[i]);
                    variant.setOriginalPrice(Double.parseDouble(originalPrices[i]));
                    variant.setPrice(Double.parseDouble(prices[i]));
                    variant.setStock(Integer.parseInt(stocks[i]));
                    String imageUrl = "";

                    if (oldImageUrls != null && i < oldImageUrls.length) {
                        imageUrl = oldImageUrls[i];
                    }

                    if (imageParts.size() > i) {

                        Part part = imageParts.get(i);

                        if (part != null && part.getSize() > 0) {

                            String fileName = part.getSubmittedFileName();

                            String uploadPath = getServletContext()
                                    .getRealPath("/assets/images/products");

                            File folder = new File(uploadPath);

                            if (!folder.exists()) {
                                folder.mkdirs();
                            }

                            part.write(uploadPath + File.separator + fileName);

                            imageUrl = fileName;
                        }
                    }

                    variant.setImageUrl(imageUrl);
                    variant.setStatus(variantStatus[i]);

                    if (discounts[i] == null || discounts[i].isBlank()) {
                        variant.setDiscountPercent(0);
                    } else {
                        variant.setDiscountPercent(Integer.parseInt(discounts[i]));
                    }

                    dao.updateVariant(variant);
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/product");
        } else if ("delete".equals(action)) {

            AdminProductDAO dao = new AdminProductDAO();

            int productId = Integer.parseInt(request.getParameter("productId"));

            dao.deleteProduct(productId);

            response.sendRedirect(request.getContextPath() + "/admin/product");
        }

    }
}
