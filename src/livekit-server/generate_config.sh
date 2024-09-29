#!/bin/sh

# Function to generate a random 32-character string
generate_key() {
  # Use /dev/urandom, tr, and head, all of which are available in Alpine
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 32
}

# Generate random keys
key1=$(generate_key)
key2=$(generate_key)

# Create config.yaml with the generated keys
cat <<EOL > /config/config.yaml
port: 7880

keys:
  key1: $key1
  key2: $key2
EOL

# Print confirmation
echo "config.yaml created with the following keys:"
echo "key1: $key1"
echo "key2: $key2"