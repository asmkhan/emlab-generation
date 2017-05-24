setwd("~/emlab-generation/rscripts/")
source("rConfig.R")
source("batchRunAnalysis.R")
library("ggplot2")
library("Hmisc")
savePlots=T
showPlots=T
scaleFactor<-1
nrowLength<-1
filePrefix<-"P1-"

##---- Read in of Data                     ------------------
#Get all the data frames at once (only common columns)
bigDF <- getDataFrameForModelRunsInFolder("~/Desktop/emlabGen/output/P2/")
bigDF[is.na(bigDF)] <- 0
#bigDF$SpotMarketCash_Country.A.electricity.spot.market<-abs(bigDF$SpotMarketCash_Country.A.electricity.spot.market)
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.A")] <- "TotalProducerCash_Stakeholder.A"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.B")] <- "TotalProducerCash_Stakeholder.B"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.C")] <- "TotalProducerCash_Stakeholder.C"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.D")] <- "TotalProducerCash_Stakeholder.D"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.E")] <- "TotalProducerCash_Stakeholder.E"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.F")] <- "TotalProducerCash_Stakeholder.F"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.G")] <- "TotalProducerCash_Stakeholder.G"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.H")] <- "TotalProducerCash_Stakeholder.H"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.I")] <- "TotalProducerCash_Stakeholder.I"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.J")] <- "TotalProducerCash_Stakeholder.J"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.K")] <- "TotalProducerCash_Stakeholder.K"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.L")] <- "TotalProducerCash_Stakeholder.L"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.M")] <- "TotalProducerCash_Stakeholder.M"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.N")] <- "TotalProducerCash_Stakeholder.N"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.O")] <- "TotalProducerCash_Stakeholder.O"

bigDF<-addSumOfVariablesByPrefixToDF(bigDF,"TotalProducerCash")
bigDF<-addSumOfVariablesByPrefixToDF(bigDF,"StakeholderCash")

#bigDF$TotalProducerStakeholderCashSum<-abs(bigDF$TotalProducerStakeholderCashSum)
#Get data frames one by one
bigDF1<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P2/","P2Scen1", "")
bigDF2<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P2/","P2Scen2", "")
bigDF3<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P2/","P2Scen3", "")
bigDF4<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P2/","P2Scen4", "")
bigDF5<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P2/","P2Scen5", "")

capacityMarketPrices3<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen3","CapacityClearingPoint")
capacityMarketPrices3$modelRun <- rep("P2Scen3",nrow(capacityMarketPrices3))
capacityMarketPrices4<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen4","CapacityClearingPoint")
capacityMarketPrices4$modelRun <- rep("P2Scen4",nrow(capacityMarketPrices4))
capacityMarketPrices5<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen5","CapacityClearingPoint")
capacityMarketPrices5$modelRun <- rep("P2Scen5",nrow(capacityMarketPrices5))

capacityMarketPricesAll<-rbind(capacityMarketPrices3,capacityMarketPrices4,capacityMarketPrices5)

producerCosts1<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen1","ProducerCosts")
producerCosts1$modelRun <- rep("P2Scen1",nrow(producerCosts1))
producerCosts1CountryA<-subset(producerCosts1,Producer.Name == "Energy Producer A" |
                                              Producer.Name == "Energy Producer B" |
                                              Producer.Name == "Energy Producer C" |
                                              Producer.Name == "Energy Producer D" |
                                              Producer.Name == "Energy Producer E" |
                                              Producer.Name == "Renewable Target Investor NL")
producerCosts1CountryB<-subset(producerCosts1,Producer.Name=="Energy Producer F" |
                                         Producer.Name=="Energy Producer G"|
                                         Producer.Name=="Energy Producer H"|
                                         Producer.Name=="Energy Producer I"|
                                         Producer.Name=="Energy Producer J"|
                                         Producer.Name=="Renewable Target Investor FBL")
producerCosts1CountryC<-subset(producerCosts1,Producer.Name=="Energy Producer K"|
                                         Producer.Name=="Energy Producer L"|
                                         Producer.Name=="Energy Producer M"|
                                         Producer.Name=="Energy Producer N"|
                                         Producer.Name=="Energy Producer O"|
                                         Producer.Name=="Renewable Target Investor DE")
producerCosts2<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen2","ProducerCosts")
producerCosts2$modelRun <- rep("P2Scen2",nrow(producerCosts2))
producerCosts2CountryA<-subset(producerCosts2,Producer.Name=="Energy Producer A" |
                                         Producer.Name=="Energy Producer B" |
                                         Producer.Name=="Energy Producer C" |
                                         Producer.Name=="Energy Producer D" |
                                         Producer.Name=="Energy Producer E" |
                                         Producer.Name=="Renewable Target Investor NL")
producerCosts2CountryB<-subset(producerCosts2,Producer.Name=="Energy Producer F")|
                                         Producer.Name=="Energy Producer G"|
                                         Producer.Name=="Energy Producer H"|
                                         Producer.Name=="Energy Producer I"|
                                         Producer.Name=="Energy Producer J"|
                                         Producer.Name=="Renewable Target Investor FBL"
