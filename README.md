# Numerus & NumerusKit

  by "Armando DiCianno <armando@dicianno.org>"

 * NumerusKit is written in Objective-C.
 * Numerus is written in Swift.

## ChangeLog

### v1.1

 * Updated sample app to Swift 3
 * Actually added version control to project

### v1.0.1

 * Removed SnapKit dependency.
 * Turned off autocorrect on textfields.

### v1.0

 * Initial version.

## Loading / opening the workspace

 * `$PROJECT` represents the directory created when the source code is unpacked.
 * Open a shell:
   ```console
   $ cd $PROJECT/
   $ open Numerus.xcworkspace
   ```
   -or-
   Double-click 'Numerus.xcworkspace'

## Running the app

 * Select a device or simulator from the selection drop-down in Xcode, and make sure 'Numerus' is the active target.
 * Cmd-R will run the app.

## Running tests

 * Select a device or simulator from the selection drop-down in Xcode, and make sure 'NumerusKit' is the active target.
 * Cmd-U will run the tests.

## Caveats

 * Numerus should run on iOS 9.0 - 10.2.
 * NumerusKit should run on iOS 8.1+.
 * You will need to set a valid Team / signing certificate, if you want to run on a hardware device.
 * NumerusKit has a number of unit tests to validate Roman numerals and to test conversion to and from integers to Roman numerals.
