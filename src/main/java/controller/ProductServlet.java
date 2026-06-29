package controller;

import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Products;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products", "/product/detail", "/product/search", "/product/filter"})
public class ProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO(); // Khởi tạo một lần dùng chung

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String path = request.getServletPath();

        switch (path) {
            case "/product/search":
                // =================================================================
                // TÌM KIẾM TỪ DATABASE THẬT
                // =================================================================
                String keyword = request.getParameter("keyword");
                if (keyword == null) keyword = "";
                keyword = keyword.trim();
                // Gọi dữ liệu thật từ DB
                List<Products> searchList = productDAO.searchProducts(keyword);
                request.setAttribute("keyword", keyword);
                request.setAttribute("searchList", searchList);
                request.getRequestDispatcher("/WEB-INF/Product/search.jsp").forward(request, response);
                break;
            case "/product/filter":
                // =================================================================
                // LỌC DỮ LIỆU TỪ DATABASE THẬT
                // =================================================================
                String brandIdParam = request.getParameter("brandId");
                String priceParam = request.getParameter("priceRange");
                // Gọi dữ liệu lọc thật từ DB
                List<Products> filterList = productDAO.filterProducts(brandIdParam, priceParam);
                request.setAttribute("selectedBrand", brandIdParam);
                request.setAttribute("selectedPrice", priceParam);
                request.setAttribute("filterList", filterList);
                request.getRequestDispatcher("/WEB-INF/Product/filter.jsp").forward(request, response);
                break;
            default:
                // =================================================================
                // TRANG CHI TIẾT + PHÂN TRANG DANH SÁCH THẬT
                // =================================================================
                String idParam = request.getParameter("id");
                int productId = 1; // ID mặc định nếu lỗi
                if (idParam != null && !idParam.isEmpty()) {
                    try {
                        productId = Integer.parseInt(idParam);
                    } catch (NumberFormatException e) {
                        productId = 1;
                    }
                }   // 1. Lấy chi tiết sản phẩm hiện tại từ DB
                Products currentProduct = productDAO.getProductById(productId);
                if (currentProduct == null) {
                    // Nếu không tìm thấy sản phẩm, lấy đại sản phẩm đầu tiên hoặc báo lỗi
                    List<Products> all = productDAO.getAllProducts();
                    if (!all.isEmpty()) currentProduct = all.get(0);
                }   request.setAttribute("product", currentProduct);
                // 2. Xử lý phân trang danh sách đi kèm dưới chân trang (Dữ liệu thật)
                String pageParam = request.getParameter("page");
                int currentPage = 1;
                if (pageParam != null && !pageParam.isEmpty()) {
                    try {
                        currentPage = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        currentPage = 1;
                    }
                }   List<Products> allProducts = productDAO.getAllProducts(); // Lấy tất cả từ DB công khai
                int productsPerPage = 4;
                int totalProducts = allProducts.size();
                int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
                int start = (currentPage - 1) * productsPerPage;
                int end = Math.min(start + productsPerPage, totalProducts);
                List<Products> productsForCurrentPage = new java.util.ArrayList<>();
                if (start < totalProducts) {
                    productsForCurrentPage = allProducts.subList(start, end);
                }   request.setAttribute("productList", productsForCurrentPage);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);
                request.getRequestDispatcher("/WEB-INF/Product/detail.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}