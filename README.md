# Cat Cafe Management System

A web-based management system for a cat cafe, developed as a group project using Java EE (JSP/Servlets) and MySQL. The system manages cafe operations including customer orders, table bookings, staff management, and cat care — all through a role-based portal for customers, staff, and admins.

---

## Features

### Customer
- Register and log in to a personal account
- Browse the cafe menu (food, beverages, desserts)
- Add items to cart and place dine-in or takeaway orders
- Checkout and make payment
- Make and manage table bookings
- View order history and order details
- Browse profiles of the resident cats
- Edit personal profile

### Staff
- Dedicated staff login portal
- View and manage customer bookings
- View and update order statuses

### Admin
- Manage staff accounts (register, search, view, update)
- Manage cat profiles (add, edit, view)
- Manage cat food inventory and feeding records
- Manage special access credentials (admin/staff)

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | JSP, HTML, CSS, JSTL |
| Backend | Java Servlets |
| Database | MySQL |
| Password Hashing | jBCrypt |
| File Upload | Apache Commons FileUpload |
| Search | Apache Lucene |
| Build Tool | Apache Ant (NetBeans) |

---

## Database Tables

| Table | Description |
|---|---|
| `customers` | Customer accounts and profiles |
| `staff` | Staff accounts |
| `special_access` | Admin and staff special login credentials |
| `menu` | Cafe menu items (food, beverages, desserts) |
| `orders` | Customer orders |
| `order_items` | Items within each order |
| `bookings` | Table booking records |
| `cafe_tables` | Cafe table information |
| `cat_profiles` | Resident cat profiles |
| `cat_food` | Cat food inventory |
| `cat_feeding` | Cat feeding records |

---

## Getting Started

### Prerequisites
- Java JDK 8 or above
- Apache Tomcat 9
- MySQL Server
- NetBeans IDE (recommended)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/AriiqMus/Cat-Cafe-Management-System.git
   ```

2. **Import the database**
   - Open phpMyAdmin or MySQL Workbench
   - Create a new database named `catcafedb2`
   - Import the `catcafedb2.sql` file

3. **Configure the database connection**
   - Open `src/java/util/DBUtil.java`
   - Update the database URL, username, and password to match your local setup

4. **Add libraries**
   - Place all `.jar` files from the `library/` folder into your project's library path

5. **Run the project**
   - Open the project in NetBeans
   - Deploy to Apache Tomcat
   - Access the app at `http://localhost:8080/CatCafeSystem`

---

## Default Login Credentials

| Role | Username | Password |
|---|---|---|
| Admin | admin | admin123 |
| Staff | staff | (set via special access) |

---

## Group Members

| Name | Role |
|---|---|
| (Add your names here) | (Add roles here) |
