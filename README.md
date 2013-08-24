gsa_template
============

XSLT template to convert the XML results from Google Search Appliance into one of the following formats:

1) JSON
2) JSONP
3) Pure HTML
4) HTML + callback javascript

Not all fields from the result are returned. They are cherry picked as :



History
=========

The initial idea was seeded from the XSLT work done in the google-mini project at https://github.com/icerunner/google-mini. 
Based on that however a lot have changed and use cases that I was solving was when the same browser / client instance requires all the various formats depending on 
various situations. So the initial XSLT from https://github.com/icerunner/google-mini has been drastically modified.


Installation
=============

Install the XSLT on the GSA server side and have it applied to your site. This is usually done with the combination of proxystylesheet=<your site>&site=<blah>&client=<blah> param in the query. Here is a sample query that I used on 
	https://developer.intuit.com
	
	https://isearch.intuit.com/search?access=p&client=ipp&proxystylesheet=ipp&site=ipp&num=20&getfields=ippcat&q=quickbooks

How to get the results in various formats
=========================================

JSON (default)
===============

	http(s)://<your gsa server url>/<your params specific to GSA>

The result will come back as (search results on https://developer.intuit.com/search?q=quickbooks) :


	{
        
	"query": "quickbooks",
	"results": [
    
      {
        "url": "https://developer.intuit.com/docs/0025_quickbooksapi",
        "title": "<b>QuickBooks</b> API | Docs | Intuit Partner Platform",
        "summary": "Back. <b>QuickBooks</b> API. Getting Started; <b>...</b> <b>QuickBooks</b> API. The <b>QuickBooks</b> API<br> documentation consists of the following topics: Introduction to <b>...</b>  ",
        "meta_tags" : [
           {
            "name": "description",
            "value": "Intuit Developer"
           },
           {
            "name": "viewport",
            "value": "width=device-width, initial-scale=1.0"
           },
    
         ]
    
        ,
        "size": "24k"
      }
      
        ,
      
		.
 	    .
		.    
		],
    
      "results_nav": {
      "total_results": "2490",
      "results_start": "1",
      "results_end": "10",
      "current_view": "0"
        ,
        "have_next": "1"
      
      }
    
          }
        

JSONP ( param = callback )
============================

Send a callback parameter along with your other parameters 

	https://isearch.intuit.com/search?access=p&client=ipp&proxystylesheet=ipp&site=ipp&num=20&getfields=ippcat&q=quickbooks&callback=jQuery183024320425000041723_1377300892854&_=1377300893023

This should get you results like :
	
	jQuery183024320425000041723_1377300892854
	          ({
        
	"query": "quickbooks",
	"results": [
    
	      {
	        "url": "https://developer.intuit.com/docs/0025_quickbooksapi",
	        "title": "<b>QuickBooks</b> API | Docs | Intuit Partner Platform",
	        "summary": "Back. Quick Links. <b>QuickBooks</b> API. <b>...</b> Other Resources; George&#39;s<br> Test Page. <b>QuickBooks</b> API. The <b>QuickBooks</b> API <br> documentation consists of the following topics: <b>...</b>  ",
	        "meta_tags" : [
	           {
	            "name": "ippcat",
	            "value": "QuickBooks API,Documentation"
	           },
    
	         ]
    
	        ,
	        "size": "20k"
	      }
		  .
		  .
		  .
  		],
    
        "results_nav": {
        "total_results": "2490",
        "results_start": "1",
        "results_end": "10",
        "current_view": "0"
          ,
          "have_next": "1"
      
        }
    
            }
		})
		

		
		
Why use HTML specific tabs ( fixing the return mime-type for the likes of IE )
==============================================================================

GSA 6.0 and 7.0 currently has a limitation where it cannot set mimetype per proxystylesheet. In essence it will transform the results into any format but the mime-type will always come back as : text/html by default. Or anything else which is the entire GSA specific. This causes issues with IE which does not pardon the mime-type issue. Look for IE – SEC7112.

The correct fix is to fix GSA. But until that happens the work around that I used is to load the search result in an "iframe" and :

1) If you want HTML only then show the results from the iframe.
2) If you want to have common code which shows the results across all browsers ( like I did ) then you would want the iframe to call a javascript on the parent page. 


** NOTE ** 
You can only do this if you have the same document.domain. Essentially if you are using a.mysite.com and search.mysite.com is your search URL then you should set a.mysite.com's document.domain to 'mysite.com' and send it along to the search site so it will render the HTMl content for the iframe with the same document.domain.

		
HTML Only (param: htmlonly=1&document_domain=<your common domain>)
========================================================================

Send a htmlonly param along with other GSA specific params. Please DO NOT use along with other params this page supports. The results are not gauranteed if you do so.

If your request is 
	https://<my site >/<otherparams>&htmlonly=1&document_domain=mysite.com
	
Results look like:

    <html>
    <head>
    <script type="text/javascript">
        document.domain="my.com";
    </script>
    </head>
    <body>
    
    {
	"query": "quickbooks",
	"results": [
    
	      {
	        "url": "https://developer.intuit.com/docs/0025_quickbooksapi",
	        "title": "<b>QuickBooks</b> API | Docs | Intuit Partner Platform",
	        "summary": "Back. Quick Links. <b>QuickBooks</b> API. <b>...</b> Other Resources; George&#39;s<br> Test Page. <b>QuickBooks</b> API. The <b>QuickBooks</b> API <br> documentation consists of the following topics: <b>...</b>  ",
	        "meta_tags" : [
	           {
	            "name": "ippcat",
	            "value": "QuickBooks API,Documentation"
	           },
			   .
			   .
			   .
    
			   ],
    
			         "results_nav": {
			         "total_results": "1260",
			         "results_start": "1",
			         "results_end": "20",
			         "current_view": "0"
			           ,
			           "have_next": "1"
      
			         }
    
          
			   }
			               </body>
			             </html>
			   

	



HTML + javascript callback (param = htmlcallback=<javascript function name>&document_domain=<your common domain>)
============================================================================================================================

Send a htmlonly param along with other GSA specific params. Please DO NOT use along with other params this page supports. The results are not gauranteed if you do so.

If your request is 
	https://<my site >/<otherparams>&htmlcallback=theSearchObj.search_call_back&document_domain=mysite.com

	
Results look like:

    <html>
     <head>
     <script type="text/javascript">
             document.domain="intuit.com";
                         parent.theSearch.search_call_back(
     
     {
   
 	"query": "quickbooks",
 	"results": [
    
 	      {
 	        "url": "https://developer.intuit.com/docs/0025_quickbooksapi",
 	        "title": "<b>QuickBooks</b> API | Docs | Intuit Partner Platform",
 	        "summary": "Back. Quick Links. <b>QuickBooks</b> API. <b>...</b> Other Resources; George&#39;s<br> Test Page. <b>QuickBooks</b> API. The <b>QuickBooks</b> API <br> documentation consists of the following topics: <b>...</b>  ",
 	        "meta_tags" : [
 	           {
 	            "name": "ippcat",
 	            "value": "QuickBooks API,Documentation"
 	           },
 			   .
 			   .
 			   .
    
 			   ],
    
 			         "results_nav": {
 			         "total_results": "1260",
 			         "results_start": "1",
 			         "results_end": "20",
 			         "current_view": "0"
 			           ,
 			           "have_next": "1"
      
 			         }
    
          
					 });
					         </script>
					         </head>
					         <body>
        

					             </body>
					           </html>
	



Live sites using it
====================
							   
* https://developer.intuit.com
							   
							   
