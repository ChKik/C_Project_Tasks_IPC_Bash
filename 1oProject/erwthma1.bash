#!/bin/bash

#Anastasia Soulele 1084612
#Xaritwn Kikidhs 1084595
#Vasilikh Nasielh 1090035
#Theodwros Platwnas 1090073

echo "Enter the name of the file: "
read filename 

#Elegxos an to filename exei swsto extension.  
if [[ $filename == *.log ]]
then 
    echo "The log file exists"
else
    echo "Wrong File Argument"
    
fi

#Erwthma 1
#Otan ekteloume to programma logparser xwris kamia parametro tote tha emfanizei mono ta AM twn melwn ths omadas mas.

if [ $# -eq 0 ];
then 
    echo "------------------------------------------ "
    echo "1084612|1084595|1090035|1090073"

fi


#Erwthma 2
#Otan ekteloume to programma logparser me mia parametro tote tha emfanizei ola ta periexomena tou arxeiou.
if [ $# -eq 1 ];
then 
    awk '{print $0}' $filename 
    
fi 

#Erwthma 3
#An sthn klhsh ths sunarthshs tou dwsoume sugkekrimeno tupo user tote tupwnei ta periexomena tou arxeiou pou aforoun ton sugkerimeno tupo kai tis emfaniseis tou, diaforetika psaxnei olous tous users kai metra tis emfaniseis tous.

if [[ $# == 3 && $2 == "--userid" ]];
then 
     echo "-----------------------------------------------"
     echo "The $3 users are:  "
     
     type=$3
     
     awk -v var="$type" '$3 ~ var {print $0}' $filename 
     
    
elif [[ $# == 2 && $2 == "--userid" ]];
then 
     echo "-----------------------------------------------"
     echo "The number of the users: "
     
     mining_usernames() {  
     
        cat $filename | awk '{print $3}' | sort | uniq -c
        
      }
      
     mining_usernames;
 
fi



#Erwthma 4
#Analoga me ton tupo ths methodou pou epilegei o xrhsths tupwnei kai ta antistoixa periexomena.

if [[ $# == 3 && $2 == "-method" ]];
then 
    methodtype=$3
    
    case $3 in 
          GET) awk -v var="$methodtype" '$7 ~ var {print $0}' $filename  
                ;;
        
        
          POST) awk -v var="$methodtype" '$7 ~ var {print $0}' $filename   
                 ;;
        
        
              *) echo "----------------------------------"
                 echo "Wrong Method Name" 
                 ;;
        
     esac
     
     
elif [[ $# == 2 && $2 == "-method" ]];
then  
    echo "----------------------------------"
    echo "Wrong Method Name"   
  
fi



#Erwthma 5
#Analoga me ton tupo prwtokollou pou epilegei o xrhsths tupwnei kai ta antistoixa periexomena.

if [[ $# == 3 && $2 == "--servprot" ]];
then 
    servtype=$3
    
    
    case $3 in 
          IPv4) awk -v var="127.0.0.1" '$1 ~ var {print $0}' $filename  
                ;;
        
        
          IPv6) awk -v var="::1" '$1 ~ var {print $0}' $filename   
                 ;;
        
        
              *) echo "----------------------------------"
                 echo "Wrong Network Protocol" 
                 ;;
        
     esac
     
     
elif [[ $# == 2 && $2 == "--servprot" ]];
then  
    echo "----------------------------------"
    echo "Wrong Network Portocol"   
  
fi




#Erwthma 6
#Ektupwnei to eidos kai to plhthos twn browsers pou uparxoun sto arxeio. 

if [[ $# == 2 && $2 == "--browsers" ]];
then 

    echo "------------------------------------"
    echo "The number of the browsers are: "
    
    
    match() {
    
     awk -v var1="Mozilla" '$0 ~ var1 {print var1}' $filename | sort 
     awk -v var2="Chrome" '$0 ~ var2 {print var2}'  $filename | sort
     awk -v var3="Safari" '$0 ~ var3 {print var3}'  $filename | sort
     awk -v var4="Edg" '$0 ~ var4 {print var4}'  $filename    |sort
  
     }
     
   
    count_browsers() {
    
     match | uniq -c
    
    }
     
     
     count_browsers;
fi 


#Erwthma 7 
#Analoga me ton mhna pou tha eisagei o xrhsths emfanizei kai ta antistoixa periexomena. 

if [[ $# == 3 && $2 == "--datum" ]];
then 
    date=$3

     case $3 in 
          Jan) awk -v var="$date" '$5 ~ var {print $0}' $filename  
                ;;
        
        
          Feb) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;
        
        
          Mar) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;
              
          Apr) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;
           
          May) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;
              
          Jun) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;
           
          Jul) awk -v var="$date" '$5 ~ var {print $0}' $filename  
           
                 ;;
          Aug) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;  
                 
          Sep) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;
                 
          Oct) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;
                 
          Nov) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;;
                 
          Dec) awk -v var="$date" '$5 ~ var {print $0}' $filename   
                 ;; 
                            
                            
              *) echo "----------------------------------"
                 echo "Wrong Date" 
                 ;;
        
     esac
     
     
elif [[ $# == 2 && $2 == "--datum" ]];
then  
    echo "----------------------------------"
    echo "Wrong Date"   
  
fi