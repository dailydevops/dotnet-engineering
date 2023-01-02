function Update-Solution {
  [CmdletBinding()]
  param (
    # Output directory
    [Parameter(Mandatory = $true)]
    [string]
    $OutputDirectory
  )

  begin {
  }

  process {
    # Update the templates
    dotnet new --update-apply | Out-Null
  }

  end {
  }
}

