package com.codegym.game_management.model;

public class ValidLoginUser {

    /* ---------- kiểm tra email ---------- */
    private static final String EMAIL_REGEX = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
    public static boolean checkEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return email.matches(EMAIL_REGEX);
    }

    /* ---------- kiểm tra mật khẩu ---------- */
    private static final String PASSWORD_REGEX = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";
    public static boolean checkPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return false;
        }
        return password.matches(PASSWORD_REGEX);
    }

    /* ---------- kiểm tra username ---------- */
    private static final String USERNAME_REGEX = "^[a-zA-Z0-9_]{3,20}$";

    public static boolean checkUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        return username.matches(USERNAME_REGEX);
    }

    /* ---------- kiểm tra số điện thoại ---------- */

    // Tách riêng biệt Regex của từng nhà mạng để dễ quản lý
    private static final String VIETTEL_REGEX = "^(03[2-9]|086|09[678])\\d{7}$";
    private static final String VINAPHONE_REGEX = "^(08[1-58]|09[14])\\d{7}$";
    private static final String MOBIFONE_REGEX = "^(07[06-9]|089|09[03])\\d{7}$";

    /* Kiểm tra số điện thoại: Đúng 1 trong 3 nhà mạng mới trả về true */
    public static boolean checkPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }

        String phoneNumber = phone.trim();

        return phoneNumber.matches(VIETTEL_REGEX) ||
                phoneNumber.matches(VINAPHONE_REGEX) ||
                phoneNumber.matches(MOBIFONE_REGEX);
    }
}
