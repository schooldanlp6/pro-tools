#!/bin/bash

TOOLS_DIR="./tools"

# Function to list available tools
list_tools() {
    echo "Available tools:"
    for tool in "$TOOLS_DIR"/*; do
        if [[ -x "$tool" && -f "$tool" ]]; then
            echo "  - $(basename "$tool")"
        fi
    done
}

# No arguments: show help and list tools
if [ $# -eq 0 ]; then
    echo "protools shell command: use to execute build tools or list them."
    echo "Usage:"
    echo "  ./pro                  # Show this help and list available tools"
    echo "  ./pro <tool>           # Execute a tool with default config"
    echo "  ./pro <tool> --help    # Execute a tool with help"
    echo "Author: Daniel Alvir"
    echo ""
    list_tools
    exit 0
fi

# Extract tool name and shift to pass remaining args
TOOL_NAME="$1"
shift
TOOL_PATH="$TOOLS_DIR/$TOOL_NAME"

# Check if tool exists and is executable
if [[ -x "$TOOL_PATH" && -f "$TOOL_PATH" ]]; then
    "$TOOL_PATH" "$@"
else
    echo "Error: Tool '$TOOL_NAME' not found in $TOOLS_DIR or is not executable."
    echo
    list_tools
    exit 1
fi

