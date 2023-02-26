#!/usr/bin/bash

echo "Welcome to the Simple converter!"

ask_action() {
echo -e "Select an option\n0. Type '0' or 'quit' to end program\n1. Convert units\n2. Add a definition\n3. Delete a definition"
}
while true; do
    ask_action
    read answer
    case $answer in
        0 | "quit" )
            echo "Goodbye!"
            break;;
        1 )
            echo "Not implemented!";;
        2 )
            echo "Not implemented!";;
        3 )
            echo "Not implemented!";;
        * )
            echo "Invalid option!";;
    esac
done
