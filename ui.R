

slide1 <- fluidRow(class = "upload_wrapper_pare",
            shiny::column(class = "upload_wrapper", width = 12, align = "center",
              div(class = "upload_by_input", 
                div(class = "image", 
                      material_file_input(input_id = "input_img_file",
                                          label = span(class = "material-icons", "cloud_upload",
                                                       span(class = "uploadspan", " Upload")
                                                       ),
                                          color = "#434544"
                                          )
                    )
                  )
            ), align = "center"
          )

slide2 <- fluidRow(class = "upload_wrapper_pare", 
            shiny::column(class = "upload_wrapper", width = 12, align = "center",
              div(class = "uploade_by_url",
                div(class = "image",
                  material_text_box(input_id = "text_url",
                                    label = span(class="glyphicon glyphicon-link", style = "color:white;",
                                                 span(class = "uploadspan2", "Paste URL link"))
                                    ),
                  actionButton("submit", 
                               label = span(class="glyphicon glyphicon-submit", 
                                            span(class = "uploadspan", "submit"))
                               )
                    )
              )
            )
          )

slide3 <- fluidRow(class = "upload_wrapper_pare",
            shiny::column(class = "upload_wrapper", width = 12, align = "center",
              div(class = "uploade_by_url",
                div(id="drop-area", align = "center",
                    fileInput(inputId = "img_by_dd", label = "D & D", width = "100%",
                              placeholder = "Drag png/jpeg",
                              accept = c('image/png', 'image/jpeg')
                              )
                    )
              )
            )
)



ui <- material_page( label = "a",
                     background_color = NULL,
                     include_fonts = TRUE,
                     nav_bar_fixed = TRUE,
                     title = "　Color Palette Maker　",
                    
                    includeCSS("www/css/style.css"),
                    plugin,
                    
                    fluidPage(
                    # main panel --------------------------------------------------------------
                    
                    fluidRow( class = "toprow",
                      material_column(width = 2,　offset = 3, align = "center",
                                    div(id = "hoge",
                                        tags$a( class= "hoge_a", herf="#", "By upload")
                                    )
                      ),
                      material_column(width = 2, align = "center",
                                    div(id = "hoge",
                                        tags$a( class= "hoge_a", herf="#", "By URL")
                                    )
                      ),
                      material_column(width = 2, offset = -3, align = "center",
                                    div(id = "hoge",
                                        tags$a( class= "hoge_a", herf="#", "By D&D")
                                    )
                      )
                    ),
                    
                    fluidRow(
                        shiny::column(width = 12, align = "center",
                          div(class = "flexslider",
                              tags$ul( class = "slides",
                                       tags$li( slide1  ),
                                       tags$li( slide2  ),
                                       tags$li( slide3  )
                                      )
                              )
                        )
                    ),
                    br(),
                    fluidRow( class = "input_row",
                      shiny::column(width = 4, offset = 2, align = "center",
                                    material_input(
                                      type = "slider",
                                      input_id = "num_colors",
                                      label = "number of colors",
                                      min_value = 5,
                                      max_value = 10,
                                      initial_value = 5,
                                      color = "#373B3B"
                                    )
                                    ),
                      shiny::column(width = 4, offset = 1, align = "center",
                                    material_radio_button(
                                      input_id = "method",
                                      label = "change method",
                                      choices = c(
                                        "method1" = "method1",
                                        "method2" = "method2",
                                        "method3" = "method3"
                                      ),
                                      color = "#373B3B"
                                    )
                                    
                      )
                    ),
                    
                  # 画像 ----------------------------------------------------------------------
                    
                    fluidRow(
                      shiny::column(width = 5, align = "center", offset = 1,
                                    material_card(class = "original_card",
                                                  title = "original", depth = 3, align = "center",
                                                    
                                                  imageOutput("image") %>% withSpinner(type = 7)
                                                  )
                                    ),
                      shiny::column(width = 5, align = "center", offset = -1,
                                    material_card(title = "palette", depth = 3, align = "center",
                                                  
                                                  plotOutput(outputId = "pantone", width = "100%")  %>% withSpinner(type = 7)
                                                  
                                                  )
                                    )
                    )
                  ),
                  

                # footer ------------------------------------------------------------------

                    tags$footer(
                      tags$a(href = "https://qiita.com/sasaki_K_sasaki", "qiita@sasaki_K_sasaki　"),
                      tags$a(href = "https://github.com/sasakiK", icon("github"))
                    )
)