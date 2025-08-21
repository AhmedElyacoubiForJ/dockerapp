#!/bin/bash
# 🔧 Dieses Skript führt eine vollständige Docker-Bereinigung durch:
#    - Entfernt ungenutzte Images, gestoppte Container und verwaiste Volumes
#    - Loggt alle Aktionen mit Zeitstempel in ~/docker-clean.log
#    - Zeigt Statusmeldungen farbig im Terminal
#    - Behandelt Fehler elegant und meldet sie sichtbar

# 🎨 Farbdefinitionen
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 📅 Zeitstempel
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# 📁 Log-Datei
logfile="./docker-clean.log"

# 🖊️ Logging-Funktion
log() {
    local message="$1"
    local color="$2"  # optional

    # Terminal-Ausgabe mit Farbe
    if [ -n "$color" ]; then
        echo -e "${BLUE}[$timestamp]${NC} ${color}${message}${NC}"
    else
        echo -e "${BLUE}[$timestamp]${NC} ${message}"
    fi

    # Logdatei-Ausgabe ohne Farbcodes
    echo "[$timestamp] $message" >> "$logfile"
}



# ❗ Fehlerbehandlung
handle_error() {
    echo -e "${RED}Fehler beim Ausführen: $1${NC}" | tee -a "$logfile"
}

log "🚀 Docker Cleanup gestartet"

if docker image prune -f; then
    log "🧹 Unbenutzte Images entfernt" "$GREEN"
else
    handle_error "docker image prune"
fi

if docker container prune -f; then
    log "🧼 Gestoppte Container entfernt" "$GREEN"
else
    handle_error "docker container prune"
fi

if docker volume prune -f; then
    log "🧽 Unbenutzte Volumes entfernt" "$GREEN"
else
    handle_error "docker volume prune"
fi

log "✅ Docker Cleanup abgeschlossen" "$YELLOW"
