import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

/**
 * Created by djm43 on 4/21/2017.
 */
@Path("/hello")
public class Hello {
    @GET

    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello!";
    }
}
