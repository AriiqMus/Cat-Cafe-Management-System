/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Ariiq
 */

public class CafeTable {
    private int tableID;
    private String tableNumber;
    private String tableType;
    private String status;

    public CafeTable() {}

    public CafeTable(int tableID, String tableNumber, String tableType, String status) {
        this.tableID = tableID;
        this.tableNumber = tableNumber;
        this.tableType = tableType;
        this.status = status;
    }

    // Getters and Setters
    public int getTableID() {
        return tableID;
    }

    public void setTableID(int tableID) {
        this.tableID = tableID;
    }

    public String getTableNumber() {
        return tableNumber;
    }

    public void setTableNumber(String tableNumber) {
        this.tableNumber = tableNumber;
    }

    public String getTableType() {
        return tableType;
    }

    public void setTableType(String tableType) {
        this.tableType = tableType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}