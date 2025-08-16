#!/bin/bash

# 🔄 Schritt 1: Lade Konfigurationsdatei (.env-config)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_PATH="$SCRIPT_DIR/.env-config"

# 📁 Prüfe, ob .env-config existiert
if [ ! -f "$CONFIG_PATH" ]; then
  echo "❌ Fehler: .env-config nicht gefunden unter $CONFIG_PATH"
  exit 1
fi

# 📦 Lade ENV_FILE_PATH aus .env-config
source "$CONFIG_PATH"

# 🧠 Prüfe, ob ENV_FILE_PATH gesetzt ist
if [ -z "$ENV_FILE_PATH" ]; then
  echo "❌ Fehler: ENV_FILE_PATH ist nicht gesetzt."
  exit 1
fi

# 📡 Schritt 2: Ermittle aktuelle IP-Adresse der VM
VM_IP=$(hostname -I | awk '{print $1}')
echo "📡 Gefundene IP: $VM_IP"

# 🔐 Schritt 3: Validierung der IP-Adresse
if [[ ! "$VM_IP" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
  echo "❌ Ungültige IP-Adresse erkannt: $VM_IP"
  exit 3
fi

# 📁 Schritt 4: Prüfe, ob die .env-Datei existiert
if [ ! -f "$ENV_FILE_PATH" ]; then
  echo "❌ Fehler: .env-Datei nicht gefunden unter $ENV_FILE_PATH"
  exit 1
fi

# 🛠️ Schritt 5: Ersetze DB_HOST in der .env-Datei mit der aktuellen IP
sed -i -E "s|^DB_HOST=.*|DB_HOST=$VM_IP|" "$ENV_FILE_PATH"

# ✅ Schritt 6: Erfolg prüfen und loggen
if [[ $? -eq 0 ]]; then
  echo "✅ IP erfolgreich aktualisiert in .env: $VM_IP"

  # 🕒 Schritt 7: Logeintrag schreiben
  LOG_FILE="$SCRIPT_DIR/update_env_ip.log"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - IP gesetzt auf $VM_IP" >> "$LOG_FILE"
  echo "📝 Logeintrag geschrieben: $LOG_FILE"
else
  echo "⚠️ Fehler beim Aktualisieren der IP in .env"
  exit 2
fi
