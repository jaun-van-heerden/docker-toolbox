#!/usr/bin/env python3
"""
Docker Toolbox Generator
Generates documentation and installer scripts from tools.yaml
"""

import yaml
import argparse
import sys
from pathlib import Path
from typing import Dict, List, Any

class ToolboxGenerator:
    def __init__(self, tools_file: str):
        """Load and parse tools.yaml"""
        with open(tools_file, 'r', encoding='utf-8') as f:
            self.data = yaml.safe_load(f)

        self.tools = self.data.get('tools', [])
        self.categories = {cat['id']: cat for cat in self.data.get('categories', [])}

    def generate_markdown(self) -> str:
        """Generate docker-dev-tools.md documentation"""
        output = []

        # Header
        output.append("# Docker Commands for Development Tools\n")
        output.append("Run popular development tools without installing them locally. Just Docker required.\n")
        output.append("---\n")

        # Table of Contents
        output.append("## Table of Contents\n")
        category_tools = {}
        for tool in self.tools:
            cat_id = tool['category']
            if cat_id not in category_tools:
                category_tools[cat_id] = []
            category_tools[cat_id].append(tool['name'])

        for cat_id, cat_info in self.categories.items():
            if cat_id in category_tools:
                tools_list = ', '.join(category_tools[cat_id])
                output.append(f"- [{cat_info['name']}](#{cat_id.replace('_', '-')}) - {tools_list}")

        output.append("\n---\n")

        # Tools by category
        current_category = None
        for tool in self.tools:
            cat_id = tool['category']

            # Add category header if new category
            if cat_id != current_category:
                current_category = cat_id
                cat_info = self.categories[cat_id]
                output.append(f"\n## {cat_info['name']}\n")

            # Tool header
            output.append(f"\n### {tool['name'].capitalize()}")
            output.append(f"{tool['description']}\n")

            # Commands
            output.append("```bash")
            commands = tool.get('commands', {})

            if 'default' in commands:
                output.append(f"# Basic usage")
                output.append(commands['default'].strip())
                output.append("")

            for cmd_name, cmd_value in commands.items():
                if cmd_name != 'default':
                    output.append(f"# {cmd_name.capitalize()}")
                    output.append(cmd_value.strip())
                    output.append("")

            output.append("```\n")

            # Aliases
            if 'aliases' in tool and commands:
                output.append("**Aliases:**")
                output.append("```bash")
                output.append("# Linux/macOS")

                # Generate Bash aliases
                for alias in tool['aliases']:
                    # Map alias to command
                    cmd_key = self._map_alias_to_command(alias, commands)
                    if cmd_key and cmd_key in commands:
                        cmd = commands[cmd_key].strip().replace('$args', '"$@"')
                        output.append(f"alias {alias}='{cmd}'")
                    elif 'default' in commands:
                        cmd = commands['default'].strip().replace('$args', '"$@"')
                        output.append(f"alias {alias}='{cmd}'")

                output.append("")
                output.append("# PowerShell")

                # Generate PowerShell functions
                for alias in tool['aliases']:
                    cmd_key = self._map_alias_to_command(alias, commands)
                    if cmd_key and cmd_key in commands:
                        cmd = commands[cmd_key].strip()
                        output.append(f"function {alias} {{ {cmd} }}")
                    elif 'default' in commands:
                        cmd = commands['default'].strip()
                        output.append(f"function {alias} {{ {cmd} }}")

                output.append("```\n")

            # Notes
            if 'notes' in tool:
                output.append(f"**Note:** {tool['notes'].strip()}\n")

            output.append("---\n")

        return '\n'.join(output)

    def _map_alias_to_command(self, alias: str, commands: Dict[str, str]) -> str:
        """Map an alias name to its corresponding command key"""
        # Remove 'dt' prefix
        name = alias.replace('dt', '', 1).lower()

        # Check for exact match in commands
        if name in commands:
            return name

        # Check for common patterns
        for pattern in ['start', 'stop', 'logs', 'cli', 'exec', 'run', 'serve', 'watch', 'check', 'write', 'build', 'new', 'simple', 'test', 'playbook', 'identify', 'mogrify']:
            if name.endswith(pattern) and pattern in commands:
                return pattern

        return 'default'

    def generate_powershell_installer(self) -> str:
        """Generate install-interactive.ps1"""
        output = []

        # Header
        output.append("#Requires -Version 5.1")
        output.append("<#")
        output.append(".SYNOPSIS")
        output.append("    Docker Toolbox - Interactive Installer (Generated from tools.yaml)")
        output.append(".DESCRIPTION")
        output.append("    Installs Docker Toolbox functions to PowerShell profile")
        output.append("#>\n")

        # Tool array
        output.append("# Tool definitions (auto-generated from tools.yaml)")
        output.append("$AllTools = @(")

        for tool in self.tools:
            cat_name = self.categories[tool['category']]['name']

            # Main tool entry
            output.append(f"    @{{ Category = '{cat_name}'; Name = '{tool['name']}'; Description = '{tool['description']}' }}")

            # Add aliases as separate entries (for start/stop/logs commands)
            for alias in tool.get('aliases', [])[1:]:  # Skip first alias (main command)
                alias_name = alias.replace('dt', '')
                desc = f"{tool['name'].capitalize()} - {alias_name}"
                output.append(f"    @{{ Category = '{cat_name}'; Name = '{alias_name}'; Description = '{desc}' }}")

        output.append(")\n")

        # Rest of installer script (simplified)
        output.append("""
# Main installer logic
function Show-Banner {
    Write-Host "Docker Toolbox - Interactive Installer" -ForegroundColor Cyan
    Write-Host "Generated from tools.yaml" -ForegroundColor Gray
    Write-Host ""
}

# Display tools and let user select
Show-Banner
$AllTools | Out-GridView -Title "Select tools to install" -OutputMode Multiple

Write-Host ""
Write-Host "Installation script continues..."
Write-Host "See full implementation in original install-interactive.ps1"
""")

        return '\n'.join(output)

    def generate_bash_installer(self) -> str:
        """Generate install.sh for Bash"""
        output = []

        # Header
        output.append("#!/usr/bin/env bash")
        output.append("# Docker Toolbox - Bash Installer (Generated from tools.yaml)")
        output.append("# Adds Docker Toolbox aliases to ~/.bashrc or ~/.zshrc\n")

        output.append('set -e\n')

        # Color codes
        output.append('# Colors')
        output.append('RED="\\033[0;31m"')
        output.append('GREEN="\\033[0;32m"')
        output.append('YELLOW="\\033[0;33m"')
        output.append('BLUE="\\033[0;34m"')
        output.append('NC="\\033[0m" # No Color\n')

        # Banner
        output.append('echo -e "${BLUE}Docker Toolbox - Bash Installer${NC}"')
        output.append('echo -e "${BLUE}Generated from tools.yaml${NC}"')
        output.append('echo ""\n')

        # Detect shell config file
        output.append('# Detect shell config file')
        output.append('if [ -n "$ZSH_VERSION" ]; then')
        output.append('    SHELL_CONFIG="$HOME/.zshrc"')
        output.append('elif [ -n "$BASH_VERSION" ]; then')
        output.append('    SHELL_CONFIG="$HOME/.bashrc"')
        output.append('else')
        output.append('    echo -e "${RED}Error: Unsupported shell${NC}"')
        output.append('    exit 1')
        output.append('fi\n')

        output.append('echo -e "${GREEN}[OK] Using config file: $SHELL_CONFIG${NC}"')
        output.append('echo ""\n')

        # Generate aliases
        output.append('# Docker Toolbox aliases (auto-generated from tools.yaml)')
        output.append('cat >> "$SHELL_CONFIG" << \'EOF\'')
        output.append('')
        output.append('# Docker Toolbox aliases')
        output.append('# Generated by https://github.com/yourusername/docker-toolbox')
        output.append('')

        # Group tools by category
        current_category = None
        for tool in self.tools:
            cat_id = tool['category']
            commands = tool.get('commands', {})

            if cat_id != current_category:
                current_category = cat_id
                cat_name = self.categories[cat_id]['name']
                output.append(f'# {cat_name}')

            # Generate aliases for this tool
            for alias in tool.get('aliases', []):
                cmd_key = self._map_alias_to_command(alias, commands)
                if cmd_key and cmd_key in commands:
                    cmd = commands[cmd_key].strip().replace('$args', '"$@"')
                elif 'default' in commands:
                    cmd = commands['default'].strip().replace('$args', '"$@"')
                else:
                    continue
                output.append(f"alias {alias}='{cmd}'")

            output.append('')

        output.append('# End Docker Toolbox aliases')
        output.append('EOF')
        output.append('')
        output.append('echo -e "${GREEN}[OK] Aliases added to $SHELL_CONFIG${NC}"')
        output.append('echo ""')
        output.append('echo "To start using the aliases, run:"')
        output.append('echo -e "  ${YELLOW}source $SHELL_CONFIG${NC}"')
        output.append('echo "Or restart your terminal."')
        output.append('echo ""')

        return '\n'.join(output)

    def generate_typst(self) -> str:
        """Generate beautiful Typst documentation"""
        output = []

        # Document header with metadata
        output.append('#set document(')
        output.append('  title: "Docker Toolbox - Complete Reference",')
        output.append('  author: "Docker Toolbox Contributors",')
        output.append('  date: auto,')
        output.append(')')
        output.append('')

        # Page setup
        output.append('#set page(')
        output.append('  paper: "a4",')
        output.append('  margin: (x: 1.5cm, y: 2cm),')
        output.append('  numbering: "1",')
        output.append('  header: align(right)[')
        output.append('    _Docker Toolbox - Complete Reference_')
        output.append('  ],')
        output.append(')')
        output.append('')

        # Text settings
        output.append('#set text(')
        output.append('  size: 11pt,')
        output.append('  hyphenate: true,')
        output.append(')')
        output.append('')

        # Heading styles
        output.append('#set heading(numbering: "1.1")')
        output.append('#show heading.where(level: 1): set text(size: 24pt, weight: "bold")')
        output.append('#show heading.where(level: 2): set text(size: 18pt, weight: "bold")')
        output.append('#show heading.where(level: 3): set text(size: 14pt, weight: "semibold")')
        output.append('')

        # Code block styling
        output.append('#show raw.where(block: true): block.with(')
        output.append('  fill: luma(240),')
        output.append('  inset: 10pt,')
        output.append('  radius: 4pt,')
        output.append('  width: 100%,')
        output.append(')')
        output.append('')

        # Link styling
        output.append('#show link: underline')
        output.append('#show link: set text(fill: rgb("#0066cc"))')
        output.append('')

        # Title page
        output.append('#align(center)[')
        output.append('  #v(3cm)')
        output.append('  #text(size: 36pt, weight: "bold")[Docker Toolbox]')
        output.append('  #v(0.5cm)')
        output.append('  #text(size: 18pt)[Complete Reference Guide]')
        output.append('  #v(1cm)')
        output.append('  #text(size: 14pt)[')
        output.append(f'    {len(self.tools)} Development Tools via Docker')
        output.append('  ]')
        output.append('  #v(0.5cm)')
        output.append('  #text(size: 12pt, style: "italic")[')
        output.append('    Run popular development tools without installing them locally')
        output.append('  ]')
        output.append('  #v(3cm)')
        output.append('  #text(size: 11pt)[')
        output.append('    Generated from tools.yaml')
        output.append('  ]')
        output.append(']')
        output.append('')
        output.append('#pagebreak()')
        output.append('')

        # Table of contents
        output.append('= Table of Contents')
        output.append('')
        output.append('#outline(depth: 2, indent: 2em)')
        output.append('')
        output.append('#pagebreak()')
        output.append('')

        # Introduction
        output.append('= Introduction')
        output.append('')
        output.append('Docker Toolbox provides ready-to-use Docker commands for development tools across multiple categories. This reference guide contains all available tools with usage examples.')
        output.append('')
        output.append('== Benefits')
        output.append('')
        output.append('- *No local installation* required (just Docker)')
        output.append('- *Consistent behavior* across Linux, macOS, and Windows')
        output.append('- *Isolated environments* prevent conflicts')
        output.append('- *Easy to try* new tools without commitment')
        output.append('- *Clean uninstall* - just remove the container')
        output.append('')
        output.append('#pagebreak()')
        output.append('')

        # Category overview
        output.append('= Categories Overview')
        output.append('')

        # Count tools per category
        category_counts = {}
        for tool in self.tools:
            cat_id = tool['category']
            category_counts[cat_id] = category_counts.get(cat_id, 0) + 1

        output.append('#table(')
        output.append('  columns: (auto, 1fr, auto),')
        output.append('  stroke: 0.5pt,')
        output.append('  align: (left, left, right),')
        output.append('  [*Category*], [*Description*], [*Tools*],')

        for cat_id, cat_info in self.categories.items():
            if cat_id in category_counts:
                count = category_counts[cat_id]
                output.append(f"  [{cat_info['name']}], [{cat_info['description']}], [{count}],")

        output.append(')')
        output.append('')
        output.append('#pagebreak()')
        output.append('')

        # Tools by category
        output.append('= Tools Reference')
        output.append('')

        current_category = None
        for tool in self.tools:
            cat_id = tool['category']
            commands = tool.get('commands', {})

            # Add category header if new category
            if cat_id != current_category:
                current_category = cat_id
                cat_info = self.categories[cat_id]
                if current_category != self.tools[0]['category']:
                    output.append('#pagebreak()')
                    output.append('')
                output.append(f"== {cat_info['name']}")
                output.append('')

            # Tool header
            tool_name = tool['name'].title()
            output.append(f"=== {tool_name}")
            output.append('')
            output.append(f"_{tool['description']}_")
            output.append('')

            # Docker image info
            output.append(f"*Docker Image:* `{tool['image']}`")
            output.append('')

            # Commands section
            if commands:
                output.append('*Usage:*')
                output.append('')

                # Default command
                if 'default' in commands:
                    output.append('```bash')
                    output.append('# Basic usage')
                    output.append(commands['default'].strip())
                    output.append('```')
                    output.append('')

                # Additional commands
                other_cmds = {k: v for k, v in commands.items() if k != 'default'}
                if other_cmds:
                    for cmd_name, cmd_value in other_cmds.items():
                        output.append('```bash')
                        output.append(f'# {cmd_name.capitalize()}')
                        output.append(cmd_value.strip())
                        output.append('```')
                        output.append('')

            # Aliases section
            if 'aliases' in tool and tool['aliases']:
                output.append('*Aliases:*')
                output.append('')
                output.append('Bash/Zsh: ' + ', '.join(f'`{a}`' for a in tool['aliases'][:3]))
                output.append('')

            # Notes section
            if 'notes' in tool:
                output.append('#block(')
                output.append('  fill: rgb("#fffacd"),')
                output.append('  inset: 8pt,')
                output.append('  radius: 4pt,')
                output.append(')[')
                output.append('  *Note:* ' + tool['notes'].strip().replace('\n', ' '))
                output.append(']')
                output.append('')

            # Examples section
            if 'examples' in tool:
                output.append('*Examples:*')
                output.append('')
                for example in tool['examples']:
                    output.append(f"- _{example['description']}_")
                    output.append('  ```bash')
                    output.append('  ' + example['command'])
                    output.append('  ```')
                output.append('')

            output.append('')

        # Appendix
        output.append('#pagebreak()')
        output.append('')
        output.append('= Appendix')
        output.append('')
        output.append('== Installation')
        output.append('')
        output.append('To use Docker Toolbox, you need Docker installed on your system.')
        output.append('')
        output.append('*Prerequisites:*')
        output.append('- Docker 20.10 or later')
        output.append('- Basic command line knowledge')
        output.append('')
        output.append('Visit #link("https://github.com/yourusername/docker-toolbox") for installation instructions.')
        output.append('')
        output.append('== Contributing')
        output.append('')
        output.append('Docker Toolbox uses a YAML-based tool management system. To add a new tool:')
        output.append('')
        output.append('1. Edit `tools.yaml`')
        output.append('2. Run `python generate.py --all`')
        output.append('3. Test the generated outputs')
        output.append('4. Submit a pull request')
        output.append('')
        output.append('== License')
        output.append('')
        output.append('MIT License - Free to use, modify, and distribute.')
        output.append('')

        return '\n'.join(output)

    def validate(self) -> List[str]:
        """Validate tools.yaml structure"""
        errors = []

        for i, tool in enumerate(self.tools):
            # Check required fields
            required = ['name', 'category', 'description', 'image']
            for field in required:
                if field not in tool:
                    errors.append(f"Tool {i}: Missing required field '{field}'")

            # Check category exists
            if tool.get('category') not in self.categories:
                errors.append(f"Tool {tool.get('name', i)}: Invalid category '{tool.get('category')}'")

            # Check aliases format
            if 'aliases' in tool:
                for alias in tool['aliases']:
                    if not alias.startswith('dt'):
                        errors.append(f"Tool {tool['name']}: Alias '{alias}' should start with 'dt'")

        return errors

