function ConvertTo-Slug {
  param(
    [string]$InputString
  )

  Write-Host "Slugifying input string: $InputString"

  if ([string]::IsNullOrEmpty($InputString)) {
    Write-Host "Error: INPUT-STRING must be provided."
    Add-Content -Path $env:GITHUB_OUTPUT -Value "result=failure"
    Add-Content -Path $env:GITHUB_OUTPUT -Value "slug="
    Add-Content -Path $env:GITHUB_OUTPUT -Value "error-message=Missing required parameter: input-string."
    return
  }

  try {
    # Convert to lowercase, replace spaces and special characters with hyphens,
    # remove leading/trailing hyphens, and ensure only alphanumeric and hyphens remain
    $slug = $InputString.ToLower() -replace '[^a-z0-9]+', '-' -replace '^-|-$', ''
    
    Add-Content -Path $env:GITHUB_OUTPUT -Value "result=success"
    Add-Content -Path $env:GITHUB_OUTPUT -Value "slug=$slug"
    Write-Host "Slugify succeeded: $slug"
    
    # Return the slug to stdout for potential piping or further use
    Write-Output "$slug"
  } catch {
    Write-Host "Failed to slugify string."
    Add-Content -Path $env:GITHUB_OUTPUT -Value "result=failure"
    Add-Content -Path $env:GITHUB_OUTPUT -Value "slug="
    Add-Content -Path $env:GITHUB_OUTPUT -Value "error-message=Failed to slugify string."
  }
}
