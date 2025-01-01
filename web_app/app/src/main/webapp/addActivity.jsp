<!-- src/main/webapp/addActivity.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>Add Acitivity</title>
</head>
<body>  
    <header class="header">
        <h1>Fitness Tracker</h1>
        <p>Add a new activity</p>
    </header>

    <script>
        function convertToMetersAndSeconds() {
            const distanceKm = parseFloat(document.getElementById('distance_km').value) || 0;
            const distanceM = parseFloat(document.getElementById('distance_m').value) || 0;
            const totalDistance = (distanceKm * 1000) + distanceM;
            document.getElementById('distance').value = totalDistance;

            const timeHours = parseFloat(document.getElementById('time_hours').value) || 0;
            const timeMinutes = parseFloat(document.getElementById('time_minutes').value) || 0;
            const timeSeconds = parseFloat(document.getElementById('time_seconds').value) || 0;
            const totalTime = (timeHours * 3600) + (timeMinutes * 60) + timeSeconds;
            document.getElementById('time').value = totalTime;

            return true;
        }
    </script>
    
    <main class="activity-container">
        <form method="post" action="/server/api/activity/add" class="activity-form" onsubmit="return convertToMetersAndSeconds()">
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
                <input type="number" id="distance_km" title="Enter kilometers" placeholder="km" required style="margin-right: 5px;" min="0" max="999">
                <input type="number" id="distance_m" title="Enter meters" placeholder="m" required min="0" max="999">
            </div>
            
            <label for="time">Time:</label>
            <div style="display: flex; align-items: center;">
                <input type="number" id="time_hours" title="Enter hours" placeholder="h" required style="margin-right: 5px;" min="0" max="999"> 
                <input type="number" id="time_minutes" title="Enter minutes (0-59)" placeholder="min" required style="margin-right: 5px;" min="0" max="59">
                <input type="number" id="time_seconds" title="Enter seconds (0-59)" placeholder="sec" required min="0" max="59">
            </div>
            
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" value='<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>' required>
            
            <input type="hidden" id="distance" name="distance">
            <input type="hidden" id="time" name="time">
            
            <button type="submit">Add Activity</button>
        </form>
    </main>
    <a href="activities.jsp" class="home-button"><i class="fa fa-home"></i></a>
</body>
</html>