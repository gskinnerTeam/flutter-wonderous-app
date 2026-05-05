# Wonderous
<p align="center">
<img width="215" src="https://user-images.githubusercontent.com/736973/187334196-b79e48b2-dbb8-4ea7-8aac-04dbc7e5159f.png#gh-dark-mode-only">
<img width="215" src="https://user-images.githubusercontent.com/736973/187334195-9821c031-a566-4f8e-b4e3-3158f733c6e5.png#gh-light-mode-only">
</p>
<p align="center">
 <img width="800" alt="wonderous-banner-800w" src="https://user-images.githubusercontent.com/736973/187334170-d05271e9-d016-4498-8065-662c6f1124fa.png">
</p>

Navigate the intersection of history, art, and culture. Wonderous will educate and entertain as you uncover information about some of the most famous structures in the world. 

Built by [gskinner](https://gskinner.com/) in partnership with the Flutter team, Wonderous deliberately pushes visual fidelity, effects and transitions to showcase what Flutter is truly capable of on modern mobile hardware.

In addition to forking and reviewing the [MIT licensed](LICENSE) code available here, you can check out more information on the [Wonderous Showcase Website](https://wonderous.app).

# App Downloads

To try the app you can download it from your favorite app store:
* [Google Play](https://play.google.com/store/apps/details?id=com.gskinner.flutter.wonders)
* [Apple App Store](https://apps.apple.com/us/app/wonderous/id1612491897)

Or you can try it on the web at https://wonderous.app/web/

# Installation

If you're new to Flutter the first thing you'll need is to follow the [setup instructions](https://flutter.dev/docs/get-started/install).

Once Flutter is setup, you can use the latest `stable` channel:
 * `flutter channel stable`
 * `flutter upgrade`

 Once on `stable` you're ready to run the app on your local device or simulator:
 * `flutter run -d ios`
 * `flutter run -d android`

### WASM

[Wonderous](https://wonderous.app/web/) is deployed using the Web Assembly target for Flutter Web (WASM). To test WASM locally you can use the command `flutter run -d chrome --wasm`.
### Impeller Rendering

This app uses the new [Impeller Runtime](https://docs.flutter.dev/perf/impeller) by default on iOS.

# About gskinner
We build innovative digital experiences for smart clients, and we love how Flutter unleashes our creativity when building multi-platform apps. Don't hesitate to [stop by our site](https://gskinner.com/) to learn more about what we do, or check out other [innovative Flutter projects](https://flutter.gskinner.com) we've built. We'd love to hear from you!

# License

This application is released under the [MIT license](LICENSE). You can use the code for any purpose, including commercial projects.

[![license](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Private Build

During each monthly maintenance round, it would be ideal to get out a new build with the updates done.

1: Update the version number in pubspec.yaml before pushing, and tag the release in github with the same version number.
2: In github, check out flutter-wonderous-app-private in github app. Set branch and pull latest from "private-builds".
4: Checkout private-build branch - should come from the flutter-wonderous-app-private repo.
3: In Repository > Repo Settings, set the remote repo to flutter-wonderous-app.
5: Run a fetch call. The branch status will now say "publish". Don't do this.
5: Merge in the latest from main.
  - To rebase, go into Branch > Rebase and select main. It will apply its 114 commits on top of origin/main, which will involve a lot of merge errors.
6: In Repository > Repo Settings, switch back to flutter-wonderous-app-private.
7: Run another fetch call, and then you should be able to push the changes to the latest build on the private repo.

# Android Build

Locally make a build from the private-builds branch via `flutter build appbundle` to upload to Play Store. The resulting appbundle file can be directly uploaded to the Play Store account.

# iOS Build

In XCode, open the ios/Runner.xcworkspace file after `flutter pub get`. Then make an archive build to upload to Test Flight. You will need to do this again to create a build for deployment too.