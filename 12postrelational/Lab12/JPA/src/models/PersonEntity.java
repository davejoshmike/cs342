package models;

import javax.persistence.*;
import java.sql.Time;
import java.util.List;

/**
 * Created by djm43 on 5/1/2017.
 */
@Entity
@Table(name = "PERSON", schema = "CPDB")
public class PersonEntity {
    private long id;
    private String title;
    private String firstname;
    private String lastname;
    private String membershipstatus;
    private String gender;
    private Time birthdate;
    private String householdrole;
    private String homegrouprole;
    private HouseholdEntity name;
    private List<TeamEntity> teams;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "TITLE")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "FIRSTNAME")
    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @Basic
    @Column(name = "LASTNAME")
    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    @Basic
    @Column(name = "MEMBERSHIPSTATUS")
    public String getMembershipstatus() {
        return membershipstatus;
    }

    public void setMembershipstatus(String membershipstatus) {
        this.membershipstatus = membershipstatus;
    }

    @Basic
    @Column(name = "GENDER")
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Basic
    @Column(name = "BIRTHDATE")
    public Time getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Time birthdate) {
        this.birthdate = birthdate;
    }

    @Basic
    @Column(name = "HOUSEHOLDROLE")
    public String getHouseholdrole() {
        return householdrole;
    }

    public void setHouseholdrole(String householdrole) {
        this.householdrole = householdrole;
    }

    @Basic
    @Column(name = "HOMEGROUPROLE")
    public String getHomegrouprole() {
        return homegrouprole;
    }

    public void setHomegrouprole(String homegrouprole) {
        this.homegrouprole = homegrouprole;
    }

    @ManyToOne
    @JoinColumn(name = "HOUSEHOLDID", referencedColumnName = "ID")
    public HouseholdEntity getName() { return name; }

    public void setName(HouseholdEntity name) { this.name = name; }

    @ManyToMany
    @JoinTable(name = "PERSONTEAM", schema = "CPDB",
            joinColumns = @JoinColumn(name = "PERSONID", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "TEAMNAME", referencedColumnName = "NAME", nullable = false))
    public List<TeamEntity> getTeams() { return teams; }

    public void setTeams(List<TeamEntity> teams) { this.teams = teams; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PersonEntity that = (PersonEntity) o;

        if (id != that.id) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;
        if (firstname != null ? !firstname.equals(that.firstname) : that.firstname != null) return false;
        if (lastname != null ? !lastname.equals(that.lastname) : that.lastname != null) return false;
        if (membershipstatus != null ? !membershipstatus.equals(that.membershipstatus) : that.membershipstatus != null)
            return false;
        if (gender != null ? !gender.equals(that.gender) : that.gender != null) return false;
        if (birthdate != null ? !birthdate.equals(that.birthdate) : that.birthdate != null) return false;
        if (householdrole != null ? !householdrole.equals(that.householdrole) : that.householdrole != null)
            return false;
        if (homegrouprole != null ? !homegrouprole.equals(that.homegrouprole) : that.homegrouprole != null)
            return false;
        if (name != null ? !name.equals(that.name) : that.name != null)
            return false;
        if (teams != null ? !teams.equals(that.teams) : that.teams != null)
            return false;
        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (firstname != null ? firstname.hashCode() : 0);
        result = 31 * result + (lastname != null ? lastname.hashCode() : 0);
        result = 31 * result + (membershipstatus != null ? membershipstatus.hashCode() : 0);
        result = 31 * result + (gender != null ? gender.hashCode() : 0);
        result = 31 * result + (birthdate != null ? birthdate.hashCode() : 0);
        result = 31 * result + (householdrole != null ? householdrole.hashCode() : 0);
        result = 31 * result + (homegrouprole != null ? homegrouprole.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (teams != null ? teams.hashCode() : 0);
        return result;
    }
}
