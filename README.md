# Terminal Web Sécurisé avec Docker

Ce projet propose un terminal web sécurisé basé sur [ttyd](https://github.com/tsl0922/ttyd), servi à travers Apache en tant que reverse proxy avec une connexion HTTPS et une authentification basique.

## Caractéristiques

- Terminal web accessible via navigateur (ttyd)
- Communication HTTPS sécurisée
- Authentification HTTP Basic
- Certificats SSL auto-signés
- Docker et Docker Compose pour un déploiement facile

## Prérequis

- Docker
- Docker Compose

## Démarrage rapide

1. Cloner ce dépôt:
   ```bash
   git clone https://github.com/randomKara/secure-web-terminal.git
   cd secure-web-terminal
   ```

2. Construire et démarrer le conteneur:
   ```bash
   docker compose up
   ```

3. Accéder au terminal web:
   - Ouvrez votre navigateur et accédez à `https://localhost/terminal`
   - Acceptez le certificat auto-signé (avertissement de sécurité)
   - Entrez les identifiants par défaut:
     - Utilisateur: `admin`
     - Mot de passe: `admin`

## Configuration

### Changer les identifiants

Pour modifier le nom d'utilisateur/mot de passe par défaut, générez un nouveau fichier `.htpasswd`:

```bash
# Installation de l'outil htpasswd si nécessaire
sudo apt-get install apache2-utils

# Générer un nouveau fichier .htpasswd
htpasswd -c .htpasswd votre_utilisateur
```

### Personnaliser les certificats SSL

Pour utiliser vos propres certificats SSL au lieu des certificats auto-signés:

1. Placez vos certificats dans un répertoire local
2. Montez ce répertoire dans Docker Compose:
   ```yaml
   volumes:
     - ./chemin/vers/vos/certs:/etc/apache2/ssl
   ```

## Licence

MIT 
