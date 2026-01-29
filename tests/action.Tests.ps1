BeforeAll {
  # Load the PowerShell script
  . "$PSScriptRoot/../action.ps1"
}

Describe "ConvertTo-Slug" {
  BeforeEach {
    # Setup function to run before each test
    $env:GITHUB_OUTPUT = [System.IO.Path]::GetTempFileName()
  }

  AfterEach {
    # Teardown function to clean up after each test
    if (Test-Path $env:GITHUB_OUTPUT) {
      Remove-Item $env:GITHUB_OUTPUT -Force
    }
  }

  It "converts string to valid slug" {
    $result = ConvertTo-Slug -InputString "Hello World! 123"
    
    $output = Get-Content $env:GITHUB_OUTPUT
    $output | Should -Contain "result=success"
    $output | Should -Contain "slug=hello-world-123"
    $result | Should -Be "hello-world-123"
  }

  It "handles special characters" {
    $result = ConvertTo-Slug -InputString "Test@#  Spaces--Test"
    
    $output = Get-Content $env:GITHUB_OUTPUT
    $output | Should -Contain "result=success"
    $output | Should -Contain "slug=test-spaces-test"
    $result | Should -Be "test-spaces-test"
  }

  It "handles leading and trailing hyphens" {
    $result = ConvertTo-Slug -InputString "--Leading-Trailing--"
    
    $output = Get-Content $env:GITHUB_OUTPUT
    $output | Should -Contain "result=success"
    $output | Should -Contain "slug=leading-trailing"
    $result | Should -Be "leading-trailing"
  }

  It "fails with empty input" {
    ConvertTo-Slug -InputString ""
    
    $output = Get-Content $env:GITHUB_OUTPUT
    $output | Should -Contain "result=failure"
    $output | Should -Contain "slug="
    $output | Should -Contain "error-message=Missing required parameter: input-string."
  }
}
