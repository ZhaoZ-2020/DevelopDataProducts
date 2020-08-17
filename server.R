
library(shiny)


shinyServer(function(input, output) {
    
    # base on the inputs, generate the simulated data.
    simdata<- reactive({
        set.seed(123)
        n<-input$n
        B<-input$B
        
        if (input$fx == 1) {
            x<-rnorm(n*B)
            truemn<-0
            truesd<-1
        }
        else if (input$fx == 2) {
            x<-rpois(n*B, 1)
            truemn<-1
            truesd<-1
        }
        else if (input$fx == 3) {
            x<-runif(n*B)
            truemn<-1/2
            truesd<-sqrt(1/12)
        }
        else if (input$fx == 4) {
            x<-rbinom(n*B,size=10, p=0.5)
            truemn<-10*0.5
            truesd<-sqrt(10*0.5*0.5)
        }
        
        matrixx<-matrix(x, nrow=B)
        xbar<-apply(matrixx,1,mean)
        
        list(x[1:n], xbar, truemn, truesd/sqrt(n))
    })
    
    
    output$Plot1 <- renderPlot({
        # draw the density plot of one sample 
        hist(simdata()[[1]], col = 'darkgray', border = 'white', 
             prob=TRUE, xlab="", main="Density plot of one sample (with size n)")
        
        ## add a line for the sample mean
        if(input$showod) {
            abline(v=mean(simdata()[[1]]), col="red", lwd=4)
        }        
    })
    
    output$Plot2 <- renderPlot({
        # draw the density plot of the B sample means
        hist(simdata()[[2]], col = 'darkgray', border = 'white', 
             prob=TRUE, xlab="", main="Density plot of the sample mean 
             (from B simulations)")
        
        # add a line for the average of the B sample means
        if(input$showod) {
            abline(v=mean(simdata()[[2]]), col="red", lwd=4)
        }
        
        if(input$shownorm) {
            curve(dnorm(x,mean=simdata()[[3]], sd=simdata()[[4]]),
                  col="blue", lwd=4, add=TRUE, yaxt="n")
        }
    })

})
