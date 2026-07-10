# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-07-10

### Added
- Local-first Mermaid rendering via the Mermaid CLI (`mmdc`). When `mmdc` is on
  `PATH`, diagrams render offline with no network access, on Windows, macOS, and
  Linux alike. Removes the hard dependency on `https://mermaid.ink` (and sidesteps
  corporate TLS-interception failures) where the CLI is installed.
- `DFX_MMDC_PATH` environment variable to point at a non-standard `mmdc` location.

### Changed
- `mermaid.ink` is now an automatic fallback, used only when `mmdc` is not found
  or fails for a given diagram. Behaviour on machines without the CLI is unchanged.
- Local rendering has no per-diagram size limit; the 4 KB cap now applies only to
  the `mermaid.ink` fallback (a URL-length constraint of that service).

## [0.2.3] - 2026-03-05

### Added
- Demo GIF added to README.md showcasing tool usage

## [0.2.2] - 2026-03-05

### Fixed
- Image alt text no longer appears as caption below images in DOCX output

## [0.2.1] - 2026-02-20

### Added
- Docker support for Linux users (avoids dependency management)
- `--verbose` flag for detailed logging output
- Output path prompt in interactive mode with default suggestion
- Clean progress indicators for non‑verbose mode (docker‑compose style)
- Ruff linting integration
- `docker-run.sh` wrapper script for easy Docker execution
- Mermaid rendering via `https://mermaid.ink` service

### Changed
- Improved non‑verbose output with visually appealing progress indicators
- README rewritten with emoji, better structure, and clearer documentation
- Makefile updated to use proper CLI flags (`-i`/`-o`)
- DEVNOTES.md expanded with linting instructions and clearer examples

### Fixed
- Python version requirement corrected to 3.10+ in documentation
- Makefile convert target now uses correct CLI syntax

## [0.2.0] - 2026-01-15

### Added
- Tag trigger for CI workflow (runs on `v*` tags)
- CLI options: `-i`/`--in` for input, `-o`/`--out` for output, `-v`/`--version` for version
- Windows support in CI workflow
- Sample image to demo directory
- Uninstall script and documentation

### Fixed
- Release workflow now uses `--force` when fetching tags to avoid conflicts

## [0.1.0] - 2025-12-14

### Added
- Bidirectional conversion: Markdown ↔ DOCX, Markdown → PDF
- Mermaid diagram rendering to PNG images
- Support for tall Mermaid diagrams (split across pages in PDF)
- Multiple PDF engines: WeasyPrint (preferred), wkhtmltopdf (fallback), xhtml2pdf (last resort)
- Colored terminal output
- GitHub Actions workflows: CI, release, and version bumping
- Ruff linting integration
- Interactive mode with format selection

### Fixed
- YAML front matter handling
- Horizontal rule rendering
- Resource path resolution for images
- CI/CD workflow dependencies
