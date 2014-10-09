#!/bin/bash

echo "Enter Number Of Classes You Are Enrolled In"
read numclasses

TOTALGPTS=0
TOTALHRS=0

function totgradepoints() {
echo `echo "scale=3; $1 * $2" | bc`
}

##################################################
while [ $numclasses -gt 0 ]
do
  echo "Enter Grade"
   read  GRADE #User enters their Grade
   case $GRADE in

     A | a  ) 
             SCALEVALUE=$( echo "4.0" | bc)
	     echo "Scale Value ==> ${SCALEVALUE}";;             
     A- | a- ) 
	      SCALEVALUE=$( echo "5.0" | bc)
  		 echo "Scale Value ==> ${SCALEVALUE}";;

     B+ | b+ ) 
 		SCALEVALUE=$( echo "3.4" | bc)
		 echo "Scale Value ==> ${SCALEVALUE}";;
     B- | b-  ) 
               SCALEVALUE=$( echo "3.0" | bc)
		 echo "Scale Value ==> ${SCALEVALUE}";;
     B | b )
	    SCALEVALUE=$( echo "2.8" | bc)
	     echo "Scale Value ==> ${SCALEVALUE}";;


    C+ | c+ ) SCALEVALUE=$(echo "2.3" | bc)
	  echo "Scale Value ==> ${SCALEVALUE}";;
 
    C | c  ) SCALEVALUE=$(echo "2.0" | bc)
	  echo "Scale Value ==> ${SCALEVALUE}";;

    C- | c- ) SCALEVALUE=$(echo "1.7" | bc)
   	   echo "Scale Value ==> ${SCALEVALUE}";;

    * ) echo "invalid letter"
 	exit 1
     ;;
  esac
  
    echo "Enter Credit Hours"
    read HOURS
   echo " "

    HOURSARRAY=( "${HOURSARRAY[@]}" "${HOURS}" )

      for i in ${HOURSARRAY[@]}; do #try to use $1?
  TOTALHRS=$( echo "$TOTALHRS + $i" | bc)
 done


       
     for a in "${LETTERGRADECHECK[*]}"
     do
        if [ "$a" == $GRADE ] ; then
          echo "already exists"
	  exit 1
        else
          LETTERGRADECHECK=( "${LETTERGRADECHECK[@]}" "${GRADE}" ) #used to test for duplicate letters
	  MYGRADEPOINT=$(totgradepoints $SCALEVALUE $HOURS)

	  TOTALSCALEARRAY=( "${TOTALSCALEARRAY[@]}" "${MYGRADEPOINT}" ) #sets new array with scale
        fi
     done

   for j in ${TOTALSCALEARRAY[@]}; do
     TOTALGPTS=$( echo "scale=3; $TOTALGPTS + $j" | bc)
   done

  runninggpa=$( echo "scale=3; $TOTALGPTS / $TOTALHRS" |bc)
  echo "Running GPA: $runninggpa"
  numclasses=$(( $numclasses - 1 ))
done

echo "Total Grade Points: $TOTALGPTS"
echo "Total Credit Hours: $TOTALHRS"

gpa=$( echo "scale=3; $TOTALGPTS / $TOTALHRS" |bc)
echo "Your GPA(Total Grade Points/Total Credit Hours: $gpa"
