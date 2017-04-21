import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by djm43 on 4/21/2017.
 */
// Base URI
@ApplicationPath("/")
public class MyApplication extends Application {
    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add( Hello.class );
        return h;
    }
}
