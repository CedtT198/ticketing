package controller;

import java.sql.Connection;
import Annotation.Controller;
import Annotation.Post;
import Annotation.RequestObject;
import model.NombreSiege;
import model.Promotion;
import model.Avion;
import util.Connexion;
import util.ModelAndView;
import util.MySession;

@Controller(value="promotion")
public class PromotionController {
    
    @Post("insertPromotion")
    public ModelAndView insertPromotion(@RequestObject Promotion promotion, MySession session) {
        ModelAndView m = new ModelAndView("promotion.jsp");

        try (Connection c = Connexion.getConnection()) {
            Avion avion = Avion.getById(c, promotion.getIdVol());
            boolean response = NombreSiege.checkLeftSiege(avion.getIdAvion(), promotion.getIdTypeSiege(), promotion.getNombreSiege());
            if (response) {
                promotion.save(c);
                m.addObject("success", "Insertion done successfuly.");
            }
            else {
                m.addObject("error", "Le nombre de siege a promouvoir ne doit pas etre superieur au nombre de siege de Type "+promotion.getIdTypeSiege()+" dans l\'avion.");
            }
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        return m;
    }
    
}
