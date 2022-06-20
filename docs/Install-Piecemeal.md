
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



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |1      |true (ByPropertyName)|
---
#### **Verb**

The verbs to install.  By default, installs Get.



Valid Values:

* Get
* New
|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |2      |true (ByPropertyName)|
---
#### **ExtensionModuleAlias**

One or more aliases used to refer to the module being extended.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |3      |true (ByPropertyName)|
---
#### **ExtensionPattern**

If provided, will override the default extension name regular expression
(by default '(extension|ext|ex|x)\.ps1$' )



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |4      |true (ByPropertyName)|
---
#### **ExtensionTypeName**

The type name to add to an extension.  This can be used to format the extension.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |5      |true (ByPropertyName)|
---
#### **ExtensionNoun**

The noun used for any extension commands.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |6      |true (ByPropertyName)|
---
#### **RequireExtensionAttribute**

If set, will require a [Runtime.CompilerServices.Extension()] to be considered an extension.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **RequireCmdletAttribute**

If set, will require a [Management.Automation.Cmdlet] attribute to be considered an extension.
This attribute can associate the extension with one or more commands.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **OutputPath**

The output path.
If provided, contents will be written to the output path with Set-Content
Otherwise, contents will be returned.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |7      |true (ByPropertyName)|
---
#### **RenameVariable**

If provided, will rename variables.



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IDictionary]```|false   |8      |true (ByPropertyName)|
---
#### **ForeachObject**

A custom Foreach-Object that will be appended to main pipelines within Get-Extension.



|Type                 |Requried|Postion|PipelineInput|
|---------------------|--------|-------|-------------|
|```[ScriptBlock[]]```|false   |9      |false        |
---
#### **WhereObject**

A custom Where-Object that will be injected to the main pipelines within Get-Extension



|Type                 |Requried|Postion|PipelineInput|
|---------------------|--------|-------|-------------|
|```[ScriptBlock[]]```|false   |10     |false        |
---
### Outputs
System.String


---
### Syntax
```PowerShell
Install-Piecemeal [[-ExtensionModule] <String>] [[-Verb] <String[]>] [[-ExtensionModuleAlias] <String[]>] [[-ExtensionPattern] <String[]>] [[-ExtensionTypeName] <String>] [[-ExtensionNoun] <String>] [-RequireExtensionAttribute] [-RequireCmdletAttribute] [[-OutputPath] <String>] [[-RenameVariable] <IDictionary>] [[-ForeachObject] <ScriptBlock[]>] [[-WhereObject] <ScriptBlock[]>] [<CommonParameters>]
```
---
### Notes
This returns a modified Get-Extension



