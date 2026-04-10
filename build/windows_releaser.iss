#define MyAppId "{{AB5A1A66-8DA2-4A93-9F7C-202B2A40F88F}}"
#define MyAppName "ToyMania"
#define MyAppVersion "5.1"
#define MyAppPublisher "tsatria03"
#define MyAppURL "https://tsatria03.github.io/projects/games/ToyMania"
#define MyAppExeName "tm.exe"

[Setup]
AppId={#MyAppId}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppPublisher}\{#MyAppName}\tm
DefaultGroupName={#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
UninstallDisplayName={#MyAppName} {#MyAppVersion}
AppMutex={#MyAppName}_Mutex
OutputDir=.
OutputBaseFilename=ToyMania_windows_installer_password_is_GreatCollector
Password=GreatCollector
Encryption=yes
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional icons:"
Name: "startmenuicon"; Description: "Create a Start Menu shortcut"; GroupDescription: "Additional icons:"

[Files]
Source: "C:\Users\tonys\OneDrive\Documents\GitHub\ToyMania\releases\windows\ToyMania_windows_portable_password_is_GreatCollector\tm\*"; \
  DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: startmenuicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; \
  Flags: nowait postinstall skipifsilent unchecked;
