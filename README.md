
# react-native-zebra-link-os
Package used for mad-project-please-move
Should work with and without expo.

If you use expo, you need to create a new dev client after installing.

`npm install git+https://github.com/equinor/react-native-zebra-link-os.git#COMMIT_HASH`

For how to use, please look at how please-move uses the package.

note: projects with this package installed _may_ have issues with building to iOS Simulator on macs with Apple Silicon. Consider using Rosetta, or build a dev client to a real device instead.
https://developer.zebra.com/content/link-os-sdk-ios-v151049-doesnt-build-ios-simulator-apple-silicon

### Read before developing
It is important to disable ARC and link the Zebra SDK for this package to work. As of this writing, this is solved in the `.podspec` file with these lines:

```  
# Our package does not use ARC (Automatic Reference Counting), and we need to disable it with the command below
s.requires_arc = false
# Our package is dependent on Zebra's SDK, so we link it with the command below
s.vendored_libraries = "ios/LinkOS/libZSDK_API.a"
```