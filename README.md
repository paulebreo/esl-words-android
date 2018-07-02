
## Development Setup

## Overview 

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
