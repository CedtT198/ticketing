package controller;

import java.sql.Connection;
import Annotation.Controller;
import Annotation.Post;
import Annotation.RequestObject;
import Annotation.RequestParam;
import model.ConstraintAnnulation;
import model.Vol;
import util.Connexion;
import util.ModelAndView;
import util.MySession;

@Controller(value="ConstraintAnnulation")
public class ConstraintAnnulationController {
    
    @Post("insertConstraintAnnulation")
    public ModelAndView insertConstraintAnnulation(@RequestParam("idVol") Integer idVol, @RequestObject ConstraintAnnulation constraintAnnulation, MySession session) {
        ModelAndView m = new ModelAndView("const-annulation.jsp");

        try (Connection c = Connexion.getConnection()) {
            Vol vol = Vol.getById(idVol);

            ConstraintAnnulation ca = constraintAnnulation.save(c);
            if (ca.getHeureAvantVol().isAfter(vol.getDateVol()) || ca.getHeureAvantVol().isEqual(vol.getDateVol())) {
                vol.setIdConstraintAnnulation(ca.getIdConstraintAnnulation());
                Vol.update(idVol, vol);
                m.addObject("success", "Insertion done successfuly.", session);
            }
            else {
                m.addObject("error", "L\'heure limite de l\'annulation d\'un vol deja reserve ne doit pas etre superieur ou egale au date de depart.", session);
            }
        } catch (Exception e) {
            m.addObject("error", e.getMessage(), session);
            e.printStackTrace();
        }
        return m;
    }
    
}
