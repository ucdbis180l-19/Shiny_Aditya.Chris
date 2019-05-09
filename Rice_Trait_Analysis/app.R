#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

Ricedata <- read.csv("~/Assignments/Assignment_4_Sriram.Aditya/RiceSNPData/RiceDiversity.44K.MSU6.Phenotypes.csv", na=c("NA","00"))

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Rice Trait Analysis"),
   
   #Some helpful information
   helpText("This application creates a scatter plot of two rice traits, with color corresponding to a third trait that helps differentiate the existing two traits."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput("trait1",
                     "Select your x-axis trait to display:",
                     c("Amylose.content",
                     "Protein.content",
                     "Region",
                     "Seed.length",
                     "Alu.Tol")
      ),
         selectInput("trait2",
                   "Select your y-axis trait to display:",
                     c("Amylose.content",
                     "Protein.content",
                     "Region",
                     "Seed.length",
                     "Alu.Tol")
      ),
         selectInput("trait3",
                   "Select fill trait to compare by:",
                     c("Amylose.content",
                      "Protein.content",
                      "Region",
                      "Seed.length",
                      "Alu.Tol")
   )),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("scatterPlot")
      )))

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$scatterPlot <- renderPlot({
      # set up scatter plot
      p1    <- ggplot(data=Ricedata,
                      aes_string(x=input$trait1,
                                 y=input$trait2, 
                                 color=input$trait3)) 
      
      # draw the histogram with the specified number of bins
      p1 + geom_point()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

