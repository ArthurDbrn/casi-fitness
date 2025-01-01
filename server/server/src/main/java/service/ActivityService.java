package service;

import java.time.LocalDate;
import java.util.List;

import dao.ActivityDAO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import model.Activity;
import model.ActivityType;

@ApplicationScoped
public class ActivityService {

    @Inject
    private ActivityDAO activityDAO;
    
    public ActivityService() {
    }

    //gets all activities
    public List<Activity> getActivities() {
        return activityDAO.getActivities();
    }

    //adds an activity
    public void addActivity(String name, String type, String date, long time, long distance) {
        ActivityType activityType = ActivityType.valueOf(type.toUpperCase());
        LocalDate activityDate = LocalDate.parse(date);
        Activity activity = new Activity(name, activityType, activityDate, time, distance);
        activityDAO.addActivity(activity);
    }

    //gets the distance covered
    public List<Object[]> getDistanceCovered(String from, String to, String granularity, String type) {
        if (type == null) {
            return activityDAO.getDistanceCovered(from, to, granularity);
        } else {
            return activityDAO.getDistanceCovered(from, to, granularity, type);
        }
    }

    //gets the time spent
    public List<Object[]> getTimeSpent(String from, String to, String granularity, String type) {
        if (type == null) {
            return activityDAO.getTimeSpent(from, to, granularity);
        } else {
            return activityDAO.getTimeSpent(from, to, granularity, type);
        }
    }
}
