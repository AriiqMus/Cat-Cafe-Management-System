<%-- 
    Document   : homepage
    Created on : 26 May 2025, 7:57:49 pm
    Author     : sitif
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Cat Diary Cafe | Home</title>
        <link rel="stylesheet" href="styles.css" />
        <style>
            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #fffaf1;
                color: #4b3621;
            }

            main {
                padding: 60px 20px;
                text-align: center;
            }

            .welcome-title {
                font-size: 3rem;
                font-weight: bold;
                margin-bottom: 30px;
                font-family: 'Castely', cursive;
                color: #4b3621;
            }

            .floating-status {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1000;
                max-width: 280px;
                text-align: left;
                padding: 20px 25px;
                opacity: 0;
                transform: translateY(-10px);
                transition: opacity 1s ease, transform 0.8s ease;
            }

            .floating-status.show {
                opacity: 1;
                transform: translateY(0);
            }

            .floating-status.hide {
                opacity: 0;
                transform: translateY(-10px);
            }


            @media (max-width: 768px) {
                .floating-status {
                    top: 15px;
                    right: 15px;
                    font-size: 1rem;
                    padding: 15px 20px;
                }
            }

            .status-card {
                display: inline-block;
                padding: 25px 30px;
                border-radius: 16px;
                font-size: 1.4rem;
                font-weight: bold;
                font-family: 'Segoe UI', sans-serif;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                animation: fadeIn 0.6s ease;
                margin: 20px auto;
                max-width: 90%;
                line-height: 1.6;
                letter-spacing: 0.5px;
            }

            .status-open {
                background-color: #e6ffed;
                color: #2e7d32;
                border: 3px solid #43a047;
                box-shadow: 0 0 10px 2px rgba(67, 160, 71, 0.3);
                animation: pulseOpen 2s infinite;
            }

            .status-closed {
                background-color: #ffe6e6;
                color: #c62828;
                border: 3px solid #e53935;
                box-shadow: 0 0 10px 2px rgba(229, 57, 53, 0.3);
                animation: pulseClosed 2s infinite;
            }

            @keyframes pulseOpen {
                0% {
                    box-shadow: 0 0 10px 2px rgba(67, 160, 71, 0.3);
                }
                50% {
                    box-shadow: 0 0 20px 4px rgba(67, 160, 71, 0.4);
                }
                100% {
                    box-shadow: 0 0 10px 2px rgba(67, 160, 71, 0.3);
                }
            }

            @keyframes pulseClosed {
                0% {
                    box-shadow: 0 0 10px 2px rgba(229, 57, 53, 0.3);
                }
                50% {
                    box-shadow: 0 0 20px 4px rgba(229, 57, 53, 0.4);
                }
                100% {
                    box-shadow: 0 0 10px 2px rgba(229, 57, 53, 0.3);
                }
            }

            .hero-image img {
                width: 90%;
                max-width: 900px;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
                margin-bottom: 50px;
                transition: transform 0.3s ease;
            }

            .hero-image img:hover {
                transform: scale(1.03);
            }

            .home-grid {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 30px;
            }

            .home-card {
                display: inline-block;
                padding: 25px 50px;
                background-color: #f8e7c1;
                border-radius: 20px;
                text-decoration: none;
                color: #4b3621;
                font-size: 1.5rem;
                font-weight: bold;
                border: 2px solid #4b3621;
                transition: all 0.3s ease;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            }

            .home-card:hover {
                background-color: #ffdd95;
                transform: translateY(-5px);
            }

            footer {
                margin-top: 60px;
                padding: 20px;
                background-color: #f0eacb;
                text-align: center;
                font-size: 0.9rem;
                color: #4b3621;
                border-top: 1px solid #d4c29e;
            }

            @media (max-width: 768px) {
                .home-card {
                    width: 80%;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp">
            <jsp:param name="page" value="home" />
        </jsp:include>

        <!-- Opening status floating top-right -->
        <div id="opening-status" class="status-card floating-status"></div>

        <main>
            <h1 class="welcome-title">Welcome to Cat Diary Cafe 🐾</h1>

            <div class="hero-image">
                <img src="images/catss.jpg" alt="Cute Cats at the Cafe">
            </div>

            <section class="home-grid">
                <a href="CatProfileServlet" class="home-card">🐱 Meet Our Cats</a>
                <!-- <a href="#" class="home-card">☕ View Our Menu</a> -->
                <a href="CustBookingServlet" class="home-card">📅 Book a Visit</a>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Cat Diary Cafe. All rights reserved.</p>
        </footer>

        <script>
            function checkOpeningHours() {
                const openingHour = 10; // 10 AM
                const closingHour = 20; // 8 PM
                const now = new Date();
                const hour = now.getHours();

                const statusDiv = document.getElementById("opening-status");

                if (hour >= openingHour && hour < closingHour) {
                    statusDiv.classList.add("status-open");
                    statusDiv.innerHTML = `🟢 <span style="font-size:1.3rem;">We're <strong>Open Now</strong>!</span><br>Hours: 10:00 AM – 8:00 PM`;
                } else {
                    statusDiv.classList.add("status-closed");
                    statusDiv.innerHTML = `🔴 <span style="font-size:1.3rem;">We're <strong>Closed</strong> 😿</span><br>Come back between 10:00 AM – 8:00 PM`;
                }

                // Animate appearance
                statusDiv.classList.add("show");

                // Auto-hide after 5 seconds
                setTimeout(() => {
                    statusDiv.classList.add("hide");
                }, 5000);
            }

            window.onload = checkOpeningHours;
        </script>

    </body>
</html>
