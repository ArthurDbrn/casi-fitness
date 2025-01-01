<!-- src/main/goals.jsp -->
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
        <p>Your goals !</p>
    </header>

    <main>
        <div class="choice container">
            <button class="choice-button" style="display: inline" id="activeChoice" onclick="changeChoice('Active')" disabled>Active Goals</button>
            <button class="choice-button" style="display: inline" id="pastChoice" onclick="changeChoice('Past')">Past Goals</button>
            <button class="choice-button" style="display: inline" id="futureChoice" onclick="changeChoice('Future')">Future Goals</button>
            <button class="choice-button" style="display: inline" id="allChoice" onclick="changeChoice('All')">All Goals</button>
        </div>
        <div class="goal-container">
            <p>Loading goals...</p>
        </div>
    </main>
    
    <a href="activities.jsp" class="home-button"><i class="fa fa-home"></i></a>
    <a href="addGoal.jsp" class="add-activity-button"><i class="fa fa-plus"></i></a>

    <script src="scripts/fetch_goals.js"></script>
    <script>
        changeChoice('Active');
    </script>
</body>
</html>