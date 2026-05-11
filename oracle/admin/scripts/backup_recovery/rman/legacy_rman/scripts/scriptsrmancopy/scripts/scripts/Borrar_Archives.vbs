' ------------------------------------------------------------------------------
' File       : Borrar_Archives.vbs
' Purpose    : Oracle RMAN backup, restore or recovery helper: Borrar Archives.
' Category   : backup_recovery/rman
' Author     : Diego Cabrera
' Created    : Unknown
' Version    : 1.0
' Usage      : Borrar_Archives.vbs
' Parameters : Review script arguments and environment variables before running.
' Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
' Oracle Ver.: Review compatibility before production use.
' Risk       : REVIEW
' Output     : Shell/command output and any script-defined log files.
' Notes      : Validate in a non-production session before operational use.
' Source     : internal
' Change Log : 
' 2026-05-11 : Diego Cabrera - Header normalization.
' ------------------------------------------------------------------------------
'
Option Explicit
on error resume next
 Dim oFSOLog
 Dim oFSOProc
 Dim sDirectoryPathLog
 Dim sDirectoryPathProc
 Dim oFolderlog
 Dim ofolderProc
 Dim oFileCollectionlog
 Dim oFileCollectionProc
 Dim oFile
 Dim iDaysOld

 

'Variables

 iDaysOld = 10
 Set oFSOLog = CreateObject("Scripting.FileSystemObject")
 sDirectoryPathLog = "C:\CM\ARCHIVES"
 set oFolderLog = oFSOLog.GetFolder(sDirectoryPathLog)
 set oFileCollectionLog = oFolderLog.Files

'Eliminar archivos

 For each oFile in oFileCollectionLog
  If oFile.DateLastModified < (Date() - iDaysOld) Then
   oFile.Delete(True)
  End If
 Next

 Set oFSOLog = Nothing
 Set oFSOProc = Nothing
 Set oFolderLog = Nothing
 Set oFolderProc = Nothing
 Set oFileCollectionLog = Nothing
 Set oFileCollectionProc = Nothing
 Set oFile = Nothing