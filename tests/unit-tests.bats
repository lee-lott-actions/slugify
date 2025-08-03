#!/usr/bin/env bats

# Load the Bash script containing the slugify_string function
load ../action.sh

# Setup function to run before each test
setup() {
  export GITHUB_OUTPUT=$(mktemp)
}

# Teardown function to clean up after each test
teardown() {
  rm -f "$GITHUB_OUTPUT"
}

@test "slugify_string converts string to valid slug" {
  run slugify_string "Hello World! 123"
  [ "$status" -eq 0 ]
  [ "$output" = "hello-world-123" ]
  [ "$(grep 'result' "$GITHUB_OUTPUT")" = "result=success" ]
  [ "$(grep 'slug' "$GITHUB_OUTPUT")" = "slug=hello-world-123" ]
}

@test "slugify_string handles special characters" {
  run slugify_string "Test@#  Spaces--Test"
  [ "$status" -eq 0 ]
  [ "$output" = "test-spaces-test" ]
  [ "$(grep 'result' "$GITHUB_OUTPUT")" = "result=success" ]
  [ "$(grep 'slug' "$GITHUB_OUTPUT")" = "slug=test-spaces-test" ]
}

@test "slugify_string handles leading and trailing hyphens" {
  run slugify_string "--Leading-Trailing--"
  [ "$status" -eq 0 ]
  [ "$output" = "leading-trailing" ]
  [ "$(grep 'result' "$GITHUB_OUTPUT")" = "result=success" ]
  [ "$(grep 'slug' "$GITHUB_OUTPUT")" = "slug=leading-trailing" ]
}

@test "slugify_string fails with empty input" {
  run slugify_string ""
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
  [ "$(grep 'result' "$GITHUB_OUTPUT")" = "result=failure" ]
  [ "$(grep 'slug' "$GITHUB_OUTPUT")" = "slug=" ]
  [ "$(grep 'error-message' "$GITHUB_OUTPUT")" = "error-message=Missing required parameter: input-string." ]
}
