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

@Controller(value="constraintAnnulation")
public class ConstraintAnnulationController {
    
    @Post("insertConstraintAnnulation")
    public ModelAndView insertConstraintAnnulation(@RequestParam("idVol") Integer idVol, @RequestObject ConstraintAnnulation constraintAnnulation, MySession session) {
        ModelAndView m = new ModelAndView("const-annulation.jsp");

        System.out.print(idVol);
        System.out.print(constraintAnnulation.getHeureAvantVol());

        try (Connection c = Connexion.getConnection()) {
            Vol vol = Vol.getById(c, idVol);
            // Vol vol = Vol.getById(c, 1);

            ConstraintAnnulation ca = constraintAnnulation.save(c);
            vol.setIdConstraintAnnulation(ca.getIdConstraintAnnulation());
            Vol.update(idVol, vol);
            // Vol.update(1, vol);
            m.addObject("success", "Insertion done successfuly.");
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        return m;
    }
    
}
