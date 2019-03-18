# MarvelApp
[![Build Status](https://travis-ci.org/homerooliveira/MarvelApp.svg?branch=dev)](https://travis-ci.org/homerooliveira/MarvelApp)![](https://img.shields.io/badge/coverage-55.2%25-green.svg)

 As the main challenge was to create a fully working app in a short period of time, I decided to use the MVVM architecture to keep the view controllers concise and to make the testing easier. Also, the coordinator pattern was used to control the flow of the application.
 
## Screenshots
![alt text](https://github.com/homerooliveira/MarvelApp/raw/dev/list.png "List of Characters") ![alt text](https://github.com/homerooliveira/MarvelApp/raw/dev/detail.png "Detail of Character")
## Installation

Using the terminal, go to the project folder where there is the Podfile and execute the command bellow.
``` sh
pod install
```
## Third-party libraries
- SwiftCrypto. Used to created a hash using md5 needed for API request.
- Kingfisher. Used to download and cache images.

## To Do
- [ ] Add iOSSnapshotTestCase to avoid regression.
- [ ] Add CircleCI to automate the development process.
- [x] Add SwiftLint to enforce code style and conventions.
- [x] Add coordinator to manage the flow.
- [x] Add Kingfisher to download and cache images.

## Requirements
- iOS 12.1 or greater
- Xcode 10.1 or greater
- Swift 4.2 or greater 
- CocoaPods 1.5.3 or greater
