## Test

### Android
```
cd qcart_sdk_flutter/example
flutter pub get
flutter run
```

#### Test Android Deeplink
```
adb shell am start -a android.intent.action.VIEW -d "qcart://test.abc/path/name?qcart=true%26skus=111,222:3#hashparam=123" app.qcart.qcart_sdk_flutter_example
```