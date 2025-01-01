package dao;

import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import model.Activity;
import model.ActivityType;
import model.StatGranularity;

import java.time.LocalDate;
import java.util.List;

@Named("activityDAO")
public class ActivityDAO {
    @PersistenceContext
    EntityManager em;

    public ActivityDAO() {
    }

    public List<Activity> getActivities() {
        return em.createQuery("SELECT a FROM Activity a", Activity.class).getResultList();
    }

    public Activity getActivity(long id) {
        return em.find(Activity.class, id);
    }

    @Transactional
    public void addActivity(Activity activity) {
        em.joinTransaction();
        em.persist(activity);
        em.flush();
    }

    public List<Object[]> getDistanceCovered(String from, String to, String granularity, String type) {
        StatGranularity statGranularity = StatGranularity.valueOf(granularity.toUpperCase());
        return em.createQuery(String.format(
                "SELECT FUNCTION('%s', a.date), SUM(a.distance) " +
                "FROM Activity a " +
                "WHERE a.type = :type AND a.date BETWEEN :from AND :to " +
                "GROUP BY FUNCTION('%s', a.date)", statGranularity, statGranularity
            ), Object[].class)
            //.setParameter("granularity", statGranularity)
            .setParameter("type", ActivityType.valueOf(type.toUpperCase()))
            .setParameter("from", LocalDate.parse(from))
            .setParameter("to", LocalDate.parse(to))
            .getResultList();
    }

    public List<Object[]> getDistanceCovered(String from, String to, String granularity) {
        StatGranularity statGranularity = StatGranularity.valueOf(granularity.toUpperCase());
        return em.createQuery(String.format(
                "SELECT FUNCTION('%s', a.date), SUM(a.distance) " +
                "FROM Activity a " +
                "WHERE a.date BETWEEN :from AND :to " +
                "GROUP BY FUNCTION('%s', a.date)", statGranularity, statGranularity
            ), Object[].class)
            //.setParameter("granularity", statGranularity)
            .setParameter("from", LocalDate.parse(from))
            .setParameter("to", LocalDate.parse(to))
            .getResultList();
    }

    public List<Object[]> getTimeSpent(String from, String to, String granularity, String type) {
        StatGranularity statGranularity = StatGranularity.valueOf(granularity.toUpperCase());
        return em.createQuery(String.format(
                "SELECT FUNCTION('%s', a.date), SUM(a.time) " +
                "FROM Activity a " +
                "WHERE a.type = :type AND a.date BETWEEN :from AND :to " +
                "GROUP BY FUNCTION('%s', a.date)", statGranularity, statGranularity
            ), Object[].class)
            //.setParameter("granularity", statGranularity)
            .setParameter("type", ActivityType.valueOf(type.toUpperCase()))
            .setParameter("from", LocalDate.parse(from))
            .setParameter("to", LocalDate.parse(to))
            .getResultList();
    }

    public List<Object[]> getTimeSpent(String from, String to, String granularity) {
        StatGranularity statGranularity = StatGranularity.valueOf(granularity.toUpperCase());
        return em.createQuery(String.format(
                "SELECT FUNCTION('%s', a.date), SUM(a.time) " +
                "FROM Activity a " +
                "WHERE a.date BETWEEN :from AND :to " +
                "GROUP BY FUNCTION('%s', a.date)", statGranularity, statGranularity
            ), Object[].class)
            //.setParameter("granularity", statGranularity)
            .setParameter("from", LocalDate.parse(from))
            .setParameter("to", LocalDate.parse(to))
            .getResultList();
    }
}
