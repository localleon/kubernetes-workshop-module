#!/bin/bash

# Coder API details
CODER_API_URL="http://coder.gnomgnom.com/api/v2"

# Define users in an array
USERS=(
    "user1"
    "user2"
    "user3"
    "user4"
    "user5"
    "user6"
    "user7"
    "user8"
    "user9"
    "user10"

)

## ================= Create Workspace Template =============================

coder template push -d infra/templates/coder-template Workshop-Kubernetes -y

# Function to generate a passphrase
generate_passphrase() {
    WORDS=(apple banana cherry delta echo foxtrot golf hotel india juliet kilo lima mike november oscar papa quebec romeo sierra tango uniform victor whiskey xray yankee zulu)
    SPECIAL_CHARS=('@' '#' '$' '%' '&' '*' '!')
    
    WORD1=${WORDS[$RANDOM % ${#WORDS[@]}]}
    WORD2=${WORDS[$RANDOM % ${#WORDS[@]}]}
    WORD3=${WORDS[$RANDOM % ${#WORDS[@]}]}
    NUMBER=$((RANDOM % 100))
    SPECIAL=${SPECIAL_CHARS[$RANDOM % ${#SPECIAL_CHARS[@]}]}
    
    echo "$WORD1-$WORD2-$WORD3-$NUMBER-$SPECIAL"
}

# Declare an associative array to store credentials
declare -A USER_CREDENTIALS

# Iterate over the list of users and create them
for USERNAME in "${USERS[@]}"; do
    PASSWORD=$(generate_passphrase)
    USER_CREDENTIALS[$USERNAME]=$PASSWORD
    echo "Creating user: $USERNAME"
    
    coder users create -e "$USERNAME@example.com" -u "$USERNAME" -p "$PASSWORD"

    sleep 1 # Optional delay to avoid overwhelming the API

done


echo "-------------------------------"
echo "User creation process completed."

echo "Generated User Credentials:"
for USERNAME in "${!USER_CREDENTIALS[@]}"; do
    echo "Username: $USERNAME@example.com, Password: ${USER_CREDENTIALS[$USERNAME]}"
done
