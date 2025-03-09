<%@page import="model.Avion" %>
<%@page import="model.Vol" %>
<%@page import="model.Billet" %>
<%@page import="model.Promotion" %>
<%@page import="model.Ville" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<%@include file="headerFront.jsp"%>

<%
    List<Ville> villes = Ville.getAll();
    List<Avion> avions = Avion.getAll();

    // List<Billet> vols = (List<Vol>) request.getAttribute("billets");
    // if (vols == null) {
        List<Billet> vols = Billet.getAll();
    // }
%>

<div class="container">
    <p>Filtre multi-critere :
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
    <% for (int i=0; i < vols.size(); i+=2) {
        Billet eco = vols.get(i);
        Billet bus = vols.get(i+1);
    %>
        <div class="col-md-12">
            <div class="nav-align-top mb-4">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <button type="button" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-detail-vol<%= eco.getIdVol() %>" aria-controls="navs-top-detail-vol<%= eco.getIdVol() %>" aria-selected="true">
                            Details vol <%= eco.getIdVol() %>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-eco<%= eco.getIdVol() %>" aria-controls="navs-top-eco<%= eco.getIdVol() %>" aria-selected="false">
                            Economique
                        </button>
                    </li>
                    <li class="nav-item">
                        <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-business<%= eco.getIdVol() %>" aria-controls="navs-top-business<%= eco.getIdVol() %>" aria-selected="false">
                            Business
                        </button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="navs-top-detail-vol<%= eco.getIdVol() %>" role="tabpanel">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="col-md-12"><strong>Date vol: </strong><%= eco.getDateOnly() %></div>
                                <div class="col-md-12"><strong>Heure: </strong><%= eco.getTimeOnly() %></div>
                                <div class="col-md-12"><strong>Avion:</strong> <%= eco.getModele() %></div>
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <strong>Depart: </strong><%= eco.getDepart() %>
                                    <br>to<br>
                                    <strong>Destination: </strong><%= eco.getDestination() %>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <% if (eco.getHeureAvantReservation() != null && eco.getHeureAvantReservation() != 0) { %>
                                    <div class="col-md-12">
                                        <span class="badge bg-label-warning me-1">
                                            Reserver des maintenant, <strong><%= eco.getHeureAvantReservation() %>H</strong> reste
                                        </span>
                                    </div>
                                <% } else { %>
                                    <div class="col-md-12">
                                        <span class="badge bg-label-primary me-1">Toujours reservable</span>
                                    </div>
                                <% }  if (eco.getHeureAvantAnnulation() != null && eco.getHeureAvantReservation() != 0) { %>
                                    <div class="col-md-12">
                                        <span class="badge bg-label-danger me-1">
                                            Il vous reste<strong> <%= eco.getHeureAvantAnnulation() %>H</strong> pour annuler
                                        </span>
                                    </div>
                                <%-- <% } if (eco.getNbProm() == 0 && bus.getNbProm() == 0) { %>
                                    <div class="col-md-12">
                                        <span class="badge bg-label-primary me-1">Aucune promotion pour ce vol</span>
                                    </div>
                                <% } else { %>
                                    <div class="col-md-12">
                                        <span class="badge bg-label-success me-1">Promotion(s) disponible pour ce vol</span>
                                    </div> --%>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="navs-top-eco<%= eco.getIdVol() %>" role="tabpanel">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <h3>
                                        Billet classe <strong>Economique</strong>
                                    </h3>
                                </div>
                                <div class="col-md-12">
                                    Reste de place disponible: <%= eco.getResteSiege() %>/<%= eco.getNbSiegeTotal() %>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <% if (eco.getNbProm() != 0) { %>
                                    <span class="badge bg-label-success me-1"><%= eco.getResteSiegeProm() %>/<%= eco.getNbProm() %> siege en promotion disponible</span>
                                <% } else { %>
                                    <span class="badge bg-label-primary me-1">Pas de promotion.</span>
                                <% } %>
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <% if (eco.getNbProm() == 0) { %>
                                        <h3><%= eco.getPuSiege() %></h3>
                                    <% } else { %>
                                        <h3>
                                            <s><%= eco.getPuSiege() %></s>
                                            <%= eco.getPuProm() %>
                                            <small style="font-size:16px"><span class="badge bg-dark"><%= eco.getPourcentage() %>% OFF</span></small>
                                        </h3>
                                    <% } %>
                                </div>
                                <div class="col-md-12">
                                    <form action="reserver" method="post">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <input type="hidden" name="HistoReservation.idVol" id="idVol" value="<%= eco.getIdVol() %>">
                                                <input type="hidden" name="HistoReservation.idTypeSiege" id="idTypeSiege" value="1">
                                                <% if (eco.getNbProm() == 0) { %>
                                                    <input type="hidden" name="HistoReservation.prix" id="prix" value="<%= eco.getPuSiege() %>">
                                                <% } else { %>
                                                    <input type="hidden" name="HistoReservation.prix" id="prix" value="<%= eco.getPuProm() %>">
                                                <% } %>
                                                <input type="text" class="form-control" name="Utilisateur.nom" id="nom" placeholder="Entrez votre nom" required>
                                            </div>
                                            <div class="col-md-4">
                                                <button type="submit" class="btn btn-info">Reserver</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="navs-top-business<%= bus.getIdVol() %>" role="tabpanel"> 
                        <div class="row">
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <h3>
                                        Billet classe <strong>Business</strong>
                                    </h3>
                                </div>
                                <div class="col-md-12">
                                    Reste de place disponible: <%= bus.getResteSiege() %>/<%= bus.getNbSiegeTotal() %>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <% if (bus.getNbProm() != 0) { %>
                                    <span class="badge bg-label-success me-1"><%= bus.getResteSiegeProm() %>/<%= bus.getNbProm() %> siege en promotion disponible</span>
                                <% } else { %>
                                    <span class="badge bg-label-primary me-1">Pas de promotion disponible.</span>
                                <% } %>
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <% if (bus.getNbProm() == 0) { %>
                                        <h3><%= bus.getPuSiege() %></h3>
                                    <% } else { %>
                                        <h3>
                                            <s><%= bus.getPuSiege() %></s>
                                            <%= bus.getPuProm() %>
                                            <small style="font-size:16px"><span class="badge bg-dark"><%= bus.getPourcentage() %>% OFF</span></small>
                                        </h3>
                                    <% } %>
                                </div>
                                <div class="col-md-12">
                                    <form action="reserver" method="post">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <input type="hidden" name="HistoReservation.idVol" id="idVol" value="<%= bus.getIdVol() %>">
                                                <input type="hidden" name="HistoReservation.idTypeSiege" id="idTypeSiege" value="2">
                                                <% if (bus.getNbProm() == 0) { %>
                                                    <input type="hidden" name="HistoReservation.prix" id="prix" value="<%= bus.getPuSiege() %>">
                                                <% } else { %>
                                                    <input type="hidden" name="HistoReservation.prix" id="prix" value="<%= bus.getPuProm() %>">
                                                <% } %>
                                                <input type="text" class="form-control" name="Utilisateur.nom" id="nom" placeholder="Entrez votre nom" required>
                                            </div>
                                            <div class="col-md-4">
                                                <button type="submit" class="btn btn-info">Reserver</button>
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