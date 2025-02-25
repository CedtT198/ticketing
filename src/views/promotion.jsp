<%@page import="model.Avion" %>
<%@page import="model.Vol" %>
<%@page import="model.TypeSiege" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<%@include file="header.jsp"%>

<div class="row">
    <div class="card mb-4"> 
        <div class="card-header d-flex align-items-center justify-content-between">
            <h5 class="mb-0">Formulaire de promotion</h5>
            <small class="text-muted float-end">Por siege pour un vol</small>
        </div>
        <div class="card-body">
            <form action="insertPromotion" method="post">
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="idTypeSiege">Type de siege</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="idTypeSiege" name="promotion.idTypeSiege" required>
                            <% List<TypeSiege> typeSieges = TypeSiege.getAll();
                            for (TypeSiege typeSiege : typeSieges) {%>
                                <option value="<%= typeSiege.getIdTypeSiege() %>"><%= typeSiege.getNomTypeSiege() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="idVol">Vol</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="idVol" name="promotion.idVol" required>
                            <% List<Vol> vols = Vol.getAll();
                            for (Vol vol : vols) {%>
                                <option value="<%= vol.getIdVol() %>"><%= vol.getIdVol() %> - <%= vol.getDateVol() %> - <%= Avion.getById(vol.getIdAvion()).getModele() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="nombreSiege">Nombre de siege</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="nombreSiege" name="promotion.nombreSiege" placeholder="3 siege a promouvoir par exemple." required/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="pourcentage">Valeur de la promotion</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="pourcentage" name="promotion.pourcentage" placeholder="Exprime en %. Par exemple 5% du prix habituel." required/>
                    </div>
                </div>
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