# Docflux CLI 🤖

<p align="center">
  <img src="demo.gif" alt="Docflux Demo" width="600">
  <br>
  <em>Demo: Converting Markdown to PDF / DOCX with Mermaid diagrams</em>
</p>

Docflux (`dfx`) is a CLI for converting technical documentation between Markdown, DOCX, and PDF while handling Mermaid diagrams.

## What It Does ✨

`dfx` supports:

- Markdown -> DOCX
- Markdown -> PDF
- DOCX -> Markdown
- Mermaid code blocks in Markdown are rendered to PNG images during Markdown output conversion. Rendering is **local-first**: if the Mermaid CLI (`mmdc`) is installed it renders offline with no network access; otherwise it falls back to the hosted `https://mermaid.ink` service.

## Prerequisites 🧰

- Python 3.10+ (Python 3.12 is recommended for PDF support and matches the install scripts)
- `uv` package manager
- Pandoc
  - If Pandoc is not in `PATH`, `dfx` attempts to download it automatically via `pypandoc`.
- **macOS**: Homebrew is required for PDF support dependencies (cairo, pkg-config)
  - The install script will install Homebrew automatically if not present
  - To install manually: https://brew.sh
- For Linux PDF support, system libraries such as `libcairo2-dev` and `pkg-config` are recommended.
- Optional: `Pillow` for splitting very tall Mermaid diagrams into multiple images.
- Mermaid rendering (choose either):
  - **Offline (recommended): the Mermaid CLI.** Install [`@mermaid-js/mermaid-cli`](https://github.com/mermaid-js/mermaid-cli) so `mmdc` is on `PATH` (`npm install -g @mermaid-js/mermaid-cli`; requires Node.js). Works on Windows, macOS, and Linux, needs no network, and renders diagrams of any size.
    - `mmdc` renders through a Chromium browser (via Puppeteer). Provide one either by letting Puppeteer download its bundled Chromium (`npx puppeteer browsers install chrome-headless-shell`), or — recommended behind a restrictive proxy, since it downloads nothing — by pointing it at a browser already installed: set `PUPPETEER_EXECUTABLE_PATH` to an existing Chrome/Edge binary (e.g. on Windows `C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe`).
    - If `mmdc` is installed to a non-standard location, set `DFX_MMDC_PATH` to its full path.
  - **Hosted fallback: `https://mermaid.ink`.** Used automatically when `mmdc` is not found. Requires outbound HTTPS to `mermaid.ink`. If unreachable, conversion continues and Mermaid code blocks are kept as-is.

## Quick Install 🚀

### Linux / macOS

```bash
curl -sSL https://raw.githubusercontent.com/fabricesemti80/docflux/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/fabricesemti80/docflux/main/install.ps1 | iex
```

## Local Install (From Repo) 📦

From the repository root:

```bash
uv tool install --native-tls --python 3.12 .
```

If `dfx` is not found after install, add your `uv` tools bin directory to `PATH`.

No-PATH fallback:

```bash
uv tool run dfx --help
```

## Usage 🛠️

Show help:

```bash
dfx --help
```

Markdown -> PDF:

```bash
dfx -i path/to/file.md --pdf
```

Markdown -> DOCX:

```bash
dfx -i path/to/file.md --docx
```

DOCX -> Markdown:

```bash
dfx -i path/to/file.docx
```

Specify output path:

```bash
dfx -i path/to/file.md -o out.pdf --pdf
```

Verbose mode:

```bash
dfx -i path/to/file.md --pdf --verbose
```

Version:

```bash
dfx --version
```

Behavior notes:

- If Markdown input is provided without `--format` / `--pdf` / `--docx`, `dfx` prompts for output format (default: `docx`).
- If `-o/--out` is omitted, `dfx` prompts for output path and suggests a default.
- For DOCX -> Markdown, extracted images are written to a `media/` folder next to the output Markdown file.

## Uninstall 🧹

### Linux / macOS

```bash
curl -sSL https://raw.githubusercontent.com/fabricesemti80/docflux/main/uninstall.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/fabricesemti80/docflux/main/uninstall.ps1 | iex
```

## Development Notes 🧪

Development workflows (`make`, `uv sync`, `uv run`, local testing) are documented in `DEVNOTES.md`.
