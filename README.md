# SecureAudioPlayer

A cross-platform application with macOS experience. Designed with your privacy in mind, this app utilizes advanced AES encryption and decryption algorithms to provide a secure and enjoyable listening experience. The Secured Audio Player not only delivers high-quality audio playback, but also ensures that your audio files remain protected from unauthorized access, offering you peace of mind as you enjoy your favorite tunes. With its user-friendly interface and robust security features, the Secured Audio Player is the ultimate solution for audiophiles seeking both convenience and privacy in their audio player of choice.

## Features

- AES encryption and decryption for enhanced security
- High-quality audio playback
- User-friendly interface
- Protection against unauthorized access
- Support for mp3 and wmv audio format.

## Requirement

- macOS 11.00 or Later
- Flutter SDK version 3.7.9
- Python 3

## Getting Started

1. Get the Flutter SDK version `3.7.9`

1.1. **Important**: If you’re installing on an Apple Silicon Mac, you must have the Rosetta translation environment available for some ancillary tools. You can install this manually by running:
`sudo softwareupdate --install-rosetta --agree-to-license`

1.2 Download the Flutter SDK via this Google Drive link:
<https://drive.google.com/file/d/1iIADnBkqUdA_kZdeHNzabSSra6CvpgtF/view?usp=sharing>

1.3 You will get the zip file. Extract that file and you will get folder called `flutter`

1.4 Move this `flutter` folder to project directory (SecuredAudioPlayer)

&nbsp;&nbsp;1.4.1 To verify you moved `flutter` folder to correct path, open the terminal and `cd` to this project. The current path after running `pwd` should be:
`path/to/project/SecuredAudioPlayer`

&nbsp;&nbsp;1.4.2 Use `ls` command. The result should be: `README.md       client          flutter         server`

&nbsp;&nbsp;1.4.3 Run the following command to verify that flutter sdk is working: 
`flutter/bin/flutter --version`

The result should be:
```
Flutter 3.7.9 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 62bd79521d (3 weeks ago) • 2023-03-30 10:59:36 -0700
Engine • revision ec975089ac
Tools • Dart 2.19.6 • DevTools 2.20.1
```

1.5 Use `cd` to `client` folder:
`cd client`

The current path after running `pwd` should be:
`path/to/project/SecuredAudioPlayer/client`

1.6 Install Flutter dependencies by running this command: 
`../flutter/bin/flutter pub get`

1.7 Check devices connection by running this command:
`../flutter/bin/flutter devices`

macOS (desktop) should be one of the result:
```
../flutter/bin/flutter devices
2 connected devices:

macOS (desktop) • macos  • darwin-arm64   • macOS 13.3 22E252 darwin-arm64
Chrome (web)    • chrome • web-javascript • Google Chrome 112.0.5615.137
```

1.8 Run Flutter Application by running this command:
`../flutter/bin/flutter run --device-id=macOS`

2. Install Python version `3.10.8`

2.1 Download python via this Link
https://www.python.org/ftp/python/3.10.8/python-3.10.8-macos11.pkg

2.2 Open another terminal and `cd` to project directory. 

The current path after running `pwd` should be:
`path/to/project/SecuredAudioPlayer`

Use `ls` command. The result should be: `README.md       client          flutter         server`

2.3 Use `cd` to `server` directory:
`cd server`

The current path after running `pwd` should be:
`path/to/project/SecuredAudioPlayer/server`

2.5 Install virtualenv command by running:
`pip3 install virtualenv`

If you haven't installed `pip3` before, please follow the instruction on this website https://dev.to/stankukucka/how-to-install-pip3-on-mac-2hi4

2.6 Create Virtual Env on current path
`virtualenv .`

After running `ls` on server directory, it will produce this result :
```
__pycache__             bin                     lib                     requirements.txt        test_cryptography.py
app.py                  data                    pyvenv.cfg              test.py                 utils
```

2.7 Activate environtment by running this command:
`source bin/activate`

2.8 Install the requirements by:
`pip3 install -r requirements.txt`


2.9 Run Flask Application by running this command:
`python3 app.py`

3. Enjoy the application!

## Credit and Acknowledgement

We would like to acknowledge the following resources and libraries that were used in the development of this project:

[Flutter](https://flutter.dev): A mobile app development framework used for the frontend of the app.

[Flask](https://flask.palletsprojects.com/en/2.2.x/): A Python framework used for the backend of the app.

[Cyptography](https://pypi.org/project/cryptography/): A package which provides cryptographic recipes and primitives to Python developers.

[macOS UI](https://macosui.dev): A flutter library that provide the native macOS UI element


We would also like to extend our gratitude to the following individuals who contributed to this project:

- [Nipphit Apisitpuwakul]()
- [Atchaya Srimongkolthana]()
- [Sinut Wattanarporn]()

This project would not have been possible without the support and guidance of these resources and individuals. Thank you!