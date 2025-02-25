<%@page import="model.Vol" %>
<%@page import="model.Ville" %>
<%@page import="model.Avion" %>
<%@page import="model.ConstraintAnnulation" %>
<%@page import="model.ConstraintReservation" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<%@include file="header.jsp"%>

<div class="card">
    <div>
        <% String error = (String) session.getAttribute("error"); 
        String success = (String) session.getAttribute("success"); 
        if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger" role="alert">
                <strong>Erreur </strong> : <%= error %>
            </div>
        <% } if (success != null && !success.isEmpty()) {  %>
            <div class="alert alert-success" role="alert">
                <%= success %>
            </div>
        <% } %>
        
        <% Map<String, String> errors = (Map<String, String>) session.getAttribute("errors");
            if (errors != null && !errors.isEmpty()) { %>
                <% for (Map.Entry<String, String> entry : errors.entrySet()) { %>
                <div class="alert alert-warning" role="alert">
                    <strong><%= entry.getKey() %></strong> : <%= entry.getValue() %></li>
                </div>
                <% } %>
        <% } %>
    </div>
    <div class="table-responsive text-nowrap">
        <table class="table">
            <thead class="table-dark">
                <tr>
                    <th>id vol</th>
                    <th>Date</th>
                    <th>Avion</th>
                    <th>Destination</th>
                    <%-- <th>Date Limite d'annulation</th>
                    <th>Limite de reservation</th> --%>
                    <%-- <th></th>
                    <th></th> --%>
                </tr>
            </thead>
            <tbody class="table-border-bottom-0">
                <% List<Vol> vols = Vol.getAll();
                for (Vol vol : vols) {%>
                    <tr>
                        <td><i class="fab fa-angular fa-lg text-danger me-3"></i><%= vol.getIdVol() %></td>
                        <td><%= vol.getDateVol() %></td>
                        <td><%= Avion.getById(vol.getIdAvion()).getModele() %></td>
                        <td><%= Ville.getById(vol.getIdVille()).getNomVille() %></td>
                        <%-- Ajout de differente couleur en fonction de l'heure --%>
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
                                                            <div class="col mb-6">
                                                                <label class="col-sm-2 col-form-label" for="dateVol">Date vol</label>
                                                                <div class="col-sm-10">
                                                                    <input type="hidden" name="idVol" id="idVol" value="<%= vol.getIdVol() %>">
                                                                    <input type="datetime-local" class="form-control" id="dateVol" name="vol.dateVol" value="<%= vol.getDateVol() %>" required/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row g-2">
                                                            <div class="col mb-0">
                                                                <select class="form-control" id="idAvion" name="vol.idAvion" required>
                                                                    <% List<Avion> avions = Avion.getAll();
                                                                    for (Avion avion : avions) {
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
                                                                    <% List<Ville> villes = Ville.getAll();
                                                                    for (Ville ville : villes) { 
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