x-platform-example
==================

Example of cross-platform BDD with Cucumber and Calabash


Getting Started
===============

The example uses the open source WordPress apps for iOS and Android. Since the Android app is licensed as GPL, we do not distribute the app with this project.

You can download the apps by doing the following. 

First ensure subversion is installed by typing `svn --version` in a command prompt.

# Download and Build: Android

Ensure you ant and have Android API 13 installed.  To install API 13:

    $ANDROID_HOME/tools/android #now install android-13

Ensure you have Calabash Android installed in version 0.4.4.

Download and build

    mkdir -p android-source
    cd android-source
    svn co http://android.svn.wordpress.org/tags/2.2.7/

You should now have a directory: `2.2.7` containing the source code for Android.

Finally build the `.apk` file

    cd 2.7.7
    ant debug

This should produce a file `bin/Dashboard-debug.apk`.


# Download and Build: iOS

Ensure you have XCode (4.5+) and XCode Command Line tools installed.

Ensure you have Calabash iOS version 0.9.144 installed.

From the root directory containing `android-source`,

    mkdir -p ios-source
    cd ios-source
    svn co http://iphone.svn.wordpress.org/tags/3.3.1/

Setup Calabash iOS

    cd 3.3.1
    calabash-ios setup

Just select the default target (WordPress).

Run this xcode incantation to build:

    xcodebuild build -workspace WordPress.xcworkspace -scheme WordPress-cal -configuration Debug -sdk iphonesimulator6.1 DEPLOYMENT_LOCATION=YES DSTROOT=build TARGETED_DEVICE_FAMILY=1 

If it complains about a missing WordPress-cal scheme then just create it from XCode and make sure you select the target: `WordPress-cal`.


# Running the tests
Plug in an Android phone (or for the patient, start an Android emulator).
Run the login feature on Android phone:

    calabash-android run android-source/2.2.7/bin/Dashboard-debug.apk -p android features/login.feature

Now run the login feature on iPhone:

    cucumber -p ios features/login.feature
    
Hopefully that works out well :)

