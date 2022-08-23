[![Codemagic build status](https://api.codemagic.io/apps/622baf8cde572f4898e607ba/622baf8cde572f4898e607b9/status_badge.svg)](https://codemagic.io/apps/622baf8cde572f4898e607ba/622baf8cde572f4898e607b9/latest_build)
# Links & Info

- [Milestones](https://github.com/gskinnerTeam/flutter-wonders-app/milestones?direction=asc&sort=due_date&state=open)
- [Project Boards](https://github.com/orgs/gskinnerTeam/projects/4/views/4)
  - [Issues for QA](https://github.com/orgs/gskinnerTeam/projects/4/views/6)
- [Google Drive Folder](https://drive.google.com/drive/folders/1tKwqBFGll87pK-iXon0AwpW36oRDCYAt)
  - [Wonders Data Folder](https://drive.google.com/drive/folders/1U2Z1axcJh8v65fUiXmJEDJKAdtK1R4WA) 
    - [Chichen Itza](https://docs.google.com/document/d/1_YDWlRiAFz-8kPvHJo2X5UyNi6jk5YGlBBwe2v5KcN4/edit)
- [Figma Wireframes](https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframe)
- [Time Tracker](https://timetracker.gskinner.com/#c=CD164420-AFD3-4BD6-B60D-BDEB28253846&p=82826D2A-E5E5-4D56-B689-B9DBF169A2D0&t=EAB922B4-2402-49CC-9666-D3FA76A2C33A)
  - [ Tempo Time Tracker](https://gskinner.atlassian.net/plugins/servlet/ac/io.tempo.jira/tempo-app#!)

# QA Builds
To access QA builds, send your Apple Id or Google Play email to Jess who will make sure it gets added.
- iOS, use TestFlight:
  - https://apps.apple.com/us/app/testflight/id899247664
- Android, download from play store
  - https://play.google.com/apps/testing/com.gskinner.flutter.wonders

If you can not see the build in TestFlight or GooglePlay, your email address is likely not registered. Ask Jess to check with the developers.

# Dev Info

### Build and Deploy
Continuous deployment is handled by CodeMagic using the apps@gskinner.com account. 
- To trigger a build, create a git tag starting with "v" and push to master
  - Successful builds will be automatically be deployed to TestFlight and Googe Play internal track.
  - Failed builds will send a slack msg to `#google-flutter4-2022-dev` channel

### Helper Scripts
There are various python scripts in the `/py` folder. Including:
- `builder.py` - Generates toJson and copyWith
- `icon-builder.py` - Generate icons from /assets/marketing/icon.xxx

### App Styling
Styles can be access using the '$styles' variable which is a global instance.