def main():
    parser = argparse.ArgumentParser(description='Generate Docker Toolbox documentation and installers')
    parser.add_argument('--validate', action='store_true', help='Validate tools.yaml')
    parser.add_argument('--markdown', action='store_true', help='Generate markdown documentation')
    parser.add_argument('--powershell', action='store_true', help='Generate PowerShell installer')
    parser.add_argument('--bash', action='store_true', help='Generate Bash installer')
    parser.add_argument('--typst', action='store_true', help='Generate Typst documentation')
    parser.add_argument('--all', action='store_true', help='Generate all files (except Typst)')
    parser.add_argument('--output-dir', default='.', help='Output directory')

    args = parser.parse_args()

    # Find tools.yaml
    tools_file = Path(__file__).parent / 'tools.yaml'
    if not tools_file.exists():
        print(f"Error: {tools_file} not found", file=sys.stderr)
        return 1

    # Load generator
    gen = ToolboxGenerator(str(tools_file))

    # Validate
    if args.validate or args.all:
        errors = gen.validate()
        if errors:
            print("Validation errors:")
            for error in errors:
                print(f"  - {error}")
            if not args.all:
                return 1
        else:
            print("[OK] Validation passed!")

    output_dir = Path(args.output_dir)
    output_dir.mkdir(exist_ok=True)

    # Generate markdown
    if args.markdown or args.all:
        print("Generating markdown documentation...")
        markdown = gen.generate_markdown()
        output_file = output_dir / 'docker-dev-tools.md'
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(markdown)
        print(f"[OK] Generated: {output_file}")

    # Generate PowerShell
    if args.powershell or args.all:
        print("Generating PowerShell installer...")
        powershell = gen.generate_powershell_installer()
        output_file = output_dir / 'install-interactive.ps1'
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(powershell)
        print(f"[OK] Generated: {output_file}")

    # Generate Bash
    if args.bash or args.all:
        print("Generating Bash installer...")
        bash = gen.generate_bash_installer()
        output_file = output_dir / 'install.sh'
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(bash)
        print(f"[OK] Generated: {output_file}")

    # Generate Typst (only if explicitly requested)
    if args.typst:
        print("Generating Typst documentation...")
        typst = gen.generate_typst()

        # Create docgen directory for source files
        docgen_dir = Path('docgen')
        docgen_dir.mkdir(exist_ok=True)

        # Save .typ source to docgen/
        typ_file = docgen_dir / 'docker-toolbox.typ'
        with open(typ_file, 'w', encoding='utf-8') as f:
            f.write(typst)
        print(f"[OK] Generated: {typ_file}")

        # PDF goes to root directory
        pdf_file = Path('docker-toolbox.pdf')

        # Try to compile to PDF if Typst is available
        try:
            import subprocess
            print("Compiling Typst to PDF...")
            result = subprocess.run(
                ['typst', 'compile', str(typ_file), str(pdf_file)],
                capture_output=True,
                text=True,
                timeout=30
            )
            if result.returncode == 0:
                print(f"[OK] Generated: {pdf_file}")
                print("    To view: open docker-toolbox.pdf")
            else:
                print(f"[INFO] Typst source created at {typ_file}")
                print("       Run 'typst compile docgen/docker-toolbox.typ docker-toolbox.pdf' to generate PDF")
        except FileNotFoundError:
            print(f"[INFO] Typst source created at {typ_file}")
            print("       Install Typst to compile to PDF: https://github.com/typst/typst")
            print("       Or use Docker: docker run --rm -v ${PWD}:/work ghcr.io/typst/typst compile /work/docgen/docker-toolbox.typ /work/docker-toolbox.pdf")
        except Exception as e:
            print(f"[INFO] Typst source created at {typ_file}")
            print(f"       Could not compile to PDF: {e}")

    print("\n[OK] Generation complete!")
    return 0

if __name__ == '__main__':
    sys.exit(main())
