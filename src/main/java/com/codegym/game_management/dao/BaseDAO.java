package com.codegym.game_management.dao;

import com.codegym.game_management.util.Database;

import java.sql.Connection;

public class BaseDAO {
    protected Connection connect = Database.getConnection();

    public BaseDAO() {

    }
}
