# App-Payload-Injector


A script used to inject executables into OSX .app files. It's also possible to extract original executable path and by configuring the chosen payload It's possible to make the payload launch the app, allowing for undetected code execution.
<br><br>

Keep in mind that some applications are write restricted and will therefore require escalated privileges for this script to work.
<br>
<br>

#Usage
`AppPayloadInjector.sh "path to app" "path to executable to be injected" "Use custom name for executable to be dropped (optional, but required if $4 will be used. Can however be left blank to generate random name)" "Save original executable name"`

$4 usage is : "ToFile_$FILEPATH", "InjectInPayloadLine_$LINETOINJECT", "InjectInPayloadEnd" or "InjectInPayloadEndNQ".

ToFile is quite simple, will save the original name of executable to a file, where the path to the file is in $FILEPATH.

InjectInPayloadLine will edit the payload and inject it into the line $LINETOINJECT. Note that paths containing space, probably, will fail this unless you modify your payload to handle it.

InjectInPayloadEnd will just add the path to the end of the document without creating a newline, this is good if you are injecting a shell script and want to execute the original executable once your payload has been executed, in this instance set the last line to "exec Apptoinject.app/Contents/MacOS/" and once InjectInPayloadEnd has finished the last line will be "exec Apptoinject.app/Contents/MacOS/$NameOfOriginalExecutable"))

InjectInPayloadEndNQ is the same, but will add a single quote `"` as the last line, useful if path contains space.

<br>
<br>
# Examples
<br><br>
Injecting a shell script.

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh"`
<br><br>
Injecting a shell script and naming payload to "Example".

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh" "Example"`
<br><br>
Injecting a shell script, and saving original executable name in /tmp/path.txt, and using a random generated name".

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh" "" "ToFile_/tmp/path.txt"`
<br><br>
Injecting a shell script, and saving original executable name in /tmp/path.txt, and using the custom name "Name".

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh" "Name" "ToFile_/tmp/path.txt"`
<br><br>
Injecting a shell script and as well the original executable name in specified payload on line 8, and using the custom name "Name".

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh" "Name" "InjectInPayloadLine_8"`
