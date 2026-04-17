## HOW TO TEST THE PLUGIN:

- Go to github actions -> build_ios -> Run workflow
- Download App-Ejemplo-iOS
- Login on appetize.io
- Upload the App-Ejemplo-iOS.zip
- Change something in the url and press enter
- Look if works

## INSTRUCTIONS TO UPGRADE THE PLUGIN:

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