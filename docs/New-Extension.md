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






|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|false   |1       |true (ByPropertyName)|Name   |



#### **ScriptBlock**




|Type           |Required|Position|PipelineInput        |Aliases                      |
|---------------|--------|--------|---------------------|-----------------------------|
|`[ScriptBlock]`|false   |2       |true (ByPropertyName)|ScriptContents<br/>Definition|



#### **CommandName**

One or more commands being extended.






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |3       |true (ByPropertyName)|



#### **ExtensionModule**

The extension module.  If provided, this will have to prefix the ExtensionNameRegex






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|



#### **ExtensionParameter**

A collection of Extension Parameters.
The key is the name of the parameter.  The value is any parameter type or attributes.






|Type           |Required|Position|PipelineInput        |
|---------------|--------|--------|---------------------|
|`[IDictionary]`|false   |5       |true (ByPropertyName)|



#### **ExtensionParameterHelp**

A collection of Extension Parameter Help.






|Type           |Required|Position|PipelineInput        |
|---------------|--------|--------|---------------------|
|`[IDictionary]`|false   |6       |true (ByPropertyName)|



#### **ExtensionCommandType**

The type of the extension command.  By default, this is a script.



Valid Values:

* Script
* Function
* Filter






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |7       |true (ByPropertyName)|



#### **ExtensionSynopsis**

The synopsis used for the extension.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |8       |true (ByPropertyName)|



#### **ExtensionLink**

Any help links for the extension.






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |9       |true (ByPropertyName)|



#### **ExtensionExample**




|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |10      |true (ByPropertyName)|





---


### Notes
At this time, New-Extension assumes that it is not generating an indented script.



---


### Syntax
```PowerShell
New-Extension [[-ExtensionName] <String>] [[-ScriptBlock] <ScriptBlock>] [[-CommandName] <String[]>] [[-ExtensionModule] <String>] [[-ExtensionParameter] <IDictionary>] [[-ExtensionParameterHelp] <IDictionary>] [[-ExtensionCommandType] <String>] [[-ExtensionSynopsis] <String>] [[-ExtensionLink] <String[]>] [[-ExtensionExample] <String[]>] [<CommonParameters>]
```
