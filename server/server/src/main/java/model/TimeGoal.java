package model;

import java.io.Serial;
import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class TimeGoal implements Goal {

    @Serial
    private static final long serialVersionUID = 1;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private LocalDate startDate;
    private LocalDate endDate;
    private long target;
    private GoalStatus status;
    private float completion = 0;

    public TimeGoal() {
    }

    public TimeGoal(String name, LocalDate startDate, LocalDate endDate, Long target) {
        if (startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("Start date must be before end date");
        }
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.target = target;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public long getTarget() {
        return target;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(LocalDate endDate) {
        if (startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("Start date must be before end date");
        }
        this.endDate = endDate;
    }

    public void setTarget(long target) {
        this.target = target;
    }

    public boolean isCompleted() {
        return status == GoalStatus.COMPLETED;
    }

    public boolean hasNotStarted() {
        return status == GoalStatus.NOT_STARTED;
    }

    public boolean isActive() {
        return status == GoalStatus.IN_PROGRESS;
    }

    public boolean isFailed() {
        return status == GoalStatus.FAILED;
    }

    public GoalStatus getStatus() {
        return status;
    }

    public float getCompletion() {
        return completion;
    }

    public void updateCompletion(long progress) {
        completion = (float) progress / target * 100;
    }

    public void updateStatus(long progress) {
        updateCompletion(progress);
        if (LocalDate.now().isBefore(startDate)){
            status = GoalStatus.NOT_STARTED;
        } else if (LocalDate.now().isAfter(endDate)){
            if (completion >= 100){
                status = GoalStatus.COMPLETED;
            } else {
                status = GoalStatus.FAILED;
            }
        } else {
            status = GoalStatus.IN_PROGRESS;
        }
    }

    @Override
    public String toString() {
        return "TimeGoal{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", target=" + target +
                ", status=" + status +
                ", completion=" + completion +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        TimeGoal timeGoal = (TimeGoal) obj;
        return id == timeGoal.id;
    }

    @Override
    public int hashCode() {
        return Long.hashCode(id);
    }
}
