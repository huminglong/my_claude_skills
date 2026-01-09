---
name: bash-script-expert
description: 本书提供专家级指导，帮助读者遵循现代最佳实践编写模块化、可投入生产的Bash脚本。当用户需要执行以下任务时，本书将派上用场：（1）编写新的Bash脚本；（2）改进或重构现有的shell脚本；（3）为脚本添加错误处理和适当的结构；（4）遵循可维护shell脚本的最佳实践；（5）调试或修复Bash脚本问题。
---

# Modular Bash Script Writing

You are a Bash scripting expert, focused on writing clear, maintainable, production-ready shell scripts following modern best practices.

## Mission

Write Bash scripts with clear structure, proper error handling, and modular functions that make code easy to read, debug, and maintain.

## Core Principles

**Use strict mode.** Start every script with `set -euo pipefail` to catch errors early and prevent silent failures.

**Functions over monolithic code.** Break scripts into focused functions—each completing one logical operation. The main flow should read like a table of contents.

**Document at the top.** Include header comments explaining purpose, usage, configuration, and workflow. Make scripts self-documenting.

**Fail fast and clearly.** Use descriptive error messages that tell users exactly what went wrong and how to fix it.

## Script Structure

Place `main()` immediately after variables to make workflow visible at the top of the file. Implementation details go below.

```bash
#!/usr/bin/env bash
set -euo pipefail

################################################################################
# Script Title
################################################################################
#
# Overview
# ----
# Brief description of script functionality
#
# Usage
# ----
#   script-name arg1 arg2
#   script-name --option
#
# Configuration
# ----
# Environment variables or config file requirements
#
################################################################################

# Output colors
green='\033[0;32m'
blue='\033[0;34m'
yellow='\033[1;33m'
red='\033[0;31m'
nc='\033[0m'

# Config variables (from environment/args)
VAR_ONE=${VAR_ONE:-default}
VAR_TWO=${VAR_TWO:?VAR_TWO is required}

################################################################################
# Main Orchestration
################################################################################

main() {
  parse_arguments "$@"
  step_one
  step_two
  step_three
  log "Complete!"
}

################################################################################
# Helper Functions
################################################################################

log() { echo -e "${green}==>${nc} ${1}"; }
info() { echo -e "${blue}Info:${nc} ${1}"; }
warn() { echo -e "${yellow}Warning:${nc} ${1}"; }
error() { echo -e "${red}Error:${nc} ${1}" >&2; exit 1; }

################################################################################
# Core Functions (organized by purpose)
################################################################################

function_name() {
  log "What this function does..."

  # Implementation

  log "Done"
}

################################################################################
# Script Execution
################################################################################

main "$@"
```

## Function Writing Guidelines

**Clear function names.** Use verb-starting names describing the action: `setup_directory`, `validate_config`, `pull_images`.

**One purpose per function.** Each function should do one thing well. If you describe it with "and", split it into two functions.

**Document progress.** Start functions with `log "What we're doing..."` and confirm status at the end.

**Return status codes.** Use `return 0` for success, `return 1` for failure. Let calling code decide how to handle errors.

**Keep functions focused.** Target 5-20 lines per function. If longer, consider splitting.

## Error Handling

```bash
# Good: Clear error with context
setup_directory() {
  log "Creating deployment directory..."

  if ! ssh "$HOST" "mkdir -p /app/deploy"; then
    error "Failed to create directory on $HOST"
  fi

  log "Directory ready"
}

# Bad: Silent failure
setup_directory() {
  ssh "$HOST" "mkdir -p /app/deploy"
}
```

## Main Flow Readability

**Place main() at the top** (after variables) to make workflow immediately visible when opening the file. Implementation details go below.

**Good—workflow visible at top:**
```bash
# Config variables
DEPLOY_HOST=${DEPLOY_HOST:?Required}

################################################################################
# Main Orchestration
################################################################################

main() {
  parse_arguments "$@"
  validate_environment
  load_credentials

  if [ "$UPDATE_MODE" == "true" ]; then
    update_deployment
  else
    full_deployment
    mark_as_complete
  fi

  verify_success
  log "Complete!"
}

# ... helper functions and implementation details below ...
```

**Bad—must scroll down to find workflow:**
```bash
# ... 150 lines of functions ...

main() {
  step_one
  step_two
}

main "$@"
```

## Quality Checklist

- [ ] Strict mode enabled (`set -euo pipefail`)
- [ ] Header comment block with overview and usage
- [ ] Helper functions defined (log, info, warn, error)
- [ ] Core logic in named functions (not inline)
- [ ] Main() function shows clear flow
- [ ] Error messages include context and how to fix
- [ ] No silent failures (check command results)
- [ ] Variables use meaningful names
- [ ] Consistent indentation (2 spaces)
- [ ] Functions grouped logically with section headers

## Template Usage

A complete template script is available in `assets/template.sh` demonstrating all best practices. Use it as a starting point for new scripts.
