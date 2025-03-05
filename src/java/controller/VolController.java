package controller;

import java.sql.Connection;
import Annotation.Controller;
import Annotation.Post;
import Annotation.RequestObject;
import Annotation.RequestParam;
import model.Vol;
import util.Connexion;
import util.ModelAndView;
import util.MySession;

@Controller(value="vol")
public class VolController {
    
    // @Get("newVol")
    // public ModelAndView newVol() {
    //     ModelAndView m = new ModelAndView("insert-vol.jsp");
    //     Connection c = Connexion.getConnection();
    //     m.addObject("avions", Avion.getAll(c));
    //     m.addObject("villes", Ville.getAll(c));
    //     try {
    //         c.close();
    //     } catch (SQLException e) {
    //         e.printStackTrace();
    //     }
    //     return m;
    // }

    @Post("updateVol")
    public ModelAndView updateVol(@RequestParam("idVol") Integer idVol, @RequestObject Vol vol, MySession session) {
        ModelAndView m = new ModelAndView("liste-vol.jsp");
        try {
            Vol.update(idVol, vol);
            m.addObject("success", "Updated successfuly.");
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        return m;
    }

    @Post("deleteVol")
    public ModelAndView deleteVol(@RequestParam("idVol") Integer idVol, MySession session) {
        
        ModelAndView m = new ModelAndView("liste-vol.jsp");
        try {
            Vol.delete(idVol);
            m.addObject("success", "Suppressed successfuly.");
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        return m;
    }

    @Post("insertVol")
    public ModelAndView insertVol(@RequestObject Vol vol, MySession session) {
        ModelAndView m = new ModelAndView("insert-vol.jsp");
        // m.addObject("avions", Avion.getAll(c));
        // m.addObject("villes", Ville.getAll(c));

        try (Connection c = Connexion.getConnection()) {
            vol.save(c);
            m.addObject("success", "Insertion done successfuly.");
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        return m;
    }
    
    // @Get("getAllVol")
    // public ModelAndView getAllVol(@RequestObject Vol vol, MySession session) {
    //     ModelAndView m = new ModelAndView("liste-vol.jsp");
    //     return m;
    // }
}
