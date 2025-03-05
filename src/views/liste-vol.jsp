<%@page import="model.Vol" %>
<%@page import="model.Ville" %>
<%@page import="model.Avion" %>
<%@page import="model.ConstraintAnnulation" %>
<%@page import="model.ConstraintReservation" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<%@include file="header.jsp"%>

<%
    List<Ville> villes = Ville.getAll();
    List<Avion> avions = Avion.getAll();

    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    if (vols == null) {
        vols = Vol.getAll();
    }
%>

<div class="container">
    <p>Filter multi-critere :
    <div class="mt-3">
        <button type="button" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#filter">Filter</button>
        <div class="modal fade" id="filter" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form action="filterByVille" method="get">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel1">Filter form</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <label class="col-sm-2 col-form-label" for="dateVol">Date vol</label>
                                <div class="col-sm-10">
                                    <input type="datetime-local" class="form-control" id="dateVol" name="dateVol" required/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col mb-6">
                                    <label class="col-sm-2 col-form-label" for="idVilleDepart">Ville depart</label>
                                    <div class="col-sm-12">
                                        <select class="form-control" id="idVilleDepart" name="idVilleDepart" required>
                                            <% for (Ville ville : villes) { %>
                                                <option value="<%= ville.getIdVille() %>"><%= ville.getNomVille() %></option>
                                            <% }%>
                                        </select>
                                    </div>
                                </div>
                                <div class="col mb-6">
                                    <label class="col-sm-2 col-form-label" for="idVilleArrivee">Ville d'arrivee</label>
                                    <div class="col-sm-12">
                                        <select class="form-control" id="idVilleArrivee" name="idVilleArrivee" required>
                                            <% for (Ville ville : villes) { %>
                                                <option value="<%= ville.getIdVille() %>"><%= ville.getNomVille() %></option>
                                            <% }%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="row">
                                        <p>Avec promotion : </p>
                                        <div class="col mb-4">
                                            <label class="col-sm-12 col-form-label" for="avecPromotionTout">Tout</label>
                                            <input type="radio" id="avecPromotionTout" name="avecPromotion" required/>   
                                        </div>

                                        <div class="col mb-4">
                                            <label class="col-sm-12 col-form-label" for="avecPromotionOui">Oui</label>
                                            <input type="radio" id="avecPromotionOui" name="avecPromotion" required/>   
                                        </div>

                                        <div class="col mb-4">
                                            <label class="col-sm-12 col-form-label" for="avecPromotionNon">Non</label>
                                            <input type="radio" id="avecPromotionNon" name="avecPromotion" required/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-success">Filter</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<br>

<div  class="container">
    <% String error = (String) request.getAttribute("error"); 
    String success = (String) request.getAttribute("success"); 
    if (error != null && !error.isEmpty()) { %>
        <div class="alert alert-danger" role="alert">
            <strong>Erreur </strong> : <%= error %>
        </div>
    <% } if (success != null && !success.isEmpty()) {  %>
        <div class="alert alert-success" role="alert">
            <%= success %>
        </div>
    <% } %>
</div>

