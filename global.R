
library(shiny)
library(dplyr)
library(plotly)
library(magick)
library(webshot)
library(ggplot2)
library(stringr)
library(RImagePalette)
library(shinymaterial)
library(shinycssloaders)
library(png);library(jpeg)

options(spinner.color="#0dc5c1")


# load Scripts ------------------------------------------------------------

source("adjust_fileInput_function.R", local = TRUE)

# load jQuery plugin ------------------------------------------------------

plugin <- tags$head(
  HTML('
       <head>
       <link rel="stylesheet" type="text/css" href="css/flexslider.css">
       <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
       <script type="text/javascript" src="js/jquery.flexslider-min.js"></script>
       
       <script type="text/javascript" charset="utf-8">
       $(window).load(function() {
       $(".flexslider").flexslider({
           manualControls: "#hoge a",
           animation: "slide",
           slideshow: false,
           directionNav: false,
       });
       });
       </script>
       
       </head>
       ')
  )



