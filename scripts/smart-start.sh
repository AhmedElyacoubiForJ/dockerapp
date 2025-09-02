#!/bin/bash

echo "🔍 Starte Container-Analyse..."

# Markdown-Datei vorbereiten
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
output_md="./logs/container-analysis-${timestamp}.md"
mkdir -p ./logs
echo "# 🧪 Container-Analyse – $timestamp" > "$output_md"
echo "" >> "$output_md"

# Alle laufenden Container holen
docker ps --format '{{.Names}}' | while read -r name; do
  echo "🧪 Analysiere Container: $name"
  echo "-------------------------------"

  echo "## 🔍 Container: \`$name\`" >> "$output_md"

  # Healthcheck anzeigen
  health=$(docker inspect --format='{{json .State.Health}}' "$name" 2>/dev/null | jq -r '.Status' 2>/dev/null)
  health=${health:-"nicht definiert"}
  echo "Healthcheck: $health"

  case "$health" in
    healthy)
      echo "**Healthcheck:** $health" >> "$output_md"
      echo "**Bewertung:** <span style=\"color:green\">✅ OK</span>" >> "$output_md"
      ;;
    unhealthy)
      echo "**Healthcheck:** $health" >> "$output_md"
      echo "**Bewertung:** <span style=\"color:red\">⚠️ Kritisch</span>" >> "$output_md"
      ;;
    *)
      echo "**Healthcheck:** $health" >> "$output_md"
      echo "**Bewertung:** <span style=\"color:gray\">ℹ️ Unbekannt</span>" >> "$output_md"
      ;;
  esac

  # Container-Größe
  size=$(docker inspect --format='{{.SizeRootFs}}' "$name" 2>/dev/null)
  echo "Größe (RootFS): ${size:-nicht verfügbar}"
  echo "**Größe (RootFS):** ${size:-nicht verfügbar}" >> "$output_md"

  # Source-Dateien
  echo "🔎 Suche nach Source-Dateien..."
  sources=$(docker exec "$name" sh -c 'find /app /src /usr/src /usr/local/src -type f \( -name "*.java" -o -name "*.class" -o -name "*.py" -o -name "*.ts" \)' 2>/dev/null || echo "")
  echo "$sources"
  source_count=$(echo "$sources" | grep -c .)
  echo "➡️ Gefundene Source-Dateien: $source_count"
  echo "**Source-Dateien gefunden:** $source_count" >> "$output_md"
  if [ "$source_count" -gt 0 ]; then
    {
      echo "<details><summary>Source-Dateien anzeigen</summary>"
      echo ""
      echo '```'
      printf "%s\n" "$sources"
      echo '```'
      echo "</details>"
    } >> "$output_md"
  fi

  # Dev-Verzeichnisse
  echo "🔎 Suche nach Dev-Verzeichnissen..."
  devdirs=$(docker exec "$name" sh -c 'find /app /src /usr/src /usr/local/src -type d \( -name "src" -o -name "target" -o -name "app" \)' 2>/dev/null || echo "")
  echo "$devdirs"
  devdir_count=$(echo "$devdirs" | grep -c .)
  echo "➡️ Gefundene Dev-Verzeichnisse: $devdir_count"
  echo "**Dev-Verzeichnisse gefunden:** $devdir_count" >> "$output_md"
  if [ "$devdir_count" -gt 0 ]; then
    {
      echo "<details><summary>Dev-Verzeichnisse anzeigen</summary>"
      echo ""
      echo '```'
      printf "%s\n" "$devdirs"
      echo '```'
      echo "</details>"
    } >> "$output_md"
  fi

  # Docker-Diff
  echo "🧭 Änderungen seit Container-Start (docker diff):"
  diff=$(docker diff "$name" 2>/dev/null | grep -vE '^C /proc|^C /sys|^C /dev' | head -n 10)
  echo "$diff"
  echo "**Änderungen seit Container-Start:**" >> "$output_md"
  if [ -n "$diff" ]; then
    {
      echo "<details><summary>docker diff anzeigen</summary>"
      echo ""
      echo '```'
      printf "%s\n" "$diff"
      echo '```'
      echo "</details>"
    } >> "$output_md"
  else
    echo "_Keine relevanten Änderungen gefunden._" >> "$output_md"
  fi

  echo "" >> "$output_md"
  echo ""
done

echo "✅ Analyse abgeschlossen."
echo "📄 Markdown-Bericht gespeichert unter: $output_md"
