#!/bin/bash
#
# Entrypoint script for secure terminal Docker container
#

# Enable Apache modules
a2enmod proxy proxy_http proxy_wstunnel ssl rewrite auth_basic

# Rewrite module est nécessaire pour la redirection HTTP -> HTTPS
a2enmod rewrite

# Generate SSL certificates if they don't exist
/usr/local/bin/generate_certs.sh

# Vérifier si Apache est correctement configuré
apachectl configtest

# Start ttyd with correct parameters
ttyd -d 2 -m 30 -p 7681 -t enableReconnect=true -t pingInterval=1 bash &

# Wait for ttyd to start
sleep 2

# Show ttyd process status
ps aux | grep ttyd

# Start Apache in foreground
exec "$@" 