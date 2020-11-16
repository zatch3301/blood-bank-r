library(shiny)
library(leaflet)
library(tidyverse)
library(janitor)
library(plotly)
library( htmltools)
library(DT)
library(dplyr)
library(formattable)

ui <- navbarPage("Blood Bank", id="mainnavbar",
                 tabPanel("Map", leafletOutput("bbmap", width = "100%", height = 800)),
                 tabPanel("Analysis", fluidPage(
                   titlePanel("Data Analysis"),
                   plotlyOutput("plot1", height = "700px")
                  )
                 ),
                 tabPanel("Data", DT::dataTableOutput("mytable")),
                 tabPanel("Read Me",includeMarkdown("readme.md"))
  
  )

server <- function(input, output, session) {
 read_csv("blood-banks-new.csv",
           col_types = cols(Latitude = col_double(),
                            Longitude = col_double())) %>%
    select(c(-1)) %>% 
    clean_names() %>%
    filter(latitude != 'NA',
    longitude != 'NA') -> bb_data
  
  
  # bb_data$category %>% unique()
  pal <- colorFactor(pal = c("#1b9e77", "#d95f02", "#7570b3"), 
                     domain = c("Charity", "Government", "Private"))
  
  # bb_data$blood_bank_name <- gsub("[0-9@!$;:,.#&() \\-\\/]","",bb_data$blood_bank_name)
  # bb_data$district <- gsub("[0-9@!$;:,.#&() \\-\\/]","",bb_data$district)
  # bb_data$blood_bank_name %>% View()
  # as.character(bb_data$blood_bank_name)
    
  output$bbmap <- renderLeaflet({
    bb_data %>% 
      leaflet() %>% 
      addTiles() %>% 
      addCircleMarkers(~longitude, ~latitude,
                 labelOptions = labelOptions(noHide = F,
                                             offset = c(0,-45), 
                                             direction = "auto"),
                 clusterOptions = markerClusterOptions(),
                 color = ~pal(bb_data$category),
                 popup =  paste0("<b>Name : </b>",as.character(bb_data$blood_bank_name),"<br/>",
                                 "<b>District : </b>",as.character(bb_data$district),"<br/>",
                                 "<b>City : </b>",as.character(bb_data$city),"<br/>",
                                 "<b>State : </b>",as.character(bb_data$state),"<br/>",
                                 "<b>Contact : </b>",as.character(bb_data$contact_no),"<br/>",
                                 "<b>Website : </b>",as.character(bb_data$website))) %>% 
      addLegend(position = "bottomright",
                pal = pal, 
                values = bb_data$category, 
                na.label = "Not Available" )
  })
  

  output$mytable <- DT::renderDataTable({
    bb_data %>% 
      clean_names() %>% 
      select(c(1:26)) -> dd
    datatable(dd, rownames = FALSE, colnames = c('Blood Bank Name' =1))
  })
  
  bb_data %>% 
    mutate(state = state %>% factor() %>% fct_infreq()) %>% 
    mutate(district = district %>% factor() %>% fct_infreq()) %>% 
    mutate(city = city %>% factor() %>% fct_infreq()) %>% 
    select(c(2:4))-> df
  
  output$plot1 <- renderPlotly({
    
    ggplotly(
      ggplot(df,aes(state))+
        geom_bar(aes(fill=state))+
        coord_flip()+
        labs(x = "State",
             y = "No.of Blood Bank",
             title = "Blood Banks",
             caption = "By gagan")+
        theme_minimal()+
        theme(axis.text.x = element_text(size = 10,
                                         face = "bold",
                                         angle = 0),
              axis.text.y = element_text(size = 10,
                                         face = "bold"),
              axis.title = element_text(size = 18,
                                        face = "bold"),
              legend.position = "none")
    )     

  })

  
}

shinyApp(ui, server)