producerCosts2CountryC<-subset(producerCosts2,Producer.Name=="Energy Producer K"|
                                         Producer.Name=="Energy Producer L"|
                                         Producer.Name=="Energy Producer M"|
                                         Producer.Name=="Energy Producer N"|
                                         Producer.Name=="Energy Producer O"|
                                         Producer.Name=="Renewable Target Investor DE")
producerCosts3<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen3","ProducerCosts")
producerCosts3$modelRun <- rep("P2Scen3",nrow(producerCosts3))
producerCosts3CountryA<-subset(producerCosts3,Producer.Name=="Energy Producer A" |
                                             Producer.Name=="Energy Producer B" |
                                             Producer.Name=="Energy Producer C" |
                                             Producer.Name=="Energy Producer D" |
                                             Producer.Name=="Energy Producer E" |
                                             Producer.Name=="Renewable Target Investor NL")
producerCosts3CountryB<-subset(producerCosts3,Producer.Name=="Energy Producer F")|
                                              Producer.Name=="Energy Producer G"|
                                              Producer.Name=="Energy Producer H"|
                                              Producer.Name=="Energy Producer I"|
                                              Producer.Name=="Energy Producer J"|
                                              Producer.Name=="Renewable Target Investor FBL"
producerCosts3CountryC<-subset(producerCosts3,Producer.Name=="Energy Producer K"|
                                               Producer.Name=="Energy Producer L"|
                                               Producer.Name=="Energy Producer M"|
                                               Producer.Name=="Energy Producer N"|
                                               Producer.Name=="Energy Producer O"|
                                               Producer.Name=="Renewable Target Investor DE")
producerCosts4<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen4","ProducerCosts")
producerCosts4$modelRun <- rep("P2Scen4",nrow(producerCosts4))
producerCosts4CountryA<-subset(producerCosts4,Producer.Name=="Energy Producer A" |
                                 Producer.Name=="Energy Producer B" |
                                 Producer.Name=="Energy Producer C" |
                                 Producer.Name=="Energy Producer D" |
                                 Producer.Name=="Energy Producer E" |
                                 Producer.Name=="Renewable Target Investor NL")
producerCosts4CountryB<-subset(producerCosts4,Producer.Name=="Energy Producer F")|
  Producer.Name=="Energy Producer G"|
  Producer.Name=="Energy Producer H"|
  Producer.Name=="Energy Producer I"|
  Producer.Name=="Energy Producer J"|
  Producer.Name=="Renewable Target Investor FBL"
producerCosts4CountryC<-subset(producerCosts4,Producer.Name=="Energy Producer K"|
                                 Producer.Name=="Energy Producer L"|
                                 Producer.Name=="Energy Producer M"|
                                 Producer.Name=="Energy Producer N"|
                                 Producer.Name=="Energy Producer O"|
                                 Producer.Name=="Renewable Target Investor DE")
producerCosts5<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen5","ProducerCosts")
producerCosts5$modelRun <- rep("P2Scen5",nrow(producerCosts5))
producerCosts5CountryA<-subset(producerCosts5,Producer.Name=="Energy Producer A" |
                                 Producer.Name=="Energy Producer B" |
                                 Producer.Name=="Energy Producer C" |
                                 Producer.Name=="Energy Producer D" |
                                 Producer.Name=="Energy Producer E" |
                                 Producer.Name=="Renewable Target Investor NL")
producerCosts5CountryB<-subset(producerCosts5,Producer.Name=="Energy Producer F")|
  Producer.Name=="Energy Producer G"|
  Producer.Name=="Energy Producer H"|
  Producer.Name=="Energy Producer I"|
  Producer.Name=="Energy Producer J"|
  Producer.Name=="Renewable Target Investor FBL"
producerCosts5CountryC<-subset(producerCosts5,Producer.Name=="Energy Producer K"|
                                 Producer.Name=="Energy Producer L"|
                                 Producer.Name=="Energy Producer M"|
                                 Producer.Name=="Energy Producer N"|
                                 Producer.Name=="Energy Producer O"|
                                 Producer.Name=="Renewable Target Investor DE")
producerCostsAllCountryA<-rbind(producerCosts1CountryA,producerCosts2CountryA,producerCosts3CountryA,producerCosts4CountryA,producerCosts5CountryA)
producerCostsAllCountryB<-rbind(producerCosts1CountryB,producerCosts2CountryB,producerCosts3CountryB,producerCosts4CountryB,producerCosts5CountryB)
producerCostsAllCountryC<-rbind(producerCosts1CountryC,producerCosts2CountryC,producerCosts3CountryC,producerCosts4CountryC,producerCosts5CountryC)

