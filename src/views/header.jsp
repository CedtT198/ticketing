<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Azur Travel</title>
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
        .menu-link {
            display: flex;
            align-items: center;
        }

        .menu-link img {
            margin-right: 15px; 
        }
    </style>
  </head>

<body>
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
            <div class="app-brand demo">
                <a href="#" class="app-brand-link">
                    <span class="app-brand-logo demo">
                    <img src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/billet-davion.png" alt="Billet d'avion" class="w-px-50 h-auto">
                    </span>
                    <span class="app-brand-text demo menu-text fw-bolder ms-2"></span>
                </a>

                <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                    <i class="bx bx-chevron-left bx-sm align-middle"></i>
                </a>
            </div>

            <div class="menu-inner-shadow"></div>

            <ul class="menu-inner py-1">
                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text"></span>
                </li>
                <li class="menu-item">
                    <a class="menu-link menu-toggle">
                        <img src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/liens/vol_d-avion.png" class="w-px-30 h-auto"/>
                        <div data-i18n="Vol Settings">Vol</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href="insert-vol.jsp" class="menu-link">
                            <div data-i18n="Insertion">Insertion</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="liste-vol.jsp" class="menu-link">
                            <div data-i18n="Liste">Liste</div>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="menu-item">
                    <a href="promotion.jsp" class="menu-link">
                        <img src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/liens/promotion.png"class="w-px-30 h-auto"/>
                        <div data-i18n="Promotion">Promotion</div>
                    </a>
                </li>
                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">Contraintes</span>
                </li>
                <li class="menu-item">
                    <a href="const-annulation.jsp" class="menu-link">
                        <img src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/liens/reservation_vol.png"class="w-px-30 h-auto"/>
                        <div data-i18n="Analytics">Heure limite de reservation</div>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="const-reservation.jsp" class="menu-link">
                        <img src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/liens/annulation_vol.png"class="w-px-30 h-auto"/> 
                        <div data-i18n="Analytics">Annulation de reservation</div>
                    </a>
                </li>
            </ul>
        </aside>
        <div class="layout-page">
            <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar" >
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
            <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
            </a>
            </div>
            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
            <ul class="navbar-nav flex-row align-items-center ms-auto">
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                    <img src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/profil/admin.png" alt class="w-px-40 h-auto rounded-circle" />
                    </div>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                    <a class="dropdown-item" href="#">
                        <div class="d-flex">
                        <!-- <div class="flex-shrink-0 me-3">
                            <div class="avatar avatar-online">
                            <img src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/profil/admin.png" alt class="w-px-40 h-auto rounded-circle" />
                            </div>
                        </div> -->
                        <div class="flex-grow-1">
                            <span class="fw-semibold d-block"><%= admin.getUsername() %></span>
                            <small class="text-muted"><%= admin.getIdAdmin() %></small>
                        </div>
                        </div>
                    </a>
                    </li>
                    <li>
                    <div class="dropdown-divider"></div>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bx bx-user me-2"></i>
                            <span class="align-middle">Mon Profile</span>
                        </a>
                    </li>
                    <li>
                        <div class="dropdown-divider"></div>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bx bx-power-off me-2"></i>
                            <span class="align-middle">Log Out</span>
                        </a>
                    </li>
                </ul>
                </li>
            </ul>
            </div>
        </nav>



            <div class="content-wrapper">
            <div class="container-xxl flex-grow-1 container-p-y">
                <!-- ========= include =========  -->
                <!-- ========= include =========  -->
                <!-- ========= include =========  -->