

        <cfmail from="support@theactorsoffice.com" to="#emailto#" subject="TICKET NO #new_ticketid# - #emailsubject#" type="HTML" bcc="kevinking7135@gmail.com"  cc="#emailcc#" >

    <HTML>
       <head><title>TAO TICKET NO #new_ticketid#</title>

       </head>
       <body>
           <!--- Style Tag in the Body, not Head, for Email --->
           <style type="text/css">
               body { font-size: 14px; }
           </style>
   
            <p>Ticket No. #new_ticketid# #emailmessage#</p>
         
           <cfif #emaillinkname# is not "" and #emaillink# is not "">
           <h4><A HREF="#emaillink#">#emaillinkname#</A></h4>
        </cfif>
 
 
           
           
           <p>&nbsp;</p>
       
        
           <p>TAO Support</p>
           <p>Automated Message Alert</p>
                 
          
     
           
           
           
           
           
           
     
       </body>
    </HTML>
    
</cfmail>