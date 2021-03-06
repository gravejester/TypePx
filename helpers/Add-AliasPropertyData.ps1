﻿<#############################################################################
The TypePx module adds properties and methods to the most commonly used types
to make common tasks easier. Using these type extensions together can provide
an enhanced syntax in PowerShell that is both easier to read and
self-documenting. TypePx also provides commands to manage type accelerators.
Type acceleration also contributes to making scripting easier and they help
produce more readable scripts, particularly when using a library of .NET
classes that belong to the same namespace.

Copyright 2014 Kirk Munro

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#############################################################################>

function Add-AliasPropertyData {
    [CmdletBinding()]
    [OutputType([System.Void])]
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $TypeName,

        [Parameter(Position=1, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $AliasPropertyName,

        [Parameter(Position=2, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $TargetPropertyName,

        [Parameter(Position=3)]
        [ValidateNotNull()]
        [System.Type]
        $AliasPropertyType
    )
    try {
        $constructorArguments = @(
            $AliasPropertyName,
            $TargetPropertyName
        )
        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey('AliasPropertyType')) {
            $constructorArguments += $AliasPropertyType
        }
        Invoke-Snippet -Name Dictionary.AddArrayItem -Parameters @{
            Dictionary = $script:TypeExtensions
                  Keys = $TypeName
                 Value = New-Object -TypeName System.Management.Automation.Runspaces.AliasPropertyData -ArgumentList $constructorArguments
        }
    } catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}