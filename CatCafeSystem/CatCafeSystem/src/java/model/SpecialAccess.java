/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Muhammad Syakil bin Mohd Zaidi
 */
public class SpecialAccess {
    private int specialAccessId;
    private String specialAccessType; // 'admin' or 'staff'
    private String specialAccessName;
    private String specialAccessPassword; // hashed password

    // Constructors
    public SpecialAccess() {}

    public SpecialAccess(int specialAccessId, String specialAccessType, String specialAccessName, String specialAccessPassword) {
        this.specialAccessId = specialAccessId;
        this.specialAccessType = specialAccessType;
        this.specialAccessName = specialAccessName;
        this.specialAccessPassword = specialAccessPassword;
    }

    // Getters and Setters
    public int getSpecialAccessId() {
        return specialAccessId;
    }

    public void setSpecialAccessId(int specialAccessId) {
        this.specialAccessId = specialAccessId;
    }

    public String getSpecialAccessType() {
        return specialAccessType;
    }

    public void setSpecialAccessType(String specialAccessType) {
        this.specialAccessType = specialAccessType;
    }

    public String getSpecialAccessName() {
        return specialAccessName;
    }

    public void setSpecialAccessName(String specialAccessName) {
        this.specialAccessName = specialAccessName;
    }

    public String getSpecialAccessPassword() {
        return specialAccessPassword;
    }

    public void setSpecialAccessPassword(String specialAccessPassword) {
        this.specialAccessPassword = specialAccessPassword;
    }

    @Override
    public String toString() {
        return "SpecialAccess{" +
               "specialAccessId=" + specialAccessId +
               ", specialAccessType='" + specialAccessType + '\'' +
               ", specialAccessName='" + specialAccessName + '\'' +
               ", specialAccessPassword='" + specialAccessPassword + '\'' +
               '}';
    }
}