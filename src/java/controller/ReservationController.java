package controller;

import java.sql.Connection;
import java.time.LocalDateTime;
import Annotation.Controller;
import Annotation.Post;
import Annotation.RequestObject;
import model.HistoReservation;
import model.Utilisateur;
import util.Connexion;
import util.ModelAndView;
import util.MySession;

@Controller(value="reservation")
public class ReservationController {

    @Post("reserver")
    public ModelAndView reserver(@RequestObject HistoReservation histoReservation,
    @RequestObject Utilisateur utilisateur, MySession session) {
        ModelAndView m = new ModelAndView("reservation-vol.jsp");

        try (Connection c = Connexion.getConnection()) {
            Utilisateur u = utilisateur.save(c);
            histoReservation.setIdUtilisateur(u.getIdUtilisateur());
            histoReservation.setDateHistoReservation(LocalDateTime.now());
            histoReservation.save(c);
            m.addObject("success", "Insertion done successfuly.");
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        return m;
    }
}
