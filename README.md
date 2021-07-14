# word_frequency

An app to count word frequency on a string

## Specs

Flutter (Channel stable, 2.2.1, on macOS 11.4 20F71 darwin-x64, locale en-GB)  
Framework • revision 02c026b03c (7 weeks ago) • 2021-05-27 12:24:44 -0700  
Engine • revision 0fdb562ac8  
Tools • Dart 2.13.1  

Android Studio 4.1.1  
Build #AI-201.8743.12.41.6953283, built on November 5, 2020  
Runtime version: 1.8.0_242-release-1644-b3-6915495 x86_64  
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o  
macOS 10.16  

## Compatibility

This projecty compiles correctly on :  
-Android (minSdkVersion 16)  
-iOs (ios, '9.0')  
-Web (Chrome Version 91.0.4472.114 (Official Build) (x86_64))    
-Web (FireFox Version 89.0 (64-bit))    
-Web (Edge v 91.0.864.67)  
-MacOs (BigSur 11.4 (20F71))    
-Windows 10  

## Models

The word_freq_interface.dart and word_freq_analyzer_interface.dart files reproduce exactly the  
interfaces described in the assignment.

The word_freq file is the normal implementation that extends Equatable.

The word_freq_analyzer file is the implementation of the algorithm.
While creating instances of this class, we can insert a fakeWaitDurationInMilliseconds,  
to check the correct ui response while loading the analysis.  
If we don't provide a value for it, the analyzer will not wait (and the loading will be so fast that  
it's impossible to verify the correct UI behavior. Try it with 2000 ms to see it in action)  

The cachedResults map stores in memory the analysis already made, so to avoid duplicate executions  
on the same text.  

The analyze method returns a sorted list of WordFrequencyInterface compliant items to be used in
 other methods.  
  
## Blocs
  
3 different Blocs are used for the 3 features.  
The blocs help to have a separation between UI and Business Logic, and they also optimize the 
rebuilds, because the BlocBuilders only rebuild the interested part.  
The states are, in all 3 cases:    
- initial (nothing happened yet)  
- loading (waiting for analyzer)  
- finished (the result may be displayed)  

The query events are added to the bloc when the user executes an action.  
(if the bloc is busy loading, the action is not received).    
The reset events are added when the text field is modified.  

## UI

The only screen is the home_page  
Here a single textField is used as input, and 3 Buttons are used to execute actions.  
The wordFrequency and the mostFrequentNWords actions will show a dialog requesting the additional  
information (respectively, the word to search, and N).  
The dialogs are described in separate classes, in this way the controllers for their fields can be    
disposed when the dialog is disposed.  
The N dialog doesn't accept non-numeric values or values less than 1.  

3 different BlocBuilders give a result after execution of the actions depending on state:    
- if initial, just an empty container  
- if loading, show some info on the query and a progressIndicator  
- if finished, show the result  

The wf_theme class contains the theme for the application.  

## Tests  

run the unit_test tests with command:  
>flutter test  

# Integration tests on Web  

Ensure chromedriver is running:
>chromedriver --port=4444  

then run:  
>flutter drive --driver=test_driver/integration_driver.dart --target=integration_test/app_test.dart -d web-server


# Integration tests on Mobile  
Connect device (real or emulator) before starting.  

Run in terminal:  
>flutter test integration_test/app_test.dart  

note: some slow Android emulators may fail. Use a higher value for  
fakeWaitDurationInMilliseconds to make it succeed.  
