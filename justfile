# Docker Toolbox - Task Runner
# Requires: just (https://github.com/casey/just)
# Install: cargo install just
# Or use Docker: alias just='docker run --rm -v ${PWD}:/work -w /work alpine sh -c "apk add --no-cache just && just"'

# Show all available commands
default:
    @just --list

# Validate tools.yaml structure
validate:
    python generate.py --validate

# Generate markdown documentation
markdown:
    python generate.py --markdown

# Generate PowerShell installer
powershell:
    python generate.py --powershell

# Generate Bash installer
bash:
    python generate.py --bash

# Generate Typst documentation source
typst:
    python generate.py --typst

# Generate all outputs (markdown + installers)
all:
    python generate.py --all

# Generate Typst PDF using Docker (no local Typst needed)
pdf:
    @echo "Generating Typst source..."
    python generate.py --typst
    @echo "Compiling to PDF using Docker..."
    docker run --rm -v ${PWD}:/work ghcr.io/typst/typst compile /work/docgen/docker-toolbox.typ /work/docker-toolbox.pdf
    @echo "✓ PDF generated: docker-toolbox.pdf"

# Open the generated PDF (cross-platform)
open-pdf: pdf
    @echo "Opening PDF..."
    {{if os() == "windows" { "start docker-toolbox.pdf" } else if os() == "macos" { "open docker-toolbox.pdf" } else { "xdg-open docker-toolbox.pdf" } }}

# Generate everything including PDF documentation
docs: all pdf
    @echo "✓ All documentation generated!"

# Clean generated files (except committed PDF)
clean:
    @echo "Cleaning generated files..."
    rm -rf docgen/
    @echo "✓ Cleaned docgen/"
    @echo "Note: docker-toolbox.pdf kept (it's committed to repo)"

# Clean everything including PDF
clean-all:
    @echo "Cleaning all generated files..."
    rm -rf docgen/
    rm -f docker-toolbox.pdf
    @echo "✓ Cleaned everything"

# Full rebuild - clean and regenerate everything
rebuild: clean all pdf
    @echo "✓ Full rebuild complete!"

# Run validation and generate all outputs (pre-commit check)
check: validate all
    @echo "✓ All checks passed!"

# Show statistics about tools.yaml
stats:
    @echo "=== Docker Toolbox Statistics ==="
    @echo "Tools defined: $(grep -c '^  - name:' tools.yaml)"
    @echo "Categories: $(grep -c '^  - id:' tools.yaml)"
    @echo "Lines in tools.yaml: $(wc -l < tools.yaml)"
    @echo ""
    @echo "Generated files:"
    @test -f docker-dev-tools.md && echo "  ✓ docker-dev-tools.md ($(wc -l < docker-dev-tools.md) lines)" || echo "  ✗ docker-dev-tools.md (not generated)"
    @test -f install.sh && echo "  ✓ install.sh ($(wc -l < install.sh) lines)" || echo "  ✗ install.sh (not generated)"
    @test -f install-interactive.ps1 && echo "  ✓ install-interactive.ps1 ($(wc -l < install-interactive.ps1) lines)" || echo "  ✗ install-interactive.ps1 (not generated)"
    @test -f docker-toolbox.pdf && echo "  ✓ docker-toolbox.pdf ($(du -h docker-toolbox.pdf | cut -f1))" || echo "  ✗ docker-toolbox.pdf (not generated)"

# Watch tools.yaml and auto-regenerate on changes (requires entr or inotifywait)
watch:
    @echo "Watching tools.yaml for changes..."
    @echo "Press Ctrl+C to stop"
    @if command -v entr > /dev/null; then \
        echo tools.yaml | entr just all; \
    elif command -v inotifywait > /dev/null; then \
        while inotifywait -e modify tools.yaml; do just all; done; \
    else \
        echo "Error: Install 'entr' or 'inotifywait' to use watch"; \
        exit 1; \
    fi

# Test a specific tool by running its Docker command
test TOOL:
    @echo "Testing {{TOOL}}..."
    @grep -A 10 "name: {{TOOL}}" tools.yaml | grep -A 1 "default:" | tail -1 | sed 's/^[[:space:]]*//' | sh

# Add a new tool (interactive)
add-tool:
    @echo "Adding a new tool..."
    @echo "This will open tools.yaml in your editor"
    @echo "Add your tool following the existing format"
    ${EDITOR:-vi} tools.yaml
    @echo "Validating..."
    @just validate
    @echo "Regenerating all outputs..."
    @just all

# Git commit with standardized message
commit MESSAGE:
    git add tools.yaml docker-dev-tools.md install.sh install-interactive.ps1 docker-toolbox.pdf .gitignore generate.py justfile README.md
    git commit -m "{{MESSAGE}}\n\nCo-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Show help for contributors
help-contribute:
    @echo "=== Contributing to Docker Toolbox ==="
    @echo ""
    @echo "1. Add tool to tools.yaml:"
    @echo "   just add-tool"
    @echo ""
    @echo "2. Validate and generate:"
    @echo "   just check"
    @echo ""
    @echo "3. Test the tool:"
    @echo "   just test <tool-name>"
    @echo ""
    @echo "4. Generate PDF docs (optional):"
    @echo "   just pdf"
    @echo ""
    @echo "5. Commit changes:"
    @echo "   just commit 'Add <tool-name> to Docker Toolbox'"
    @echo ""
    @echo "6. Push and create PR"
    @echo ""
    @echo "See README.md for detailed contributing guidelines"
