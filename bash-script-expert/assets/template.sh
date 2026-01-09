#!/usr/bin/env bash
set -euo pipefail

################################################################################
# Script Template
################################################################################
#
# Overview
# ----
# [Brief description of what this script does]
#
# Usage
# ----
#   ./template.sh [arguments]
#   ./template.sh --help
#
# Configuration
# ----
# [Environment variables or config requirements]
#
################################################################################

# Output colors
green='\033[0;32m'
blue='\033[0;34m'
yellow='\033[1;33m'
red='\033[0;31m'
nc='\033[0m'

# Configuration variables
EXAMPLE_VAR=${EXAMPLE_VAR:-default_value}
REQUIRED_VAR=${REQUIRED_VAR:?REQUIRED_VAR must be set}

################################################################################
# Main Orchestration
################################################################################

main() {
  log "Starting script..."

  parse_arguments "$@"
  validate_environment
  perform_main_task

  log "Script completed successfully!"
}

################################################################################
# Helper Functions
################################################################################

log() { echo -e "${green}==>${nc} ${1}"; }
info() { echo -e "${blue}Info:${nc} ${1}"; }
warn() { echo -e "${yellow}Warning:${nc} ${1}"; }
error() { echo -e "${red}Error:${nc} ${1}" >&2; exit 1; }

show_help() {
  cat << EOF
Usage: ${0##*/} [OPTIONS]

Description of what this script does.

OPTIONS:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    --option VALUE      Example option

EXAMPLES:
    ${0##*/}
    ${0##*/} --option value

EOF
  exit 0
}

################################################################################
# Core Functions
################################################################################

parse_arguments() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -h|--help)
        show_help
        ;;
      -v|--verbose)
        VERBOSE=true
        shift
        ;;
      *)
        error "Unknown option: $1. Use --help for usage information."
        ;;
    esac
  done
}

validate_environment() {
  log "Validating environment..."

  # Add validation checks here
  if [ ! -d "/path/to/check" ]; then
    error "Required directory not found"
  fi

  log "Environment validated"
}

perform_main_task() {
  log "Performing main task..."

  # Main implementation here

  log "Task completed"
}

################################################################################
# Script Execution
################################################################################

main "$@"
