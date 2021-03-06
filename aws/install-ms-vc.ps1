#########################################################################################
#
# Install MS VC++.
#
#########################################################################################
Function InstallVcRedist() {
    # Install VcRedist https://docs.stealthpuppy.com/docs/vcredist
    Install-Module -Name VcRedist -Force
    Import-Module -Name VcRedist -Force

    # Get and install VC++ 2013 Redistributable package (x86 and x64)
    New-Item $env:TEMP\VcRedist -ItemType Directory -Force

    $VcList = Get-VcList -Release 2013 -Architecture x86
    $VcList | Save-VcRedist -ForceWebRequest -Path $env:TEMP\VcRedist
    Install-VcRedist -Silent -Path $env:TEMP\VcRedist -VcList $VcList

    $VcList = Get-VcList -Release 2013 -Architecture x64
    $VcList | Save-VcRedist -ForceWebRequest -Path $env:TEMP\VcRedist
    Install-VcRedist -Silent -Path $env:TEMP\VcRedist -VcList $VcList

    # verify installed VC++
    Write-Host "Installed VC++ Distributions: "
    Get-InstalledVcRedist | Select Name, Version, ProductCode

}

InstallVcRedist

