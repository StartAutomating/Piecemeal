New-Extension
-------------
### Synopsis
Creates an Extension

---
### Description

Creates an Extension

---
### Related Links
* [Get-Extension](Get-Extension.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
New-Extension -ExtensionName MyExtension -CommandName New-Extension -ScriptBlock {
    [ValidateScript({return $true})]
    param()
    "Hello World"
}
```

---
### Parameters
#### **ExtensionName**

The name of the extension



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **ScriptBlock**

> **Type**: ```[ScriptBlock]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **CommandName**

One or more commands being extended.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionModule**

The extension module.  If provided, this will have to prefix the ExtensionNameRegex



> **Type**: ```[String]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionParameter**

A collection of Extension Parameters.
The key is the name of the parameter.  The value is any parameter type or attributes.



> **Type**: ```[IDictionary]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionParameterHelp**

A collection of Extension Parameter Help.



> **Type**: ```[IDictionary]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionCommandType**

The type of the extension command.  By default, this is a script.



Valid Values:

* Script
* Function
* Filter



> **Type**: ```[String]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionSynopsis**

The synopsis used for the extension.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 8

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionLink**

Any help links for the extension.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 9

> **PipelineInput**:true (ByPropertyName)



---
#### **ExtensionExample**

> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 10

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
New-Extension [[-ExtensionName] <String>] [[-ScriptBlock] <ScriptBlock>] [[-CommandName] <String[]>] [[-ExtensionModule] <String>] [[-ExtensionParameter] <IDictionary>] [[-ExtensionParameterHelp] <IDictionary>] [[-ExtensionCommandType] <String>] [[-ExtensionSynopsis] <String>] [[-ExtensionLink] <String[]>] [[-ExtensionExample] <String[]>] [<CommonParameters>]
```
---
### Notes
At this time, New-Extension assumes that it is not generating an indented script.
