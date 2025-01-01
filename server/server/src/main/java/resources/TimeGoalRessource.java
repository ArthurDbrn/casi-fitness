package resources;

import java.net.URI;
import java.util.List;

import jakarta.ws.rs.Produces;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import model.TimeGoal;

import service.TimeGoalService;

@Path("/timeGoals")
public class TimeGoalRessource {
    @Inject
    private TimeGoalService timeGoalService;
    
    public TimeGoalRessource() {
    }

    @GET
    @Path("/get")
    public List<TimeGoal> getTimeGoals() {
        timeGoalService.updateGoals();
        return timeGoalService.getGoals();
    }

    @GET
    @Path("/getActive")
    public List<TimeGoal> getActiveTimeGoals() {
        timeGoalService.updateGoals();
        return timeGoalService.getActiveTimeGoals();
    }

    @GET
    @Path("/getFuture")
    public List<TimeGoal> getFutureTimeGoals() {
        timeGoalService.updateGoals();
        return timeGoalService.getFutureTimeGoals();
    }

    @GET
    @Path("/getFailed")
    public List<TimeGoal> getFailedTimeGoals() {
        timeGoalService.updateGoals();
        return timeGoalService.getFailedTimeGoals();
    }

    @GET
    @Path("/getCompleted")
    public List<TimeGoal> getCompletedTimeGoals() {
        timeGoalService.updateGoals();
        return timeGoalService.getCompletedTimeGoals();
    }

    @POST
    @Path("/add")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addGoal(@FormParam("name") String name, @FormParam("startDate") String startDate,
            @FormParam("endDate") String endDate, @FormParam("target") long target) {
        timeGoalService.addGoal(name, startDate, endDate, target);
        return Response.temporaryRedirect(URI.create("/app/goals.jsp")).build();
    }
}
