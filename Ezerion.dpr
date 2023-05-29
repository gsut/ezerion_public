program Ezerion;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {EzerionForm},
  mySplash in 'mySplash.pas' {mySplashForm},
  {$IFDEF ANDROID}
  JVE.AdMob in '..\..\comp\JVEsuite\JVE.AdMob.pas',
  JVE.Analytics in '..\..\comp\JVEsuite\JVE.Analytics.pas',
  JVE.AppStore in '..\..\comp\JVEsuite\JVE.AppStore.pas',
  JVE.Banners in '..\..\comp\JVEsuite\JVE.Banners.pas',
  JVE.Configuration in '..\..\comp\JVEsuite\JVE.Configuration.pas',
  JVE.Interstitials in '..\..\comp\JVEsuite\JVE.Interstitials.pas',
  JVE.Utils in '..\..\comp\JVEsuite\JVE.Utils.pas',
  JVE.OpenURL in '..\..\comp\JVEsuite\JVE.OpenURL.pas',
  JVE.Actions in '..\..\comp\JVEsuite\JVE.Actions.pas',
  JVE.Messaging in '..\..\comp\JVEsuite\JVE.Messaging.pas',
  JVE.Analytics.Common in '..\..\comp\JVEsuite\JVE.Analytics.Common.pas',
  JVE.Browser in '..\..\comp\JVEsuite\JVE.Browser.pas',
  JVE.Layout in '..\..\comp\JVEsuite\JVE.Layout.pas',
  {$ENDIF}
  Data in 'Data.pas' {DataForm: TDataModule};

{$R *.res}

begin
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.Initialize;
  Application.CreateForm(TDataForm, DataForm);
  Application.CreateForm(TmySplashForm, mySplashForm);
  Application.Run;
end.


