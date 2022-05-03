
Get-Extension
-------------
### Synopsis
Gets Extensions

---
### Description

Gets Extensions.

Extensions can be found in:

* Any module that includes -ExtensionModuleName in it's tags.
* The directory specified in -ExtensionPath

---
### Examples
#### EXAMPLE 1
```PowerShell
Get-Extension
```

---
### Parameters
#### **ExtensionPath**

If provided, will look beneath a specific path for extensions.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |1      |true (ByPropertyName)|
---
#### **Force**

If set, will clear caches of extensions, forcing a refresh.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **CommandName**

If provided, will get extensions that extend a given command



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |2      |true (ByPropertyName)|
---
#### **ExtensionPattern**

The regular expression used to determine if a script is an extension.
By default, '(extension|ext|ex|x)\.ps1$'



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |3      |true (ByPropertyName)|
---
#### **ExtensionName**

The name of an extension



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |4      |true (ByPropertyName)|
---
#### **Like**

If provided, will treat -ExtensionName as a wildcard.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **Match**

If provided, will treat -ExtensionName as a regular expression.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **ExtensionModule**

The extension module.  If provided, this will have to prefix the ExtensionNameRegex



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |5      |true (ByPropertyName)|
---
#### **ExtensionModuleAlias**

A list of extension module aliases.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |6      |true (ByPropertyName)|
---
#### **ExtensionTypeName**

The extension type name.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |7      |true (ByPropertyName)|
---
#### **DynamicParameter**

If set, will return the dynamic parameters object of all the extensions for a given command.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **CouldRun**

If set, will return if the extension could run.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **CouldPipe**

If set, will return if the extension could accept this input from the pipeline.



|Type            |Requried|Postion|PipelineInput|
|----------------|--------|-------|-------------|
|```[PSObject]```|false   |8      |false        |
---
#### **Run**

If set, will run the extension.  If -Stream is passed, results will be directly returned.
By default, extension results are wrapped in a return object.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **Stream**

If set, will stream output from running the extension.
By default, extension results are wrapped in a return object.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **DynamicParameterSetName**

If set, will return the dynamic parameters of all extensions for a given command, using the provided DynamicParameterSetName.
Implies -DynamicParameter.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |9      |true (ByPropertyName)|
---
#### **DynamicParameterPositionOffset**

If provided, will return the dynamic parameters of all extensions for a given command, with all positional parameters offset.
Implies -DynamicParameter.



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |10     |true (ByPropertyName)|
---
#### **NoMandatoryDynamicParameter**

If set, will return the dynamic parameters of all extensions for a given command, with all mandatory parameters marked as optional.
Implies -DynamicParameter.  Does not actually prevent the parameter from being Mandatory on the Extension.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **RequireExtensionAttribute**

If set, will require a [Runtime.CompilerServices.Extension()] attribute to be considered an extension.



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
#### **ValidateInput**

If set, will validate this input against [ValidateScript], [ValidatePattern], [ValidateSet], and [ValidateRange] attributes found on an extension.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[PSObject]```|false   |11     |true (ByPropertyName)|
---
#### **AllValid**

If set, will validate this input against all [ValidateScript], [ValidatePattern], [ValidateSet], and [ValidateRange] attributes found on an extension.
By default, if any validation attribute returned true, the extension is considered validated.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **ParameterSetName**

The name of the parameter set.  This is used by -CouldRun and -Run to enforce a single specific parameter set.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |12     |true (ByPropertyName)|
---
#### **Parameter**

The parameters to the extension.  Only used when determining if the extension -CouldRun.



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IDictionary]```|false   |13     |true (ByPropertyName)|
---
#### **SteppablePipeline**

If set, will output a steppable pipeline for the extension.
Steppable pipelines allow you to control how begin, process, and end are executed in an extension.
This allows for the execution of more than one extension at a time.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **Help**

If set, will output the help for the extensions



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **ParameterHelp**

If set, will get help about one or more parameters of an extension



|Type            |Requried|Postion|PipelineInput|
|----------------|--------|-------|-------------|
|```[String[]]```|false   |14     |false        |
---
#### **Example**

If set, will get help examples



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **FullHelp**

If set, will output the full help for the extensions



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
### Outputs
Extension


---
### Syntax
```PowerShell
Get-Extension [[-ExtensionPath] <String>] [-Force] [[-CommandName] <String[]>] [[-ExtensionPattern] <String>] [[-ExtensionName] <String[]>] [-Like] [-Match] [[-ExtensionModule] <String>] [[-ExtensionModuleAlias] <String[]>] [[-ExtensionTypeName] <String>] [-DynamicParameter] [-CouldRun] [[-CouldPipe] <PSObject>] [-Run] [-Stream] [[-DynamicParameterSetName] <String>] [[-DynamicParameterPositionOffset] <Int32>] [-NoMandatoryDynamicParameter] [-RequireExtensionAttribute] [-RequireCmdletAttribute] [[-ValidateInput] <PSObject>] [-AllValid] [[-ParameterSetName] <String>] [[-Parameter] <IDictionary>] [-SteppablePipeline] [-Help] [[-ParameterHelp] <String[]>] [-Example] [-FullHelp] [<CommonParameters>]
```
---


