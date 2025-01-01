<!-- src/main/activities.jsp -->
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
        <p>Here are your activities !</p>
    </header>

    <main>
        <div class="stat-container">
            <div class="stat">
                <h2 style="display: inline;">Total Distance Covered this month :</h2>
                <p id="total-distance" style="display: inline;">Loading...</p>
            </div>
            <div class="stat">
                <h2 style="display: inline;">Total Time Spent training this month :</h2>
                <p id="total-time" style="display: inline;">Loading...</p>
            </div>
        </div>
        <div class="activity-container">
            <div id="activity-list">
                <p>Loading activities...</p>
            </div>
        </div>
    </main>

    <script src="scripts/fetch_activities.js"></script>
    <script src="scripts/display_stat_of_month.js"></script>
    
    <a href="goals.jsp" class="goals-button"><i class="fa fa-bullseye"></i></a>
    <a href="dashboard.jsp" class="dashboard-button"><i class="fa fa-signal"></i></i></a>
    <!--<a href="settings.jsp" class="settings-button"><i class="fa fa-gear"></i></a> -->
    <a href="addActivity.jsp" class="add-activity-button"><i class="fa fa-plus"></i></a>
</body>
</html>
