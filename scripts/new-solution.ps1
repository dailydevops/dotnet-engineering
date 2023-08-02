function New-Solution {
  [CmdletBinding()]
  param (
    # Solution name
    [Parameter(Mandatory = $true)]
    [string]
    $SolutionName,

    # Output directory
    [Parameter(Mandatory = $true)]
    [string]
    $OutputDirectory
  )

  begin {
  }

  process {
    dotnet new sln -n $SolutionName -o $OutputDirectory | Out-Null

    $solutionFilePath = (Get-ChildItem -File -Path "$SolutionName.sln" | Resolve-Path -Relative).replace('\', '/')
    $scriptNewProject = "$OutputDirectory\new-project.ps1"
    $scriptUpdateSolution = "$OutputDirectory\update-solution.ps1"
    $scriptWorkflow = "$OutputDirectory\.github\workflows\cicd.yml"

    (Get-Content -Path $scriptNewProject) -replace '###SOLUTION###', $solutionFilePath | Set-Content -Path $scriptNewProject
    (Get-Content -Path $scriptUpdateSolution) -replace '###SOLUTION###', $solutionFilePath | Set-Content -Path $scriptUpdateSolution
    (Get-Content -Path $scriptWorkflow) -replace '###SOLUTION###', $solutionFilePath | Set-Content -Path $scriptWorkflow
  }

  end {
  }
}
