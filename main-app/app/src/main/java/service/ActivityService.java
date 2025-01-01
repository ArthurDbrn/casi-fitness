package service;

import java.util.List;

import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.jws.WebService;
import jakarta.ws.rs.Path;
import model.ActivityType;
import model.Activity;

import dao.ActivityDAO;

@Named("activityService")
@WebService
public class ActivityService {
    @Inject
    ActivityDAO activityDAO;

    public ActivityService() {
    }

    public void addActivity(String titre, ActivityType type, String date, String time, String distance) {
        activityDAO.addActivity(titre, type, date, time, distance);
    }

    public Activity getActivity(long id) {
        return activityDAO.getActivity(id);
    }

    @Path("/activities")
    public List<Activity> getActivities() {
        return activityDAO.getActivities();
    }
}
