# Projektbetrieb – Anne & Oliver

## Ziel
Änderungswünsche von Anne/Oliver schnell umsetzen, in Git committen und auf die bestehende Dev-Static ausrollen.

## Standardablauf je Änderungswunsch
1. Änderung in `src/` umsetzen.
2. Lokal prüfen (Dateien/Build).
3. `git add -A && git commit -m "feat/fix: ..."`.
4. Deployment auf Dev-Static mit `scripts/deploy-dev.ps1`.
5. Kurzstatus an Anne: was geändert, wann deployed, was zu testen ist.

## Aktuelle Zielumgebung
- Azure Storage Account: `pdvstatic`
- Container: `$web` (konfigurierbar)
- Auth: `az login` (interaktiv) oder bestehende Session

## Hinweise
- Kein `--delete-destination=true` im Standard, um versehentliches Löschen zu vermeiden.
- Bei strukturellen Umbauten optional vorher abstimmen.
