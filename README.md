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

# Installation

If you're new to Flutter the first thing you'll need is to follow the [setup instructions](https://flutter.dev/docs/get-started/install).

Once Flutter is setup, you can use the latest `beta` channel:
 * `flutter channel beta`
 * `flutter upgrade`

 Once on `beta` you're ready to run the app on your local device or simulator:
 * `flutter run -d ios`
 * `flutter run -d android`

### Impeller Rendering Layer

Impeller is Flutter's next-generation rendering layer, that takes full advantage of modern hardware-accelerated graphics APIs. It is currently available as an **early adopter preview**, but is not yet feature-complete or fully optimized.

The version of Wonderous available in the iOS app store uses Impeller, but by default this code base does not. If you'd like to enable Impeller for iOS, follow these steps:

Edit the `Info.plist` file and set `FLTEnableImpeller` to `true`:
```
<key>FLTEnableImpeller</key>
<true/>
```

Then, switch to the `master` channel and build as normal:
 * `flutter channel master`
 * `flutter upgrade`
 * `flutter run -d ios`

**Note:** Currently, when Impeller is enabled testing in Simulator will not work, you will need to test on a physical device.

# About gskinner
We build innovative digital experiences for smart clients, and we love how Flutter unleashes our creativity when building multi-platform apps. Don't hesitate to [stop by our site](https://gskinner.com/) to learn more about what we do, or check out other [innovative Flutter projects](https://flutter.gskinner.com) we've built. We'd love to hear from you!

# License

This application is released under the [MIT license](LICENSE). You can use the code for any purpose, including commercial projects.

[![license](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
