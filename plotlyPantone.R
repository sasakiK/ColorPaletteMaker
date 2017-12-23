
makePantone <- function(path, n_row = 5 ){
  
  #------------get color from Image------------#
  your_image <- jpeg::readJPEG(path)
  palette <- image_palette(your_image, n = n_row)
  
  #------------plot for PARTONE------------#
  df <- data.frame(X = seq( 1 : n_row ),
                   Y = rep( 10, n_row) )
  
  axisOption <- list(title =  "",
                     showgrid = FALSE,
                     zeroline = FALSE,
                     showline = FALSE,
                     showticklabels = FALSE)

  pantone <- plot_ly(df,
                    x = ~Y,
                    y = ~X,
                    type = "bar",
                    marker = list(color = palette),
                    orientation = 'h'
                    ) %>%
            layout(autosize = T, #width = "100%", height = "100%",
                   title = "",
                   xaxis = axisOption,
                   yaxis = axisOption
                   )
  return(pantone)
}