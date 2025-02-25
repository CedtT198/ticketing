package model;

import java.time.LocalDateTime;

public class HistoReservation {
    Integer idHistoReservation;
    LocalDateTime dateHistoReservation;
    Double prix;
    Integer idVol;
    Integer idUtilisateur;

    public HistoReservation() {}
    public HistoReservation(Integer idHistoReservation, LocalDateTime dateHistoReservation, Double prix, Integer idVol, Integer idUtilisateur) {
        this.idHistoReservation = idHistoReservation;
        this.dateHistoReservation = dateHistoReservation;
        this.prix = prix;
        this.idVol = idVol;
        this.idUtilisateur = idUtilisateur;
    }

    public Integer getIdHistoReservation() {
        return idHistoReservation;
    }

    public void setIdHistoReservation(Integer idHistoReservation) {
        this.idHistoReservation = idHistoReservation;
    }

    public LocalDateTime getDateHistoReservation() {
        return dateHistoReservation;
    }

    public void setDateHistoReservation(LocalDateTime dateHistoReservation) {
        this.dateHistoReservation = dateHistoReservation;
    }

    public Double getPrix() {
        return prix;
    }

    public void setPrix(Double prix) {
        this.prix = prix;
    }

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(Integer idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }
}
