#!/usr/bin/bash

echo "Welcome to the Simple converter!"

re='^[a-z]+_to_[a-z]+ -?[0-9]+(.[0-9]+)?$'
num='^-?[0-9]+(.[0-9]+)?$'
file_name="definitions.txt"

output_file() {
count=1
while IFS= read -r line
do
  echo "$count. $line"
  (( count++ ))
done < "$file_name"
}


ask_action() {
    echo -e "Select an option\n0. Type '0' or 'quit' to end program\n1. Convert units\n2. Add a definition\n3. Delete a definition"
}


add_definition() {
    while true; do
        echo "Enter a definition:"
        read user_input
        if [[ "$user_input" =~ $re ]]; then
            echo "$user_input" >> "$file_name"
            break
        else
            echo "The definition is incorrect!";
        fi
    done
}


delete_definition() {
    if [ -s $file_name ]; then
        # The file is not-empty.
        echo "Type the line number to delete or '0' to return"
        output_file
        num_lines=$(wc -l < $file_name)
        while true; do
            read number
            if [[ "$number" = "0" ]]; then
                break;
            elif [[ "$number" =~ $num && "$number" -le "$num_lines" ]]; then
                sed -i "${number}d" "$file_name"
                break
            
            else
                echo "Enter a valid line number!";

            fi   
        done
    else
        # The file is empty.
        echo "Please add a definition first!"
    fi
}


convert() {
    if [ -s $file_name ]; then
        # The file is not-empty.
        echo "Type the line number to convert units or '0' to return"
        output_file
        num_lines=$(wc -l < $file_name)
        while true; do
            read number
            if [[ "$number" = "0" ]]; then
                break;
            elif [[ "$number" =~ $num && "$number" -le "$num_lines" ]]; then
                echo "Enter a value to convert:"
                while true; do
                    read value
                    if [[ "$value" =~ $num ]]; then
                        line=$(sed "${number}!d" "$file_name")
                        read -a text <<< "$line"
                        definition="${text[0]}"
                        constant="${text[1]}"
                        result=$(echo "scale=2; $constant * $value" | bc -l)
                        echo "Result: $result"
                        break;
                    else
                        echo "Enter a float or integer value!"
                    fi
                done
                break;
            else
                echo "Enter a valid line number!";  
            fi
        done
    else
        # The file is empty.
        echo "Please add a definition first!"
    fi
}

while true; do
    ask_action
    read answer
    case $answer in
        0 | "quit" )
            echo "Goodbye!"
            break;;
        1 )
            convert;;
        2 )
            add_definition;;
        3 )
            delete_definition;;
        * )
            echo "Invalid option!";;
    esac
done
