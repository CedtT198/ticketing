<%@page import="model.Avion" %>
<%@page import="model.ConstraintReservation" %>
<%@page import="model.ConstraintAnnulation" %>
<%@page import="model.Vol" %>
<%@page import="model.Ville" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<%@include file="headerFront.jsp"%>

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
                                        <div class="col mb-6">
                                            <label class="col-sm-6 col-form-label" for="avecPromotionTout">Tout</label>
                                            <input type="radio" id="avecPromotionTout" name="avecPromotion" required/>   
                                        </div>

                                        <div class="col mb-6">
                                            <label class="col-sm-6 col-form-label" for="avecPromotionOui">Oui</label>
                                            <input type="radio" id="avecPromotionOui" name="avecPromotion" required/>   
                                        </div>

                                        <div class="col mb-6">
                                            <label class="col-sm-6 col-form-label" for="avecPromotionNon">Non</label>
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

<div class="row">
    <% for (Vol vol : vols) {%>
        <div class="col-md-12">
            <div class="nav-align-top mb-4">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <button type="button" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-detail-vol<%= vol.getIdVol() %>" aria-controls="navs-top-detail-vol<%= vol.getIdVol() %>" aria-selected="true">
                            Details vol <%= vol.getIdVol() %>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-eco<%= vol.getIdVol() %>" aria-controls="navs-top-eco<%= vol.getIdVol() %>" aria-selected="false">
                            Economique
                        </button>
                    </li>
                    <li class="nav-item">
                        <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-business<%= vol.getIdVol() %>" aria-controls="navs-top-business<%= vol.getIdVol() %>" aria-selected="false">
                            Business
                        </button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="navs-top-detail-vol<%= vol.getIdVol() %>" role="tabpanel">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <strong>Date et heure vol: <%= vol.getDateVol() %></strong>
                                </div>
                                <div class="col-md-12">Avion: <%= Avion.getById(vol.getIdAvion()).getModele() %></div>
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-12"><%= Ville.getById(vol.getIdVille()).getNomVille() %> - <%= Ville.getById(vol.getIdVille_1()).getNomVille() %></div>
                            </div>
                            <div class="col-md-4">
                                <% if (vol.getIdConstraintReservation() != null) { %>
                                    <div class="col-md-12">
                                        <span class="badge bg-label-warning me-1">
                                            Reserver des maintenant, <strong><%= ConstraintReservation.getById(vol.getIdConstraintReservation()).getHeureAvantVol() %>H</strong> reste
                                        </span>
                                    </div>
                                <% }  if (vol.getIdConstraintAnnulation() != null) { %>
                                    <div class="col-md-12">
                                        <span class="badge bg-label-danger me-1">
                                            Encore, il vous reste<strong> <%= ConstraintAnnulation.getById(vol.getIdConstraintAnnulation()).getHeureAvantVol() %>H</strong> pour annuler
                                        </span>
                                    </div>
                                <% } if (vol.getIdConstraintAnnulation() == null && vol.getIdConstraintReservation() == null) { %>
                                    <div>
                                        <span class="badge bg-label-primary me-1">Toujours reservable.</span>
                                    </div>
                                <% } %>
                            </div>
                            <div class="col-md-4">
                                <% List<Promotion> prom = Promotion.getAllByVol(vol.getIdVol());
                                 if (prom.size() == 0) { %>
                                    <div>
                                        <span class="badge bg-label-primary me-1">Aucune promotion pour ce vol.</span>
                                    </div>
                                <% } else { %>
                                    <div>
                                        <span class="badge bg-label-success me-1">Promotion(s) disponible pour ce vol.</span>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="navs-top-eco<%= vol.getIdVol() %>" role="tabpanel">
                        <div class="row">
                            <div class="col-md-8">
                                Billet classe <strong>Economique</strong> depart ... pour la ...
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <h3>0.00$</h3>
                                </div>
                                <div class="col-md-12">
                                    <form action="reserver" method="post">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <input type="hidden" name="idVol" id="idVol" value="<%= vol.getIdVol() %>">
                                                <input type="hidden" name="idTypeSiege" id="idTypeSiege" value="1">
                                                <input type="text" class="form-control" name="nom" id="nom" placeholder="Entrer le nom auquel vous enregistreriez votre reservation.">
                                            </div>
                                            <div class="col-md-4">
                                                <button type="submit" class="btn btn-outline-info">Reserver</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="navs-top-business<%= vol.getIdVol() %>" role="tabpanel"> 
                        <div class="row">
                            <div class="col-md-8">
                                Billet classe <strong>Business</strong> depart ... pour la ...
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <h3>0.00$</h3>
                                </div>
                                <div class="col-md-12">
                                    <form action="reserver" method="post">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <input type="hidden" name="idVol" id="idVol" value="<%= vol.getIdVol() %>">
                                                <input type="hidden" name="idTypeSiege" id="idTypeSiege" value="2">
                                                <input type="text" class="form-control" name="nom" id="nom" placeholder="Entrer le nom auquel vous enregistreriez votre reservation.">
                                            </div>
                                            <div class="col-md-4">
                                                <button type="submit" class="btn btn-outline-info">Reserver</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div><br>
    <% } %>
</div>

<%@include file="footer.jsp"%>