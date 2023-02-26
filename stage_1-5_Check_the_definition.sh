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
        echo "The definition is correct!";
    else
        echo "The definition is incorrect!";
    fi
else
    echo "The definition is incorrect!";
fi
