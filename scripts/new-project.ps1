function New-Project {
  [CmdletBinding()]
  param (
    # Parameter help description
    [Parameter(Mandatory = $true)]
    [string]
    $ProjectName,

    # Parameter help description
    [Parameter(Mandatory = $true)]
    [ValidateSet('Library', 'Console', 'WebApi', 'WebApp', 'Function', 'BlazorServer', 'BlazorWasm', 'RazorLibrary', 'xUnit', 'NUnit', 'MSTest', 'Benchmarks')]
    [string]
    $ProjectType,

    # Solution File
    [Parameter(Mandatory = $true)]
    [string]
    $SolutionFile,

    # Output Direcotry
    [Parameter(Mandatory = $true)]
    [string]
    $OutputDirectory,

    # Parameter help description
    [Parameter(Mandatory = $true)]
    [string]
    $Framework,

    # Parameter help description
    [Parameter(Mandatory = $true)]
    [boolean]
    $DisableTests,

    # Parameter help description
    [Parameter(Mandatory = $true)]
    [boolean]
    $DisableUnitTests,

    # Parameter help description
    [Parameter(Mandatory = $true)]
    [boolean]
    $DisableIntegrationTests,

    [Parameter(Mandatory = $true)]
    [boolean]
    $EnableProjectGrouping,

    [Parameter(Mandatory = $false)]
    [boolean]
    $EnableAdvProjectGrouping = $false,

    [Parameter(Mandatory = $false)]
    [boolean]
    $DisableArchitectureTests = $false
  )

  begin {
    function New-TestProject {
      param (
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $projectName,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $folder,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $sourceProject,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $framework,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $solutionFile,

        [Parameter(Mandatory = $false)]
        [string]
        $projectGroupName = ""
      )

      dotnet new classlib -n $projectName -o $folder -f $framework --no-restore --force | Out-Null
      # Add Project reference
      dotnet add $folder reference $sourceProject | Out-Null
      # Add additional packages
      $additionalPackages = @('coverlet.msbuild', 'coverlet.collector', 'Microsoft.NET.Test.Sdk', 'xunit', 'xunit.runner.visualstudio', 'xunit.analyzers', 'NetEvolve.Extensions.XUnit')
      foreach ($additionalPackage in $additionalPackages) {
        $createPackageParameters = 'add', $folder, 'package', $additionalPackage
        & dotnet $createPackageParameters | Out-Null
      }

      $targetFolder = 'tests'
      if ($projectGroupName -ne "") {
        $targetFolder = "src/$($projectGroupName)/$($targetFolder)"
      }

      dotnet sln $solutionFile add -s $targetFolder $folder | Out-Null
    }
  }

  process {
    # Update the templates
    dotnet new --update-apply | Out-Null

    # DON'T CHANGE!
    $projectSdk = 'classlib'
    $targetFolder = 'src'
    $additionalCreateParameters = @()
    $additionalPackages = @()
    $setFramework = $true
    $createProjectReadMe = $false
    $projectGroup = ""
    $projectGroupName = ""

    switch ($ProjectType) {
      'Library' {
        $createProjectReadMe = $true
      }
      'Console' {
        $projectSdk = 'console'
        $additionalCreateParameters += '--use-program-main', '--no-restore'
      }
      'WebApi' {
        $projectSdk = 'webapi'
        $additionalCreateParameters += '--use-program-main', '--no-restore'
      }
      'WebApp' {
        $projectSdk = 'webapp'
        $additionalCreateParameters += '--use-program-main', '--no-restore'
      }
      'Function' {
        $projectSdk = 'func'
        $setFramework = $false
        $Framework = 'net6.0'
      }
      'BlazorServer' {
        $projectSdk = 'blazorserver-empty'
        $additionalCreateParameters += '--no-restore'
      }
      'BlazorWasm' {
        $projectSdk = 'blazorwasm-empty'
        $additionalCreateParameters += '--no-restore'
      }
      'RazorLibrary' {
        $projectSdk = 'razorclasslib'
        $additionalCreateParameters += '--support-pages-and-views', '--no-restore'
      }
      'xUnit' {
        $DisableTests = $true
        $targetFolder = 'tests'
        $additionalCreateParameters += '--no-restore'
        $additionalPackages += 'coverlet.collector', 'coverlet.msbuild', 'Verify.Xunit', 'Microsoft.NET.Test.Sdk', 'xunit', 'xunit.runner.visualstudio', 'xunit.analyzers', 'NetEvolve.Extensions.XUnit'
      }
      'NUnit' {
        $DisableTests = $true
        $targetFolder = 'tests'
        $additionalCreateParameters += '--no-restore'
        $additionalPackages += 'coverlet.collector', 'coverlet.msbuild', 'Verify.Nunit', 'Microsoft.NET.Test.Sdk', 'NUnit', 'NUnit3TestAdapter', 'NUnit.Analyzers', 'NetEvolve.Extensions.NUnit'
      }
      'MSTest' {
        $DisableTests = $true
        $targetFolder = 'tests'
        $additionalCreateParameters += '--no-restore'
        $additionalPackages += 'coverlet.collector', 'coverlet.msbuild', 'Verify.MSTest', 'Microsoft.NET.Test.Sdk', 'MSTest', 'NetEvolve.Extensions.MSTest'
      }
      'Benchmarks' {
        $projectSdk = 'console'
        $ProjectName = "$($ProjectName).Benchmarks"
        $DisableTests = $true
        $additionalCreateParameters += '--use-program-main', '--no-restore'
        $additionalPackages += 'BenchmarkDotNet'
      }
    }

    if ([string]::IsNullOrWhiteSpace($Framework)) {
      $Framework = 'net8.0'
    }

    $projectGroupStart = $ProjectName.IndexOf('.')
    if ($EnableProjectGrouping -eq $true -and $projectGroupStart -ne -1) {
      $projectGroupStart += 1

      $projectGroupEnd = $ProjectName.IndexOf('.', $projectGroupStart)
      if ($EnableAdvProjectGrouping -eq $true -and $projectGroupEnd -ne -1) {
        $projectGroupName = $ProjectName.Substring($projectGroupStart, $projectGroupEnd - $projectGroupStart)
      } else {
        $projectGroupName = $ProjectName.Substring($projectGroupStart)
      }
      $projectGroup = "src/$($projectGroupName)/"
    }

    $ProjectFolder = New-Item -Path "$($projectGroup)$($targetFolder)\$($ProjectName)" -ItemType Directory -Force
    if ($projectGroupName -ne "") {
      $targetFolder = "src/$($projectGroupName)/$($targetFolder)"
    }

    $createParameters = 'new', $projectSdk, '-n', $ProjectName, '-o', $ProjectFolder, '--force'
    if ($EnableAdvProjectGrouping -eq $true -or $setFramework -eq $true) {
      $createParameters += '-f', $Framework
    }
    & dotnet $createParameters $additionalCreateParameters | Out-Null

    foreach ($additionalPackage in $additionalPackages) {
      $createPackageParameters = 'add', $ProjectFolder, 'package', $additionalPackage
      & dotnet $createPackageParameters | Out-Null
    }

    if ($createProjectReadMe -eq $true) {
      $ProjectReadMe = New-Item -Path "$($ProjectFolder)\README.md" -ItemType File -Force
      Set-Content -Path $ProjectReadMe -Value 'Please give the customer a brief introduction about this library, and how to use it.'
    }

    dotnet sln $SolutionFile add -s "$($targetFolder)" $ProjectFolder | Out-Null

    if ($DisableTests -eq $false) {
      if ($DisableUnitTests -eq $false) {
        $ProjectNameUnitTests = "$($ProjectName).Tests.Unit"
        $ProjectFolderUnitTests = New-Item -Path "$($projectGroup)tests\$($ProjectNameUnitTests)" -ItemType Directory -Force
        New-TestProject $ProjectNameUnitTests $ProjectFolderUnitTests $ProjectFolder $Framework $SolutionFile $projectGroupName
      }

      if ($DisableIntegrationTests -eq $false) {
        $ProjectNameIntegrationTests = "$($ProjectName).Tests.Integration"
        $ProjectFolderIntegrationTests = New-Item -Path "$($projectGroup)tests\$($ProjectNameIntegrationTests)" -ItemType Directory -Force
        New-TestProject $ProjectNameIntegrationTests $ProjectFolderIntegrationTests $ProjectFolder $Framework $SolutionFile $projectGroupName
      }

      if ($DisableArchitectureTests -eq $false) {
        $ProjectNameArchitectureTests = "$($ProjectName).Tests.Architecture"
        $ProjectFolderArchitectureTests = New-Item -Path "$($projectGroup)tests\$($ProjectNameArchitectureTests)" -ItemType Directory -Force
        New-TestProject $ProjectNameArchitectureTests $ProjectFolderArchitectureTests $ProjectFolder $Framework $SolutionFile $projectGroupName
      }
    }

  }

  end {
  }
}
