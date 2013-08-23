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

Install the XSLT on the GSA server side and have a simple curl call to get the corresponding results

How to get the results in various formats
=========================================

JSON
=====

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
      
      {
        "url": "https://developer.intuit.com/docs/0025_quickbooksapi/0005_introduction_to_quickbooksapi",
        "title": "Introduction to <b>QuickBooks</b> API | Docs | Intuit Partner Platform",
        "summary": "<b>...</b> Introduction to <b>QuickBooks</b> API. <b>...</b> The following topics provide an overview of<br> how the developer and the app&#39;s user experience the <b>QuickBooks</b> API. <b>...</b>  ",
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
        "size": "16k"
      }
    
        ,
      
      {
        "url": "https://developer.intuit.com/docs/0025_quickbooksapi/0050_data_services/v2/0400_quickbooks_online",
        "title": "<b>QuickBooks</b> Online | Docs | Intuit Partner Platform",
        "summary": "Back. <b>QuickBooks</b> API. <b>...</b> <b>QuickBooks</b> Online. Data Services for <b>QuickBooks</b> Online<br> is a set of REST APIs that provide access to <b>QuickBooks</b> data. <b>...</b>  ",
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
        "size": "28k"
      }
    
        ,
      
      {
        "url": "https://developer.intuit.com/docs/0025_quickbooksapi/0050_data_services/v2/0500_quickbooks_windows",
        "title": "<b>QuickBooks</b> Desktop | Docs | Intuit Partner Platform",
        "summary": "Back. <b>QuickBooks</b> API. <b>...</b> <b>QuickBooks</b> Desktop. Data Services for <b>QuickBooks</b><br> Desktop is a REST API that provides access to <b>QuickBooks</b> data. <b>...</b>  ",
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
        "size": "47k"
      }
    
        ,
      
      {
        "url": "https://developer.intuit.com/docs/0025_quickbooksapi/0055_devkits/0250_qb",
        "title": "<b>QuickBooks</b> SDK (QBSDK) | Docs | Intuit Partner Platform",
        "summary": "Back. <b>QuickBooks</b> API. Getting Started; Reference; API Explorer; DevKits; Auth;<br> Pricing; Happy Developers; Marketing; <b>...</b> <b>QuickBooks</b> SDK (QBSDK). <b>...</b>  ",
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
        "size": "29k"
      }
    
        ,
      
      {
        "url": "https://developer.intuit.com/docs/0025_quickbooksapi/0055_devkits/0300_windows_azure_program_for_quickbooksapi",
        "title": "Windows Azure Program for <b>QuickBooks</b> API | Docs | Intuit <b>...</b>",
        "summary": "Back. <b>QuickBooks</b> API. Getting Started; Reference; API Explorer;<br> DevKits; Auth; Pricing; Happy Developers; Marketing; <b>...</b> Windows<br> Azure Program for <b>QuickBooks</b> API. <b>...</b>  ",
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
        "size": "19k"
      }
    
        ,
      
      {
        "url": "https://developer.intuit.com/blog/category/quickbooks",
        "title": "Blog | Intuit Partner Platform",
        "summary": "<b>...</b> Combined QBO and <b>QB</b> Java Devkit released - IPP Java DevKit. <b>...</b><br> The release version is 2.0.1. This is a major new release that<br> adds <b>QuickBooks</b> Online support to the <b>...</b>  ",
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
        "size": "66k"
      }
    
        ,
      
      {
        "url": "https://developer.intuit.com/docs/0085_quickbooks_windows_sdk/010_qb",
        "title": "<b>QuickBooks</b> SDK | Docs | Intuit Partner Platform",
        "summary": "<b>...</b> <b>QuickBooks</b> SDK. Although Intuit Anywhere is the preferred approach for<br> integrating apps with <b>QuickBooks</b> data, we continue to support <b>...</b>  ",
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
        "size": "18k"
      }
    
        ,
      
      {
        "url": "https://developer.intuit.com/docs/0025_quickbooksapi/0010_getting_started/0020_connect",
        "title": "Connect to <b>QuickBooks</b> | Docs | Intuit Partner Platform",
        "summary": "<b>...</b> Connect to <b>QuickBooks</b>. Overview. Connect your app to <b>QuickBooks</b><br> data to provide your users a seamless experience. <b>...</b>  ",
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
        "size": "20k"
      }
    
        ,
      
      {
        "url": "https://developer.intuit.com/docs/0025_quickbooksapi/0010_getting_started/0030_integrate_your_app",
        "title": "Integrate with <b>QuickBooks</b> | Docs | Intuit Partner Platform",
        "summary": "Back. <b>QuickBooks</b> API. Getting Started; Reference; API Explorer; DevKits; Auth;<br> Pricing; Happy Developers; Marketing; <b>...</b> Integrate with <b>QuickBooks</b>. Overview. <b>...</b>  ",
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
        
		