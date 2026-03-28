---
name: ir-a
description: Abre páginas web, carpetas XDG o rutas del sistema cuando el usuario dice "abre ..." o "ve a ..."
license: GPL-3.0-or-later
metadata:
    audience: end-users (not necessarily tech-savy)
---

## Qué hago

Cuando el usuario pide "abre ...", "ve a ...", o similar, determino qué tipo de recurso es y lo abro con el comando apropiado del sistema.

## Comandos por plataforma

| Sistema | Comando |
|---------|---------|
| Linux   | `xdg-open <ruta-o-url>` |
| macOS   | `open <ruta-o-url>` |
| Windows | `start <ruta-o-url>` |

## Tipos de solicitudes

### 1. Páginas web

Si el usuario pide abrir una página (ej. "abre la configuración de mi cuenta de GitHub"):

1. Usa WebFetch o tu conocimiento para determinar la URL oficial
2. Ejecuta el comando de apertura con la URL

Ejemplos:
- "abre la configuración de GitHub" → `xdg-open https://github.com/settings/profile`
- "abre Twitter" → `xdg-open https://twitter.com`
- "abre la documentación de Bun" → `xdg-open https://bun.sh/docs`

### 2. Carpetas XDG estándar (Linux)

Usa las variables de entorno XDG o los defaults:

| Solicitud | Variable | Default |
|-----------|----------|---------|
| "mis documentos" | `$XDG_DOCUMENTS_DIR` | `~/Documents` |
| "mis descargas" | `$XDG_DOWNLOAD_DIR` | `~/Downloads` |
| "mi escritorio" | `$XDG_DESKTOP_DIR` | `~/Desktop` |
| "mis imágenes" / "mis fotos" | `$XDG_PICTURES_DIR` | `~/Pictures` |
| "mi música" | `$XDG_MUSIC_DIR` | `~/Music` |
| "mis videos" | `$XDG_VIDEOS_DIR` | `~/Videos` |
| "mi home" / "mi carpeta personal" | `$HOME` | `~` |
| "mi config" | `$XDG_CONFIG_HOME` | `~/.config` |
| "mi caché" | `$XDG_CACHE_HOME` | `~/.cache` |
| "mis datos" | `$XDG_DATA_HOME` | `~/.local/share` |

Para obtener el valor real, ejecuta: `echo $XDG_DOCUMENTS_DIR` (o similar).

### 3. Rutas conocidas

| Solicitud | Ruta |
|-----------|------|
| "carpeta temporal" / "tmp" | `/tmp` |
| "raíz" / "root del sistema" | `/` |
| "usr" | `/usr` |
| "etc" | `/etc` |
| "var" | `/var` |
| "opt" | `/opt` |

### 4. Rutas explícitas

Si el usuario da una ruta específica (ej. "abre /home/user/proyecto"), ábrela directamente.

### 5. Rutas ambiguas o desconocidas

Si no puedes determinar la ruta con certeza, **pregunta al usuario** antes de abrir.

## Sin confirmación requerida

Para casos 1-4, ejecuta directamente sin pedir confirmación.
Solo pregunta en el caso 5 (rutas ambiguas).

## Ejemplos de uso

```
Usuario: "abre mis descargas"
Agente: Ejecuta `xdg-open ~/Downloads`

Usuario: "abre la configuración de mi cuenta de GitHub"
Agente: Ejecuta `xdg-open https://github.com/settings/profile`

Usuario: "abre /tmp"
Agente: Ejecuta `xdg-open /tmp`

Usuario: "abre la carpeta del proyecto actual"
Agente: Ejecuta `xdg-open .` (o el directorio de trabajo actual)
```
