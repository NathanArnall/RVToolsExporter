# RVToolsExporter
Powershell script to generate RVTools excel export with customizable options. Intended to be used alongside another excel document.

To make it task scheduler/script ready, make sure all variables are set and all paths and permissions are correct.

# Requried Variables | Type ("example"):

RvToolsFilePath | File Path String ("C:\Program Files (x86)\Dell\RVTools\RVTools.exe")

ExportDir | Folder Path String ("C:\RVToolsExport")

ExportName | String (filename.xlsx)

ESXiUsername | String ("root")

ESXiServer | Hostname / IP Address of ESXi or vSphere ("192.168.1.1")

GenerateEncPWD | Boolean ($true, $false)

EncPWD | Encrypted Password String ("_RVToolsV3PWD0000000000000000000000000000") (if GenerateEncPWD is false)
