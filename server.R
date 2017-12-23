

shinyServer(function(input, output, session) {
  
  readImage <- function(path_to_image){
    image_in <- path_to_image
    if(!is.null(image_in)){
      if(str_detect(image_in$type, "jpg|JPG|jpeg|JPEG")){
        return(readJPEG(image_in$datapath))
      } else if(str_detect(image_in$type, "png|PNG")) {
        return(readPNG(image_in$datapath))
      }
    }
    return(readJPEG("pic/Flag.jpg"))
  }
  
  imageReadUpload <- reactive({
    readImage(input$input_img_file) %>% return()
  })
  imageReadDD <- reactive({
    readImage(input$img_by_dd) %>% return()
  })
  
  
  #--------default image left--------#
  del_bool <- FALSE
  
  p <- "pic/Flag.jpg"
  output$image <- renderImage({
    
    width  <- session$clientData$output_image_width
    height <- session$clientData$output_image_height
    pixelratio <- session$clientData$pixelratio
    
    list(src = p,
         contentType = 'image/png',
         width = width,
         height = height,
         alt = "This is alternate text")
  }, deleteFile = del_bool)
  
  
  #--------default image right--------#
  output$pantone <- renderPlot({
    # width  <- session$clientData$output_image_width
    makePantone() %>% return()
  })
  
# getEvent ----------------------------------------------------------------

      #--------input by upload--------#
    observeEvent(input$input_img_file,{
      
      output$image <- renderImage({
        
        width  <- session$clientData$output_image_width
        height <- session$clientData$output_image_height
        pixelratio <- session$clientData$pixelratio
        
        list(src = (input$input_img_file$datapath),
             contentType = 'image/png',
             width = width,
             height = height,
             alt = "This is alternate text")
      }, deleteFile = del_bool)
    })
  
      #--------input by URL----------#
    observeEvent(input$text_url,{
      
      input_url <- reactive({
        text <- input$text_url %>% as.character()
      })  
      
      filenum <- paste("pic/", round(runif(1)  * 1000), ".png", sep = "")
      
      observeEvent(input$submit, {
        webshot(url = input_url(),
                file = filenum,
                # "pic/temp.png",
                cliprect = "viewport")

        output$image <- renderImage({
          
          width  <- session$clientData$output_image_width
          height <- session$clientData$output_image_height
          pixelratio <- session$clientData$pixelratio
          
          list(src = req(filenum),
               contentType = 'image/png',
               width = width,
               height = height,
               alt = "This is alternate text")
        }, deleteFile = del_bool)
      })
    })
    
      #--------input by D&D----------#
    observeEvent(input$img_by_dd, {
      output$image <- renderImage({
        
        width  <- session$clientData$output_image_width
        height <- session$clientData$output_image_height
        pixelratio <- session$clientData$pixelratio
        
        list(src = (input$img_by_dd$datapath),
             contentType = 'image/png',
             width = width,
             height = height,
             alt = "This is alternate text")
      }, deleteFile = del_bool)
    })
    
    

# run RImagePalette -------------------------------------------------------

  # function for Pantone
    
    # Mode <- function(x) {
    #   ux <- unique(x)
    #   ux[which.max(tabulate(match(x, ux)))]
    # }
    
    makePantone <- function( inputtype = "upload", n_row = 5, method = "mean"){
      
      your_image <- switch (inputtype,
        "upload" = imageReadUpload(),
        "DD"     = imageReadDD()
      )
      #------------get color from Image------------#
      if(method == "method1"){  choice <- mean
      } else if (method == "method2"){
        choice <- median
      } else {
        choice <- min
      }
      palette <- image_palette(your_image, n = n_row, choice = choice)
      
      #------------plot for PARTONE------------#
      df <- data.frame(X = seq( 1 : n_row ),
                       Y = rep( 10, n_row) )
      
      pantone <- ggplot(df,
                       aes(x = X, 
                           y = Y, 
                           fill = factor(X))
                        ) + geom_bar(stat = "identity", width = 0.8) +
                          coord_flip() +
                          scale_fill_manual(values = palette) +
                          theme_void() + 
                          theme(legend.position="none")
      
      return(pantone)
    }
    
    
    #--------input by upload--------#
    observeEvent(input$input_img_file,{
      output$pantone <- renderPlot({
        width  <- session$clientData$output_image_width
        makePantone(inputtype = "upload",
                    n_row = input$num_colors,
                    method = input$method) %>% return()
      })
    })
    
    #--------input by URL----------#
    observeEvent(input$text_url,{
      output$pantone <- renderPlot(
        makePantone(n_row = input$num_colors,
                    method = input$method) %>% return()
      )
    })

    #--------input by D&D----------#
    observeEvent(input$img_by_dd, {
      output$pantone <- renderPlot(
        makePantone(inputtype = "DD", 
                    n_row = input$num_colors,
                    method = input$method) %>% return()
      )
    })
  
    
    
    
}) # end of server