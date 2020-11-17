#!/bin/bash

if [ -n "$1" ]&&[ "$2" ]&&[ "$3" ]&&[ $4 ];then
    echo `date` >> ./script.log

    if [[ "$1" =~ ^http://|^ftp://|^https ]]; then

        if curl -u $2:$3 $1 --fail --silent --show-error > tmp.text; then
            echo -e "\e[42mEverything is OK!\e[0m"

            if grep -q ".$4." ./tmp.text; then
                echo -e "OK" | tee -a ./script.log
                echo "Execution complite" >> ./script.log
            else
                echo "FAIL: no entry found." | tee -a ./script.log
            fi
            `rm ./tmp.text`
        else
            # Curl gives errors. ###
            echo "FAIL: see curl's errors." | tee -a ./script.log
        fi
    else
        echo -e "\e[31mERROR: First parameter should start with http://, ftp:// or https://\e[0m"
        exit 0
    fi
else
    echo -e "\e[31mERROR: You need to provide 4 parameters\e[0m"
    exit 0
fi
