Piecemeal enables Easy Extensible Plugins for PowerShell.

## What is Piecemeal?

Piecemeal is a little PowerShell module that helps solve a big problem: PowerShell extensibility.

Piecemeal allows function and scripts to have extended capabilities and act as extensions for any command.

Piecemeal standardizes these capabilities and provides a simple function you can embed into any module to power an engine of extensibility.

#### Installing Piecemeal

You can embed Piecemeal by using Install-Piecemeal:

```PowerShell
Install-Piecemeal -ExtensionModuleName MyModule -Verb Get -OutputPath .\Get-MyModuleExtension.ps1
```

This will create the source for the command Get-MyModuleExtension.
Get-MyModuleExtension is a modified copy of Get-Extension that returns only extensions related to MyModule.

**NOTE: Your Module does not have to Require or Nest Piecemeal**

#### Extending a Function

Once Piecemeal has been installed into a module, you can allow any command to be extended with two easy optional steps:

1. Add dynamic parameters from extensions

```PowerShell
    # Add this block to any function to make the function extensible (change the name of the extension command as needed)
    dynamicParam {        
        Get-MyModuleExtension -CommandName $MyInvocation.MyCommand -DynamicParameter
    }
```

2. Run the extension


By default, running your extension command will produce an object containing:
* CommandName (the name of the command)
* ExtensionCommand (the extension command)
* ExtensionOutput (the output from the extension)
* Done (indicates if you should stop processing additional extensions)

```PowerShell
    # Add this wherever you would like within the function you're extending.  
    # This will return an object with the output of each extension
    Get-MyModuleExtension -Run -CommandName $MyInvocation.Mycommand 
```

You can also run the extension and -Stream the results
```PowerShell
    # Add this wherever you would like within the function you're extending.  
    # This will return an object with the output of each extension
    Get-MyModuleExtension -Run -Stream -CommandName $MyInvocation.Mycommand -Parameter (@{} + $psBoundParameters)
```

Alternatively, you can determine what -CouldRun:
```PowerShell
    # Add this wherever you would like within the function you're extending.  
    # This will return an object with the output of each extension
    Get-MyModuleExtension -CouldRun -CommandName $MyInvocation.Mycommand -Parameter (@{} + $psBoundParameters)
```

Once you have completed these steps, your command can be extended.  
Extensions can exist within your module or any module that adds your module to it's tags.

### Extension Scripts Structure

Extensions are simple scripts files named with the regular expression ```\.(extension|ext|ex|x)\.ps1$```.

The often include the name of the module that contains the commands that are being extended, for example ```AudioGain.RoughDraft.Extension.ps1```.

They can be automatically discovered in any module that adds the tag "Piecemeal", or can be discovered beneath an extension path.

Extensions should include the following attributes above their parameter block:

~~~PowerShell
# It's an extension (this is optional, unless you use -RequireExtensionAttribute)
[Runtime.CompilerServices.Extension()]
# Next one or more Cmdlet attribute define the command that is being extended.
# (this is also optional, unless you use -RequireCmdletAttribute )
[Management.Automation.Cmdlet("Set","Something")]
# Finally, an extension can indicate how it should be Inherited with the ComponentModel.Inheritance attribute.
# An extension that is 'Inherited' should return control to the main function when it is done.  This is the default
# An extension that is 'NotInherited' should run and return directly.
# An extension that is 'InheritedReadOnly' should only declare parameters
[ComponentModel.Inheritance("Inherited")]
param(
# It's good practice to make at least one parameter of the extension should be mandatory.
[Parameter(Mandatory)]
[switch]
$MyEditExtension
)
~~~
