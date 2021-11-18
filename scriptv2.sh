#!/bin/bash

# Checking how many kernels installed in my system ##

kernelcount=`rpm -q kernel | wc -l`
echo "We have total $kernelcount kernels installed in this system"

echo

# Creating a custom user #

echo "Provide the username which you want to create: " ; read customusername

grep $customusername /etc/passwd > /dev/null
if [ $? -ne 0 ];
then
        useradd $customusername
        echo "User $customusername successfully created"
else
        echo "Sorry, $customusername already exist, kindly check !"
fi

echo

# Service Management in Linux #

echo -n "Enter the name of service which you want to manage: " ; read customservice

echo -n "Provide the action you want to perform (start | stop | status): " ; read customaction

case $customaction in
        start)
                systemctl $customaction $customservice
                echo "Service $customservice successfully started"
                ;;
        stop)
                systemctl $customaction $customservice
                echo "Service $customservice successfully stopped"
                ;;

        status)
                echo "Displaying status of $customservice"
                echo "-----------------------------------"
                systemctl $customaction $customservice
                ;;
        *)
                echo "Unknown Action! Try again"
                ;;
        esac

# Traversing over multiple values #
echo
echo "Generating Shell for last 5 users present in /etc/passwd file"
for userlogins in `cat /home/glassbreak/userdetails | tail -5` ;
        do
                userpassword=`chage -l $userlogins | grep 'Last password change' | cut -d':' -f2-`
                echo -n "User $userlogins Last password change happened on $userpassword"
                echo
        done