#TEMPORARY LINES FOR TESTING
colnames(producerCosts1CountryA)[which(names(producerCosts1CountryA) == "Tick")] <- "tick"
colnames(producerCosts1CountryB)[which(names(producerCosts1CountryB) == "Tick")] <- "tick"
colnames(producerCosts1CountryC)[which(names(producerCosts1CountryC) == "Tick")] <- "tick"
producerCostsAllCountryA<-producerCosts1CountryA
producerCostsAllCountryB<-producerCosts1CountryB
producerCostsAllCountryC<-producerCosts1CountryC
colnames(producerCostsAllCountryA)[which(names(producerCostsAllCountryA) == "Tick")] <- "tick"
colnames(producerCostsAllCountryB)[which(names(producerCostsAllCountryB) == "Tick")] <- "tick"
colnames(producerCostsAllCountryC)[which(names(producerCostsAllCountryC) == "Tick")] <- "tick"
##########

producerProfits1<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen1","ProducerProfits")
producerProfits1$modelRun <- rep("P2Scen1",nrow(producerProfits1))
producerProfits1CountryA<-subset(producerProfits1,Producer.Name == "Energy Producer A" |
                                 Producer.Name == "Energy Producer B" |
                                 Producer.Name == "Energy Producer C" |
                                 Producer.Name == "Energy Producer D" |
                                 Producer.Name == "Energy Producer E" |
                                 Producer.Name == "Renewable Target Investor NL")
producerProfits1CountryB<-subset(producerProfits1,Producer.Name=="Energy Producer F" |
                                 Producer.Name=="Energy Producer G"|
                                 Producer.Name=="Energy Producer H"|
                                 Producer.Name=="Energy Producer I"|
                                 Producer.Name=="Energy Producer J"|
                                 Producer.Name=="Renewable Target Investor FBL")
producerProfits1CountryC<-subset(producerProfits1,Producer.Name=="Energy Producer K"|
                                 Producer.Name=="Energy Producer L"|
                                 Producer.Name=="Energy Producer M"|
                                 Producer.Name=="Energy Producer N"|
                                 Producer.Name=="Energy Producer O"|
                                 Producer.Name=="Renewable Target Investor DE")
producerProfits2<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen2","ProducerProfits")
producerProfits2$modelRun <- rep("P2Scen2",nrow(producerProfits2))
producerProfits2CountryA<-subset(producerProfits2,Producer.Name=="Energy Producer A" |
                                 Producer.Name=="Energy Producer B" |
                                 Producer.Name=="Energy Producer C" |
                                 Producer.Name=="Energy Producer D" |
                                 Producer.Name=="Energy Producer E" |
                                 Producer.Name=="Renewable Target Investor NL")
producerProfits2CountryB<-subset(producerProfits2,Producer.Name=="Energy Producer F")|
  Producer.Name=="Energy Producer G"|
  Producer.Name=="Energy Producer H"|
  Producer.Name=="Energy Producer I"|
  Producer.Name=="Energy Producer J"|
  Producer.Name=="Renewable Target Investor FBL"
producerProfits2CountryC<-subset(producerProfits2,Producer.Name=="Energy Producer K"|
                                 Producer.Name=="Energy Producer L"|
                                 Producer.Name=="Energy Producer M"|
                                 Producer.Name=="Energy Producer N"|
                                 Producer.Name=="Energy Producer O"|
                                 Producer.Name=="Renewable Target Investor DE")
producerProfits3<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen3","ProducerProfits")
producerProfits3$modelRun <- rep("P2Scen3",nrow(producerProfits3))
producerProfits3CountryA<-subset(producerProfits3,Producer.Name=="Energy Producer A" |
                                                 Producer.Name=="Energy Producer B" |
                                                 Producer.Name=="Energy Producer C" |
                                                 Producer.Name=="Energy Producer D" |
                                                 Producer.Name=="Energy Producer E" |
                                                 Producer.Name=="Renewable Target Investor NL")
producerProfits3CountryB<-subset(producerProfits3,Producer.Name=="Energy Producer F")|
                                                  Producer.Name=="Energy Producer G"|
                                                  Producer.Name=="Energy Producer H"|
                                                  Producer.Name=="Energy Producer I"|
                                                  Producer.Name=="Energy Producer J"|
                                                  Producer.Name=="Renewable Target Investor FBL"
producerProfits3CountryC<-subset(producerProfits3,Producer.Name=="Energy Producer K"|
                                                   Producer.Name=="Energy Producer L"|
                                                   Producer.Name=="Energy Producer M"|
                                                   Producer.Name=="Energy Producer N"|
                                                   Producer.Name=="Energy Producer O"|
                                                   Producer.Name=="Renewable Target Investor DE")
producerProfits4<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen4","producerProfits")
producerProfits4$modelRun <- rep("P2Scen4",nrow(producerProfits4))
producerProfits4CountryA<-subset(producerProfits4,Producer.Name=="Energy Producer A" |
                                 Producer.Name=="Energy Producer B" |
                                 Producer.Name=="Energy Producer C" |
                                 Producer.Name=="Energy Producer D" |
                                 Producer.Name=="Energy Producer E" |
                                 Producer.Name=="Renewable Target Investor NL")