<div class="card">
    <div class="table-responsive text-nowrap">
        <table class="table">
            <thead class="table-dark">
                <tr>
                    <th>id vol</th>
                    <th>Date</th>
                    <th>Avion</th>
                    <th>Depart</th>
                    <th>Destination</th>
                    <%-- <th>Date Limite d'annulation</th>
                    <th>Limite de reservation</th> --%>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="table-border-bottom-0">
                <% for (Vol vol : vols) {%>
                    <tr>
                        <td><i class="fab fa-angular fa-lg text-danger me-3"></i><%= vol.getIdVol() %></td>
                        <td><%= vol.getDateVol() %></td>
                        <td><%= Avion.getById(vol.getIdAvion()).getModele() %></td>
                        <td><%= Ville.getById(vol.getIdVille()).getNomVille() %></td>
                        <td><%= Ville.getById(vol.getIdVille_1()).getNomVille() %></td>
                        <% if (vol.getIdConstraintReservation() != null) { %>
                            <td><%= ConstraintReservation.getById(vol.getIdConstraintReservation()).getHeureAvantVol() %>H avant vol</td>
                        <% } else { %>
                            <%-- <td></td> --%>
                        <% } %>
                        <% if (vol.getIdConstraintAnnulation() != null) { %>
                            <td><%= ConstraintAnnulation.getById(vol.getIdConstraintAnnulation()).getHeureAvantVol() %>H avant vol</td>
                        <% } else { %>
                            <%-- <td></td> --%>
                        <% } %>
                        <td>
                            <div class="col-lg-4 col-md-6">
                                <div class="mt-3">
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#update<%= vol.getIdVol() %>">Update</button>
                                    <div class="modal fade" id="update<%= vol.getIdVol() %>" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <form action="updateVol" method="post">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel1">Update form</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="col mb-12">
                                                                <label class="col-sm-2 col-form-label" for="dateVol">Date vol</label>
                                                                <div class="col-sm-12">
                                                                    <input type="hidden" name="idVol" id="idVol" value="<%= vol.getIdVol() %>">
                                                                    <input type="datetime-local" class="form-control" id="dateVol" name="vol.dateVol" value="<%= vol.getDateVol() %>" required/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row g-2">
                                                            <div class="col mb-0">
                                                                <select class="form-control" id="idAvion" name="vol.idAvion" required>
                                                                    <% for (Avion avion : avions) {
                                                                        if (vol.getIdAvion() == avion.getIdAvion()) { %>
                                                                            <option value="<%= avion.getIdAvion() %>" selected><%= avion.getModele() %></option>
                                                                        <% } else { %>
                                                                            <option value="<%= avion.getIdAvion() %>"><%= avion.getModele() %></option>
                                                                        <% }
                                                                    } %>
                                                                </select>
                                                            </div>
                                                            <div class="col mb-0">
                                                                <select class="form-control" id="idVille" name="vol.idVille" required>
                                                                    <% for (Ville ville : villes) { 
                                                                        if (vol.getIdVille() == ville.getIdVille()) { %>
                                                                            <option value="<%= ville.getIdVille() %>" selected><%= ville.getNomVille() %></option>
                                                                        <% } else { %>
                                                                            <option value="<%= ville.getIdVille() %>"><%= ville.getNomVille() %></option>
                                                                        <% }
                                                                    } %>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-success">Save changes</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="mt-3">
                                <button class="btn btn-danger" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBottom<%= vol.getIdVol() %>" aria-controls="offcanvasBottom<%= vol.getIdVol() %>">Delete</button>
                                <div class="offcanvas offcanvas-bottom" tabindex="-1" id="offcanvasBottom<%= vol.getIdVol() %>" aria-labelledby="offcanvasBottomLabel">
                                    <div class="offcanvas-header">
                                        <h5 id="offcanvasBottomLabel" class="offcanvas-title">Delete vol</h5>
                                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                    </div>
                                    <div class="offcanvas-body">
                                        <ul>Voulez-vous vraiment supprimer ce Vol ?
                                                <%-- <li>id : <%= vol.getIdVol() %></li> --%>
                                                <li>Date : <%= vol.getDateVol() %></li>
                                                <li>Ville destination : <%= Ville.getById(vol.getIdVille()).getNomVille() %></li>
                                                <%-- <li>Avion : <%= Avion.getById(vol.getIdAvion()).getModele() %></li> --%>
                                            </ul>
                                        </p>
                                        <form action="deleteVol" method="post">
                                            <input type="hidden" name="idVol" id="idVol" value="<%= vol.getIdVol() %>">
                                            <button type="submit" class="btn btn-success me-2">Confirm</button>
                                            <button type="button" class="btn btn-outline-danger" data-bs-dismiss="offcanvas">Cancel</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<%@include file="footer.jsp"%>