<a href="https://github.com/gskinnerTeam/flutter-wonders-app/actions"><img src="https://github.com/gskinnerTeam/flutter-wonders-app/workflows/integration_tests/badge.svg" alt="Build Status"></a>  <a href="https://github.com/gskinnerTeam/flutter-wonders-app/actions"><img src="https://github.com/gskinnerTeam/flutter-wonders-app/workflows/widget_tests/badge.svg" alt="Build Status"></a>
# Project Links

- [Milestones](https://github.com/gskinnerTeam/flutter-wonders-app/milestones?direction=asc&sort=due_date&state=open)
- [Project Boards](https://github.com/orgs/gskinnerTeam/projects/4/views/4)
  - [Issues for QA](https://github.com/orgs/gskinnerTeam/projects/4/views/6)
- [Google Drive Folder](https://drive.google.com/drive/folders/1tKwqBFGll87pK-iXon0AwpW36oRDCYAt)
  - [Wonders Data Folder](https://drive.google.com/drive/folders/1U2Z1axcJh8v65fUiXmJEDJKAdtK1R4WA) 
    - [Chichen Itza](https://docs.google.com/document/d/1_YDWlRiAFz-8kPvHJo2X5UyNi6jk5YGlBBwe2v5KcN4/edit)
- [Figma Project](https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframe)
  - [Artifacts](https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframe?node-id=785%3A7621)
  - [Timeline](https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframe?node-id=785%3A6853)
- [Time Tracker](https://timetracker.gskinner.com/#c=CD164420-AFD3-4BD6-B60D-BDEB28253846&p=82826D2A-E5E5-4D56-B689-B9DBF169A2D0&t=EAB922B4-2402-49CC-9666-D3FA76A2C33A)

# QA Builds
To access QA builds, send your Apple Id or Google Play email to Jess who will make sure it gets added.
- iOS, use TestFlight:
  - https://apps.apple.com/us/app/testflight/id899247664
- Android, download from play store
  - https://play.google.com/apps/testing/com.gskinner.flutter.wonders

If you can not access the builds, your id is likely not registered. Ask Jess to check with the developers.

# Dev Info

### Build and Deploy
Continuous deployment is handled by CodeMagic using the apps@gskinner.com account. 
- To trigger a build, create a git tag starting with "v" and push
  - Successful builds will be automatically be deployed to TestFlight and Googe Play internal track.
  - Failed builds will send a slack msg to `#google-flutter4-2022-dev` channel // TODO

### Helper Scripts
There are various python scripts in the `/py` folder. Including:
- `builder.py` - Generates toJson and copyWith
- `icon-builder.py` - Generate icons from /assets/marketing/icon.xxx

### App Styling
Use context extensions for styling. 
- `context.style` - Provides access to all style categories
- `context.colors`
- `context.insets`
- `context.textStyles`
- `context.times`

Eg:
```dart
// Colors
backgroundColor: context.colors.bg,
// Times
duration: context.times.fast
// TextStyles
style: context.textStyles.body
// etc...
```

Note: `context.style` is only safe to use from within build() methods, as it calls `context.watch` internally. Use `context.read<AppStyle>()` if you need to access it outside of build (eg, initState).
