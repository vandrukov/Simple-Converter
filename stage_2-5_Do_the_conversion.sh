#!/usr/bin/bash

echo "Enter a definition:"
read -a user_input
arr_length="${#user_input[@]}"
definition="${user_input[0]}"
constant="${user_input[1]}"
re='^[a-z]+_to_[a-z]+$'
num='^-?[0-9]+(.[0-9]+)?$'

if [[ "$definition" =~ $re &&  "$arr_length" == 2 ]]; then
    if [[ "$constant" =~ $num ]]; then
        echo "Enter a value to convert:";
        while true; do
            read value
            if [[ "$value" =~ $num ]]; then
                result=$(echo "scale=2; $constant * $value" | bc -l)
                echo "Result: $result"
                break
            else
                echo "Enter a float or integer value!"
            fi
        done
    else
        echo "The definition is incorrect!";
    fi
else
    echo "The definition is incorrect!";
fi
