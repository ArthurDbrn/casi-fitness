package resources;

import java.net.URI;
import java.util.List;

import dto.StatRequest;
import model.Activity;
import service.ActivityService;
import jakarta.inject.Inject;

import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;

@Path("/activity")
public class ActivityResource {
    @Inject
    ActivityService activityService;

    public ActivityResource() {
    }

    @GET
    public List<Activity> getActivities() {
        return activityService.getActivities();
    }

    @POST
    @Path("/add")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addActivity(@FormParam("name") String name, @FormParam("type") String type,
            @FormParam("date") String date, @FormParam("time") long time, @FormParam("distance") long distance) {
        activityService.addActivity(name, type, date, time, distance);
        return Response.temporaryRedirect(URI.create("/app/activities.jsp")).build();
    }

    @POST
    @Path("/distanceCovered")
    @Consumes(MediaType.APPLICATION_JSON)
    public List<Object[]> getDistanceCovered(StatRequest request) {
        String from = request.getFrom();
        String to = request.getTo();
        String granularity = request.getGranularity();
        String type = request.getType();
        return activityService.getDistanceCovered(from, to, granularity, type);
    }

    @POST
    @Path("/timeSpent")
    @Consumes(MediaType.APPLICATION_JSON)
    public List<Object[]> getTimeSpent(StatRequest request) {
        String from = request.getFrom();
        String to = request.getTo();
        String granularity = request.getGranularity();
        String type = request.getType();
        return activityService.getTimeSpent(from, to, granularity, type);
    }
}
