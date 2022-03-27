﻿Write-FormatView -TypeName Extension -Property DisplayName, Synopsis, Extends, Parameters -VirtualProperty @{        
    Parameters = {        
        @(foreach ($kv in ([Management.Automation.CommandMetaData]$_).Parameters.GetEnumerator()) {
            @(
            . $setOutputStyle -ForegroundColor Verbose 
            "[$($kv.Value.ParameterType)]"
            . $clearOutputStyle
            . $setOutputStyle -ForegroundColor Warning
            "`$$($kv.Key)"
            . $clearOutputStyle
            ) -join ''
        }) -join [Environment]::NewLine
    }    
    Extends = {
        $_.Extends.Keys -join [Environment]::NewLine
    }
} -Wrap -ColorProperty @{
    "DisplayName" = {"Success"}
}
