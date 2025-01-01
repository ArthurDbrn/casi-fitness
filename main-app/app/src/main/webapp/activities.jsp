<!-- src/main/activities.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>Fitness Tracker</title>
    
</head>
<body>
    
    <header class="header">
        <h1>Fitness Tracker</h1>
        <p>Here are your activities !</p>
    </header>

    <main class="activity-container">
        <c:choose>
            <c:when test="${empty activityService.getActivities()}">
                <p>You haven't added any acitivities :( Start getting fit <a href="addActivity.jsp">here</a> !</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="activity" items="${activityService.getActivities()}">
                    <section class="activity" id="activity-${activity.id}">
                        <h2>${activity.name}</h2>
                        <p><strong style="color: grey;">${activity.type}</strong></p>
                        <p><strong>Distance:</strong> ${activity.distance.split(":")[0]} km ${activity.distance.split(":")[1] }m</p>
                        <p><strong>Time:</strong> ${activity.time.split(":")[0]} hours ${activity.time.split(":")[1]} minutes ${activity.time.split(":")[2]} seconds</p>
                        <p><strong>Date:</strong> ${activity.date}</p>
                    </section>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </main>

    <footer class="footer">
        <p>&copy; 2024 Fitness Tracker. All rights reserved.</p>
    </footer>
</body>
</html>
