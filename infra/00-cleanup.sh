#!/bin/bash


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

# Loop through users
for USER in "${USERS[@]}"; do
    kubectl delete namespace $USER
done