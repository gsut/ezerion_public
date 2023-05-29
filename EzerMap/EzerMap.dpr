program EzerMap;

uses
  Vcl.Forms,
  MainMap in 'MainMap.pas' {MainMapForm},
  myconst in 'myconst.pas',
  MyUtils in 'MyUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Ezerion Map Creator';
  Application.CreateForm(TMainMapForm, MainMapForm);
  Application.Run;
end.
