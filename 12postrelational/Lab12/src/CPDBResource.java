import models.HouseholdEntity;
import models.PersonEntity;
import models.PersonteamEntity;
import models.TeamEntity;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceContextType;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.POST;
import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
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
@LocalBean
@Path("cpdb")
public class CPDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext(unitName = "CPDBResource", type = PersistenceContextType.TRANSACTION)
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

    /**
     * POST a new person using the criteria query API.
     *
     * @param person the person object to create
     */
    @POST
    @Path("person")
    @Consumes(MediaType.APPLICATION_JSON)
    public void createPerson(PersonEntity person){
        em.persist(person);
    }

    /**
     * PUT a person to update/create using the criteria query API.
     * Upsert logic is implemented in the merge method
     *
     * @param person the person object to update/create
     */
    @PUT
    @Path("person")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updatePerson(PersonEntity person) {
        if(person != null){
            em.merge(person);
        }
    }

    /**
     * DELETE a person using the criteria query API.
     *
     * @param id the id of the person to delete
     */
    @DELETE
    @Path("person/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void deletePerson(@PathParam("id") long id) {
        PersonEntity person = em.find(PersonEntity.class, id);
        if(person != null){
            em.remove(person);
        }
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
        List<PersonEntity> personList = em.createQuery(em.getCriteriaBuilder().createQuery(PersonEntity.class)).getResultList();
        for(int i = 0; i < personList.size(); i++) {
            if(personList.get(i).getName().getId() != id){
                personList.remove(i);
            }
        }
        return personList;
    }

    /**
     * GET a list of people on a team
     *
     * @param teamname the name of the team to retrieve
     * @return a list of people
     */
    @GET
    @Path("team/{teamname}/people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PersonEntity> getPeopleOnTeam(@PathParam("teamname") String teamname) {
        // get all personIds from personteam table where teamname = teamname
        List<PersonteamEntity> personteam = em.createQuery(em.getCriteriaBuilder().createQuery(PersonteamEntity.class)).getResultList();
        ArrayList<Long> personIds = new ArrayList<>(personteam.size());
        for(int i = 0; i < personteam.size(); i++) {
            if(personteam.get(i).getTeamname() == teamname){
                personIds.add(personteam.get(i).getPersonid());
            }
        }

        // get all people whose ids are in the personIds list
        List<PersonEntity> personList = em.createQuery(em.getCriteriaBuilder().createQuery(PersonEntity.class)).getResultList();
        for(int i = 0; personList.get(i)==null; i++) {
            if(personIds.contains(personList.get(i).getId())){
                personList.remove(i);
                i--;
            }
        }

        return personList;
    }

    /**
     * GET all teams of a person using the criteria query API.
     *
     * @param personid the id of the person to retrieve teams for
     * @return a list of all team records for a specific person
     */
    @GET
    @Path("person/{personid}/teams")
    @Produces(MediaType.APPLICATION_JSON)
    public List<TeamEntity> getTeamsOfPerson(@PathParam("personid") long personid) {
        // get all teamnames from personteam table where personid = id
        List<PersonteamEntity> personteam = em.createQuery(em.getCriteriaBuilder().createQuery(PersonteamEntity.class)).getResultList();
        ArrayList<String> teamnames = new ArrayList<>(personteam.size());
        for(int i = 0; i < personteam.size(); i++) {
            if(personteam.get(i).getPersonid() == personid){
                teamnames.add(personteam.get(i).getTeamname());
            }
        }

        // get all teams whose teamnames are within the teamnames list
        List<TeamEntity> teamList = em.createQuery(em.getCriteriaBuilder().createQuery(TeamEntity.class)).getResultList();
        for(int i = 0; teamList.get(i)==null; i++ ) {
            if(!teamnames.contains(teamList.get(i).getName())){
                teamList.remove(i);
                i--;
            }
        }

        return teamList;
    }
}