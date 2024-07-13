<CFINCLUDE template="/include/remote_load.cfm" /><cfquery datasource="#dsn#" name="FindRefPage"  >
    SELECT
    a.appname
    ,a.appAuthor
    ,c.compname
    ,p.pgname
    ,a.appId
    ,a.appDescription
    ,a.appLogoName
    ,a.colorTopBar
    ,a.colorLeftSideBar
    ,a.mocktoday
    ,a.mock_yn
    ,c.compid
    ,c.compDir
    ,c.compTable
    ,c.compowner
    ,c.compIcon
    ,c.menuYN
    ,c.menuOrder
    ,c.compInner
    ,c.compRecordName
    ,c.compActive
    ,p.pgid
    ,p.pgDir
    ,p.pgTitle
    ,p.pgHeading
    ,p.pgFilename
    ,p.datatables_YN
    ,p.fullcalendar_YN
    ,p.editable_YN
    ,p.newdatatables_YN
    ,p.pk
    FROM pgpages p
    INNER JOIN pgcomps c ON c.compID = p.compID
    INNER JOIN pgapps a ON a.appID = c.appid
    WHERE p.pgid = #ref_pgid#
</cfquery>

<CFINCLUDE template="/include/remote_load.cfm" /><cfquery datasource="#dsn#" name="FindRefcontacts"  >
    SELECT recordname
    from contactdetails
    WHERE contactid = #contactid#
</cfquery>

<style>
.btn-success:disabled {
	color: #fff;
	background-color: #D3D3D3;
	border-color: #D3D3D3
}
</style>
<cfoutput>
<cfif #ref_pgid# is "3">    
    
    <cfset cookie.uploadDir = "#dir_contact_avatar_filename#" /> 
    <cfset cookie.return_url = "/app/contact/?contactid=#contactid#" />
    <cfset subtitle = "#FindRefContacts.recordname#" />
    
    
        <cfset browser_contact_avatar_loc="/media-#host#/users/#finduser.userid#/contacts/#contactid#" />

    <cfset browser_contact_avatar_filename="#browser_contact_avatar_loc#/avatar.jpg" />
    <cfset image_url = "#browser_contact_avatar_filename#" />
    
<cfelseif #ref_pgid# is "7">
    <cfset subtitle = "#userFirstName# #userLastName#" />
        <cfset image_url = "#browser_user_avatar_filename#" />
    <cfset cookie.uploadDir = "#dir_user_avatar_filename#" /> 
        <cfset cookie.return_url = "/app/myaccount/" />
    
    <cfelseif #ref_pgid# is "9">
    <cfset subtitle = "#userFirstName# #userLastName#" />
        <cfset image_url = "#browser_user_avatar_filename#" />
    <cfset cookie.uploadDir = "#dir_user_avatar_filename#" /> 
        <cfset cookie.return_url = "/app/setup/" />
    
</cfif>
    


</cfoutput>

<cfif #ref_pgid# is "9">			
<cfset picsize = 200 />
    <cfset inputsize = 200 />
<cfelse>
    <cfset picsize = 200 />
    <cfset inputsize = 300 />
    </cfif>
<link rel="stylesheet" href="/app/assets/css/croppie.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.5/croppie.js"></script>
<h4><cfoutput>#subtitle#</cfoutput></h4>
			  	<div class="row">
                        <div id="cont">
                                      <h5 class="col-md-12" style="padding-bottom:20px;">           Avatar has been updated!</h5>
                            
                    </div>
                    <div id="selectfile">
          <h5 class="col-md-12" style="padding-bottom:20px;">           Select an image on your computer and upload image. Then click Continue.</h5>
                    
			  		
			  		<div class="col-md-12" style="padding-bottom:20px;">
                        
                        
                        
                        	<div  style="padding-bottom:10px;">
                                <strong>Select a file:</strong></div>
                        
                        	<input type="file" id="upload" >
                    </div>
        </div>
					<input type="hidden" name="picturebase" id="picturebase" value="">
                        
           
                        
                     <div class="col-md-12" >
                        <div id="upload-input" style="width:<Cfoutput>#inputsize#</cfoutput>px; height: <Cfoutput>#inputsize#</cfoutput>px;"></div>
			  		</div>  
                            <div class="col-md-12" >
					
					 
						<BR>
                        <button id="uploadbutton" class="btn  upload-result btn-primary" >Update</button>
             
                        
                        
                        
			  		</div>
                </div>
<cfif #ref_pgid# is "9">			
<cfset picsize = 200 /> 
<cfelse>
    <cfset picsize = 200 />
    </cfif>

    <script>
    $(document).ready(
    function(){
        $('#cont').hide();
    
        $('#uploadbutton').hide();
        $('input:file').change(
            function(){
                if ($(this).val()) {
                    $('#uploadbutton').attr('disabled',false);  
              
                    $('#uploadbutton').show();
                } 
            }
            );
    });
    </script>
 
<script type="text/javascript">
$uploadCrop = $('#upload-input').croppie({
    enableExif: true,
    url: <Cfoutput>'#image_url#</cfoutput>?ver=<Cfoutput>#rand()#</cfoutput>',
    viewport: {
        width: <cfoutput>#picsize#</cfoutput>,
        height: <cfoutput>#picsize#</cfoutput>,
        type: 'circle'
    },
    boundary: {
        width: <cfoutput>#picsize#</cfoutput>,
        height: <cfoutput>#picsize#</cfoutput>
    }
});


$('#upload').on('change', function () { 
	var reader = new FileReader();
    reader.onload = function (e) {
    	$uploadCrop.croppie('bind', {
    		url: e.target.result
    	}).then(function(){
    		console.log('jQuery bind complete');
    	});
    	
    }
    reader.readAsDataURL(this.files[0]);
});

    
    
    function resultToField() {
        uploadCrop.croppie('result','base64').then(function(baseImage) {
            $('#picturebase').val(baseImage);
        });
    };
    
    
    

$('.upload-result').on('click', function (ev) {
	$uploadCrop.croppie('result', {
		type: 'canvas',
		size: 'viewport'
	}).then(function (resp) {
		$.ajax({
			url: "/include/image_upload2.cfm",
			type: "POST",
			data: {"picturebase":resp},
			success: function (data) {
                html = '<img style="margin: 20px;" src="' + resp + '" /><BR><A HREF="<Cfoutput>#cookie.return_url#</cfoutput>"><button type="button" class="btn  btn-primary waves-effect mb-2 waves-light" >Continue</button></a>';
				$("#upload-input").html(html);
                $('#uploadbutton').hide();
        $('#selectfile').hide();
                $('#cont').show();
			}
		});
	});
});
</script>

<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
