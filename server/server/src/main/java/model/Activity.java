package model;

import java.io.Serial;
import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Activity {
    @Serial
    private static final long serialVersionUID = 1;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private ActivityType type;
    private LocalDate date;
    private long time; // Time in seconds
    private long distance; // Distance in meters

    public Activity() {
    }

    public Activity(String name, ActivityType type, LocalDate date, long time, long distance) {
        this.name = name;
        this.type = type;
        this.date = date;
        this.time = time;
        this.distance = distance;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public void setDate(String date) {
        this.date = LocalDate.parse(date);
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }

    public long getDistance() {
        return distance;
    }

    public void setDistance(long distance) {
        this.distance = distance;
    }

    public ActivityType getType() {
        return type;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setType(ActivityType type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Activity{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type=" + type +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Activity activity = (Activity) obj;

        if (id != activity.id) return false;
        if (name != null ? !name.equals(activity.name) : activity.name != null) return false;
        return type == activity.type;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        return result;
    }
}
