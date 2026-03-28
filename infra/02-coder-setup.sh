#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/templates/coder-template"

# Coder API details
CODER_API_URL="https://workstation.aks-dev0.amp-cloud.net/api/v2"

# Define users in an array
USERS=(
    "team1"
    "team2"
    "team3"
    "team4"
    "team5"
    "team6"
    "team7"
    "team8"
    "team9"
    "team10"
    "team11"
    "team12"
    "team13"
    "team14"
    "team15"
    "team16"
    "team17"
    "team18"
    "team19"
    "team20"
    "team21"
    "team22"
    "team23"
    "team24"
    "team25"
    "team26"
    "team27"
    "team28"
    "team29"
    "team30"
)

## ================= Create Workspace Template =============================

coder templates push -d "$TEMPLATE_DIR" Workshop-Kubernetes -y

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
