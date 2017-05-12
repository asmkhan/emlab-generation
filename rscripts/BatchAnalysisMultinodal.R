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
bigDF <- getDataFrameForModelRunsInFolder("~/Desktop/emlabGen/output/P1/")
bigDF[is.na(bigDF)] <- 0
bigDF$SpotMarketCash_Country.A.electricity.spot.market<-abs(bigDF$SpotMarketCash_Country.A.electricity.spot.market)
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.A")] <- "TotalProducerCash_Stakeholder.A"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.B")] <- "TotalProducerCash_Stakeholder.B"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.C")] <- "TotalProducerCash_Stakeholder.C"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.D")] <- "TotalProducerCash_Stakeholder.D"
colnames(bigDF)[which(names(bigDF) == "TotalProducerStakeholderCash_Stakeholder.E")] <- "TotalProducerCash_Stakeholder.E"

bigDF<-addSumOfVariablesByPrefixToDF(bigDF,"TotalProducerCash")
bigDF<-addSumOfVariablesByPrefixToDF(bigDF,"StakeholderCash")

#bigDF$TotalProducerStakeholderCashSum<-abs(bigDF$TotalProducerStakeholderCashSum)
#Get data frames one by one
bigDF1<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P1/","P1Scen1", "")
bigDF2<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P1/","P1Scen2", "")
bigDF3<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P1/","P1Scen3", "")
bigDF4<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P1/","P1Scen4", "")
bigDF5<-getDataFrameForModelRun("~/Desktop/emlabGen/output/P1/","P1Scen5", "")

capacityMarketPrices3<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen3","CapacityClearingPoint")
capacityMarketPrices3$modelRun <- rep("P1Scen3",nrow(capacityMarketPrices3))
capacityMarketPrices4<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen4","CapacityClearingPoint")
capacityMarketPrices4$modelRun <- rep("P1Scen4",nrow(capacityMarketPrices4))
capacityMarketPrices5<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen5","CapacityClearingPoint")
capacityMarketPrices5$modelRun <- rep("P1Scen5",nrow(capacityMarketPrices5))

capacityMarketPricesAll<-rbind(capacityMarketPrices3,capacityMarketPrices4,capacityMarketPrices5)

producerCosts1<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen1","ProducerCosts")
producerCosts1$modelRun <- rep("P1Scen1",nrow(producerCosts1))
producerCosts2<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen2","ProducerCosts")
producerCosts2$modelRun <- rep("P1Scen2",nrow(producerCosts2))
producerCosts3<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen3","ProducerCosts")
producerCosts3$modelRun <- rep("P1Scen3",nrow(producerCosts3))
producerCosts4<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen4","ProducerCosts")
producerCosts4$modelRun <- rep("P1Scen4",nrow(producerCosts4))
producerCosts5<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen4","ProducerCosts")
producerCosts5$modelRun <- rep("P1Scen5",nrow(producerCosts5))

producerCostsAll<-rbind(producerCosts1,producerCosts2,producerCosts3,producerCosts4,producerCosts5)
colnames(producerCostsAll)[which(names(producerCostsAll) == "Tick")] <- "tick"

producerProfits1<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen1","ProducerProfits")
producerProfits1$modelRun <- rep("P1Scen1",nrow(producerProfits1))
producerProfits2<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen2","ProducerProfits")
producerProfits2$modelRun <- rep("P1Scen2",nrow(producerProfits2))
producerProfits3<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen3","ProducerProfits")
producerProfits3$modelRun <- rep("P1Scen3",nrow(producerProfits3))
producerProfits4<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen4","ProducerProfits")
producerProfits4$modelRun <- rep("P1Scen4",nrow(producerProfits4))
producerProfits5<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen4","ProducerProfits")
producerProfits5$modelRun <- rep("P1Scen5",nrow(producerProfits5))

producerProfitsAll<-rbind(producerProfits1,producerProfits2,producerProfits3,producerProfits4,producerProfits5)
colnames(producerProfitsAll)[which(names(producerProfitsAll) == "Tick")] <- "tick"

