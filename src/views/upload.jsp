<%@include file="headerFront.jsp"%>

<div class="row">
    <div class="card mb-4">
        <div class="card-header d-flex align-items-center justify-content-between">
            <h5 class="mb-0">Formulaire d'insertion</h5>
            <small class="text-muted float-end">Upload de photo de passeport</small>
        </div>
        <div class="card-body">
            <form action="upload" method="post" enctype="multipart/form-data">
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="dateVol">Fichier</label>
                    <div class="col-sm-10">
                        <input type="file" class="form-control" id="file" name="file" required/>
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