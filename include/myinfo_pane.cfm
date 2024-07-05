 <h4>                  
 
 <cfoutput>#userFirstName# #userlastName# </cfoutput>

<span class="float-end">
  
    <a title="Update Account" data-bs-toggle="modal" data-bs-target="#remoteUpdateAccount" data-bs-original-title="Update Account"> <i class="mdi mdi-square-edit-outline"></i></a>
  
  </span>

</h4> 



  <div class="row">
    <!-- First Column: 20% Width -->
    <div class="col-md-2">
      <p class="card-text">
        <a href="/app/image-upload/?contactid=<cfoutput>#contactid#&ref_pgid=7</cfoutput>">
         <center> <figure>
            <img src="<cfoutput>#browser_user_avatar_filename#</cfoutput>?ver=<cfoutput>#rand()#</cfoutput>" class="mr-2 rounded-circle gambar img-responsive img-thumbnail" title="User ID: <cfoutput>#userid#</cfoutput>" style="max-width:120px; width:100%;" alt="profile-image" id="item-img-output" />
            <figcaption>
              <Center><cfoutput>#useravatarname#</cfoutput></center>
            </figcaption>
          </figure></center>
        </a>
      </p><form action="/recover/index.cfm">
    <p class="card-text"><center><cfoutput><input type="hidden" name="recoverid" value="#userid#" />
    </cfoutput><button type="submit" class="btn btn-xs btn-primary waves-effect mb-2 waves-light" style="background-color: #406e8e; border: #406e8e"  >Change Password</button></center>
</p>
</form>
    </div>
    
    <!-- Second Column: 80% Width -->
    <div class="col-10">
<cfoutput>
        <dl class="row">
      


          <dt class="col-sm-3">Email:</dt>
          <dd class="col-sm-9">#useremail#</dd>

          <dt class="col-sm-3">Address:</dt>
          <dd class="col-sm-9">
            #useradd1#<br>
            #useradd2#
          </dd>

          <dt class="col-sm-3">Town/City:</dt>
          <dd class="col-sm-9">#usercity#</dd>

          <dt class="col-sm-3">Postal Code:</dt>
          <dd class="col-sm-9">#userzip#</dd>

          <dt class="col-sm-3">State/Region:</dt>
          <dd class="col-sm-9">#userdefstate#</dd>

          <dt class="col-sm-3">Country:</dt>
          <dd class="col-sm-9">#usercountryname#</dd>
        </dl>
    

      </cfoutput>
</div>
</div>
