## Overview


## Development Setup
The general steps for writing our first Android app using Flutter are:

1. Install Flutter framework (aka Software Development Kit aka SDK). [Click here](https://flutter.io/get-started/install/)

2. Install Microsoft Visual Studio Code (aka VSC) - this is our code editor that we use to edit, compile, and debug our code. [Click here](https://code.visualstudio.com/download)

3. Install Android Studio - we install this because we need to run our Android emulator which will let us run a "virtual" Android phone on our machine to preview what we will eventually upload to an actual phone. Note that Android Studio can also be used as a code editor. [Click here](https://developer.android.com/studio/index.html)

4. Install Flutter add-ons to VSC - we need to customize VSC so it recognizes the Dart language as well as Flutter-specific syntax. Find instructions for that [here](https://flutter.io/get-started/editor/#vscode)

5. After installing the necessary software, run this ["Hello World" program](https://flutter.io/get-started/codelab/), then check out this quick [video](https://www.youtube.com/watch?v=0gA6o6YWheo) to run our first Flutter App in the emulator.

6. Finally, here is [instructions](https://developer.android.com/studio/run/device.html) on how to upload our app to our Android device (free, no Google play account necessary). 

Note that steps for setting up iOS development is similar but requires downloading XCode. You can find those
instructions [here](https://flutter.io/setup-macos/#ios-setup)

The commands to run are:
```
flutter upgrade
flutter channel beta
flutter run
```



#### Loading the data


#### Listing the words feature

#### Random words feature

#### Timed words feature


## Known issues

## Troubleshooting hints
Since Flutter is still not v1.0, you might encounter
version incompability errors because new features could 
break compatibility.

This repo uses the `beta` channel which is the "stable" branch of the Flutter framework
and is recommended by Google.

If you get errors with package versions incompatibility, try
running `flutter doctor` to see if you are using the right
version of Flutter. Also, you can try clearing the cache
right before you upgrade to a new Flutter version.
```
# run diagnostics in verbose mode if necessary
flutter doctor -v

# clear cache
rm -rf bin/cache

# switch to the right channel and upgrade
flutter channel beta
flutter upgrade

# run with verbose mode if necessary
flutter run -v
```
More documentation about upgrading here: https://flutter.io/upgrading/

### Building a release version
```
flutter run --release
```
