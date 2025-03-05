package controller;

import java.sql.Connection;
import Annotation.Controller;
import Annotation.Post;
import Annotation.RequestObject;
import Annotation.RequestParam;
import model.ConstraintReservation;
import model.Vol;
import util.Connexion;
import util.ModelAndView;
import util.MySession;

@Controller(value="ConstraintReservation")
public class ConstraintReservationController {
    
    @Post("insertConsRes")
    public ModelAndView insertConsRes(@RequestParam("idVol") Integer idVol, @RequestObject ConstraintReservation constraintReservation, MySession session) {
        ModelAndView m = new ModelAndView("const-reservation.jsp");

        try (Connection c = Connexion.getConnection()) {
            Vol vol = Vol.getById(c, idVol);

            ConstraintReservation cr = constraintReservation.save(c);
            vol.setIdConstraintReservation(cr.getIdConstraintReservation());
            Vol.update(idVol, vol);
            m.addObject("success", "Insertion done successfuly.");
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        return m;
    }
    
}
