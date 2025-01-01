package dao;

import java.util.List;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import model.TimeGoal;

@Named("timeGoalDAO")
@ApplicationScoped
public class TimeGoalDAO {
    @PersistenceContext
    EntityManager em;

    public TimeGoalDAO() {
    }

    public List<TimeGoal> getGoals() {
        return em.createQuery("SELECT tg FROM TimeGoal tg", TimeGoal.class).getResultList();
    }

    public List<TimeGoal> getActiveTimeGoals() {
        return em.createQuery("SELECT tg FROM TimeGoal tg", TimeGoal.class)
                .getResultStream()
                .filter(timeGoal -> timeGoal.isActive())
                .toList();
    }

    public List<TimeGoal> getFutureTimeGoals() {
        return em.createQuery("SELECT tg FROM TimeGoal tg", TimeGoal.class)
                .getResultStream()
                .filter(timeGoal -> timeGoal.hasNotStarted())
                .toList();
    }

    public List<TimeGoal> getFailedTimeGoals() {
        return em.createQuery("SELECT tg FROM TimeGoal tg", TimeGoal.class)
                .getResultStream()
                .filter(timeGoal -> timeGoal.isFailed())
                .toList();
    }

    public List<TimeGoal> getCompletedTimeGoals() {
        return em.createQuery("SELECT tg FROM TimeGoal tg", TimeGoal.class)
                .getResultStream()
                .filter(timeGoal -> timeGoal.isCompleted())
                .toList();
    }

    public TimeGoal getGoalById(long id) {
        return em.find(TimeGoal.class, id);
    }

    @Transactional
    public void addGoal(TimeGoal timeGoal) {
        em.joinTransaction();
        em.persist(timeGoal);
        em.flush();
    }

    @Transactional
    public void updateGoal(TimeGoal timeGoal, long progress) {
        timeGoal.updateStatus(progress);
        em.joinTransaction();
        em.merge(timeGoal);
        em.flush();
    }

}
