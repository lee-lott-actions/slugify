function ConvertTo-Slug {
  param(
    [string]$InputString
  )
  
  if ([string]::IsNullOrEmpty($InputString)) {
    Write-Host "Error: INPUT-STRING must be provided."
    Add-Content -Path $env:GITHUB_OUTPUT -Value "result=failure"
    Add-Content -Path $env:GITHUB_OUTPUT -Value "slug="
    Add-Content -Path $env:GITHUB_OUTPUT -Value "error-message=Missing required parameter: input-string."
    return
  }

  try {
  	Write-Host "Slugifying input string: $InputString"
	
    # Convert to lowercase, replace spaces and special characters with hyphens,
    # remove leading/trailing hyphens, and ensure only alphanumeric and hyphens remain
    $slug = $InputString.ToLower() -replace '[^a-z0-9]+', '-' -replace '^-|-$', ''
    
    Add-Content -Path $env:GITHUB_OUTPUT -Value "result=success"
    Add-Content -Path $env:GITHUB_OUTPUT -Value "slug=$slug"
    Write-Host "Slugify succeeded: $slug"
  } catch {
	$errorMsg = "Error: Failed to slugify string. Exception: $($_.Exception.Message)"
    Add-Content -Path $env:GITHUB_OUTPUT -Value "result=failure"
    Add-Content -Path $env:GITHUB_OUTPUT -Value "slug="
    Add-Content -Path $env:GITHUB_OUTPUT -Value "error-message=$errorMsg"
	Write-Host $errorMsg
  }
}
