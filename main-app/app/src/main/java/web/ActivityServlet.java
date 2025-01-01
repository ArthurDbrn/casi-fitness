package web;

import java.io.IOException;
import java.util.List;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.ActivityType;
import model.Activity;

import service.ActivityService;

@WebServlet("/activity")
public class ActivityServlet extends HttpServlet{

    @Inject
    private ActivityService activityService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/activities.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String operation = req.getParameter("operation");
        switch (operation) {
            case "add":
                String name = req.getParameter("name");
                ActivityType type = ActivityType.valueOf(req.getParameter("type").toUpperCase());
                String distance = req.getParameter("distance_km") + ":" + req.getParameter("distance_m");
                String time = req.getParameter("time_hours") + ":" + req.getParameter("time_minutes") + ":" + req.getParameter("time_seconds");
                String date = req.getParameter("date");
                activityService.addActivity(name, type, date, time, distance);
                resp.sendRedirect(req.getContextPath() + "/activity");
                break;
            case "get":
                List<Activity> activities = activityService.getActivities();
                req.setAttribute("activities", activities);
                req.getRequestDispatcher("/activities.jsp").forward(req, resp);
                break;
        }
    }
    
}