producerProfits4CountryB<-subset(producerProfits4,Producer.Name=="Energy Producer F")|
                                  Producer.Name=="Energy Producer G"|
                                  Producer.Name=="Energy Producer H"|
                                  Producer.Name=="Energy Producer I"|
                                  Producer.Name=="Energy Producer J"|
                                  Producer.Name=="Renewable Target Investor FBL"
producerProfits4CountryC<-subset(producerProfits4,Producer.Name=="Energy Producer K"|
                                 Producer.Name=="Energy Producer L"|
                                 Producer.Name=="Energy Producer M"|
                                 Producer.Name=="Energy Producer N"|
                                 Producer.Name=="Energy Producer O"|
                                 Producer.Name=="Renewable Target Investor DE")
producerProfits5<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen5","producerProfits")
producerProfits5$modelRun <- rep("P2Scen5",nrow(producerProfits5))
producerProfits5CountryA<-subset(producerProfits5,Producer.Name=="Energy Producer A" |
                                 Producer.Name=="Energy Producer B" |
                                 Producer.Name=="Energy Producer C" |
                                 Producer.Name=="Energy Producer D" |
                                 Producer.Name=="Energy Producer E" |
                                 Producer.Name=="Renewable Target Investor NL")
producerProfits5CountryB<-subset(producerProfits5,Producer.Name=="Energy Producer F")|
                                  Producer.Name=="Energy Producer G"|
                                  Producer.Name=="Energy Producer H"|
                                  Producer.Name=="Energy Producer I"|
                                  Producer.Name=="Energy Producer J"|
                                  Producer.Name=="Renewable Target Investor FBL"
producerProfits5CountryC<-subset(producerProfits5,Producer.Name=="Energy Producer K"|
                                 Producer.Name=="Energy Producer L"|
                                 Producer.Name=="Energy Producer M"|
                                 Producer.Name=="Energy Producer N"|
                                 Producer.Name=="Energy Producer O"|
                                 Producer.Name=="Renewable Target Investor DE")
producerProfitsAllCountryA<-rbind(producerProfits1CountryA,producerProfits2CountryA,producerProfits3CountryA,producerProfits4CountryA,producerProfits5CountryA)
producerProfitsAllCountryB<-rbind(producerProfits1CountryB,producerProfits2CountryB,producerProfits3CountryB,producerProfits4CountryB,producerProfits5CountryB)
producerProfitsAllCountryC<-rbind(producerProfits1CountryC,producerProfits2CountryC,producerProfits3CountryC,producerProfits4CountryC,producerProfits5CountryC)

#TEMPORARY LINES FOR TESTING
colnames(producerProfits1CountryA)[which(names(producerProfits1CountryA) == "Tick")] <- "tick"
colnames(producerProfits1CountryB)[which(names(producerProfits1CountryB) == "Tick")] <- "tick"
colnames(producerProfits1CountryC)[which(names(producerProfits1CountryC) == "Tick")] <- "tick"
producerProfitsAllCountryA<-producerProfits1CountryA
producerProfitsAllCountryB<-producerProfits1CountryB
producerProfitsAllCountryC<-producerProfits1CountryC
colnames(producerProfitsAllCountryA)[which(names(producerProfitsAllCountryA) == "Tick")] <- "tick"
colnames(producerProfitsAllCountryB)[which(names(producerProfitsAllCountryB) == "Tick")] <- "tick"
colnames(producerProfitsAllCountryC)[which(names(producerProfitsAllCountryC) == "Tick")] <- "tick"
##########

avgPriceBoxplotData<-ddply(bigDF, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunIdAverage, sum, "Avg_El_PricesinEURpMWh_Country.A")
consumerCostBoxplotData<-subset(bigDF, tick==39)
consumerCostBoxplotData<-ddply(consumerCostBoxplotData, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunId,function(x){x}, "SpotMarketCash_Country.A.electricity.spot.market")
producerCashBoxPlotData<-ddply(bigDF, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunIdAverage, sum, "TotalProducerCashSum")
stakeholderCashBoxPlotData<-ddply(bigDF, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunIdAverage, sum, "StakeholderCashSum")
co2PriceBoxPlotData<-ddply(bigDF, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunId, sum, "CO2Price_Decarbonization.Model")
theme_publication()

elpriceBoxplot<-qplot(x=modelRun, y=V1, data=avgPriceBoxplotData, geom="boxplot")+xlab("Scenario")+ylab(" Avg. Electricity Price")+theme_grey(base_size=13)
if(showPlots) elpriceBoxplot
if(savePlots) ggsave(filename= paste(filePrefix, "electricityPriceBoxplot.pdf", sep=""),plot=elpriceBoxplot, width=30, height=20, units="cm", scale=scaleFactor)

capMarketPriceBoxplotData<-ddply(capacityMarketPricesAll, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "price")
capMarketVolumeBoxplotData<-ddply(capacityMarketPricesAll, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "volume")

