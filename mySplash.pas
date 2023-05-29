unit mySplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  FMX.Ani;

type
  TmySplashForm = class(TForm)
    StartupTimer: TTimer;
    EzerionImage: TImage;
    QulvarImage: TImage;
    spLeftImage: TImage;
    spRightImage: TImage;
    spDownImage: TImage;
    BackGroundRectangle: TRectangle;
    spLeftFloatAnimation: TFloatAnimation;
    spRightFloatAnimation: TFloatAnimation;
    EzerionFloatAnimation: TFloatAnimation;
    QulvarFloatAnimation: TFloatAnimation;
    spDownFloatAnimation: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure StartupTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EzerionFloatAnimationFinish(Sender: TObject);
  private
    procedure LoadMainForm;
    Procedure StartAnimation;
  public
  end;

var
  mySplashForm : TmySplashForm;
  EForm        : TForm;
  CanBeCreate  : Boolean;

implementation
Uses Main;
{$R *.fmx}

procedure TmySplashForm.EzerionFloatAnimationFinish(Sender: TObject);
begin
  //LogoImage.Bitmap.LoadFromFile(EzerionForm.FormatToDevice('splash.png',qtImage, guNone));
  StartupTimer.Interval := 500; // can be changed to improve startup speed in later releases
  StartupTimer.Enabled  := True;
end;

procedure TmySplashForm.FormCreate(Sender: TObject);
begin
  CanBeShow    := False;
  CanbeCreate  := True;
end;

Procedure TmySplashForm.StartAnimation;
Var
  sW, sH, mH  : Double;
Begin
  sW := BackGroundRectangle.Width;
  sH := BackGroundRectangle.Height;

  mH := sH / 36;

  EzerionImage.Height     := mH * 6;
  EzerionImage.Width      := EzerionImage.Height * 650 / 275;
  EzerionImage.Position.X := (sW - EzerionImage.Width) / 2;
  EzerionImage.Position.Y := (sH / 3) + mH;
  EzerionImage.Opacity    := 0;

  QulvarImage.Height      := mH * 3;
  QulvarImage.Width       := QulvarImage.Height * 500 / 167;
  QulvarImage.Position.X  := (sW - QulvarImage.Width) / 2;
  QulvarImage.Position.Y  := (sH / 3) + (mH * 8);
  QulvarImage.Opacity     := 0;

  spLeftImage.Width       := sW * 0.625;
  spLeftImage.Height      := spLeftImage.Width * 202 / 255;
  spLeftImage.Position.X  := 0;
  spLeftFloatAnimation.StartValue  := - spLeftImage.Height;
  spLeftFloatAnimation.StopValue   := 0;

  spRightImage.Width      := sw * 0.35;
  spRightImage.Height     := spRightImage.Width * 230 / 139;
  spRightImage.Position.X := sW - spRightImage.Width;
  spRightFloatAnimation.StartValue  := - spRightImage.Height;
  spRightFloatAnimation.StopValue   := 0;

  spDownImage.Width       := sW;
  spDownImage.Height      := spDownImage.Width * 200 / 343;
  spDownImage.Position.X  := 0;
  spDownFloatAnimation.StartValue  := sH;
  spDownFloatAnimation.StopValue   := sH - spDownImage.Height;

  QulvarFloatAnimation.Enabled  := True;
  EzerionFloatAnimation.Enabled := True;
  spLeftFloatAnimation.Enabled  := True;
  spRightFloatAnimation.Enabled := True;
  spDownFloatAnimation.Enabled  := True;
End;

procedure TmySplashForm.FormShow(Sender: TObject);
begin
  StartAnimation;
  if CanBeCreate then
  Begin
    CanbeCreate := False;
    EForm       := TEzerionForm.Create(Application);
  End;
end;

procedure TmySplashForm.LoadMainForm;
begin
  EForm.Show;
  Application.MainForm := EForm;
  Close;
end;

procedure TmySplashForm.StartupTimerTimer(Sender: TObject);
begin
  StartupTimer.Enabled := false;
  if CanBeShow then
    LoadMainForm
  Else
    StartupTimer.Enabled := true;
end;

end.
