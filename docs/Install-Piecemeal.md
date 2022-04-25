
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
* [](Get-Extension.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Install-Piecemeal -ExtensionModule RoughDraft -ExtensionModuleAlias rd -ExtensionTypeName RoughDraft.Extension
```

---
### Parameters
#### **ExtensionModule**

The name of the module that is being extended.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|true    |1      |true (ByPropertyName)|
---
#### **Verb**

The verbs to install.  By default, installs Get.



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



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |4      |true (ByPropertyName)|
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
### Outputs
System.String


---
### Syntax
```PowerShell
Install-Piecemeal [-ExtensionModule] <String> [[-Verb] <String[]>] [[-ExtensionModuleAlias] <String[]>] [[-ExtensionPattern] <String>] [[-ExtensionTypeName] <String>] [[-ExtensionNoun] <String>] [-RequireExtensionAttribute] [-RequireCmdletAttribute] [[-OutputPath] <String>] [<CommonParameters>]
```
---
### Notes
This returns a modified Get-Extension



