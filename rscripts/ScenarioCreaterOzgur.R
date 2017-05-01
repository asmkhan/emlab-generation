#Placeholders

# Step 1 building the scenarios: insert dataframe and read the scenario file. Name parameters
# that need to be replaced with 
setwd("/home/sk/emlab-generation/emlab-generation/src/main/resources/scenarios/")
xmlFilePath="/home/sk/emlab-generation/emlab-generation/src/main/resources/scenarios/"
scenarioFolder="/home/sk/Desktop/scenario/"

# Step 2 building the scenarios: make separate data vectors

#Initialize parameters
noOfRepetitions = 40

nameList<-character()

#BASE CASE 
filePathAndName <- paste(xmlFilePath,"RQ2Scen1.xml",sep="")
filestump<-"RQ2Scen1"
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