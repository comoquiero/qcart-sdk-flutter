## Test

### Android
```
cd example
flutter pub get
flutter run
```

#### Test Android Deeplink
```
adb shell am start -a android.intent.action.VIEW -d "qcart://test.abc/path/name?qcart=true%26skus=111,222:3#hashparam=123" app.qcart.qcart_sdk_flutter_example
```

### iOS

#### How to test the iOS plugin:

- Go to github actions -> build_ios -> Run workflow
- Download App-Ejemplo-iOS
- Login on appetize.io
- Upload the App-Ejemplo-iOS.zip
- Change something in the url and press enter
- Look it works

#### Instructions to upgrade the iOS plugin:

```
# 1. Clear Flutter's build cache
flutter clean

# 2. Update the plugin to the latest version
flutter pub upgrade qcart_sdk_flutter
flutter pub get

# 3. Clean up and reinstall native iOS dependencies
cd ios
rm -rf Pods
rm Podfile.lock
pod install --repo-update
```