' Define the path to the executable and all its arguments
' Note: Double quotes are used to escape quotes within the string.
' "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" is needed for spaces.
' --app="https://www.messenger.com/" is needed for the argument.

strCommand = _
    """C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"" --profile-directory=""Profile 4"" --app=""https://www.messenger.com/"""

' Run the command silently (0) and wait for it to complete (True)
' For a browser launch, you might not want to wait, so let's set it to False.
' If set to True, the script will wait until Edge is closed.
' If set to False, the script will exit immediately.

CreateObject("Wscript.Shell").Run strCommand, 0, False