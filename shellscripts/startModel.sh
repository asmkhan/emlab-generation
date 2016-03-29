#!/bin/bash
if [ -f emlabConfig.cfg ];then
        . emlabConfig.cfg
else
    echo "Define emlabConfig.cfg, by changing the template. Exiting sc\                                                                    
ript."
    exit
fi

-Djava.library.path=/opt/ibm/ILOG/CPLEX_Studio1262/cplex/bin/x86-64_linux

sh $emlabHome/shellscripts/makeRamdisk.sh

#start model
cd $emlabModelFolder
mvn exec:java -Djava.library.path=/opt/ibm/ILOG/CPLEX_Studio1262/cplex/bin/x86-64_linux $1
