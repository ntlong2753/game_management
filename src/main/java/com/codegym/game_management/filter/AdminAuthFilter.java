package com.codegym.game_management.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = "/home-admin/*")
public class AdminAuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String role = null;
        if (session != null) {
            role = (String) session.getAttribute("adminRole");
        }

        if ("ADMIN".equals(role)) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/game-management/admin/login");
        }
    }
}