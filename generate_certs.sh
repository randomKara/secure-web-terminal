#!/bin/bash
#
# Script to generate self-signed SSL certificates for Apache
#

# Configuration variables
CERT_DIR="/etc/apache2/ssl"
CERT_FILE="$CERT_DIR/server.crt"
KEY_FILE="$CERT_DIR/server.key"
DAYS_VALID=365
COUNTRY="FR"
STATE="Paris"
LOCALITY="Paris"
ORGANIZATION="Secure Terminal"
ORGANIZATIONAL_UNIT="DevOps"
COMMON_NAME="localhost"
EMAIL="admin@example.com"

# Create directory if it doesn't exist
mkdir -p $CERT_DIR

# Check if certificates already exist
if [ -f "$CERT_FILE" ] && [ -f "$KEY_FILE" ]; then
    echo "SSL certificates already exist. Skipping generation."
    exit 0
fi

# Generate SSL certificates
echo "Generating self-signed SSL certificates..."
openssl req -x509 -nodes -days $DAYS_VALID -newkey rsa:2048 \
    -keyout "$KEY_FILE" -out "$CERT_FILE" \
    -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORGANIZATIONAL_UNIT/CN=$COMMON_NAME/emailAddress=$EMAIL"

# Set proper permissions
chmod 600 "$KEY_FILE"
chmod 644 "$CERT_FILE"

echo "SSL certificates generated successfully:"
echo "Certificate: $CERT_FILE"
echo "Private Key: $KEY_FILE" 