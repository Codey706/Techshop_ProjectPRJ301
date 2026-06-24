package model;

/**
 * 
 * @author Huynh Nhu Y
 */
public class Dashboard {

    // =========================================================================
    // 1. MODEL CHO TRANG TỔNG DOANH THU (Revenue)
    // =========================================================================
    public static class Revenue {

        private int month;
        private int totalOrders;
        private double revenue;

        public Revenue() {
        }

        public Revenue(int month, int totalOrders, double revenue) {
            this.month = month;
            this.totalOrders = totalOrders;
            this.revenue = revenue;
        }

        public int getMonth() {
            return month;
        }

        public void setMonth(int month) {
            this.month = month;
        }

        public int getTotalOrders() {
            return totalOrders;
        }

        public void setTotalOrders(int totalOrders) {
            this.totalOrders = totalOrders;
        }

        public double getRevenue() {
            return revenue;
        }

        public void setRevenue(double revenue) {
            this.revenue = revenue;
        }
    }

    // =========================================================================
    // 2. MODEL CHO TRANG SẢN PHẨM BÁN CHẠY (TopProduct)
    // =========================================================================
    public static class TopProduct {

        private String productName;
        private String baseSku;
        private int sold;

        public TopProduct() {
        }

        public TopProduct(String productName, String baseSku, int sold) {
            this.productName = productName;
            this.baseSku = baseSku;
            this.sold = sold;
        }

        public String getProductName() {
            return productName;
        }

        public void setProductName(String productName) {
            this.productName = productName;
        }

        public String getBaseSku() {
            return baseSku;
        }

        public void setBaseSku(String baseSku) {
            this.baseSku = baseSku;
        }

        public int getSold() {
            return sold;
        }

        public void setSold(int sold) {
            this.sold = sold;
        }
    }
}
