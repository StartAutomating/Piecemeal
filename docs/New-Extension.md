
New-Extension
-------------
### Synopsis
Creates an Extension

---
### Description

Creates an Extension

---
### Related Links
* [](Get-Extension.md)
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

#### EXAMPLE 2
```PowerShell
New-Extension -Command
```

---
### Parameters
#### **ExtensionName**

The name of the extension



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |1      |true (ByPropertyName)|
---
#### **ScriptBlock**

|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[ScriptBlock]```|false   |2      |true (ByPropertyName)|
---
#### **CommandName**

One or more commands being extended.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |3      |true (ByPropertyName)|
---
#### **ExtensionModule**

The extension module.  If provided, this will have to prefix the ExtensionNameRegex



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |4      |true (ByPropertyName)|
---
#### **ExtensionParameter**

A collection of Extension Parameters.   
The key is the name of the parameter.  The value is any parameter type or attributes.



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IDictionary]```|false   |5      |true (ByPropertyName)|
---
#### **ExtensionParameterHelp**

A collection of Extension Parameter Help.



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IDictionary]```|false   |6      |true (ByPropertyName)|
---
#### **ExtensionCommandType**

The type of the extension command.  By default, this is a script.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |7      |true (ByPropertyName)|
---
#### **ExtensionSynopsis**

The synopsis used for the extension.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |8      |true (ByPropertyName)|
---
#### **ExtensionLink**

Any help links for the extension.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |9      |true (ByPropertyName)|
---
#### **ExtensionExample**

|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |10     |true (ByPropertyName)|
---
### Syntax
```PowerShell
New-Extension [[-ExtensionName] <String>] [[-ScriptBlock] <ScriptBlock>] [[-CommandName] <String[]>] [[-ExtensionModule] <String>] [[-ExtensionParameter] <IDictionary>] [[-ExtensionParameterHelp] <IDictionary>] [[-ExtensionCommandType] <String>] [[-ExtensionSynopsis] <String>] [[-ExtensionLink] <String[]>] [[-ExtensionExample] <String[]>] [<CommonParameters>]
```
---
### Notes
At this time, New-Extension assumes that it is not generating an indented script.



