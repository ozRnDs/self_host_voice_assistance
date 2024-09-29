#!/bin/bash

# Function to generate a random 32-character string
generate_key() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}

# Generate random keys
key1=$(generate_key)
key2=$(generate_key)

# Create config.yaml with the generated keys
cat <<EOL > config.yaml
port: 7880

keys:
  key1: $key1
  key2: $key2
EOL

# Print confirmation
echo "config.yaml created with the following keys:"
echo "key1: $key1"
echo "key2: $key2"