

# change material file input -------------------------------------------------------


create_material_object <- function(js_file, material_tag_list){
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::includeScript(
          system.file(
            file.path("js", js_file),
            package = "shinymaterial"
          )
        )
      )
    ),
    material_tag_list
  )
}


material_file_input <- function(input_id,
                                label = "File",
                                color = NULL) {
  
  if(!is.null(color)){
    
    file_input_style <-
      shiny::tagList(
        shiny::tags$head(
          shiny::tags$style(
            paste0(
              '
              input[name=shiny-material-file-path-wrapper-', input_id, ']:not(.browser-default).valid{
              border-bottom: 1px solid', color, ' !important;
              box-shadow: 0 1px 0 0', color, ' !important;
              }
              '
            )
            )
            )
            )
    
  } else {
    file_input_style <- shiny::tags$div()
  }
  create_material_object(
    js_file =
      "shiny-material-file-input.js",
    material_tag_list =
      shiny::tagList(
        shiny::tags$div(
          class = "file-field input-field",
          shiny::tags$div(
            shiny::tags$span(label),
            shiny::tags$input(
              id = input_id,
              class = "shiny-material-file-input",
              type = "file"
            )
          ),
          shiny::tags$div(
            class = "file-path-wrapper",
            shiny::tags$input(
              class = "file-path validate",
              type="text",
              name = paste0("shiny-material-file-path-wrapper-", input_id)
            )
          )
        ),
        file_input_style
      )
  )
}


# change normal fileInput -------------------------------------------------

fileInput <- function(inputId, label, multiple = FALSE, accept = NULL,
                      width = NULL, buttonLabel = "Browse...", placeholder = "No file selected") {
  
  restoredValue <- restoreInput(id = inputId, default = NULL)
  
  # Catch potential edge case - ensure that it's either NULL or a data frame.
  if (!is.null(restoredValue) && !is.data.frame(restoredValue)) {
    warning("Restored value for ", inputId, " has incorrect format.")
    restoredValue <- NULL
  }
  
  if (!is.null(restoredValue)) {
    restoredValue <- toJSON(restoredValue, strict_atomic = FALSE)
  }
  
  inputTag <- tags$input(
    id = inputId,
    name = inputId,
    type = "file",
    style = "display: none;",
    `data-restore` = restoredValue
  )
  
  if (multiple)
    inputTag$attribs$multiple <- "multiple"
  if (length(accept) > 0)
    inputTag$attribs$accept <- paste(accept, collapse=',')
  
  
  div(class = "form-group shiny-input-container",
      style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
      
      div(class = "input-group",
          tags$label(class = "input-group-btn",
                     inputTag
          ),
          tags$span(class = "form-placeholder",  placeholder) ,
          tags$input(type = "text", class = "form-control",
                     readonly = "readonly"
          )
      )
  )
}