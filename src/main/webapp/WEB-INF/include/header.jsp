<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mirai-Công nghệ của tương lai</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .text-truncate-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;  
            overflow: hidden;
        }
        
        /* HIỆU ỨNG FOCUS Ô TÌM KIẾM MÀU XANH DƯƠNG */
        #search-input:focus {
            box-shadow: 0 0 0 2px #0056b3 !important;
            border-color: #0056b3 !important;
            background-color: #fff !important;
        }
        
        .search-dropdown-menu {
            min-width: 480px !important;
        }
        
        .search-item {
            transition: all 0.2s ease-in-out;
            border-radius: 8px;
        }
        
        .search-item:hover {
            background-color: #f8f9fa;
        }
        
        .search-item:hover span {
            color: #0056b3 !important;
        }

        /* ĐỊNH DẠNG CAROUSEL BANNER */
        .carousel-item img {
            object-fit: cover;
            width: 100%;
        }
        /* Thay đổi màu sắc nút chấm tròn chỉ số cho đúng tông xanh dương */
        .carousel-indicators [data-bs-target] {
            background-color: #0056b3 !important;
        }
    </style>
</head>
<body class="bg-light text-dark d-flex flex-column min-vh-screen">