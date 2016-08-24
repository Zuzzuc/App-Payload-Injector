# App-Payload-Injector


A script that will inject any chosen payload to be executed on app start.
<br><br>

Keep in mind that some applications are write restricted and will therefore require escalated privileges for this script to work.
<br>
<br>

Usage: AppPayloadInjector.sh "path to app" "path to executable to be injected" "Rename executable to be dropped (optional, but required if $4 will be used. Can however be left blank to generate random name)" "Save original executable path"

$4 usage is : "ToFile_$FILEPATH", "InjectInPayloadLine_$LINETOINJECT", "InjectInPayloadEnd".

ToFile is quite simple, will save the original name of executable to a file, where the path to the file is in $FILEPATH.

InjectInPayloadLine will edit the payload and inject it into the line $LINETOINJECT, overwriting everything else on that line. 

InjectInPayloadEnd will just add the path to the end of the document, good if you are using a shell script and want to execute the original once your payload has been executed, in this instance set the last line to "exec Apptoinject.app/Contents/MacOS/" and once InjectInPayloadEnd has finished the last line will be "exec Apptoinject.app/Contents/MacOS/$PathToOriginal))"

<br>
<br>
# Examples
<br><br>
Examples: Simply injecting a shell script.

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh"`

Examples: Simply injecting a shell script and naming payload to "Example".

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh" "Example"`

Examples: Injecting a shell script, and saving original executable name in /tmp/path.txt, and using a random generated name".

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh" "" "ToFile_/tmp/path.txt"`

Examples: Injecting a shell script, and saving original executable name in /tmp/path.txt, and using the custom name "Name".

`AppPayloadInjector.sh "/Applications/App.app" "~/Desktop/Shell.sh" "Name" "ToFile_/tmp/path.txt"`