producerCostsBoxplotDataCountryA<-ddply(producerCostsAllCountryA, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "Money")
producerCostsBoxplotDataCountryB<-ddply(producerCostsAllCountryB, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "Money")
producerCostsBoxplotDataCountryC<-ddply(producerCostsAllCountryC, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "Money")

producerProfitsBoxplotDataCountryA<-ddply(producerProfitsAllCountryA, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "Money")
producerProfitsBoxplotDataCountryB<-ddply(producerProfitsAllCountryB, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "Money")
producerProfitsBoxplotDataCountryC<-ddply(producerProfitsAllCountryC, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "Money")

capMarketPricePlotinA<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(capacityMarketPricesAll, "price", "Capacity Market Price in Country A [EUR/MW]")
if(showPlots) capMarketPricePlotinA
if(savePlots) ggsave(filename= paste(filePrefix, "capMarketPrices.pdf", sep=""),plot=capMarketPricePlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

capMarketPriceBoxPlot<-qplot(x=modelRun, y=V1, data=capMarketPriceBoxplotData, geom="boxplot")+xlab("Scenario")+ylab(" Avg. Electricity Price")+theme_grey(base_size=13)
if(showPlots) capMarketPriceBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "capMarketPricesBoxPlot.pdf", sep=""),plot=capMarketPriceBoxPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

capMarketVolumePlotinA<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(capacityMarketPricesAll, "volume", "Capacity Market Clearing Volume in Country A [EUR/MW]")
if(showPlots) capMarketVolumePlotinA
if(savePlots) ggsave(filename= paste(filePrefix, "capMarketClearingVolume.pdf", sep=""),plot=capMarketVolumePlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

capMarketVolumeBoxPlot<-qplot(x=modelRun, y=V1, data=capMarketVolumeBoxplotData, geom="boxplot")+xlab("Scenario")+ylab("Capacity Market Clearing Volume")+theme_grey(base_size=13)
if(showPlots) capMarketVolumeBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "capMarketClearingVolumeBoxPlot.pdf", sep=""),plot=capMarketVolumeBoxPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

consumerCostsPlot<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "SpotMarketCash_Country.A.electricity.spot.market", "Consumer Costs")
if(showPlots) consumerCostsPlot
if(savePlots) ggsave(filename= paste(filePrefix, "consumerCostsPlotinA.pdf", sep=""),plot=consumerCostsPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

consumerCostBoxplot<-qplot(x=modelRun, y=V1, data=consumerCostBoxplotData, geom="boxplot")+xlab("Scenario")+ylab("Consumer Costs")+theme_grey(base_size=13)
if(showPlots) consumerCostBoxplot
if(savePlots) ggsave(filename= paste(filePrefix, "consumerCostBoxplot.pdf", sep=""),plot=consumerCostBoxplot, width=30, height=20, units="cm", scale=scaleFactor)

capMarketDemandTarget1<-meltPrefixVariables(bigDF3,"CapacityMarketDemandTarget_Country.A")
capMarketDemandTarget1$modelRun<- rep("P1Scen3",nrow(capMarketDemandTarget1))
capMarketDemandTarget2<-meltPrefixVariables(bigDF4,"CapacityMarketDemandTarget_Country.A")
capMarketDemandTarget2$modelRun<- rep("P1Scen4",nrow(capMarketDemandTarget2))
capMarketDemandTarget3<-meltPrefixVariables(bigDF5,"CapacityMarketDemandTarget_Country.A")
capMarketDemandTarget3$modelRun<- rep("P1Scen5",nrow(capMarketDemandTarget3))
capMarketDemandTargets<-rbind(capMarketDemandTarget1,capMarketDemandTarget2,capMarketDemandTarget3)
capMarketDemandTargetsBoxPlotData<-ddply(capMarketDemandTargets, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "value")

drTotalDemandShifted1<-meltPrefixVariables(bigDF2,"SpotMarketTotalElasticDemand_Country.A.electricity.spot.market")
drTotalDemandShifted1$modelRun<-rep("P1Scen2",nrow(drTotalDemandShifted1))
drTotalDemandShifted2<-meltPrefixVariables(bigDF4,"SpotMarketTotalElasticDemand_Country.A.electricity.spot.market")
drTotalDemandShifted2$modelRun<-rep("P1Scen4",nrow(drTotalDemandShifted2))
drTotalDemandShifted3<-meltPrefixVariables(bigDF5,"SpotMarketTotalElasticDemand_Country.A.electricity.spot.market")
drTotalDemandShifted3$modelRun<-rep("P1Scen5",nrow(drTotalDemandShifted3))
drTotalDemandShifted<-rbind(drTotalDemandShifted1,drTotalDemandShifted2,drTotalDemandShifted3)

storageCapacity1<-meltPrefixVariables(bigDF2,"StorageCapacity_Storage.Unit.for.NL.ESM")
storageCapacity1$modelRun<-rep("P1Scen2",nrow(storageCapacity1))
storageCapacity2<-meltPrefixVariables(bigDF4,"StorageCapacity_Storage.Unit.for.NL.ESM")
storageCapacity2$modelRun<-rep("P1Scen4",nrow(storageCapacity2))
storageCapacity3<-meltPrefixVariables(bigDF5,"StorageCapacity_Storage.Unit.for.NL.ESM")
storageCapacity3$modelRun<-rep("P1Scen5",nrow(storageCapacity2))
storageCapacityAll<-rbind(storageCapacity1,storageCapacity2,storageCapacity3)

storageDischarge1<-meltPrefixVariables(bigDF2,"StorageDischargingCycles_Storage.Unit.for.NL.ESM")
storageDischarge1$modelRun<-rep("P1Scen2",nrow(storageDischarge1))
storageDischarge1$value<-(storageDischarge1$value)/2
storageDischarge2<-meltPrefixVariables(bigDF4,"StorageDischargingCycles_Storage.Unit.for.NL.ESM")
storageDischarge2$modelRun<-rep("P1Scen4",nrow(storageDischarge2))
storageDischarge2$value<-(storageDischarge2$value)/2
storageDischarge3<-meltPrefixVariables(bigDF5,"StorageDischargingCycles_Storage.Unit.for.NL.ESM")
storageDischarge3$modelRun<-rep("P1Scen5",nrow(storageDischarge3))
storageDischarge3$value<-(storageDischarge3$value)/2
storageDischargeAll<-rbind(storageDischarge1,storageDischarge2,storageDischarge3)

capMarketDemandTargetPlot<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(capMarketDemandTargets, "value", "Cap. Market Demand Target")
if(showPlots) capMarketDemandTargetPlot
if(savePlots) ggsave(filename= paste(filePrefix, "capMarketDemandTarget.pdf", sep=""),plot=capMarketDemandTargetPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

capMarketDemandTargetBoxPlot<-qplot(x=modelRun, y=V1, data=capMarketDemandTargetsBoxPlotData, geom="boxplot")+xlab("Scenario")+ylab("Consumer Costs")+theme_grey(base_size=13)
if(showPlots) capMarketDemandTargetBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "capMarketDemandTargetBoxPlot.pdf", sep=""),plot=capMarketDemandTargetBoxPlot, width=30, height=20, units="cm", scale=scaleFactor)

