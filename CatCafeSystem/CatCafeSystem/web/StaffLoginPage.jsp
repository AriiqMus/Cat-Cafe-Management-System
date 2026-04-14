<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff Login - Cat Diary Cafe</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #fcd56a;
                margin: 0;
                padding: 0;
                color: #000;
            }
            main {
                max-width: 400px;
                margin: 60px auto;
                background-color: #fff8e1;
                padding: 30px;
                border-radius: 20px;
                border: 3px solid #4b3621;
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                margin-bottom: 30px;
                font-family: 'Castely', cursive;
                color: #4b3621;
                font-size: 32px;
            }
            form {
                display: flex;
                flex-direction: column;
            }
            label {
                font-weight: bold;
                margin-bottom: 8px;
                color: #4b3621;
                text-align: left;
            }
            input[type="text"], input[type="password"] {
                padding: 12px;
                margin-bottom: 20px;
                border: 2px solid #4b3621;
                border-radius: 10px;
                font-size: 16px;
                background-color: #fffaf0;
                color: #000;
            }
            .login-btn {
                background-color: #ffdd95;
                color: #4b3621;
                padding: 14px;
                border: none;
                border-radius: 25px;
                font-size: 18px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .login-btn:hover {
                background-color: #ffe8b6;
            }
            .error-message {
                color: red;
                font-weight: bold;
                text-align: center;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <main>
            <h2>Staff Login</h2>

            <!-- Show error message if error parameter exists -->
            <% String error = request.getParameter("error");
        if ("true".equals(error)) { %>
            <div class="error-message">
                Invalid Staff ID / Password / Role! Please try again.
            </div>
            <% }%>

            <form action="${pageContext.request.contextPath}/StaffLoginServlet" method="post">
                <label for="staffId">Staff ID</label>
                <input type="text" id="staffId" name="staffId" placeholder="Enter your staff ID" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <label>Role</label>
                <div style="margin-bottom: 20px;">
                    <input type="radio" id="admin" name="role" value="admin" required>
                    <label for="admin">Admin</label>

                    <input type="radio" id="staff" name="role" value="staff" required style="margin-left:20px;">
                    <label for="staff">Staff</label>
                </div>

                <button type="submit" class="login-btn"><i class="fas fa-sign-in-alt"></i> Login</button>
            </form>
        </main>
    </body>
</html>
