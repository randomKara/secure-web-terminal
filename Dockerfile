# Use Ubuntu as base image
FROM ubuntu:latest

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
# Use --no-install-recommends to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    apache2 \
    build-essential \
    ca-certificates \
    cmake \
    git \
    libjson-c-dev \
    libssl-dev \
    libuv1-dev \
    libwebsockets-dev \
    openssl \
    ssl-cert \
    tzdata \
    wget \
    curl \
    procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Apache modules
RUN a2enmod proxy proxy_http proxy_wstunnel ssl auth_basic rewrite

# Clone and build ttyd from source with specific version to ensure stability
WORKDIR /tmp
RUN git clone --depth=1 --branch 1.7.3 https://github.com/tsl0922/ttyd.git \
    && cd ttyd \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/ttyd

# Create directory for SSL certificates
RUN mkdir -p /etc/apache2/ssl

# Copy configuration files
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
COPY .htpasswd /etc/apache2/.htpasswd
COPY generate_certs.sh /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/

# Make scripts executable
RUN chmod +x /usr/local/bin/generate_certs.sh /usr/local/bin/entrypoint.sh

# Expose ports
EXPOSE 80 443

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command
CMD ["apache2ctl", "-D", "FOREGROUND"] 