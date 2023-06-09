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
    $DisableIntegrationTests
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
        $solutionFile
      )

      dotnet new xunit -n $projectName -o $folder -f $framework --no-restore --force | Out-Null
      # Add Project reference
      dotnet add $folder reference $sourceProject | Out-Null
      # Add additional packages
      dotnet add $folder package --no-restore coverlet.msbuild | Out-Null
      dotnet add $folder package --no-restore Verify.Xunit | Out-Null

      dotnet sln $solutionFile add -s 'tests' $folder | Out-Null
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
        $projectSdk = 'xunit'
        $DisableTests = $true
        $targetFolder = 'tests'
        $additionalCreateParameters += '--no-restore'
        $additionalPackages += 'coverlet.msbuild', 'Verify.Xunit'
      }
      'NUnit' {
        $projectSdk = 'nunit'
        $DisableTests = $true
        $targetFolder = 'tests'
        $additionalCreateParameters += '--no-restore'
        $additionalPackages += 'coverlet.msbuild', 'Verify.Nunit'
      }
      'MSTest' {
        $projectSdk = 'mstest'
        $DisableTests = $true
        $targetFolder = 'tests'
        $additionalCreateParameters += '--no-restore'
        $additionalPackages += 'coverlet.msbuild', 'Verify.MSTest'
      }
      'Benchmarks' {
        $projectSdk = 'console'
        $ProjectName = "$($ProjectName).Benchmarks"
        $DisableTests = $true
        $additionalCreateParameters += '--use-program-main', '--no-restore'
        $additionalPackages += 'BenchmarkDotNet'
      }
    }

    $ProjectFolder = New-Item -Path "$($targetFolder)\$($ProjectName)" -ItemType Directory -Force

    $createParameters = 'new', $projectSdk, '-n', $ProjectName, '-o', $ProjectFolder, '--force'
    if ($setFramework -eq $true) {
      $createParameters += '-f', $Framework
    }
    & dotnet $createParameters $additionalCreateParameters | Out-Null

    foreach ($additionalPackage in $additionalPackages) {
      $createPackageParameters = 'add', $ProjectFolder, 'package', $additionalPackage, '--no-restore'
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
        $ProjectFolderUnitTests = New-Item -Path "tests\$($ProjectNameUnitTests)" -ItemType Directory -Force
        New-TestProject $ProjectNameUnitTests $ProjectFolderUnitTests $ProjectFolder $Framework $SolutionFile
      }

      if ($DisableIntegrationTests -eq $false) {
        $ProjectNameIntegrationTests = "$($ProjectName).Tests.Integration"
        $ProjectFolderIntegrationTests = New-Item -Path "tests\$($ProjectNameIntegrationTests)" -ItemType Directory -Force
        New-TestProject $ProjectNameIntegrationTests $ProjectFolderIntegrationTests $ProjectFolder $Framework $SolutionFile
      }
    }

  }

  end {
  }
}
