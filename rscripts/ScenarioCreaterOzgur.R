#Placeholders

# Step 1 building the scenarios: insert dataframe and read the scenario file. Name parameters
# that need to be replaced with 
#setwd("/home/sk/emlab-generation/emlab-generation/src/main/resources/scenarios/")
#xmlFilePath="/home/sk/emlab-generation/emlab-generation/src/main/resources/scenarios/"
setwd("/home/sk/Desktop/scenario/input/")
xmlFilePath="/home/sk/Desktop/scenario/input/"
scenarioFolder="/home/sk/Desktop/scenario/output/"

# Step 2 building the scenarios: make separate data vectors

#Initialize parameters
noOfRepetitions = 40

nameList<-character()

# Paper 1 Scenario 1
filePathAndName <- paste(xmlFilePath,"P1Scen1.xml",sep="")
filestump<-"P1Scen1"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}

# Paper 1 Scenario 2
filePathAndName <- paste(xmlFilePath,"P1Scen2.xml",sep="")
filestump<-"P1Scen2"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}

# Paper 1 Scenario 3
filePathAndName <- paste(xmlFilePath,"P1Scen3.xml",sep="")
filestump<-"P1Scen3"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}

# Paper 1 Scenario 4
filePathAndName <- paste(xmlFilePath,"P1Scen4.xml",sep="")
filestump<-"P1Scen4"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}

# Paper 1 Scenario 5
filePathAndName <- paste(xmlFilePath,"P1Scen5.xml",sep="")
filestump<-"P1Scen5"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}

# Paper 2 Scenario 1
filePathAndName <- paste(xmlFilePath,"P2Scen1.xml",sep="")
filestump<-"P2Scen1"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#demandGrowthTrendFBL", runID, xmlFileContent)
  xmlFileContent<-gsub("#demandGrowthTrendDE", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}

# Paper 2 Scenario 2
filePathAndName <- paste(xmlFilePath,"P2Scen2.xml",sep="")
filestump<-"P2Scen2"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#demandGrowthTrendFBL", runID, xmlFileContent)
  xmlFileContent<-gsub("#demandGrowthTrendDE", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}

# Paper 2 Scenario 3
filePathAndName <- paste(xmlFilePath,"P2Scen3.xml",sep="")
filestump<-"P2Scen3"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#demandGrowthTrendFBL", runID, xmlFileContent)
  xmlFileContent<-gsub("#demandGrowthTrendDE", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}

# Paper 2 Scenario 4
filePathAndName <- paste(xmlFilePath,"P2Scen4.xml",sep="")
filestump<-"P2Scen4"
for(runID in seq(1:noOfRepetitions))
{
  xmlFileContent<-readLines(filePathAndName, encoding = "UTF-8")
  xmlFileContent<-gsub("#demandGrowthTrendNL", runID, xmlFileContent)
  xmlFileContent<-gsub("#demandGrowthTrendFBL", runID, xmlFileContent)
  xmlFileContent<-gsub("#demandGrowthTrendDE", runID, xmlFileContent)
  xmlFileContent<-gsub("#coalPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#gasPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#biomassPrice", runID, xmlFileContent)
  xmlFileContent<-gsub("#uraniumPrice", runID, xmlFileContent)
  
  fileName<-paste(filestump, "-", runID, ".xml", sep="")
  writeLines(xmlFileContent,paste(scenarioFolder,fileName,sep=""))
  nameList<- cbind(nameList, fileName)
}