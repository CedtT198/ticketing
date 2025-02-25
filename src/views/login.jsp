<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<!DOCTYPE html>
<html
  lang="en"
  class="light-style customizer-hide"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/"
  data-template="vertical-menu-template-free">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <title>Login Administrator</title>
    <meta name="description" content="" />
    <link rel="icon" type="image/x-icon" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/img/favicon/avion.ico" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/fonts/boxicons.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/css/demo.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/css/pages/page-auth.css" />
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/vendor/js/helpers.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/CedtT198/ticketing-assets@main/assets/js/config.js"></script>
  </head>

  <body>
    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
          <!-- Register -->
          <div class="card">
            <div class="card-body">
              <!-- Logo -->
              <%-- <div class="app-brand justify-content-center">
                <a href="index.html" class="app-brand-link gap-2">
                  <span class="app-brand-text demo text-body fw-bolder">Azur Travel</span>
                </a>
              </div> --%>
              <!-- /Logo -->
              <h4 class="mb-2">Administrator</h4>
              <p class="mb-4">Please sign-in to your account</p>

              <form class="mb-3" action="auth" method="post">
                <div class="mb-3">
                  <label for="email" class="form-label">Username</label>
                  <input
                    type="text"
                    class="form-control"
                    id="username"
                    name="admin.username"
                    placeholder="Enter your username"
                    value="admin1"
                    autofocus/>
                </div>
                <div class="mb-3 form-password-toggle">
                  <div class="d-flex justify-content-between">
                    <label class="form-label" for="password">Password</label>
                  </div>
                  <div class="input-group input-group-merge">
                    <input
                      type="password"
                      class="form-control"
                      id="password"
                      name="admin.password"
                      value="admin1"
                      placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                      aria-describedby="password"/>
                    <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                  </div>
                </div>
                <div>
                  <% String error = (String) session.getAttribute("error"); 
                  if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-danger" role="alert">
                        <strong>Erreur </strong> : <%= error %>
                    </div>
                  <% } %>

                  <% Map<String, String> errors = (Map<String, String>) session.getAttribute("errors");
                      if (errors != null && !errors.isEmpty()) { %>
                        <% for (Map.Entry<String, String> entry : errors.entrySet()) { %>
                          <div class="alert alert-warning" role="alert">
                            <strong><%= entry.getKey() %></strong> : <%= entry.getValue() %></li>
                          </div>
                        <% } %>
                  <% } %>
                </div>

                <div class="mb-3">
                  <button class="btn btn-primary d-grid w-100" type="submit">Sign in</button>
                </div>
              </form>
            </div>
          </div>
          <!-- /Register -->
        </div>
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
