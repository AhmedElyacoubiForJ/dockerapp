# Die **laufenden Prozesse unter Windows 11**, also welche Programme und Dienste gerade aktiv sind. Hier sind ein paar Wege, wie du das schnell und effektiv herausfinden kannst:

---

## 🧭 1. **Task-Manager öffnen**

Der Klassiker:

- **Shortcut:** `Strg + Shift + Esc`
- Oder: Rechtsklick auf die Taskleiste → **Task-Manager**

Dort siehst du:

- Alle laufenden Prozesse
- CPU-, RAM-, Festplatten- und Netzwerk-Auslastung
- Hintergrundprozesse und Dienste

Du kannst nach Namen, Ressourcenverbrauch oder Status sortieren.

---

## 🧠 2. **PowerShell oder Eingabeaufforderung**

Wenn du lieber mit der Konsole arbeitest:

```powershell
Get-Process
```

Oder klassisch in CMD:

```cmd
tasklist
```

Das zeigt dir eine Liste aller laufenden Prozesse inkl. PID und Speicherverbrauch.

---

## 🧰 3. **Details zu Docker-Containern**

Wenn du speziell Docker-Prozesse meinst:

```bash
docker ps
```

Das zeigt dir alle laufenden Container — inklusive Ports, Status und Namen.

---

## 🧪 Bonus: Prozesse filtern

Wenn du z.B. nur Java-Prozesse sehen willst:

```powershell
Get-Process | Where-Object {$_.ProcessName -like "*java*"}
```

Oder in CMD:

```cmd
tasklist | findstr java
```

[//]: # (---)

[//]: # ()
[//]: # (Wenn du magst, kann ich dir auch zeigen, wie man Prozesse automatisch überwacht oder ein kleines Skript schreibt, )

[//]: # (das dir z.B. nur Docker-bezogene Prozesse oder IntelliJ-Instanzen anzeigt.)

> In Windows 11 gibt es mehrere Wege, um **Dienste (Services)** zu starten oder zu stoppen.
> Hier sind die gängigsten Methoden, damit du schnell wieder den Überblick bekommst:

---

## ⚙️ 1. **Über die Dienste-Verwaltung (`services.msc`)**

Der klassische Weg:

1. Drücke `Windows + R` → gib `services.msc` ein → Enter
2. Es öffnet sich die **Dienste-Konsole**
3. Dort kannst du:
    - Dienste starten, stoppen, pausieren oder neu starten
    - Den Starttyp ändern (Automatisch, Manuell, Deaktiviert)
    - Status und Beschreibung einsehen

💡 Rechtsklick auf einen Dienst → „Starten“ oder „Beenden“

---

## 🧠 2. **Mit PowerShell**

Wenn du lieber mit der Konsole arbeitest:

- Dienst starten:
  ```powershell
  Start-Service -Name "Dienstname"
  ```

- Dienst stoppen:
  ```powershell
  Stop-Service -Name "Dienstname"
  ```

- Beispiel:
  ```powershell
  Stop-Service -Name "wuauserv"  # Windows Update Dienst
  ```

Du kannst auch alle Dienste auflisten:
```powershell
Get-Service
```

---

## 🖥️ 3. **Über den Task-Manager**

1. Öffne den Task-Manager (`Strg + Shift + Esc`)
2. Reiter „Dienste“ → dort kannst du Dienste starten/stoppen per Rechtsklick

---

## 🧰 4. **Systemkonfiguration (`msconfig`)**

1. `Windows + R` → `msconfig` → Enter
2. Reiter „Dienste“ → hier kannst du Dienste aktivieren/deaktivieren (nützlich für den Systemstart)

[//]: # (---)

[//]: # ()
[//]: # (Wenn du mir sagst, welchen Dienst du steuern willst &#40;z.B. Docker, SQL Server, Windows Update&#41;, kann ich dir den genauen Befehl oder Pfad geben. Oder willst du ein kleines Skript, das bestimmte Dienste automatisch verwaltet? Sag einfach Bescheid 💡)

---
Klar, Ahmed! In PowerShell kannst du die Ausgabe von `Get-Service` ganz flexibel filtern – je nachdem, was du suchst. Hier sind ein paar praktische Beispiele, die du direkt ausprobieren kannst:

---

## 🔍 **Nach Dienstname filtern**

```powershell
Get-Service | Where-Object { $_.Name -like "*docker*" }
```

➡️ Zeigt alle Dienste, deren Name „docker“ enthält.

---

## 🟢 **Nur laufende Dienste anzeigen**

```powershell
Get-Service | Where-Object { $_.Status -eq "Running" }
```

➡️ Zeigt nur Dienste, die gerade aktiv sind.

---

## 🔴 **Nur gestoppte Dienste anzeigen**

```powershell
Get-Service | Where-Object { $_.Status -eq "Stopped" }
```

---

## 🧾 **Bestimmte Eigenschaften anzeigen**

Du kannst die Ausgabe auch auf bestimmte Spalten beschränken:

```powershell
Get-Service | Where-Object { $_.Status -eq "Running" } | Select-Object Name, DisplayName, Status
```

➡️ Zeigt nur Name, Anzeigename und Status der laufenden Dienste.

---

## 🧠 **Beispiel: Alle Dienste mit „SQL“ im Namen, die gerade laufen**

```powershell
Get-Service | Where-Object { $_.Name -like "*sql*" -and $_.Status -eq "Running" }
```

[//]: # (---)

[//]: # ()
[//]: # (Wenn du magst, kann ich dir auch ein kleines PowerShell-Skript basteln, das dir regelmäßig bestimmte Dienste überwacht oder automatisch startet/stoppt. Sag einfach, was du brauchst 💡)