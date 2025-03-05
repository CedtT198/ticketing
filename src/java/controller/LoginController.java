package controller;

import java.sql.Connection;
import java.sql.SQLException;
import Annotation.Controller;
import Annotation.Post;
import Annotation.RequestObject;
import model.Admin;
import util.ModelAndView;
import util.MySession;
import util.Connexion;

@Controller(value="login")
public class LoginController {
    
    @Post("auth")
    public ModelAndView auth(@RequestObject Admin admin, MySession session) {
        ModelAndView m = new ModelAndView("insert-vol.jsp");

        try (Connection c = Connexion.getConnection()) {
            Integer idAdmin = admin.auth(c);    
            admin.setIdAdmin(idAdmin);
            session.add("admin", admin);
            // m.addObject("success", "Connected successfuly.");
        }
        catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        catch(Exception e) {
            m.setUrl("login.jsp");
            m.addObject("error", e.getMessage());
            e.printStackTrace();
        }
        
        return m;
    }
}
