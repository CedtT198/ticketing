<%@page import="model.Avion" %>
<%@page import="model.Ville" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<%@include file="header.jsp"%>

<div class="row">
    <div class="card mb-4">
        <div class="card-header d-flex align-items-center justify-content-between">
            <h5 class="mb-0">Formulaire d'insertion</h5>
            <small class="text-muted float-end">Vol</small>
        </div>
        <div class="card-body">
            <form action="insertVol" method="post">
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="dateVol">Date vol</label>
                    <div class="col-sm-10">
                        <input type="datetime-local" class="form-control" id="dateVol" name="Vol.dateVol" required/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="idAvion">Avion</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="idAvion" name="Vol.idAvion" required>
                            <% List<Avion> avions = Avion.getAll();
                            for (Avion avion : avions) {%>
                                <option value="<%= avion.getIdAvion() %>"><%= avion.getModele() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="idVille">Ville de depart</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="idVille" name="Vol.idVille" required>
                            <% List<Ville> villes = Ville.getAll();
                            for (Ville ville : villes) {%>
                                <option value="<%= ville.getIdVille() %>"><%= ville.getNomVille() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="idVille_1">Ville d'arrivee</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="idVille_1" name="Vol.idVille_1" required>
                            <% for (Ville ville : villes) {%>
                                <option value="<%= ville.getIdVille() %>"><%= ville.getNomVille() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div>
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
                <div class="row justify-content-end">
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Insert</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%@include file="footer.jsp"%>