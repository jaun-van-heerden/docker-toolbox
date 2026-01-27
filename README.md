# Docker Toolbox

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Required-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-lightgrey)](https://github.com/yourusername/docker-toolbox)
[![Tools](https://img.shields.io/badge/Tools-100%2B-brightgreen)](docker-dev-tools.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

> Run 100+ development tools via Docker without installing them locally

A curated collection of Docker commands and aliases to run popular development tools without local installation. Perfect for developers who want a clean system while maintaining access to every tool they need.

```
    ____             __                ______            __ __
   / __ \____  _____/ /_____  _____   /_  __/___  ____  / / /_  ____  _  __
  / / / / __ \/ ___/ //_/ _ \/ ___/    / / / __ \/ __ \/ / __ \/ __ \| |/_/
 / /_/ / /_/ / /__/ ,< /  __/ /       / / / /_/ / /_/ / / /_/ / /_/ />  <
/_____/\____/\___/_/|_|\___/_/       /_/  \____/\____/_/_.___/\____/_/|_|
```

## Why Docker Toolbox?

**The Problem:**
Installing development tools directly on your system leads to:
- Version conflicts between projects
- Bloated system with rarely-used tools
- Complex setup procedures
- Different installation methods across operating systems
- Dependency hell and conflicting requirements

**The Solution:**
Docker Toolbox provides ready-to-use Docker commands for 100+ development tools:
- **No local installation** required (just Docker)
- **Consistent behavior** across Linux, macOS, and Windows
- **Isolated environments** prevent conflicts
- **Easy to try** new tools without commitment
- **Clean uninstall** - just remove the container
- **Version pinning** for reproducible environments

## What's Inside?

### 100+ Tools Across 15 Categories

| Category | Tools |
|----------|-------|
| **Build & Task Runners** | just, Make |
| **Static Site Generators** | Jekyll, Hugo, MkDocs |
| **Terminal Tools** | tmux, htop, ncdu, lazygit, lazydocker, ranger, fzf, bat, ripgrep, fd, jq, yq |
| **Programming Languages** | Python, Jupyter Notebook, Node.js, Go, Rust, Ruby |
| **Development Environments** | VS Code Server, RStudio, Vert |
| **Testing Tools** | Playwright |
| **Databases** | PostgreSQL, MySQL, Redis, MongoDB |
| **Message Brokers & IoT** | Mosquitto (MQTT), MQTT Explorer |
| **DevOps & Cloud** | AWS CLI, Azure CLI, Google Cloud, Terraform, Ansible, kubectl, Helm |
| **Code Quality** | Prettier, Black, ShellCheck, hadolint, markdownlint |
| **Media & Documents** | Pandoc, FFmpeg, ImageMagick, yt-dlp, Typst, LaTeX |
| **Networking & Security** | nmap, curl, Trivy, testssl |
| **API Development** | Swagger UI, HTTPie, Newman |
| **Git Tools** | git, GitHub CLI |

See [docker-dev-tools.md](docker-dev-tools.md) for the complete list with usage examples.

---

## Important Notice

### Use at Your Own Risk

**Docker Toolbox** provides curated Docker commands for development tools, but please be aware:

- ✅ **Official Sources**: We prioritize official Docker images from verified publishers (e.g., `python:3.12`, `node:22`, `postgres:16`)
- ✅ **Testing**: Commands are tested on Windows, macOS, and Linux, but your environment may differ
- ⚠️ **Your Responsibility**: You should verify the tools meet your security and compliance requirements
- ⚠️ **No Warranty**: These tools are provided "as-is" without warranties of any kind

### Before Using a Tool

1. **Check the source**: Review the Docker image source and publisher
   - Official images: `docker pull <image>` and check Docker Hub for details
   - Example: [Python on Docker Hub](https://hub.docker.com/_/python)

2. **Review documentation**: Each tool has official documentation with detailed options
   - See [docker-dev-tools.md](docker-dev-tools.md) for Docker commands
   - Visit the tool's official website for comprehensive documentation

3. **Understand what it does**: The commands mount your local directories
   - Review the `-v` volume mounts to see what files are accessible
   - Be cautious with commands that require credentials or sensitive data

4. **Test in a safe environment**: Try tools on test projects before production use

### Security Considerations

- **Mounted volumes**: Tools have access to directories you mount (`-v ${PWD}:/app`)
- **Network access**: Some tools connect to external services or databases
- **Credentials**: Be careful when mounting config directories (`~/.aws`, `~/.kube`, etc.)
- **Image sources**: Verify image publishers on Docker Hub before use
- **Updates**: Docker images may update - pin specific versions for reproducibility

**By using Docker Toolbox, you acknowledge these risks and agree to verify tools before use.**

---

## Quick Start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running
- Basic familiarity with command line

### Example Usage

```bash
# Run Python script without installing Python
docker run --rm -v ${PWD}:/app -w /app python:3.12 python script.py

# Start Jupyter Notebook for data science
docker run --rm -p 8888:8888 -v ${PWD}:/home/jovyan/work jupyter/scipy-notebook

# Start VS Code in browser
docker run --rm -p 8080:8080 -v ${PWD}:/home/coder/project codercom/code-server --auth none

# Run MQTT broker for IoT
docker run --rm -p 1883:1883 -p 9001:9001 eclipse-mosquitto

# Format code with Prettier
docker run --rm -v ${PWD}:/work tmknom/prettier --write .

# Run Node.js application
docker run --rm -v ${PWD}:/app -w /app node:22 node app.js

# Search code with ripgrep
docker run --rm -v ${PWD}:/data -w /data alpine sh -c "apk add --no-cache ripgrep > /dev/null 2>&1 && rg -i 'TODO'"

# Run Playwright tests
docker run --rm -v ${PWD}:/work -w /work mcr.microsoft.com/playwright:v1.40.0 npx playwright test
```

### Using Aliases (Recommended)

Instead of typing long Docker commands, set up aliases using our installer.

**💡 Naming:** Functions use the `dt` prefix (e.g., `dtpython`, `dtnode`) to avoid conflicts with natively installed tools.

#### Windows PowerShell

Run the interactive installer:

```powershell
git clone https://github.com/yourusername/docker-toolbox.git
cd docker-toolbox
.\install-interactive.ps1
```

The installer will:
- Show you all 87 available tools in a selection window
- Let you choose which ones to add (Ctrl+Click for multiple)
- Add the functions to your PowerShell `$PROFILE`
- Create a backup before making changes

Then reload: `. $PROFILE` (or restart PowerShell)

Usage examples: `dtpython script.py`, `dtnode app.js`, `dtjupyter`

#### Linux / macOS (Bash/Zsh)

Manual setup - add to `~/.bashrc` or `~/.zshrc`:

```bash
# Example aliases with dt prefix (no conflicts!)
alias dtpython='docker run --rm -it -v ${PWD}:/app -w /app python:3.12 python'
alias dtnode='docker run --rm -it -v ${PWD}:/app -w /app node:22 node'
alias dtjupyter='docker run --rm -p 8888:8888 -v ${PWD}:/home/jovyan/work jupyter/base-notebook'
alias dtrg='docker run --rm -v ${PWD}:/data -w /data alpine sh -c "apk add --no-cache ripgrep > /dev/null 2>&1 && rg"'
```

Then reload: `source ~/.bashrc`

Usage: `dtpython script.py`, `dtnode app.js`, `dtjupyter`

**See [docker-dev-tools.md](docker-dev-tools.md) for all 92 tools with copy-paste ready commands.**

---

## Limitations

### Known Constraints

**1. Performance Overhead**
- First run downloads images (can be slow depending on internet)
- Container startup adds ~0.5-1 second overhead
- I/O operations slightly slower than native

**2. File System Access**
- Only mounted directories are accessible
- Can't access files outside mounted volumes
- Windows path handling requires special attention
- File permissions may differ from host

**3. Networking**
- Use `host.docker.internal` to reach host services (from inside container)
- Port mapping required for server applications
- VPN/proxy configurations may need adjustments
- Some tools need `--network host` flag

**4. Interactive Applications**
- Some TUI apps have terminal size detection issues
- Keyboard shortcuts might be captured by terminal emulator
- Copy/paste behavior may vary

**5. Credentials & Configuration**
- Must explicitly mount config directories (e.g., `~/.aws`, `~/.kube`, `~/.ssh`)
- SSH keys need explicit mounting and permission fixes
- Environment variables must be passed with `-e` flag

**6. Platform-Specific Issues**
- **Windows**: Must use PowerShell or Git Bash for `${PWD}` variable
- **Windows**: Path format differences (`C:\` vs `/`)
- **macOS**: Filesystem performance can be slower with volumes
- **Linux**: User ID mapping may cause permission issues

**7. Resource Usage**
- Each container uses memory (10-100MB typical)
- Docker images consume disk space (50MB-2GB per tool)
- Need to run `docker system prune` periodically for cleanup

### When NOT to Use Docker Toolbox

- Performance-critical applications (use native installation)
- Tools requiring deep system integration (kernel modules, etc.)
- GUI applications (Docker primarily for CLI tools)
- Tools needing real-time performance
- Complex volume mount scenarios
- When you need the tool frequently (better to install natively)

---

## Installation

### Option 1: Use Directly (No Setup Required)

Just run the Docker commands directly from [docker-dev-tools.md](docker-dev-tools.md). No setup needed.

### Option 2: Interactive Installer (Windows PowerShell)

For Windows users, we provide an interactive installer:

```powershell
git clone https://github.com/yourusername/docker-toolbox.git
cd docker-toolbox
.\install-interactive.ps1
```

Or if you get an execution policy error:

```powershell
powershell -ExecutionPolicy Bypass -File install-interactive.ps1
```

The installer will:
- Check for Docker installation
- Show all 92 tools in a selection window (Ctrl+Click for multiple)
- Create PowerShell profile if it doesn't exist
- Backup your profile before making changes
- Add selected functions with `dt` prefix (e.g., `dtpython`, `dtnode`)
- Show usage instructions

### Option 3: Manual Setup

#### Linux / macOS (Bash/Zsh)

1. Browse [docker-dev-tools.md](docker-dev-tools.md)
2. Copy the aliases/functions for tools you need
3. Add to your shell config file (`~/.bashrc` or `~/.zshrc`)
4. Reload: `source ~/.bashrc`

#### Windows (PowerShell)

1. Open your profile: `notepad $PROFILE`
   - Create if needed: `New-Item -Path $PROFILE -Type File -Force`
2. Browse [docker-dev-tools.md](docker-dev-tools.md)
3. Copy the PowerShell functions for tools you need
4. Paste into your profile and save
5. Reload: `. $PROFILE`

### Option 4: Browse Only

```bash
git clone https://github.com/yourusername/docker-toolbox.git
cd docker-toolbox

# Browse all available tools
cat docker-dev-tools.md
```

---

## Updating or Removing Tools

### Using the Interactive Installer (Windows)

The easiest way to add, remove, or change your installed tools is to **run the interactive installer again**:

```powershell
cd docker-toolbox
.\install-interactive.ps1
```

**How it works:**
- Select the tools you want (add new ones or deselect to remove)
- The installer automatically **backs up your current profile** before making changes
- It **replaces the entire Docker Toolbox section** with your new selection
- **All other profile content is preserved** (your custom functions, aliases, etc.)

**Example workflow:**
1. Initially selected: `dtpython`, `dtnode`, `dtgo`
2. Run installer again and select: `dtpython`, `dtnode`, `dtcargo` (added rust, removed go)
3. Result: Profile now has `dtpython`, `dtnode`, `dtcargo`

### Manual Editing

You can also manually edit your profile file:

#### Windows PowerShell
```powershell
notepad $PROFILE
```

#### Linux/macOS
```bash
# Bash
nano ~/.bashrc

# Zsh
nano ~/.zshrc
```

**What to edit:**
- Find the section between `# Docker Toolbox functions` and `# End Docker Toolbox functions`
- Add, remove, or modify any functions within this section
- Save and reload: `. $PROFILE` (PowerShell) or `source ~/.bashrc` (bash)

**Backups:**
The installer creates timestamped backups (e.g., `Microsoft.PowerShell_profile.ps1.backup.20251211094248`)
- Location (PowerShell): `~\Documents\WindowsPowerShell\`
- Location (bash/zsh): Same directory as config file with `.backup` extension

You can restore from a backup if needed:
```powershell
# PowerShell
Copy-Item "$PROFILE.backup.20251211094248" $PROFILE

# Linux/macOS
cp ~/.bashrc.backup.20251211094248 ~/.bashrc
```

---

## Architecture & Maintenance

### YAML-Based Tool Management

Docker Toolbox uses a **single source of truth** approach for managing tools:

```
tools.yaml → generate.py → Outputs
                          ├── docker-dev-tools.md
                          ├── install.sh
                          └── install-interactive.ps1
```

**All tools are defined in `tools.yaml`** with:
- Tool name, category, description
- Docker image and commands
- Aliases and command variations
- Notes and usage examples

**The `generate.py` script** automatically generates:
- ✅ **Markdown documentation** (`docker-dev-tools.md`) - Complete reference guide
- ✅ **Bash installer** (`install.sh`) - Adds aliases to `~/.bashrc` or `~/.zshrc`
- ✅ **PowerShell installer** (`install-interactive.ps1`) - Interactive tool selection
- ✅ **PDF documentation** (`docker-toolbox.pdf`) - Beautiful professional documentation
- 📁 **Typst source** (`docgen/*.typ`) - Source files (gitignored)

### For Maintainers: Adding a New Tool

1. **Edit `tools.yaml`** only (not the generated files):
   ```yaml
   - name: newtool
     category: terminal-tools
     description: Description of the tool
     image: official/image:tag
     type: ephemeral
     aliases:
       - dtnewtool
     commands:
       default: |
         docker run --rm -it official/image:tag $args
   ```

2. **Validate and generate all outputs**:
   ```bash
   python generate.py --validate
   python generate.py --all
   ```

3. **Test the generated outputs**:
   - Check `docker-dev-tools.md` for proper formatting
   - Run generated `install.sh` on Linux/macOS
   - Run generated `install-interactive.ps1` on Windows
   - Verify the Docker command works

4. **Regenerate PDF** (optional but recommended):
   ```bash
   just pdf
   ```

5. **Commit all changes**:
   ```bash
   git add tools.yaml docker-dev-tools.md install.sh install-interactive.ps1 docker-toolbox.pdf
   git commit -m "Add [tool-name] to Docker Toolbox"
   ```

### Generator Usage

```bash
# Validate tools.yaml structure
python generate.py --validate

# Generate specific output
python generate.py --markdown
python generate.py --bash
python generate.py --powershell

# Generate everything (markdown + installers)
python generate.py --all

# Generate beautiful Typst/PDF documentation
python generate.py --typst

# Specify output directory
python generate.py --all --output-dir dist/
```

**PDF Documentation:**

The PDF (`docker-toolbox.pdf`) is professionally formatted and includes:
- 📄 **Auto-generated from `tools.yaml`** - Always up to date
- 📚 **Complete reference guide** - All 71 tools with examples
- 🎨 **Professional formatting** - Title page, TOC, categories table
- 📊 **Category overview** - Tools organized by 16 categories
- ✅ **Committed to repo** - Easy to download and share
- 📁 **Source files gitignored** - `docgen/` folder not committed

To regenerate the PDF:
```bash
# Using just (recommended)
just pdf

# Or using Python + Docker
python generate.py --typst
docker run --rm -v ${PWD}:/work ghcr.io/typst/typst compile /work/docgen/docker-toolbox.typ /work/docker-toolbox.pdf

# Or if you have Typst installed locally
python generate.py --typst
typst compile docgen/docker-toolbox.typ docker-toolbox.pdf
```

**Benefits of this approach:**
- ✅ **No duplication** - Define each tool once
- ✅ **Consistency** - All outputs stay in sync
- ✅ **Easy maintenance** - Update one file, regenerate all
- ✅ **Validation** - Catch errors before committing
- ✅ **Scalability** - Easy to add 100s of tools

---

## Contributing

We welcome contributions! Whether it's adding new tools, improving documentation, or fixing bugs.

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/add-new-tool
   ```
3. **Add your tool** to `tools.yaml` (see Architecture section above)
4. **Regenerate outputs**:
   ```bash
   python generate.py --validate
   python generate.py --all
   ```
5. **Test your changes** on your platform
6. **Submit a pull request** with a clear description

### Contribution Guidelines

- **Edit `tools.yaml` only** - Don't manually edit generated files
- **Follow the YAML structure** in existing tools
- **Use official Docker images** when available
- **Pin version tags** (e.g., `python:3.12` instead of `python:latest`)
- **Test commands** on your platform before submitting
- **Run `python generate.py --validate`** to check for errors
- **Run `python generate.py --all`** to regenerate outputs
- **Keep descriptions concise** and informative
- **Use the `dt` prefix** for all aliases (e.g., `dtpython`, `dtnode`)

### What to Contribute

- **New tools**: Add tools not yet in the collection
- **Better Docker images**: Suggest more efficient/official images
- **Platform-specific fixes**: Improve Windows/macOS/Linux compatibility
- **Documentation**: Clarify usage, add examples, fix typos
- **Limitations**: Document edge cases or workarounds

---

## Tips & Best Practices

1. **Pre-pull images** to avoid delays during first use:
   ```bash
   docker pull python:3.12
   docker pull node:22
   docker pull postgres:16
   ```

2. **Use specific version tags** for reproducibility:
   - Good: `python:3.12`, `node:22`, `postgres:16`
   - Avoid: `python:latest`, `node:latest`

3. **The `--rm` flag** automatically removes containers after use (keeps things clean)

4. **Interactive mode** (`-it` flags) needed for REPLs, shells, and TUI apps

5. **Volume mounts** (`-v ${PWD}:/app`) share your current directory with container

6. **Clean up periodically**:
   ```bash
   # Remove stopped containers
   docker container prune

   # Remove unused images
   docker image prune

   # Remove everything unused
   docker system prune -a
   ```

7. **Create project-specific alias files** that your team can share

8. **Check disk usage**:
   ```bash
   docker system df
   ```

---

## Troubleshooting

### Common Issues

**Command not found / Permission denied**
- Ensure Docker is running
- Check Docker is in your PATH
- On Linux, add user to docker group: `sudo usermod -aG docker $USER`

**Volume mount doesn't work**
- Windows: Use PowerShell or Git Bash
- Check path format matches your OS
- Verify directory exists

**Can't access host services from container**
- Use `host.docker.internal` as hostname
- Example: `psql -h host.docker.internal -U postgres`

**Image pull is slow**
- Normal for first time (images can be 100MB-2GB)
- Consider pre-pulling images you'll use frequently

**Permission issues on Linux**
- Add `--user $(id -u):$(id -g)` to Docker commands
- Example: `docker run --rm --user $(id -u):$(id -g) -v ${PWD}:/app python:3.12 python script.py`

---

## Star History

If you find this project useful, please consider giving it a star! It helps others discover the project.

[![Star History Chart](https://api.star-history.com/svg?repos=yourusername/docker-toolbox&type=Date)](https://star-history.com/#yourusername/docker-toolbox&Date)

---

## Documentation

- **[docker-dev-tools.md](docker-dev-tools.md)** - Complete reference with all tools and examples
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Detailed contribution guidelines

---

## License

MIT License - Feel free to use, modify, and distribute.

## Acknowledgments

Thanks to:
- All the Docker image maintainers
- The open-source community
- Contributors who add new tools and improvements

---

<div align="center">

**Found this useful?** [⭐ Star the repo](https://github.com/yourusername/docker-toolbox) and share it with your team!

**Have a tool to add?** [PRs welcome!](CONTRIBUTING.md)

**Found a bug?** [Open an issue](https://github.com/yourusername/docker-toolbox/issues)


</div>
