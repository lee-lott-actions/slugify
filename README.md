# Slugify String Action

This GitHub Action transforms a string into a GitHub-compatible slug (e.g., converts "My Awesome Repo" to "my-awesome-repo"). It processes the input locally and outputs the slugified string for use in workflows.

## Features
- Converts a string to a lowercase slug with hyphens, removing special characters.
- Outputs the slugified string (`slug`) for easy integration into workflows.
- Requires no external API calls or permissions, ensuring lightweight execution.

## Inputs
| Name        | Description                                      | Required | Default |
|-------------|--------------------------------------------------|----------|---------|
| `input-string` | The string to slugify (e.g., "My Awesome Repo"). | Yes      | N/A     |

## Outputs
| Name        | Description                                           |
|-------------|-------------------------------------------------------|
| `result` | Result of the slugify ("success" or "failure").    |
| `slug` | The slugified string (e.g., "my-awesome-repo").    |
| `error-message` | Error message if the slugify fails.    |

## Usage
1. **Add the Action to Your Workflow**:
   Create or update a workflow file (e.g., `.github/workflows/slugify-string.yml`) in your repository.

2. **Reference the Action**:
   Use the action by referencing the repository and version (e.g., `v1`), or the local path if stored in the same repository.

3. **Example Workflow**:
   ```yaml
   name: Slugify String
   on:
     push:
       branches:
         - main
   jobs:
     slugify:
       runs-on: ubuntu-latest
       steps:
         - name: Slugify String
           id: slugify
           uses: la-actions/slugify@v1.0.0
           with:
             name: 'My Awesome Repo'
         - name: Print Slug
           run: |
             echo "Slugified string: ${{ steps.slugify.outputs.slug }}"
