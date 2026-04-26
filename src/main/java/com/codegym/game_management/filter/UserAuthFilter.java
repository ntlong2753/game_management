package com.codegym.game_management.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/home-user/*"})
public class UserAuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Chỉ cho qua nếu có thẻ và thẻ ghi là USER
        if (session != null && "USER".equals(session.getAttribute("userRole"))) {
            chain.doFilter(request, response);
        } else {
            // Không phải user thì đá về trang login user
            res.sendRedirect(req.getContextPath() + "/");
        }
    }
}
