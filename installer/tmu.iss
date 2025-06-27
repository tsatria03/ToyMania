#define MyAppName "ToyMania"
#define MyAppVersion "4.0"
#define MyAppPublisher "tsatria03"
#define MyAppURL "https://tsatria03.itch.io/toymania"
#define MyAppExeName "tm.exe"
#define MyReadme "readme.txt"

[Setup]
AppId={{64477427-9EAA-4A52-905B-269D21D008DA}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
OutputDir=.
OutputBaseFilename=ToyMania_windows_installer
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional icons:"
Name: "startmenuicon"; Description: "Create a Start Menu shortcut"; GroupDescription: "Additional icons:"

[Files]
Source: "C:\Users\tsatr\OneDrive\Documents\GitHub\ToyMania\releases\windows\ToyMania_windows_portable_password_is_GreatCollector\tm\*"; \
  DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Users\tsatr\OneDrive\Documents\GitHub\ToyMania\releases\windows\ToyMania_windows_portable_password_is_GreatCollector\tm\docks\readme.txt"; \
  DestDir: "{app}"; Flags: ignoreversion
Source: "audio/logo.wav"; DestDir: "{tmp}"; Flags: dontcopy
Source: "audio/directory.wav"; DestDir: "{tmp}"; Flags: dontcopy
Source: "audio/startmenu.wav"; DestDir: "{tmp}"; Flags: dontcopy
Source: "audio/icons.wav"; DestDir: "{tmp}"; Flags: dontcopy
Source: "audio/ready.wav"; DestDir: "{tmp}"; Flags: dontcopy
Source: "audio/installing.wav"; DestDir: "{tmp}"; Flags: dontcopy
Source: "audio/finished.wav"; DestDir: "{tmp}"; Flags: dontcopy

[Icons]
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: startmenuicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; \
  Flags: nowait postinstall skipifsilent unchecked
Filename: "{app}\{#MyReadme}"; Description: "View ReadMe file"; \
  Flags: postinstall shellexec skipifsilent unchecked

[Code]
const
  SND_ASYNC = $0001;

var
  IsInitialPage: Boolean;

procedure PlaySound(FileName: String; Module: Longint; Flags: Integer);
external 'PlaySoundW@winmm.dll stdcall';

procedure StopSound();
begin
  PlaySound('', 0, 0);
end;

procedure InitializeWizard();
begin
  IsInitialPage := True;
  ExtractTemporaryFile('logo.wav');
  ExtractTemporaryFile('directory.wav');
  ExtractTemporaryFile('startmenu.wav');
  ExtractTemporaryFile('icons.wav');
  ExtractTemporaryFile('ready.wav');
  ExtractTemporaryFile('installing.wav');
  ExtractTemporaryFile('finished.wav');
  // Play logo.wav synchronously to delay UI
  PlaySound(ExpandConstant('{tmp}\logo.wav'), 0, 0);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if IsInitialPage then
  begin
    IsInitialPage := False;
    Exit;
  end;
  StopSound();
  case CurPageID of
    wpSelectDir:
      PlaySound(ExpandConstant('{tmp}\directory.wav'), 0, SND_ASYNC);
    wpSelectProgramGroup:
      PlaySound(ExpandConstant('{tmp}\startmenu.wav'), 0, SND_ASYNC);
    wpSelectTasks:
      PlaySound(ExpandConstant('{tmp}\icons.wav'), 0, SND_ASYNC);
    wpReady:
      PlaySound(ExpandConstant('{tmp}\ready.wav'), 0, SND_ASYNC);
    wpInstalling:
      PlaySound(ExpandConstant('{tmp}\installing.wav'), 0, SND_ASYNC);
    wpFinished:
      PlaySound(ExpandConstant('{tmp}\finished.wav'), 0, SND_ASYNC);
  end;
end;
