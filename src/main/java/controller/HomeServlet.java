package controller;

import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import model.Products;
import model.Categories;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    // Khởi tạo một lần dùng chung để tiết kiệm tài nguyên
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Logic lấy Sản phẩm bán chạy
        List<Products> bestSellers = productDAO.getBestSellers();
        request.setAttribute("bestSellers", bestSellers);

        // 2. Logic xử lý "Gợi ý cho bạn"
        List<Categories> categoryList = productDAO.getSuggestionCategories();

        // Tạo Map chứa danh sách sản phẩm theo từng CategoryId
        Map<Integer, List<Products>> productsMap = new HashMap<>();

        if (categoryList != null) {
            for (Categories cat : categoryList) {
                List<Products> productsByCat = productDAO.getProductsByCategoryId(cat.getCategoryId());
                productsMap.put(cat.getCategoryId(), productsByCat);
            }
        }

        // Đẩy dữ liệu sang file JSP
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("productsMap", productsMap);

        // Chuyển hướng tới trang home.jsp
        request.getRequestDispatcher("/WEB-INF/Home/home.jsp").forward(request, response);

        ProductDAO productDAO = new ProductDAO();

        List<Products> featuredProducts = productDAO.getFeaturedProducts();

        request.setAttribute("featuredProducts", featuredProducts);

        request.getRequestDispatcher("/WEB-INF/Home/home.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý các logic dạng POST tại trang chủ (nếu có)
    }
}