drTotalDemandShiftedPlot<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(drTotalDemandShifted, "value", "Total Demand Shifted")
if(showPlots) drTotalDemandShiftedPlot
if(savePlots) ggsave(filename= paste(filePrefix, "totalDemandShifted.pdf", sep=""),plot=drTotalDemandShiftedPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

storageCapacityPlot<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(storageCapacityAll, "value", "Storage Capacity")
if(showPlots) storageCapacityPlot
if(savePlots) ggsave(filename= paste(filePrefix, "storageCapacity.pdf", sep=""),plot=storageCapacityPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

storageDischargePlot<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(storageDischargeAll, "value", "Storage Discharging Cycles")
if(showPlots) storageDischargePlot
if(savePlots) ggsave(filename= paste(filePrefix, "storageDischargeCycles.pdf", sep=""),plot=storageDischargePlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

shortageInHoursCountryA<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "ShortageInHours_Country.A", "Shortage in Hours in Country A [h]")
if(showPlots) shortageInHoursCountryA
if(savePlots) ggsave(filename= paste(filePrefix, "shortageinA.pdf", sep=""),plot=shortageInHours, width=15.66, height=10.44, units="cm", scale=scaleFactor)

shortageInHoursCountryB<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "ShortageInHours_Country.B", "Shortage in Hours in Country B [h]")
if(showPlots) shortageInHoursCountryB
if(savePlots) ggsave(filename= paste(filePrefix, "shortageinB.pdf", sep=""),plot=shortageInHours, width=15.66, height=10.44, units="cm", scale=scaleFactor)

shortageInHoursCountryC<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "ShortageInHours_Country.C", "Shortage in Hours in Country A [h]")
if(showPlots) shortageInHoursCountryC
if(savePlots) ggsave(filename= paste(filePrefix, "shortageinC.pdf", sep=""),plot=shortageInHours, width=15.66, height=10.44, units="cm", scale=scaleFactor)

unservedEnergy<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "EnergyNotServedinMWh_Country.A", "Energy Not Served in Country A [MWh]")
if(showPlots) unservedEnergy
if(savePlots) ggsave(filename= paste(filePrefix, "unservedEnergyinA.pdf", sep=""),plot=unservedEnergy, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerCash<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "TotalProducerCashSum", "Total Producer Cash [EUR]")
if(showPlots) producerCash
if(savePlots) ggsave(filename= paste(filePrefix, "totalProducerCashinCountryA.pdf", sep=""),plot=producerCash, width=15.66, height=10.44, units="cm", scale=scaleFactor)

stakeholderCash<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "StakeholderCashSum", "Total Stakeholder Cash [EUR]")
if(showPlots) stakeholderCash
if(savePlots) ggsave(filename= paste(filePrefix, "totalStakeholderCashinCountryA.pdf", sep=""),plot=stakeholderCash, width=15.66, height=10.44, units="cm", scale=scaleFactor)


