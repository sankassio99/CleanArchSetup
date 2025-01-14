param (
    [string]$SolutionName
)

if (-not $SolutionName) {
    Write-Error "Please specify the Solution Name."
    exit
}

# Define the src directory
$SrcDirectory = "./src"
$RootDirectory = "."

# Create the src folder if it doesn't exist
if (-not (Test-Path -Path $SrcDirectory)) {
    New-Item -ItemType Directory -Path $SrcDirectory | Out-Null
}

# Create the solution
Write-Host "Creating solution: $SolutionName.sln"
dotnet new sln -n $SolutionName -o $RootDirectory

# Function to create a project and add it to the solution
function Add-Project {
    param (
        [string]$Type,
        [string]$ProjectName,
        [string]$AdditionalArgs = ""
    )

    $ProjectPath = Join-Path -Path $SrcDirectory -ChildPath $ProjectName

    Write-Host "Creating project: $ProjectName of type $Type"
    Write-Host "dotnet new $Type $AdditionalArgs -n $ProjectName -o $ProjectPath"
    if (-not [string]::IsNullOrWhiteSpace($AdditionalArgs)) {
        $ArgsArray = $AdditionalArgs -split ' '
        dotnet new $Type -n $ProjectName -o $ProjectPath @ArgsArray
    } else {
        dotnet new $Type -n $ProjectName -o $ProjectPath
    }

    Write-Host "Adding $ProjectName to solution"
    dotnet sln "$RootDirectory\$SolutionName.sln" add "$ProjectPath\$ProjectName.csproj"
}

# Create and add projects
Add-Project -Type "webapi" -ProjectName "$SolutionName.Api" -AdditionalArgs "--use-controllers"
Add-Project -Type "classlib" -ProjectName "$SolutionName.Application"
Add-Project -Type "classlib" -ProjectName "$SolutionName.Domain"
Add-Project -Type "classlib" -ProjectName "$SolutionName.Infra"

Write-Host "Solution and projects created successfully in $SrcDirectory."
