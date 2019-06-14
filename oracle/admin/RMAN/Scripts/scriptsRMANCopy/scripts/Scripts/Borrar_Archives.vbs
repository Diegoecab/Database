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