<!-- src/main/webapp/addActivity.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>Add Acitivity</title>
</head>
<body>  
    <header class="header">
        <h1>Fitness Tracker</h1>
        <p>Add a new activity</p>
    </header>
    
    <main class="activity-container">
        <form method="post" action="activity" class="activity-form">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="type">Activity:</label>
            <select id="type" name="type" required>
                <option value="Running">Running</option>
                <option value="Cycling">Cycling</option>
                <option value="Swimming">Swimming</option>
            </select>
            
            <label for="distance">Distance:</label>
            <div style="display: flex; align-items: center;">
                <input type="number" id="distance_km" name="distance_km" title="Enter kilometers" placeholder="km" required style="margin-right: 5px;" min = "0" max="999">
                <input type="number" id="distance_m" name="distance_m" title="Enter meters" placeholder="m" required min="0" max="999">
            </div>
            
            <label for="time">Time:</label>
            <div style="display: flex; align-items: center;">
                <input type="number" id="time_hours" name="time_hours" title="Enter hours" placeholder="h" required style="margin-right: 5px;" min="0" max="999"> 
                <input type="number" id="time_minutes" name="time_minutes" title="Enter minutes (0-59)" placeholder="min" required style="margin-right: 5px;" min="0" max="59">
                <input type="number" id="time_seconds" name="time_seconds" title="Enter seconds (0-59)" placeholder="sec" required min= "0" max="59">
            </div>
            
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" value='<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>' required>
            
            <button type="submit">Add Activity</button>
        </form>
    </main>
    
    <footer class="footer">
        <p>&copy; 2024 Fitness Tracker. All rights reserved.</p>
    </footer>
</body>
</html>