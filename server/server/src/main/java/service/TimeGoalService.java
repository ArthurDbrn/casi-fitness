package service;

import java.time.LocalDate;
import java.util.List;

import dao.TimeGoalDAO;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import model.TimeGoal;

@ApplicationScoped
public class TimeGoalService {
    @Inject
    private TimeGoalDAO timeGoalDAO;

    @Inject
    private ActivityService activityService;

    public TimeGoalService() {
    }

    public List<TimeGoal> getGoals() {
        return timeGoalDAO.getGoals();
    }

    public List<TimeGoal> getActiveTimeGoals() {
        return timeGoalDAO.getActiveTimeGoals();
    }

    public List<TimeGoal> getFutureTimeGoals() {
        return timeGoalDAO.getFutureTimeGoals();
    }

    public List<TimeGoal> getFailedTimeGoals() {
        return timeGoalDAO.getFailedTimeGoals();
    }

    public List<TimeGoal> getCompletedTimeGoals() {
        return timeGoalDAO.getCompletedTimeGoals();
    }

    public void addGoal(String name, String startDate, String endDate, long target) {
        TimeGoal timeGoal = new TimeGoal(name, LocalDate.parse(startDate), LocalDate.parse(endDate), target);
        timeGoalDAO.addGoal(timeGoal);
    }

    public void updateGoals() {
        timeGoalDAO.getGoals().forEach(timeGoal -> {
            long progress = getProgress(timeGoal.getStartDate().toString(), timeGoal.getEndDate().toString());
            timeGoalDAO.updateGoal(timeGoal, progress);
        });
    }

    public long getProgress(String startDate, String endDate) {
        return activityService.getTimeSpent(endDate, endDate, "day", null)
                .stream()
                .mapToLong(arr -> (long) arr[1])
                .sum();
    }
}
