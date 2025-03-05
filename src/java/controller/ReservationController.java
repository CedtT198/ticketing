package controller;

import java.sql.Connection;
import Annotation.Controller;
import Annotation.Post;
import Annotation.RequestObject;
import model.HistoReservation;
import util.Connexion;
import util.ModelAndView;
import util.MySession;

@Controller(value="reservation")
public class ReservationController {

    @Post("insertReservation")
    public ModelAndView insertReservation(@RequestObject HistoReservation histoReservation, MySession session) {
        ModelAndView m = new ModelAndView("reservation-vol.jsp");

        try (Connection c = Connexion.getConnection()) {
            // HistoReservation hr = histoReservation.save(c);
            histoReservation.save(c);
            m.addObject("success", "Insertion done successfuly.");
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        return m;
    }
}
