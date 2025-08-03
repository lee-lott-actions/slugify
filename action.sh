#!/bin/bash

slugify_string() {
  local input_string="$1"

  if [ -z "$input_string" ]; then
    echo "result=failure" >> "$GITHUB_OUTPUT"
    echo "slug=" >> "$GITHUB_OUTPUT"
    echo "error-message=Missing required parameter: input-string." >> "$GITHUB_OUTPUT"
    return
  fi

  # Convert to lowercase, replace spaces and special characters with hyphens,
  # remove leading/trailing hyphens, and ensure only alphanumeric and hyphens remain
  local slug=$(echo "$input_string" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/-+/-/g; s/^-|-$//g')

  echo "result=success" >> "$GITHUB_OUTPUT"
  echo "slug=$slug" >> "$GITHUB_OUTPUT"

  # Return the slug to stdout for potential piping or further use
  echo "$slug"
}
