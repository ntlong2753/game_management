package com.codegym.game_management.dao;

import com.codegym.game_management.util.Database;

import java.sql.Connection;

public class BaseDAO {
    protected static Connection connect;
    public BaseDAO() {
        this.connect = Database.getConnection();
    }
}
