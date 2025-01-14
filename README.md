## Synopsis

Script to set up a Clean Architecture solution with multiple projects.

## Description

This script creates a new .NET solution and adds multiple projects to it following the Clean Architecture pattern. It creates a solution file and four projects: Api, Application, Domain, and Infra.

## Parameter

**SolutionName**  
The name of the solution to be created.

## Example

```powershell
.\CleanArchSetup.ps1 -SolutionName "MySolution"
```

This command creates a solution named "MySolution" and adds the Api, Application, Domain, and Infra projects to it.

## Notes

- The script requires the .NET SDK to be installed and available in the system's PATH.
- The script creates a "src" directory if it does not exist and places all projects within this directory.