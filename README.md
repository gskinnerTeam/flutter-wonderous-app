[![Codemagic build status](https://api.codemagic.io/apps/62c5bf4e59f5e09fd24b0994/62c5bf4e59f5e09fd24b0993/status_badge.svg)](https://codemagic.io/apps/62c5bf4e59f5e09fd24b0994/62c5bf4e59f5e09fd24b0993/latest_build)
# Wonderous

Navigate the intersection of history, art, and culture. Wonderous will educate and entertain as you uncover information about some of the most famous structures in the world. 

Built by [gskinner](https://gskinner.com/) in partnership with the Flutter team, Wonderous deliberately pushes visual fidelity, effects and transitions to showcase what Flutter is truly capable of on modern mobile hardware.

In addition to forking and reviewing the [MIT licensed](LICENSE) code available here, you can check out more information on the [Wonderous Showcase Website](https://wonderous.app).



# Demo Builds

To try the app you can download it from your favorite app store:
* [Google Play](https://play.google.com/store/apps/details?id=com.gskinner.flutter.wonders)
* [Apple App Store](https://apps.apple.com/us/app/wonderous/id1612491897)

### Installation

If you're new to Flutter the first thing you'll need is to follow the [setup instructions](https://flutter.dev/docs/get-started/install).

Once Flutter is setup, you can use the latest `beta` channel:
 * `flutter channel beta`
 * `flutter upgrade`

 Once you're on `beta` you're ready to run the app:
 * `flutter run -d ios`
 * `flutter run -d android`


### Enable Impeller

For better first-run performance on iOS you can enable "Impeller", which is Flutters new rendering engine. 

To enable, edit the `Info.plist` file and set `FLTEnableImpeller` to `true`:
```
<key>FLTEnableImpeller</key>
<true/>
```

Then, switch to the `master` channel and build as normal:
 * `flutter channel master`
 * `flutter upgrade`
 * `flutter run -d ios`

Note: When Impeller is enabled builds to the Simulator will not work, you will need to test on a physical device instead.

# About gskinner
We exist to build innovative digital experiences for smart clients, and we love how easy Flutter makes that experience. Don't hesitate to [stop by our site](https://gskinner.com/) to learn more about what we do. We'd love to hear from you!

### License

This application is released under the [MIT license](LICENSE). You can use the code for any purpose, including commercial projects.

[![license](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
