# Numerus & NumerusKit

  by Armando DiCianno

 * NumerusSwift is written in Swift.
 * Numerus is written in Swift.
 * NumerusKit is written in Objective-C. [Final version: 1.3.1 -- see git tag for 1.3.1 to utilize it]

## Roadmap

### 3.0.0

* Remove Foundation completely from NumerusSwift.

## ChangeLog

### v2.0.2

* Added explicit support for macOS 10.11 and up

### v2.0.1

* Added support for building macOS version of NumerusSwift

### v2.0.0

* Created new Swift-only library -- NumerusSwift. NumerusKit is stable, but will no longer be updated.
* Updated example app to only use NumerusSwift.

### v1.3.1

* Updated NumerusKit to iOS 11.0
* Updated sample app to iOS 11.0

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

 * NumerusSwift should run on:
   * 2.0.0: iOS 11+ (Swift 4.2)
 * NumerusKit should run on
   * 1.3.1: iOS 11+
   * 1.2.0: iOS 8.1+.
 * You will need to set a valid Team / signing certificate, if you want to run on a hardware device.
 * Numerus* has a number of unit tests to validate Roman numerals and to test conversion to and from integers to Roman numerals.
