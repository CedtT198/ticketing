package controller;

import java.sql.Connection;
import java.util.List;
import Annotation.Controller;
import Annotation.Get;
import Annotation.RequestParam;
import util.Connexion;
import util.ModelAndView;
import util.MySession;
import model.Vol;
import model.Admin;

@Controller(value="filter")
public class FilterController {
    @Get("filterByVille")
    public ModelAndView auth(@RequestParam("idVille") Integer idVille, MySession session) {
        Admin admin = (Admin) session.get("admin");
        System.out.println(admin.getUsername());

        ModelAndView m = new ModelAndView("liste-vol.jsp");

        try (Connection c = Connexion.getConnection()) {
            List<Vol> vols = Vol.getAllFilteredByIdVille(idVille);
            m.addObject("vols", vols);
            m.addObject("success", "Filtered successfuly");
        } catch (Exception e) {
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }

        return m;
    }
}
