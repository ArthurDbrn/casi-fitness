<!-- src/main/webapp/addGoal.jsp -->
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
        <p>Add a new goal</p>
    </header>

    <script>
        function convertToSeconds() {
            const timeHours = parseFloat(document.getElementById('time_hours').value) || 0;
            const timeMinutes = parseFloat(document.getElementById('time_minutes').value) || 0;
            const timeSeconds = parseFloat(document.getElementById('time_seconds').value) || 0;
            const totalTime = (timeHours * 3600) + (timeMinutes * 60) + timeSeconds;
            document.getElementById('target').value = totalTime;

            return true;
        }
    </script>
    
    <main class="activity-container">
        <form method="post" action="/server/api/timeGoals/add" class="activity-form" onsubmit="return convertToSeconds()">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="time">Targeted Time:</label>
            <div style="display: flex; align-items: center;">
                <input type="number" id="time_hours" title="Enter hours" placeholder="h" required style="margin-right: 5px;" min="0" max="999"> 
                <input type="number" id="time_minutes" title="Enter minutes (0-59)" placeholder="min" required style="margin-right: 5px;" min="0" max="59">
                <input type="number" id="time_seconds" title="Enter seconds (0-59)" placeholder="sec" required min="0" max="59">
            </div>
            
            <label for="date">Start Date:</label>
            <input type="date" id="startDate" name="startDate" value='<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>' required>

            <label for="date">End Date:</label>
            <input type="date" id="endDate" name="endDate" value='<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>' required>
            
            <input type="hidden" id="target" name="target">
            
            <button type="submit">Add Goal</button>
        </form>
    </main>
    <a href="goals.jsp" class="goals-button"><i class="fa fa-bullseye"></i></a>
</body>
</html>