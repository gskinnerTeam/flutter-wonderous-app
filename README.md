<a href="https://github.com/gskinnerTeam/flutter-wonders-app/actions"><img src="https://github.com/gskinnerTeam/flutter-wonders-app/workflows/integration_tests/badge.svg" alt="Build Status"></a><a href="https://github.com/gskinnerTeam/flutter-wonders-app/actions"><img src="https://github.com/gskinnerTeam/flutter-wonders-app/workflows/widget_tests/badge.svg" alt="Build Status"></a>
# Project Links

- [Milestones](https://github.com/gskinnerTeam/flutter-wonders-app/milestones?direction=asc&sort=due_date&state=open)
- [Project Boards](https://github.com/orgs/gskinnerTeam/projects/4/views/4)
  - [Issues for QA](https://github.com/orgs/gskinnerTeam/projects/4/views/6)
- [Figma Project](https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframe)
  - [Artifacts](https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframe?node-id=785%3A7621)
  - [Timeline](https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframe?node-id=785%3A6853)
- [Time Tracker](https://timetracker.gskinner.com/#c=CD164420-AFD3-4BD6-B60D-BDEB28253846&p=82826D2A-E5E5-4D56-B689-B9DBF169A2D0&t=EAB922B4-2402-49CC-9666-D3FA76A2C33A)

# Wonder Editor
To run the editor as a developer:
- `flutter run -r lib/editor.dart`

[ TODO: Add macOs binary for designers to use ]

# Dev Info
- `py\builder.py` - Generates toJson and copyWith
- `py\icon-builder.py` - Generate icons from /assets/marketing/icon.xxx

# App Styling
There is an `AppStyle` instance, which can be access with `context.style`. eg:
```
// Colors
backgroundColor: context.colors.bg,
// Times
duration: context.times.fast
// TextStyles
style: context.textStyles.body
// etc...
```

Note: `context.style` is only safe to use from within build() methods, as it calls `context.watch` internally.
Use `context.read<AppStyle>()` if you need to access it outside of build (eg, initState).

### Build and Deploy Instructions
[ TODO - Add fastlane build instructions ]