producerCashBoxPlot<-qplot(x=modelRun, y=V1, data=producerCashBoxPlotData, geom="boxplot")+xlab("Scenario")+ylab("Producer Cash [EUR]")+theme_grey(base_size=13)
if(showPlots) producerCashBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "totalProducerCashBoxPlot.pdf", sep=""),plot=producerCashBoxPlot, width=30, height=20, units="cm", scale=scaleFactor)

stakeholderCashBoxPlot<-qplot(x=modelRun, y=V1, data=stakeholderCashBoxPlotData, geom="boxplot")+xlab("Scenario")+ylab("Stakeholder Cash [EUR]")+theme_grey(base_size=13)
if(showPlots) stakeholderCashBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "totalStakeholderCashBoxPlot.pdf", sep=""),plot=stakeholderCashBoxPlot, width=30, height=20, units="cm", scale=scaleFactor)

co2Price<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "CO2Price_Decarbonization.Model", "CO2 Price [EUR]")
if(showPlots) co2Price
if(savePlots) ggsave(filename= paste(filePrefix, "co2Price.pdf", sep=""),plot=co2Price, width=15.66, height=10.44, units="cm", scale=scaleFactor)

co2PriceBoxPlot<-qplot(x=modelRun, y=V1, data=co2PriceBoxPlotData, geom="boxplot")+xlab("Scenario")+ylab("CO2 Price [EUR]")+theme_grey(base_size=13)
if(showPlots) co2PriceBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "co2PriceBoxPlot.pdf", sep=""),plot=co2PriceBoxPlot, width=30, height=20, units="cm", scale=scaleFactor)

