package controller;

import Annotation.Controller;
import Annotation.Get;
import util.ModelAndView;
import util.MySession;

@Controller(value="logout")
public class LogOutController {
    
    @Get("signout")
    public ModelAndView signout(MySession session) {
        ModelAndView m = new ModelAndView("login.jsp");
        session.delete("admin");
        m.addObject("success", "Logged out successfuly.");
        return m;
    }
}
