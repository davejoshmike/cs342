package models;

import javax.persistence.*;

/**
 * Created by djm43 on 5/1/2017.
 */
@Entity
@Table(name = "TEAM", schema = "CPDB", catalog = "")
public class TeamEntity {
    private String name;
    private String mandate;

    @Id
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "MANDATE")
    public String getMandate() {
        return mandate;
    }

    public void setMandate(String mandate) {
        this.mandate = mandate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TeamEntity that = (TeamEntity) o;

        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (mandate != null ? !mandate.equals(that.mandate) : that.mandate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = name != null ? name.hashCode() : 0;
        result = 31 * result + (mandate != null ? mandate.hashCode() : 0);
        return result;
    }
}