producerCostsPlotinA<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(producerCostsBoxplotDataCountryA, "V1", "Producer Costs in Country A [EUR]")
if(showPlots) producerCostsPlotinA
if(savePlots) ggsave(filename= paste(filePrefix, "producerCostsPlotinA.pdf", sep=""),plot=producerCostsPlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerCostsPlotinB<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(producerCostsBoxplotDataCountryB, "V1", "Producer Costs in Country B [EUR]")
if(showPlots) producerCostsPlotinB
if(savePlots) ggsave(filename= paste(filePrefix, "producerCostsPlotinB.pdf", sep=""),plot=producerCostsPlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerCostsPlotinC<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(producerCostsBoxplotDataCountryC, "V1", "Producer Costs in Country C [EUR]")
if(showPlots) producerCostsPlotinC
if(savePlots) ggsave(filename= paste(filePrefix, "producerCostsPlotinC.pdf", sep=""),plot=producerCostsPlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerCostsAllCountriesPlot<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun3Countries(producerCostsBoxplotDataCountryA,producerCostsBoxplotDataCountryB,producerCostsBoxplotDataCountryC,"V1","V1","V1","Producer Costs")

producerProfitsPlotinA<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(producerProfitsBoxplotDataCountryA, "V1", "Producer Costs in Country A [EUR]")
if(showPlots) producerProfitsPlotinA
if(savePlots) ggsave(filename= paste(filePrefix, "producerProfitsPlotinA.pdf", sep=""),plot=producerProfitsPlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerProfitsPlotinB<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(producerProfitsBoxplotDataCountryB, "V1", "Producer Costs in Country B [EUR]")
if(showPlots) producerProfitsPlotinB
if(savePlots) ggsave(filename= paste(filePrefix, "producerProfitsPlotinB.pdf", sep=""),plot=producerProfitsPlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerProfitsPlotinC<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(producerProfitsBoxplotDataCountryC, "V1", "Producer Costs in Country C [EUR]")
if(showPlots) producerProfitsPlotinC
if(savePlots) ggsave(filename= paste(filePrefix, "producerProfitsPlotinC.pdf", sep=""),plot=producerProfitsPlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerProfitsAllCountriesPlot<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun3Countries(producerProfitsBoxplotDataCountryA,producerProfitsBoxplotDataCountryB,producerProfitsBoxplotDataCountryC,"V1","V1","V1","Producer Profits")



producerCostsBoxPlot<-qplot(x=modelRun, y=V1, data=producerCostsBoxplotData, geom="boxplot")+xlab("Scenario")+ylab(" Producer Costs [EUR]")+theme_grey(base_size=13)
if(showPlots) producerCostsBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "producerCostsBoxPlot.pdf", sep=""),plot=producerCostsBoxPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerProfitsBoxPlot<-qplot(x=modelRun, y=V1, data=producerProfitsBoxplotData, geom="boxplot")+xlab("Scenario")+ylab(" Producer Profits [EUR]")+theme_grey(base_size=13)
if(showPlots) producerProfitsBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "producerProfitsBoxPLot.pdf", sep=""),plot=producerProfitsBoxPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

bigDF <- addSupplyRatiosNew(bigDF)
supplyRatioPlot1<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(bigDF, "SupplyRatio_Country.A", "Supply Ratio Jorn")
if(showPlots) supplyRatioPlot1
supplyRatioPlot2<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(bigDF, "SupplyRatio_Country.B", "Supply Ratio Jorn")
if(showPlots) supplyRatioPlot2
supplyRatioPlot3<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(bigDF, "SupplyRatio_Country.C", "Supply Ratio Jorn")
if(showPlots) supplyRatioPlot3

supplyRatiosAllCountriesPlot<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun3Countries(bigDF,bigDF,bigDF,"SupplyRatio_Country.A","SupplyRatio_Country.B","SupplyRatio_Country.C","Producer Costs")


peakSupply2<-meltPrefixVariables(bigDF,"TotalOperationalIntermittentCapacityPerZoneInMW_Country.A")
peakSupply2$value<-peakSupply2$value*0.1
temp<-meltPrefixVariables(bigDF,"TotalOperationalNonIntermittentCapacityPerZoneInMW_Country.A")
peakSupply2$value<-peakSupply2$value+temp$value

supplyRatio2<-cbind(peakSupply2)
supplyRatio2$value<-(peakSupply2$value)/(peakDemand1$value)
supplyRatioPlot2<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(supplyRatio2, "value", "Supply Ratio 2")
if(showPlots) supplyRatioPlot2
if(savePlots) ggsave(filename= paste(filePrefix, "supplyRatio2.pdf", sep=""),plot=supplyRatioPlot2, width=15.66, height=10.44, units="cm", scale=scaleFactor)

capacities1<-getTableForRunId("~/Desktop/emlabGen/output/P2/","P2Scen1","CapacityinMWPerTechPerZone")
#capacities1$modelRun <- rep("P2Scen1",nrow(capacities1))
capacitiesCountryA<-capacities1[capacities1$market=="Country A electricity spot market",]
capacitiesCountryB<-capacities1[capacities1$market=="Country B electricity spot market",]
capacitiesCountryC<-capacities1[capacities1$market=="Country C electricity spot market",]
capacitiesCountryA$market<-NULL
capacitiesCountryA$modelRun <- rep("Country A",nrow(capacitiesCountryA))
colnames(capacitiesCountryA)[which(names(capacitiesCountryA) == "technology")] <- "variable"
colnames(capacitiesCountryA)[which(names(capacitiesCountryA) == "capacity")] <- "value"
capacitiesCountryB$market<-NULL
capacitiesCountryB$modelRun <- rep("Country B",nrow(capacitiesCountryB))
colnames(capacitiesCountryB)[which(names(capacitiesCountryB) == "technology")] <- "variable"
colnames(capacitiesCountryB)[which(names(capacitiesCountryB) == "capacity")] <- "value"
capacitiesCountryC$market<-NULL
capacitiesCountryC$modelRun <- rep("Country C",nrow(capacitiesCountryC))
colnames(capacitiesCountryC)[which(names(capacitiesCountryC) == "technology")] <- "variable"
colnames(capacitiesCountryC)[which(names(capacitiesCountryC) == "capacity")] <- "value"

capacitiesCountryA$value<-capacitiesCountryA$value/1000
capacitiesCountryB$value<-capacitiesCountryB$value/1000
capacitiesCountryC$value<-capacitiesCountryC$value/1000

stackedCapacities<-plotStackedTechnologyDiagram3Countries(capacitiesCountryA,capacitiesCountryB,capacitiesCountryC)
if(savePlots) ggsave(filename= paste(filePrefix, "stackedCapacityDiagram.pdf", sep=""),plot=stackedCapacities, width= 17, height= 17, units="cm", scale=scaleFactor)


avgPrices<-meltPrefixVariables(bigDF,"Avg_El_PricesinEURpMWh_")
avgPrice3CountryPlot<-plotMoltenVariableFacettedByVariable3Countries(avgPrices,"Average Price")
if(showPlots) avgPrice3CountryPlot
if(savePlots) ggsave(filename= paste(filePrefix, "avgprice3country_unfaceted.pdf", sep=""),plot=avgPrice3CountryPlot, width= 27, height= 17, units="cm", scale=scaleFactor)

shortages<-meltPrefixVariables(bigDF,"ShortageInHours_")
shortagesPlot<-plotMoltenVariableFacettedByVariable3Countries(shortages,"Shortage [h]")
if(showPlots) shortagesPlot
if(savePlots) ggsave(filename= paste(filePrefix, "shorateplot.pdf", sep=""),plot=shortagesPlot, width= 27, height= 17, units="cm", scale=scaleFactor)


intCongestion<-meltPrefixVariables(bigDF,"InterconnectorCongestion_")
intPriceConv<-meltPrefixVariables(bigDF,"InterconnectorPriceConvergence_")
congestionPlot<-plotMoltenVariableFacettedByVariable3Countries(intCongestion,"Interconnector Congestion [h]")
if(showPlots) congestionPlot
priceconvPlot<-plotMoltenVariableFacettedByVariable3Countries(intPriceConv,"Interconnector Congestion [h]")
if(showPlots) priceconvPlot

