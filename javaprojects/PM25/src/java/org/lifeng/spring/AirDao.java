/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lifeng.spring;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Administrator
 */
@Entity
@Table(name = "air")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Air.findAll", query = "SELECT a FROM Air a"),
    @NamedQuery(name = "Air.findByStation", query = "SELECT a FROM Air a WHERE a.station = :station"),
    @NamedQuery(name = "Air.findByAqi", query = "SELECT a FROM Air a WHERE a.aqi = :aqi"),
    @NamedQuery(name = "Air.findByAirquality", query = "SELECT a FROM Air a WHERE a.airquality = :airquality"),
    @NamedQuery(name = "Air.findByPollute", query = "SELECT a FROM Air a WHERE a.pollute = :pollute"),
    @NamedQuery(name = "Air.findByPm25", query = "SELECT a FROM Air a WHERE a.pm25 = :pm25"),
    @NamedQuery(name = "Air.findByPm10", query = "SELECT a FROM Air a WHERE a.pm10 = :pm10"),
    @NamedQuery(name = "Air.findByCo", query = "SELECT a FROM Air a WHERE a.co = :co"),
    @NamedQuery(name = "Air.findByNo2", query = "SELECT a FROM Air a WHERE a.no2 = :no2"),
    @NamedQuery(name = "Air.findByO3per1", query = "SELECT a FROM Air a WHERE a.o3per1 = :o3per1"),
    @NamedQuery(name = "Air.findByO3per8", query = "SELECT a FROM Air a WHERE a.o3per8 = :o3per8"),
    @NamedQuery(name = "Air.findBySo2", query = "SELECT a FROM Air a WHERE a.so2 = :so2")})
public class AirDao implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 40)
    @Column(name = "station")
    private String station;
    @Column(name = "aqi")
    private Integer aqi;
    @Size(max = 40)
    @Column(name = "airquality")
    private String airquality;
    @Size(max = 40)
    @Column(name = "pollute")
    private String pollute;
    @Column(name = "pm25")
    private Integer pm25;
    @Column(name = "pm10")
    private Integer pm10;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "co")
    private Double co;
    @Column(name = "no2")
    private Integer no2;
    @Column(name = "o3per1")
    private Integer o3per1;
    @Column(name = "o3per8")
    private Integer o3per8;
    @Column(name = "so2")
    private Integer so2;

    public AirDao() {
    }

    public AirDao(String station) {
        this.station = station;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public Integer getAqi() {
        return aqi;
    }

    public void setAqi(Integer aqi) {
        this.aqi = aqi;
    }

    public String getAirquality() {
        return airquality;
    }

    public void setAirquality(String airquality) {
        this.airquality = airquality;
    }

    public String getPollute() {
        return pollute;
    }

    public void setPollute(String pollute) {
        this.pollute = pollute;
    }

    public Integer getPm25() {
        return pm25;
    }

    public void setPm25(Integer pm25) {
        this.pm25 = pm25;
    }

    public Integer getPm10() {
        return pm10;
    }

    public void setPm10(Integer pm10) {
        this.pm10 = pm10;
    }

    public Double getCo() {
        return co;
    }

    public void setCo(Double co) {
        this.co = co;
    }

    public Integer getNo2() {
        return no2;
    }

    public void setNo2(Integer no2) {
        this.no2 = no2;
    }

    public Integer getO3per1() {
        return o3per1;
    }

    public void setO3per1(Integer o3per1) {
        this.o3per1 = o3per1;
    }

    public Integer getO3per8() {
        return o3per8;
    }

    public void setO3per8(Integer o3per8) {
        this.o3per8 = o3per8;
    }

    public Integer getSo2() {
        return so2;
    }

    public void setSo2(Integer so2) {
        this.so2 = so2;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (station != null ? station.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AirDao)) {
            return false;
        }
        AirDao other = (AirDao) object;
        if ((this.station == null && other.station != null) || (this.station != null && !this.station.equals(other.station))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.lifeng.spring.Air[ station=" + station + " ]";
    }
    
}
