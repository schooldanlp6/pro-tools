#!/bin/bash
#!/usr/bin/env bash

TOOLS_DIR="./tools/"
TOOLS_DIR_PRETTY="./tools"

# Function to list available tools
list_tools() {
    echo "Available tools:"
    echo "  - init (builtin tool command)"
    for tool in "$TOOLS_DIR"./*; do
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
    echo "Author: DanLP6"
    echo ""
    list_tools
    exit 0
fi

if [ "$1" == init ]; then
   for tool in "$TOOLS_DIR"./*; do
      chmod +x $tool
   done
fi

# Extract tool name and shift to pass remaining args
TOOL_NAME="$1"
TOOL_ARGS="$2"
shift 1
TOOL_PATH="$TOOLS_DIR/$TOOL_NAME"

# Check if tool exists and is executable
if [[ -x "$TOOL_PATH" && -f "$TOOL_PATH" ]]; then
    "$TOOL_PATH" "$TOOL_ARGS" "$@"
else
    if [ "$TOOL_NAME" == init ]; then
        echo ""
        list_tools
        exit 0
    else
        echo "Error: Tool '$TOOL_NAME' not found in $TOOLS_DIR_PRETTY or is not executable."
        echo
        list_tools
        exit 1
    fi
fi

