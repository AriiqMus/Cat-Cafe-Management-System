/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Muhammad Syakil bin Mohd Zaidi
 */
public class InsertResult {
    public boolean success;
    public boolean emailTaken;
    public boolean usernameTaken;

    public InsertResult(boolean success, boolean emailTaken, boolean usernameTaken) {
        this.success = success;
        this.emailTaken = emailTaken;
        this.usernameTaken = usernameTaken;
    }
}
