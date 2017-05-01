import models.HouseholdEntity;
import models.PersonEntity;
import models.TeamEntity;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.POST;
import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

import static java.lang.System.in;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class CPDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PersonEntity getPerson(@PathParam("id") long id) {
        return em.find(PersonEntity.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PersonEntity> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(PersonEntity.class)).getResultList();
    }

    @POST
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public void updatePerson(@PathParam("id") long id, ){

    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("household/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PersonEntity> getPeopleByHousehold(@PathParam("id") long id) {
        HouseholdEntity household = em.find(HouseholdEntity.class, id);
        List<PersonEntity> personList = em.createQuery(em.getCriteriaBuilder().createQuery(PersonEntity.class)).getResultList();
        for(PersonEntity personEntity : personList){
            personEntity.getName().getId() == household.getId()
        }
        return em.find(HouseholdEntity.class, id);
    }

    /**
     * GET an individual person record.
     *
     * @param name the name of the team to retrieve
     * @return a team record
     */
    @GET
    @Path("team/{name}")
    @Produces(MediaType.APPLICATION_JSON)
    public TeamEntity getTeam(@PathParam("name") String name) {
        return em.find(TeamEntity.class, name);
    }

    /**
     * GET all teams using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all team records
     */
    @GET
    @Path("teams")
    @Produces(MediaType.APPLICATION_JSON)
    public List<TeamEntity> getTeams() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(TeamEntity.class)).getResultList();
    }
}