Describe "ConvertTo-Slug" {
	BeforeAll {
	  # Load the PowerShell script
	  . "$PSScriptRoot/../action.ps1"
	}
	
	BeforeEach {
		$env:GITHUB_OUTPUT = New-TemporaryFile
	}
	
	AfterEach {
		if (Test-Path $env:GITHUB_OUTPUT) { Remove-Item $env:GITHUB_OUTPUT }
	}

	Context "Conversion Cases" {
		It "unit: ConvertTo-Slug converts string to valid slug" {
			$result = ConvertTo-Slug -InputString "Hello World! 123"
			
			$output = Get-Content $env:GITHUB_OUTPUT
			$output | Should -Contain "result=success"
			$output | Should -Contain "slug=hello-world-123"
			$result | Should -Be "hello-world-123"
		}
		
		It "unit: ConvertTo-Slug handles special characters" {
			$result = ConvertTo-Slug -InputString "Test@#  Spaces--Test"
			
			$output = Get-Content $env:GITHUB_OUTPUT
			$output | Should -Contain "result=success"
			$output | Should -Contain "slug=test-spaces-test"
			$result | Should -Be "test-spaces-test"
		}
		
		It "unit: ConvertTo-Slug handles leading and trailing hyphens" {
			$result = ConvertTo-Slug -InputString "--Leading-Trailing--"
			
			$output = Get-Content $env:GITHUB_OUTPUT
			$output | Should -Contain "result=success"
			$output | Should -Contain "slug=leading-trailing"
			$result | Should -Be "leading-trailing"
		}
	}	
	
	Context "Parameter Validation Failure Cases" {
		It "unit: ConvertTo-Slug fails with empty input" {
			ConvertTo-Slug -InputString ""
			
			$output = Get-Content $env:GITHUB_OUTPUT
			$output | Should -Contain "result=failure"
			$output | Should -Contain "slug="
			$output | Should -Contain "error-message=Missing required parameter: input-string."
		}
	}	

	Context "Exception Failure Cases" {
		It "unit: ConvertTo-Slug fails with exception" {
			Mock Write-Output { throw "Write-Output Error" }
	
			try {
				$result = ConvertTo-Slug -InputString "Hello World! 123"
			} catch {}
	
			$output = Get-Content $env:GITHUB_OUTPUT
			$output | Should -Contain "result=failure"
			$output | Should -Contain "slug="
			$output | Where-Object { $_ -match "^error-message=Error: Failed to slugify string\. Exception:" } |
				Should -Not -BeNullOrEmpty
		}   
  	}
}
