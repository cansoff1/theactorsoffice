 


 <h4 class="text-nowrap">
               My Billing
                </h4>
                <div class="row" style="margin: auto;">






                    <cfoutput query="thrivecartdetails">

                        <div class="col-md-12 col-lg-6 p-1"><strong>Invoice ID: </strong>#invoiceid#</div>



                        <div class="col-md-12 col-lg-6 p-1"><strong>Purchase Date: </strong>#dateformat(purchasedate)#</div>

                        <cfif #dateformat(trialenddate)# is not "">

                            <div class="col-md-12 col-lg-6 p-1"><strong>Trial End Date: </strong>#dateformat(trialenddate)#</div>
                        </cfif>


                        <div class="col-md-12 col-lg-6 p-1"><strong>Product: </strong>#baseproductlabel#</div>


                        <div class="col-md-12 col-lg-6 p-1"><strong>Plan: </strong>#planname#</div>

                    </cfoutput>
<div class="col-md-12 col-lg-6 p-1">Have questions and want to cancel?  <a href="mailto:support@theactorsoffice.com">Email</A> us</div>

                </div>







