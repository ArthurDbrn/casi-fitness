package dao;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import model.Activity;
import model.ActivityType;

import java.util.List;

@Named("activityDAO")
@ApplicationScoped
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
    public void addActivity(String titre, ActivityType type) {
        Activity activity = new Activity();
        activity.setName(titre);
        activity.setType(type);
        em.joinTransaction();
        em.persist(activity);
        em.flush();
    }
}
