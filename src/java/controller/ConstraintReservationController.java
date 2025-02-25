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
    
    @Post("insertConstraintReservation")
    public ModelAndView insertConstraintReservation(@RequestParam("idVol") Integer idVol, @RequestObject ConstraintReservation constraintReservation, MySession session) {
        ModelAndView m = new ModelAndView("const-reservation.jsp");

        try (Connection c = Connexion.getConnection()) {
            Vol vol = Vol.getById(idVol);

            ConstraintReservation cr = constraintReservation.save(c);
            if (cr.getHeureAvantVol().isAfter(vol.getDateVol()) || cr.getHeureAvantVol().isEqual(vol.getDateVol())) {
                vol.setIdConstraintReservation(cr.getIdConstraintReservation());
                Vol.update(idVol, vol);
                m.addObject("success", "Insertion done successfuly.", session);
            }
            else {
                m.addObject("error", "L\'heure limite de reservation ne doit pas etre superieur ou egale au date de depart.", session);
            }

        } catch (Exception e) {
            m.addObject("error", e.getMessage(), session);
            e.printStackTrace();
        }
        return m;
    }
    
}
