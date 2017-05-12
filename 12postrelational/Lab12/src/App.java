import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by djm43 on 4/27/2017.
 */
// Base URI
@ApplicationPath("/")
public class App extends javax.ws.rs.core.Application{
    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add( CPDBResource.class );
        return h;
    }
}
