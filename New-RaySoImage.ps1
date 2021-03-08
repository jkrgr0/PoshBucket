
<#PSScriptInfo

.VERSION 1.0.0

.GUID c7dfa8a3-c744-4552-ac97-7b17e51b4922

.AUTHOR Janek Kroeger

.COPYRIGHT MIT License\nCopyright (c) 2021 Janek Kröger

.LICENSEURI https://github.com/Wav3/PoshBucket/blob/main/LICENSE

.PROJECTURI https://github.com/Wav3/PoshBucket

#>

<#
.DESCRIPTION
 Creates a new beautiful image of your code that can be downloaded.
 This script uses https://ray.so.

#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [String]$Code,

    [Parameter()]
    [String]$Title = 'Untitled-1',

    [Parameter()]
    [ValidateSet('candy', 'breeze', 'midnight', 'sunset')]
    [String]$Colors = 'midnight',

    [Parameter()]
    [Bool]$Background = $true,

    [Parameter()]
    [Bool]$DarkMode = $true,

    [Parameter()]
    [ValidateSet(16, 32, 64, 128)]
    [int]$Padding = '64'
)
Begin {
}
Process {
    # Convert code to base 64
    $Encoded = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Code))
    # Urlencode base64 encoded string
    $Encoded = [System.Web.HttpUtility]::UrlEncode($Encoded)

    $Url = "https://ray.so/?colors=$Colors&background=$($Background.ToString().ToLower())&darkMode=$($DarkMode.ToString().ToLower())&padding=$Padding&Title=$Title&code=$Encoded"

    Write-Verbose -Message $Url
    Start-Process $Url
}
End {
}