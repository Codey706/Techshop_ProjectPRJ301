package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author PC
 */
// 1. CẬP NHẬT URL PATTERNS ĐỂ NHẬN CẢ LỆNH SEARCH VÀ FILTER
@WebServlet(name = "ProductServlet", urlPatterns = {"/products", "/product/detail", "/product/search", "/product/filter"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy đường dẫn URL hiện tại để phân biệt hành động
        String path = request.getServletPath();

        if (path.equals("/product/search")) {
            // =================================================================
            // 2. XỬ LÝ CHỨC NĂNG TÌM KIẾM (/product/search)
            // =================================================================
            String keyword = request.getParameter("keyword");
            if (keyword == null) {
                keyword = "";
            }
            keyword = keyword.trim();

            List<model.Products> searchList = new java.util.ArrayList<>();
            if (!keyword.isEmpty()) {
                // Giả lập trả về 3 kết quả tương thích khi tìm kiếm
                for (int i = 1; i <= 3; i++) {
                    searchList.add(new model.Products(
                        i, 1, 1, "SKU-SE" + i, "Kết quả tìm cho: " + keyword + " dòng " + i, "slug-s" + i,
                        120, 5, true, false, false, 1, "Mô tả sản phẩm tìm kiếm", 1, null, null, null, null, null, null
                    ));
                }
            }

            request.setAttribute("keyword", keyword);
            request.setAttribute("searchList", searchList);
            request.getRequestDispatcher("/WEB-INF/Product/search.jsp").forward(request, response);

        } else if (path.equals("/product/filter")) {
            // =================================================================
            // 3. XỬ LÝ CHỨC NĂNG LỌC SẢN PHẨM (/product/filter)
            // =================================================================
            String brandIdParam = request.getParameter("brandId");
            String priceParam = request.getParameter("priceRange"); // ví dụ: under-15m, 15m-25m...

            List<model.Products> filterList = new java.util.ArrayList<>();
            
            // Giả lập sinh ra 4 sản phẩm theo bộ lọc đã chọn
            for (int i = 1; i <= 4; i++) {
                filterList.add(new model.Products(
                    i, 1, 1, "SKU-FL" + i, "Sản phẩm lọc theo tiêu chí " + i, "slug-f" + i,
                    80, 2, false, true, false, 1, "Mô tả sản phẩm lọc", 1, null, null, null, null, null, null
                ));
            }

            request.setAttribute("selectedBrand", brandIdParam);
            request.setAttribute("selectedPrice", priceParam);
            request.setAttribute("filterList", filterList);
            request.getRequestDispatcher("/WEB-INF/Product/filter.jsp").forward(request, response);

        } else {
            // =================================================================
            // 4. XỬ LÝ TRANG CHI TIẾT + DANH SÁCH ĐI KÈM MẶC ĐỊNH (/product/detail hoặc /products)
            // =================================================================
            String idParam = request.getParameter("id");
            int productId = 1;
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    productId = Integer.parseInt(idParam);
                } catch (NumberFormatException e) {
                    productId = 1;
                }
            }

            model.Products currentProduct = new model.Products(
                    productId, 1, 1, "SKU-" + productId,
                    "Laptop Gaming Chiến Thần Số " + productId, "slug-" + productId,
                    999, 45, true, true, false, 1,
                    "- CPU: Core Ultra 7 siêu mạnh mẽ\n- RAM: 16GB LPDDR5X\n- Ổ cứng: 512GB SSD NVMe\n- Card đồ họa: RTX 4060 cực mượt",
                    1, null, null, null, null, null, null
            );
            request.setAttribute("product", currentProduct);

            // Xử lý phân trang danh sách đi kèm ở phía dưới
            String pageParam = request.getParameter("page");
            int currentPage = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            List<model.Products> allProducts = new java.util.ArrayList<>();
            for (int i = 1; i <= 8; i++) {
                allProducts.add(new model.Products(i, 1, 1, "SKU-" + i, "Sản phẩm Laptop mẫu số " + i, "slug-" + i, 100, 10, true, true, false, 1, "Mô tả", 1, null, null, null, null, null, null));
            }

            int productsPerPage = 4; 
            int totalProducts = allProducts.size();
            int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
            int start = (currentPage - 1) * productsPerPage;
            int end = Math.min(start + productsPerPage, totalProducts);

            List<model.Products> productsForCurrentPage = new java.util.ArrayList<>();
            if (start < totalProducts) {
                productsForCurrentPage = allProducts.subList(start, end);
            }

            request.setAttribute("productList", productsForCurrentPage);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/WEB-INF/Product/detail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
    }
}