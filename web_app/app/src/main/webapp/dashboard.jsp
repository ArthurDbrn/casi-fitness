<!-- src/main/dashboard.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>Fitness Tracker</title>
</head>
<body>
    
    <header class="header">
        <h1>Fitness Tracker</h1>
        <p>Your performances !</p>
    </header>

    <main>
        <select id="type" name="type" onchange="changePeriod()" required>
            <option value="Running">Running</option>
            <option value="Cycling">Cycling</option>
            <option value="Swimming">Swimming</option>
            <option value="all">All</option>
        </select>

        <select id="granularity" name="granularity" onchange="changePeriod()" required>
            <option value="day">Day</option>
            <option value="month">Month</option>
            <option value="year">Year</option>
        </select>

        <div id="period-container">
            <p>loading...</p>
        </div>

        <div class="stat-container" style="background-color: aliceblue;">
            <canvas id="distanceChart" width="800" height="400"></canvas>
        </div>
    </main>

    <a href="activities.jsp" class="home-button"><i class="fa fa-home"></i></a>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="scripts/display_stats.js"></script>
    <script src="scripts/fetch_stats.js"></script>
    <script>
        changePeriod();
    </script>
    
</body>
</html>