welfareBoxplotData<-ddply(bigDF, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunIdAverage, sum, "Avg_El_PricesinEURpMWh_Country.A")
consumerCostBoxplotData<-subset(bigDF, tick==39)
consumerCostBoxplotData<-ddply(consumerCostBoxplotData, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunId,function(x){x}, "SpotMarketCash_Country.A.electricity.spot.market")
producerCashBoxPlotData<-ddply(bigDF, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunIdAverage, sum, "TotalProducerCashSum")
stakeholderCashBoxPlotData<-ddply(bigDF, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunIdAverage, sum, "StakeholderCashSum")
co2PriceBoxPlotData<-ddply(bigDF, .variables=c("runId", "modelRun"),.fun=functionOfVariablePerRunId, sum, "CO2Price_Decarbonization.Model")


avgPricePlotinA<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "Avg_El_PricesinEURpMWh_Country.A", "Avg. Electricity Price in Country A [EUR/MW]")
if(showPlots) avgPricePlotinA
if(savePlots) ggsave(filename= paste(filePrefix, "avgPricePlotinA.pdf", sep=""),plot=avgPricePlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

elpriceBoxplot<-qplot(x=modelRun, y=V1, data=welfareBoxplotData, geom="boxplot")+xlab("Scenario")+ylab(" Avg. Electricity Price")+theme_grey(base_size=13)
if(showPlots) elpriceBoxplot
if(savePlots) ggsave(filename= paste(filePrefix, "electricityPriceBoxplot.pdf", sep=""),plot=elpriceBoxplot, width=30, height=20, units="cm", scale=scaleFactor)

capMarketPriceBoxplotData<-ddply(capacityMarketPricesAll, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "price")
capMarketVolumeBoxplotData<-ddply(capacityMarketPricesAll, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "volume")

producerCostsBoxplotData<-ddply(producerCostsAll, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "Money")
producerProfitsBoxplotData<-ddply(producerProfitsAll, .variables=c("runId", "modelRun","tick"),.fun=functionOfVariablePerRunId, sum, "Money")

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


# capMarketDemandTarget<-plotSpaghettiTimeSeries(bigDF3, "CapacityMarketDemandTarget_Country.A","trial","Time [a]", NULL, 8)
# if(showPlots) capMarketDemandTarget

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

shortageInHours<-plotTimeSeriesWithConfidenceIntervalByFacettedGroup(bigDF, "ShortageInHours_Country.A", "Shortage in Hours in Country A [h]")
if(showPlots) shortageInHours
if(savePlots) ggsave(filename= paste(filePrefix, "shortageinA.pdf", sep=""),plot=shortageInHours, width=15.66, height=10.44, units="cm", scale=scaleFactor)

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

producerCostsPlotinA<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(producerCostsBoxplotData, "V1", "Producer Costs in Country A [EUR]")
if(showPlots) producerCostsPlotinA
if(savePlots) ggsave(filename= paste(filePrefix, "producerCostsPlotinA.pdf", sep=""),plot=producerCostsPlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerCostsBoxPlot<-qplot(x=modelRun, y=V1, data=producerCostsBoxplotData, geom="boxplot")+xlab("Scenario")+ylab(" Producer Costs [EUR]")+theme_grey(base_size=13)
if(showPlots) producerCostsBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "producerCostsBoxPlot.pdf", sep=""),plot=producerCostsBoxPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerProfitsPlotinA<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(producerProfitsBoxplotData, "V1", "Producer Profits in Country A [EUR]")
if(showPlots) producerProfitsPlotinA
if(savePlots) ggsave(filename= paste(filePrefix, "producerProfitsPlotinA.pdf", sep=""),plot=producerProfitsPlotinA, width=15.66, height=10.44, units="cm", scale=scaleFactor)

producerProfitsBoxPlot<-qplot(x=modelRun, y=V1, data=producerProfitsBoxplotData, geom="boxplot")+xlab("Scenario")+ylab(" Producer Profits [EUR]")+theme_grey(base_size=13)
if(showPlots) producerProfitsBoxPlot
if(savePlots) ggsave(filename= paste(filePrefix, "producerProfitsBoxPLot.pdf", sep=""),plot=producerProfitsBoxPlot, width=15.66, height=10.44, units="cm", scale=scaleFactor)

# bigDF <- addSupplyRatiosNew(bigDF)
# supplyRatioPlot1<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(bigDF, "SupplyRatio_Country.A", "Supply Ratio Jorn")
# if(showPlots) supplyRatioPlot1

peakSupply1<-meltPrefixVariables(bigDF,"TotalOperationalCapacityPerZoneInMW_Country.A")
peakDemand1<-meltPrefixVariables(bigDF,"SpotMarketPeakLoad_Country.A.electricity.spot.market")
supplyRatio1<-cbind(peakSupply1)
supplyRatio1$value<-(peakSupply1$value)/(peakDemand1$value)
supplyRatioPlot1<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(supplyRatio1, "value", "Supply Ratio 1")
if(showPlots) supplyRatioPlot1
if(savePlots) ggsave(filename= paste(filePrefix, "supplyRatio1.pdf", sep=""),plot=supplyRatioPlot1, width=15.66, height=10.44, units="cm", scale=scaleFactor)


peakSupply2<-meltPrefixVariables(bigDF,"TotalOperationalIntermittentCapacityPerZoneInMW_Country.A")
peakSupply2$value<-peakSupply2$value*0.3
temp<-meltPrefixVariables(bigDF,"TotalOperationalNonIntermittentCapacityPerZoneInMW_Country.A")
peakSupply2$value<-peakSupply2$value+temp$value

supplyRatio2<-cbind(peakSupply2)
supplyRatio2$value<-(peakSupply2$value)/(peakDemand1$value)
supplyRatioPlot2<-plotTimeSeriesWithConfidenceIntervalByFacettedGroupWithoutModelRun(supplyRatio2, "value", "Supply Ratio 2")
if(showPlots) supplyRatioPlot2
if(savePlots) ggsave(filename= paste(filePrefix, "supplyRatio2.pdf", sep=""),plot=supplyRatioPlot2, width=15.66, height=10.44, units="cm", scale=scaleFactor)

capacities1<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen1","CapacityinMWPerTechPerZone")
capacities1$modelRun <- rep("P1Scen1",nrow(capacities1))
capacities2<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen2","CapacityinMWPerTechPerZone")
capacities2$modelRun <- rep("P1Scen2",nrow(capacities2))
capacities3<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen3","CapacityinMWPerTechPerZone")
capacities3$modelRun <- rep("P1Scen3",nrow(capacities3))
capacities4<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen4","CapacityinMWPerTechPerZone")
capacities4$modelRun <- rep("P1Scen4",nrow(capacities4))
capacities5<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen4","CapacityinMWPerTechPerZone")
capacities5$modelRun <- rep("P1Scen5",nrow(capacities5))

capacitiesAll<-rbind(capacities1,capacities2,capacities3,capacities4,capacities5)


capacitiesAll$market<-NULL
colnames(capacitiesAll)[which(names(capacitiesAll) == "technology")] <- "variable"
colnames(capacitiesAll)[which(names(capacitiesAll) == "capacity")] <- "value"

capacitiesAll$value<-capacitiesAll$value/1000
stackedCapacities<-plotStackedTechnologyDiagram(moltenVariable=capacitiesAll,ylabel="Capacity [GW]")
if(showPlots) stackedCapacities
if(savePlots) ggsave(filename= paste(filePrefix, "stackedCapacityDiagram.pdf", sep=""),plot=stackedCapacities, width= 15.66, height= 14, units="cm", scale=scaleFactor)

LDC<-getTableForRunId("~/Desktop/emlabGen/output/P1/","P1Scen3","PriceVolumeLengthInHoursPerSegment")

