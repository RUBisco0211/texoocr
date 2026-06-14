# TexoOCR

A macOS menu bar app that captures formula screenshots and converts them to LaTeX instantly.

## Features

- **One-click capture** — Press ⌘⇧L to screenshot a formula, LaTeX is copied to clipboard
- **Import images** — Drag or open image files for recognition
- **100% offline** — All processing happens on-device via ONNX Runtime
- **Editable history** — Browse past results with image preview, rendered formula, and editable LaTeX source
- **Multiple copy formats** — Plain LaTeX, `$...$`, `$$...$$`, `\(...\)`
- **Dark & light backgrounds** — Auto-detects and inverts dark background images
- **Bilingual** — Chinese & English interface

## Requirements

- macOS 14.0+
- Apple Silicon or Intel Mac

## Build from Source

Command-line build:

```bash
./scripts/build.sh
```

The built app is written to `build/Products/Debug/TexoOCR.app`.

Build a Release app:

```bash
CONFIGURATION=Release ./scripts/build.sh
```

Code signing is disabled by default. To use the signing configuration from the
Xcode project:

```bash
CODE_SIGNING_ALLOWED=YES ./scripts/build.sh
```

Build a Release DMG:

```bash
./scripts/build_dmg.sh
```

The DMG is written to `build/Dist/TexoOCR-<version>.dmg`. To package an existing
Release app without rebuilding:

```bash
SKIP_BUILD=YES ./scripts/build_dmg.sh
```

You can also open `TexoOCR.xcodeproj` in Xcode 15+ and build with ⌘R.

> **Note:** You need to grant Accessibility permission for the screen capture hotkey to work.

## Download

Available on the [Mac App Store](#) (link coming soon).

## Acknowledgments

- **[alephpi / Texo](https://github.com/alephpi/Texo)** — Formula recognition model (LGPL, used with permission)
- **[Texo OCR Web](https://texocr.netlify.app)** — Online formula recognition service by the FormulaNet author
- **[ONNX Runtime](https://github.com/microsoft/onnxruntime)** — On-device inference engine (MIT)
- **[KaTeX](https://github.com/KaTeX/KaTeX)** — LaTeX rendering (MIT)

## Privacy

TexoOCR does not collect, transmit, or store any personal data. All processing happens entirely on your device. [Privacy Policy](https://zclk9000.github.io/texoocr-privacy/privacy-policy.html)

## License

App source code: MIT License

FormulaNet model weights: LGPL (granted by the author for this project)

## Contact

zclk9000@me.com
