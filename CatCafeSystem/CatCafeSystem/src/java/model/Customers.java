/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Ariiq
 */

public class Customers {
    private int customerId;
    private String customerName;
    private java.sql.Date customerBirthDate;
    private java.sql.Date customerDateRegistered;
    private String customerPhoneNumber;
    private String customerEmail;
    private String customerPassword;
    private String customerStatus; // Should be "active" or "deactivated"
    private String customerUsername;

    // Constructors
    public Customers() {}

    public Customers(int customerId, String customerName, java.sql.Date customerBirthDate,
                    java.sql.Date customerDateRegistered, String customerPhoneNumber,
                    String customerEmail, String customerPassword, String customerStatus,
                    String customerUsername) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.customerBirthDate = customerBirthDate;
        this.customerDateRegistered = customerDateRegistered;
        this.customerPhoneNumber = customerPhoneNumber;
        this.customerEmail = customerEmail;
        this.customerPassword = customerPassword;
        this.customerStatus = customerStatus;
        this.customerUsername = customerUsername;
    }

    // Getters and Setters
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public java.sql.Date getCustomerBirthDate() {
        return customerBirthDate;
    }

    public void setCustomerBirthDate(java.sql.Date customerBirthDate) {
        this.customerBirthDate = customerBirthDate;
    }

    public java.sql.Date getCustomerDateRegistered() {
        return customerDateRegistered;
    }

    public void setCustomerDateRegistered(java.sql.Date customerDateRegistered) {
        this.customerDateRegistered = customerDateRegistered;
    }

    public String getCustomerPhoneNumber() {
        return customerPhoneNumber;
    }

    public void setCustomerPhoneNumber(String customerPhoneNumber) {
        this.customerPhoneNumber = customerPhoneNumber;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPassword() {
        return customerPassword;
    }

    public void setCustomerPassword(String customerPassword) {
        this.customerPassword = customerPassword;
    }

    public String getCustomerStatus() {
        return customerStatus;
    }

    public void setCustomerStatus(String customerStatus) {
        this.customerStatus = customerStatus;
    }

    public String getCustomerUsername() {
        return customerUsername;
    }

    public void setCustomerUsername(String customerUsername) {
        this.customerUsername = customerUsername;
    }

    @Override
    public String toString() {
        return "Customer{" +
               "customerId=" + customerId +
               ", customerName='" + customerName + '\'' +
               ", customerBirthDate=" + customerBirthDate +
               ", customerDateRegistered=" + customerDateRegistered +
               ", customerPhoneNumber='" + customerPhoneNumber + '\'' +
               ", customerEmail='" + customerEmail + '\'' +
               ", customerPassword='" + customerPassword + '\'' +
               ", customerStatus='" + customerStatus + '\'' +
               ", customerUsername='" + customerUsername + '\'' +
               '}';
    }
}

