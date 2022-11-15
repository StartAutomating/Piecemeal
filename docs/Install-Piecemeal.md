Install-Piecemeal
-----------------
### Synopsis
Installs Piecemeal

---
### Description

Installs Piecemeal into a module.

This enables extensibility within the module.

---
### Related Links
* [Get-Extension](Get-Extension.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Install-Piecemeal -ExtensionModule RoughDraft -ExtensionModuleAlias rd -ExtensionTypeName RoughDraft.Extension
```

#### EXAMPLE 2
```PowerShell
1{0,1})$','\.ps(?<IsPowerShell>1{0,1})\.(?<Extension>[^.]+$)','\.ps(?<IsPowerShell>1{0,1})$' -OutputPath '.\Get-PipeScript.ps1' -RenameVariable @{ExtensionPath='PipeScriptPath'}
```

---
### Parameters
#### **ExtensionModule**

The name of the module that is being extended.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Verb**

The verbs to install.  By default, installs Get.



Valid Values:

* Get
* New



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionModuleAlias**

One or more aliases used to refer to the module being extended.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionPattern**

If provided, will override the default extension name regular expression
(by default '(extension|ext|ex|x)\.ps1$' )



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionTypeName**

The type name to add to an extension.  This can be used to format the extension.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionNoun**

The noun used for any extension commands.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **RequireCmdletAttribute**

If set, will require a [Management.Automation.Cmdlet] attribute to be considered an extension.
This attribute can associate the extension with one or more commands.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **OutputPath**

The output path.
If provided, contents will be written to the output path with Set-Content
Otherwise, contents will be returned.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:true (ByPropertyName)



---
#### **RenameVariable**

If provided, will rename variables.



> **Type**: ```[IDictionary]```

> **Required**: false

> **Position**: 8

> **PipelineInput**:true (ByPropertyName)



---
#### **ForeachObject**

A custom Foreach-Object that will be appended to main pipelines within Get-Extension.



> **Type**: ```[ScriptBlock[]]```

> **Required**: false

> **Position**: 9

> **PipelineInput**:false



---
#### **WhereObject**

A custom Where-Object that will be injected to the main pipelines within Get-Extension



> **Type**: ```[ScriptBlock[]]```

> **Required**: false

> **Position**: 10

> **PipelineInput**:false



---
### Outputs
* [String](https://learn.microsoft.com/en-us/dotnet/api/System.String)


* [IO.FileInfo](https://learn.microsoft.com/en-us/dotnet/api/System.IO.FileInfo)




---
### Syntax
```PowerShell
Install-Piecemeal [[-ExtensionModule] <String>] [[-Verb] <String[]>] [[-ExtensionModuleAlias] <String[]>] [[-ExtensionPattern] <String[]>] [[-ExtensionTypeName] <String>] [[-ExtensionNoun] <String>] [-RequireCmdletAttribute] [[-OutputPath] <String>] [[-RenameVariable] <IDictionary>] [[-ForeachObject] <ScriptBlock[]>] [[-WhereObject] <ScriptBlock[]>] [<CommonParameters>]
```
---
### Notes
This returns a modified Get-Extension
