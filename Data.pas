unit Data;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni;

type
  TDataForm = class(TDataModule)
    GameConnection: TUniConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataForm: TDataForm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
