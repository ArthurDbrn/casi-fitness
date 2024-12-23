package service;

import java.util.List;

import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.jws.WebService;

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

    public void addActivity(String titre, ActivityType type) {
        activityDAO.addActivity(titre, type);
    }

    public Activity getActivity(long id) {
        return activityDAO.getActivity(id);
    }

    public List<Activity> getActivities() {
        return activityDAO.getActivities();
    }
}
