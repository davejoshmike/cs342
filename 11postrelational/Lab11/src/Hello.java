import javax.ws.rs.*;
import javax.ws.rs.core.Context;

/**
 * Created by djm43 on 4/21/2017.
 */
@Path("/hello/api")
public class Hello {
    private String x;

    @GET
    @Produces({"text/plain", "application/json"})
    public String getAllMessage() {
        return "Getting... ";
    }

    @GET
    @Path("/{x}")
    @Produces({"text/plain", "application/json"})
    public String getMessage(@PathParam("x") String x) {
        return "Getting: " + x;
    }

    @PUT
    @Path("/{x}")
    @Consumes({"text/plain", "application/json"})
    @Produces({"text/plain", "application/json"})
    public String setMessage(@PathParam("x") String x) {
        this.x = x;
        return "Putting: " + x;
    }

    @POST
    @Consumes({"text/plain", "application/json"})
    @Produces({"text/plain", "application/json"})
    public String postMessage(String x) {
        this.x = x;
        return "Posting: " + x;
    }

    @DELETE
    @Path("/{x}")
    @Consumes({"text/plain", "application/json"})
    @Produces({"text/plain", "application/json"})
    public String deleteMessage(@PathParam("x") String x) {
        String message = "Deleting: " + x;
        this.x = null;
        return message;
    }
}
