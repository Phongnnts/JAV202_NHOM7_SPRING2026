<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Poly Cafe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #6fbf4c;
            --secondary: #ffb347;
            --dark: #2d2f36;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: #fef9f0;
            color: #333;
        }
        .navbar {
            padding: 1rem 0;
        }
        .navbar-brand {
            font-size: 1.8rem;
            letter-spacing: 1px;
        }
        .hero-section {
            background: linear-gradient(135deg, #e9f5e1 0%, #f9e6cf 100%);
            padding: 5rem 0;
            border-radius: 0 0 2rem 2rem;
        }
        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            color: var(--dark);
        }
        .hero-subtitle {
            font-size: 1.2rem;
            color: #555;
            margin: 1rem 0;
        }
        .btn-primary {
            background-color: var(--primary);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 50px;
            font-weight: 600;
        }
        .btn-primary:hover {
            background-color: #5da63e;
        }
        .product-card {
            border: none;
            border-radius: 20px;
            transition: all 0.3s ease;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        .product-img {
            height: 220px;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .product-card:hover .product-img {
            transform: scale(1.05);
        }
        .product-title {
            font-weight: 600;
            font-size: 1.1rem;
            margin-top: 1rem;
        }
        .product-price {
            color: var(--primary);
            font-weight: 700;
            font-size: 1.2rem;
        }
        .recent-activity {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .recent-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.75rem 0;
            border-bottom: 1px solid #eee;
        }
        .recent-item:last-child {
            border-bottom: none;
        }
        .recent-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 12px;
        }
        .recent-text {
            flex: 1;
        }
        .recent-name {
            font-weight: 500;
            margin-bottom: 0;
        }
        .recent-time {
            font-size: 0.75rem;
            color: #888;
        }
        footer {
            background: var(--dark);
            color: #fff;
            padding: 3rem 0 1rem;
            margin-top: 4rem;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/layout/menu.jsp" />