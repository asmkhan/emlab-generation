#!/bin/bash
if [ -f emlabConfig.cfg ];then
        . emlabConfig.cfg
else
    echo "Define emlabConfig.cfg, by changing the template. Exiting sc\                                                                    
ript."
    exit
fi

sh $emlabHome/shellscripts/makeRamdisk.sh

#start model
cd $emlabModelFolder
echo $1
echo ¨passed¨
mvn exec:java $1
