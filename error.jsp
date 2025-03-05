<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link rel="icon" type="image/x-icon" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/favicon/avion.ico" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/fonts/boxicons.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/css/demo.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/css/pages/page-auth.css" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/js/helpers.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/js/config.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
        }
        h1 {
            font-size: 250px;
        }
        p {
            font-size: 25px;
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="alert alert-warning" role="alert">
                <ul>
                    <% List<String> errors = (List<String>) request.getAttribute("list_error");
                        for (String error : errors) { %>
                            <li><% out.println(error);%></li>
                    <% } %>
                </ul>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/libs/popper/popper.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/js/bootstrap.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/js/menu.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/js/main.js"></script>
    <script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>