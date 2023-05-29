Unit Main;
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Objects, FMX.Controls.Presentation, FMX.Ani,
  Data.DB, UniProvider, SQLiteUniProvider, DBAccess, Uni, MemDS, System.IOUtils,
  FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.Media, FMX.ListBox, FMX.Advertising,
  {$IFDEF ANDROID}
    Androidapi.JNI.Os,
    Androidapi.JNI.GraphicsContentViewText,
    Androidapi.Helpers,
    Androidapi.JNIBridge,
    Androidapi.JNI.Analytics,
    FMX.Platform.Android,
  {$ENDIF}
  {$IFDEF IOS}
    IOSapi.MediaPlayer,
    IOSapi.CoreGraphics,
    FMX.Platform.IOS,
    IOSapi.UIKit,
    Macapi.ObjCRuntime,
    Macapi.ObjectiveC,
    iOSapi.Cocoatypes,
    Macapi.CoreFoundation,
    iOSapi.Foundation,
    iOSapi.CoreImage,
    iOSapi.QuartzCore,
    iOSapi.CoreData,
    JVE.Utils,
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    Windows,
  {$ENDIF}
  FMX.Platform, FMX.WebBrowser, FMX.Colors, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.Net.URLClient, System.Actions,
  FMX.ActnList, JVE.AdMob, JVE.Banners, JVE.Analytics.Common,
  JVE.Analytics, JVE.AppStore;

const
  //Log Types
  EZ_LOGIN           = 1;
  EZ_ADD_LIVE        = 2;
  EZ_CLOSE           = 3;

  MaxX               = 13;
  MaxY               = 18;

  MaxSimulatorTry    = 50;

  LastLevel          = 120;
type
  SoundType  = (stNone, stBlink, stBomb, stBigBomb, stFail, stLevelEnd, stBreak, stTeleport);
  QFType     = (qtNone, qtImage, qtDB, qbText, qtMP3);
  Universes  = (guNone, guWater, guRock, guFire, guSpace);
  ResultType = (scWin, scLose);
  ExitType   = (etButton, etBack, etProgram);

  PlayType  = Record
                X             : Integer;
                Y             : Integer;
                Score         : Integer;
              End;
  cPlayType = Array[1..MaxSimulatorTry] of PlayType;
  GameType  = Record
                UserId        : Integer;
                ActiveLevel   : Integer;
                MaxLevel      : Integer;
                Sound         : Boolean;
                SoundVolume   : Single;
                Music         : Boolean;
                MusicVolume   : Single;
                Lang          : String[10];
                Score         : Integer;
                Vibration     : Boolean;
                EMail         : String;
                UserName      : String;
                Password      : String;
                AutoLogin     : Boolean;
                ServerLogin   : Boolean;
                ColorSet      : Integer;
                Login         : Boolean;
                CompState     : Integer;
                LevelPage     : Integer;
                UserCount     : Integer;
                GameLife      : Integer;
                Universe      : Universes;
                Flag          : String[40];
                Gender        : Char;
                BirthYear     : Integer;
              End;
  FrameType = Record
                FType    : Byte;
                Value    : Byte;
                cCode    : Char;
                MaxValue : Byte;
              End;
  LevelType = Record
                pScore    : Integer;
                MatrixX   : Integer;
                MatrixY   : Integer;
                BackI     : String[100];
                Frame     : Array[1..MaxX,1..MaxY] of FrameType;
                MaxPlayer : Integer;
              End;

  QueueType = Record
                OldFrame    : FrameType;
                NewFrame    : FrameType;
                X           : Integer;
                Y           : Integer;
                Player      : Integer;
                Sound       : SoundType;
                WinLose     : Integer;
              End;

  ZLevelType    = Record
                    P1MoveX    : Integer;
                    P1MoveY    : Integer;
                    P2MoveX    : Integer;
                    P2MoveY    : Integer;
                    TrMessage  : String[250];
                    EnMessage  : String[250];
                  End;
  NLType        = Record
                    Id           : Integer;
                    Matrix_X     : Integer;
                    Matrix_Y     : Integer;
                    Matrix_Value : String;
                    Player_Count : Integer;
                  End;
  ZeroLevelType = Array [1..10] of ZLevelType;
  AnimeQueueType  = Array[1..500] of QueueType;

  TEzerionForm = class(TForm)
    GameTabControl: TTabControl;
    StartTabItem: TTabItem;
    GameTabItem: TTabItem;
    SettingsTabItem: TTabItem;
    LanguageTabItem: TTabItem;
    GestureManager1: TGestureManager;
    SQLiteUniProvider: TSQLiteUniProvider;
    SettingBackGroundImage: TImage;
    SettingMusicImage: TImage;
    SettingLangImage: TImage;
    SettingBackImage: TImage;
    LangEnImage: TImage;
    LangTrImage: TImage;
    LangBackgroundImage: TImage;
    LevelTabItem: TTabItem;
    s1Image: TImage;
    StartBackgroundImage: TImage;
    PlayerTimer: TTimer;
    LevelBackgroundImage: TImage;
    UpArrowImage: TImage;
    DownArrowImage: TImage;
    AnimeTimer: TTimer;
    MusicTimer: TTimer;
    SoundTabItem: TTabItem;
    SoundBackgroundImage: TImage;
    SoundSoundImage: TImage;
    SoundSoundVolumeImage: TImage;
    SoundMusicVolumeImage: TImage;
    SoundBackImage: TImage;
    SoundMusicImage: TImage;
    OnTabChangeAnimation: TFloatAnimation;
    GameBackgroundImage: TImage;
    WebTabItem: TTabItem;
    GameWebBrowser: TWebBrowser;
    SoundTrackBar: TAlphaTrackBar;
    MusicTrackBar: TAlphaTrackBar;
    GExitImage: TImage;
    GSettingImage: TImage;
    Heart1Image: TImage;
    Heart2Image: TImage;
    Heart3Image: TImage;
    LangImage: TImage;
    WinLoseTabItem: TTabItem;
    WinLoseImage: TImage;
    p1Image: TImage;
    p2Image: TImage;
    p3Image: TImage;
    p4Image: TImage;
    p5Image: TImage;
    p6Image: TImage;
    p1Text: TText;
    p2Text: TText;
    p3Text: TText;
    p4Text: TText;
    p5Text: TText;
    p6Text: TText;
    SoundTitleImage: TImage;
    GestureManager2: TGestureManager;
    ActionList1: TActionList;
    YukariKaydir: TAction;
    AsagiKaydir: TAction;
    LExitImage: TImage;
    fl1Image: TImage;
    fl2Image: TImage;
    fl3Image: TImage;
    fl4Image: TImage;
    fl5Image: TImage;
    fl6Image: TImage;
    UserNameTabItem: TTabItem;
    UserNameBackgroundImage: TImage;
    UserNameMenuImage: TImage;
    UserNameOkImage: TImage;
    UserNameEdit: TEdit;
    CountryComboBox: TComboBox;
    sUserInfoImage: TImage;
    UsernameText: TText;
    sUFlagImage: TImage;
    sm1Image: TImage;
    sm2Image: TImage;
    sm3Image: TImage;
    sm4Image: TImage;
    WinLoseTimer: TTimer;
    s1HeightFloatAnimation: TFloatAnimation;
    s1WidthFloatAnimation: TFloatAnimation;
    s1XFloatAnimation: TFloatAnimation;
    s1YFloatAnimation: TFloatAnimation;
    SSettingImage: TImage;
    InfoImage: TImage;
    AvatarImage: TImage;
    AvatarXFloatAnimation: TFloatAnimation;
    AvatarYFloatAnimation: TFloatAnimation;
    L1Image: TImage;
    L2Image: TImage;
    ADSTabItem: TTabItem;
    ADSBackgroundImage: TImage;
    ADSMessageImage: TImage;
    AdsViewImage: TImage;
    ADSMenuImage: TImage;
    EzerionRewardAd: TJVEAdMobInterstitial;
    HandImage: TImage;
    ZeroXFloatAnimation: TFloatAnimation;
    ZeroYFloatAnimation: TFloatAnimation;
    ZeroTimer: TTimer;
    MessageImage: TImage;
    MessageText: TText;
    sHImage: TImage;
    sXImage: TImage;
    sLImage: TImage;
    sS2Image: TImage;
    sS1Image: TImage;
    score1Image: TImage;
    score2Image: TImage;
    score3Image: TImage;
    score4Image: TImage;
    score5Image: TImage;
    score6Image: TImage;
    score7Image: TImage;
    score8Image: TImage;
    score9Image: TImage;
    SettingUserImage: TImage;
    SettingVibrationImage: TImage;
    EzerionAd: TJVEAdMobInterstitial;
    EzerionAnalytics: TJVEAnalytics;
    BackRectangle: TRectangle;
    WebBackImage: TImage;
    AnimationEndTimer: TTimer;
    EzerionAdMob: TJVEAdMob;
    MusicMediaPlayer: TMediaPlayer;
    MapListImage: TImage;
    GenderComboBox: TComboBox;
    BirthYearComboBox: TComboBox;
    SavedLevelTabItem: TTabItem;
    SavedLevelBackgroundImage: TImage;
    SavedLevelMenuImage: TImage;
    SavedLevelYesImage: TImage;
    SavedLevelNoImage: TImage;
    EzerionAppRater: TJVEAppRater;
    sS3Image: TImage;
    L3Image: TImage;
    HelpImage: TImage;
    PauseImage: TImage;
    PauseTabItem: TTabItem;
    PauseBackgroundImage: TImage;
    PauseMenuImage: TImage;
    PauseMainMenuImage: TImage;
    PauseContinueImage: TImage;
    sUserFlagImage: TImage;
    LangBackImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure SettingImageClick(Sender: TObject);
    procedure SettingBackImageClick(Sender: TObject);
    procedure SettingMusicImageClick(Sender: TObject);
    procedure LangBackImageClick(Sender: TObject);
    procedure SettingLangImageClick(Sender: TObject);
    procedure ScoreBackImageClick(Sender: TObject);
    procedure s4ImageClick(Sender: TObject);
    procedure PlayerTimerTimer(Sender: TObject);
    procedure ExitImageClick(Sender: TObject);
    procedure UpArrowImageClick(Sender: TObject);
    procedure DownArrowImageClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LangTrImageClick(Sender: TObject);
    procedure LangEnImageClick(Sender: TObject);
    procedure AnimeTimerTimer(Sender: TObject);
    procedure MusicTimerTimer(Sender: TObject);
    procedure SoundBackImageClick(Sender: TObject);
    procedure SoundTrackBarChange(Sender: TObject);
    procedure MusicTrackBarChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure OnTabChangeAnimationFinish(Sender: TObject);
    procedure GameTabControlChange(Sender: TObject);
    procedure p1ImageClick(Sender: TObject);
    procedure WinLoseImageClick(Sender: TObject);
    procedure YukariKaydirExecute(Sender: TObject);
    procedure AsagiKaydirExecute(Sender: TObject);
    procedure UserNameOkImageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sm1ImageClick(Sender: TObject);
    procedure sm2ImageClick(Sender: TObject);
    procedure sm3ImageClick(Sender: TObject);
    procedure sm4ImageClick(Sender: TObject);
    procedure WinLoseTimerTimer(Sender: TObject);
    procedure s1ImageClick(Sender: TObject);
    procedure InfoImageClick(Sender: TObject);
    procedure AvatarXFloatAnimationFinish(Sender: TObject);
    procedure ADSMenuImageClick(Sender: TObject);
    procedure AdsViewImageClick(Sender: TObject);
    procedure EzerionRewardAdAdClosed;
    procedure EzerionRewardAdNoAd(Sender: TJVEAdMobInterstitial; Error: string);
    procedure EzerionRewardAdReward(Sender: TJVEAdMobInterstitial; Kind: string;
      Amount: Double);
    procedure ZeroTimerTimer(Sender: TObject);
    procedure SettingUserImageClick(Sender: TObject);
    procedure SettingVibrationImageClick(Sender: TObject);
    procedure WebBackImageClick(Sender: TObject);
    procedure AnimationEndTimerTimer(Sender: TObject);
    procedure MapListImageClick(Sender: TObject);
    procedure SavedLevelYesImageClick(Sender: TObject);
    procedure SavedLevelNoImageClick(Sender: TObject);
    procedure HelpImageClick(Sender: TObject);
    procedure PauseContinueImageClick(Sender: TObject);
    procedure PauseMainMenuImageClick(Sender: TObject);
    procedure PauseImageClick(Sender: TObject);
  private
   pC              : Array[1..6] of Char;
   LevelEnd        : Boolean;
   Turn            : Integer;
   sComp,
   iComp           : TStrings;
   Level           : LevelType;
   Game            : GameType;
   LastTabStatus   : Integer;
   CPlay           : cPlayType;
   Winner          : Integer;
   AnimeQueue      : AnimeQueueType;
   AnimeMax,
   AnimeRun        : Integer;
   AnimeInProgress : Boolean;
   InClick         : Boolean;
   AppCanClose     : Boolean;
   AnimatedLevel   : Boolean;
   ZeroLevel       : ZeroLevelType;
   ZeroMove        : Integer;
   OldPoint        : String;
   AdsLevel        : Integer;
   FMusicName      : String;
   MoveCount       : Integer;

    { Private declarations }

    //General Procedures
    Procedure TextMatrixToArrayMatrix(TextMatrix:String;MaxPlayer:Integer);
    Function  ArrayMatrixToTextMatrix:String;
    Function  CheckCurrentLang:String;
    procedure ExitFromScreen(EType:ExitType);
    procedure SavedLevelPlay(SLId:Integer);

    //Level Select Procedures
    procedure PlayLevel(Lv:Integer;IsSavedLavel:Boolean);
    procedure onSelectLevelClick(Sender: TObject);
    Procedure CreateSelectLevelArea(ScreenWidth, ScreenHeight:Integer);
    Procedure CreateSelectLevelSquare(Lv:Integer;Sender:TFmxObject);
    procedure FreeAndNilLevelSelect;
    Procedure LevelScreenView;
    Function  GetLevelPage(Lv:Integer):Integer;

    //Zero Level Procedure
    Function  GetZeroHandPosX(dX, dY:Integer):Single;
    Function  GetZeroHandPosY(dX, dY:Integer):Single;
    procedure onZeroFrameClick(Sender: TObject);
    Procedure FillZeroArray;

    //Level Procedures
    Procedure CalculateMaxValue;
    Procedure CalculateFrameMaxValue(X,Y:Integer);
    Procedure CreateLevelSquare(Frame:FrameType; cW, cL, cT:Integer;cN:String;Sender:TFmxObject);
    Procedure CreateLevelArea(ScreenWidth, ScreenHeight:Integer);
    procedure onFrameClick(Sender: TObject);
    procedure PushTheFrame(X, Y, P:Integer;pC:Char);
    Procedure AddAnimeQueue(OldFrame, NewFrame:FrameType; X, Y, P, WL : Integer;Sound:SoundType);
    Function  InQueue(X,Y,P:Integer):Boolean;
    Procedure ReImageFrame(OldFrame, NewFrame:FrameType; X, Y : Integer;Sound:SoundType);
    Procedure ExplodeFrame(X, Y : Integer; Sound:SoundType);
    Procedure IncPlayerPoint(P, Point:Integer);
    procedure FreeAndNilLevel;
    Procedure SaveWinnerLevel;
    Procedure ComputerPlay(P:Integer);
    Procedure PlayMusic(FName:String;MC:Integer);
    Procedure StopMusic;
    Procedure PlaySound(sType:SoundType);
    Procedure SetTurn;
    Procedure GoToNextPlayer;
    Function  PlayerLive(P:Integer):Boolean;
    Procedure ShowLevelResult(Res:ResultType);
    Procedure SetPlayerBoard;
    procedure FrameFloatAnimationFinish(Sender: TObject);
    Procedure WriteScore(Score:Integer);
    procedure SaveLevelData;
    Procedure SaveScore;
    Function  LoadScore:Integer;
    Procedure AddNewLevel;

    //DB procedures
    Function  ConnectDB(DBName:String):Boolean;
    Procedure DisconnectDB;
    Function  LoadUserGameInfo:Boolean;
    Function  SaveUserGameInfo:Boolean;
    Function  GetLevelInfo:Boolean;
    Procedure GetRandomName(Var Name, Nation, Flag:String);
    Function  IsLevelExists(Lv:Integer):Boolean;
    Procedure WriteLog(LogType:Integer);
    Procedure CheckGameLife;
    Procedure FillComboBox;
    Function  GetFlagFromCountry(Country:String):String;
    Function  GetCountryFromFlag(Flag:String):String;
    Procedure CheckVersion;
    Function  GetVersion:String;
    Procedure SetVersion(Version:String);
    Function  GetSavedLevelMatrix:String;
    Function  GetSavedLevelId:Integer;
    Procedure ClearSavedLevel;

    // Set Screen Procedures
    Procedure SetScreenLang;
    procedure SetSettingScreen;
    procedure SetSettingScreenLang;
    procedure SetLanguageScreen;
    procedure SetLanguageScreenLang;
    procedure SetStartScreen;
    procedure SetStartScreenLang;
    procedure SetSoundScreen;
    procedure SetSoundScreenLang;
    procedure SetUserNameScreen;
    procedure SetUserNameScreenLang;
    procedure SetWebScreen;
    procedure SetWebScreenLang;
    procedure SetADSScreen;
    procedure SetADSScreenLang;
    procedure SetSavedLevelScreen;
    procedure SetSavedLevelScreenLang;
    procedure SetPauseScreen;
    procedure SetPauseScreenLang;
    procedure SetGameScreen(bT:Integer);
    Procedure ShowStartScreen;

    Procedure SetWebBowser(OUrl:String);
    Function  GetWinner:Integer;
    Procedure ShowWinLose;
    procedure Vibration(VTime:Integer);
    Procedure FillAgeGender;

    Procedure PlayMusicMp3(Mp3:String;Duration:Double);
    Procedure PlaySoundMp3(Mp3:String);

    Function  HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject):Boolean;

  public
    { Public declarations }
    Function  FormatToDevice(InStr:String; QFT:QFType; Universe:Universes):String;
  end;

{$IFDEF IOS}
Const
  libAudioToolbox        = '/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox';
  kSystemSoundID_vibrate = $FFF;

  Procedure AudioServicesPlaySystemSound( inSystemSoundID: integer ); Cdecl; External libAudioToolbox Name _PU + 'AudioServicesPlaySystemSound';
{$ENDIF}
var
  EzerionForm : TEzerionForm;
  CanBeShow   : Boolean;

implementation
Uses FMX.VirtualKeyboard, Data;
{$R *.fmx}

{ TAdViewListener }

type
  TPlayThread = class(TThread)
  private
    MPlayer    : TMediaPlayer;
    MDuration  : Double;

  public
    constructor Create(const FileName : String;const Volume, Duration : Double);
    destructor Destroy; override;
  protected
    procedure Execute; override;
  end;

constructor TPlayThread.Create(const FileName : String;const Volume, Duration : Double);
begin
  inherited Create(true);
  FreeOnTerminate  := true;
  MPlayer          := TMediaPlayer.Create(EzerionForm);
  MPlayer.FileName := FileName;
  MPlayer.Volume   := Volume;
  MDuration        := Duration;
  Resume;
end;

destructor TPlayThread.Destroy;
begin
  Sleep(Trunc(MDuration * 1000));
  MPlayer.Free;
  inherited;
end;

procedure TPlayThread.Execute;
begin
  inherited;
  MPlayer.Play;
end;

Procedure TEzerionForm.PlayMusicMp3(Mp3:String;Duration:Double);
Var
  aThread : TPlayThread;
Begin
  aThread := TPlayThread.Create(Mp3, Game.MusicVolume, Duration);
End;

Procedure TEzerionForm.PlaySoundMp3(Mp3:String);
Var
  aThread : TPlayThread;
Begin
  aThread := TPlayThread.Create(Mp3, Game.SoundVolume, 10);
End;

procedure TEzerionForm.Vibration(VTime:Integer);
{$IFDEF ANDROID}
  Var
    Vibrator:JVibrator;
{$ENDIF}
begin
  if Game.Vibration then
  Begin
    {$IFDEF ANDROID}
      Vibrator:=TJVibrator.Wrap((SharedActivityContext.getSystemService(TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectID);
      Vibrator.vibrate(VTime);
    {$ENDIF}
    {$IFDEF IOS}
      AudioServicesPlaySystemSound( kSystemSoundID_vibrate );
    {$ENDIF}
  End;
end;

function conststr(c: char;n: byte): string;
var
 s : string;
begin {conststr}
  setlength(s,n);
  fillchar(s[1],n,c);
  conststr:=s
end; {conststr}

procedure mytruncate(var s: string);
var
 temp   : real;
 kk     : integer;
 num    : boolean;
begin {truncate}
  if (s<>'')and(length(s)<>0) then
  begin
    while (length(s)>=1) and CharInSet(s[1],[#255,#32,#0]) and (s<>'') do
      delete(s,1,1);
    while (length(s)>=1)and CharInSet(s[length(s)], [#255,#32,#0]) and (s<>'') do
      delete(s,length(s),1);
    if (s=conststr('0',length(s))) And (Length(s)>1) then s:='';
    val(s,temp,kk); if kk=0 then num:=true else num:=false;
    if temp=0 then
       while num and (pos('.',s)<>0) and (s[length(s)]='0') and (s<>'') do
             delete(s,length(s),1);
    if (pos('.',s)<>0) and CharInSet(s[1],['-','0'..'9']) then
       while CharInSet(s[length(s)],['.']) do
         delete(s,length(s),1);
    while (pos(#13,s)<>0) and (s<>'') do delete(s,pos(#13,s),1);
  end;
end;  {truncate}

function MyStrToExtended(s:String):Extended;
var
  dumreal:Extended;
  dumint:integer;
begin
  Val(s,dumreal,dumint);
  if dumint=0 then
    result:=dumreal
  else
    result:=0;
end;


function StrToValOlabilir(s:string):boolean;
var
  dumreal:real;
  dumint:integer;
begin
  Val(s,dumreal,dumint);
  result:=((dumint=0)and(dumreal<>0)); {dumreal<>0 gereksiz gibi ancak hata vermesin diye, zatendumreal=0 ise result 0 oluyor}
end;


function MyStrToInt(s:String):Longint;
Var e:Extended;
begin
  result:=0;
  mytruncate(s);
  if StrToValOlabilir(s) then
    if s<>'' then
    begin
      //result:=StrToInt(s)
      e:=MyStrToExtended(s);
      result:=Round(e);
    end;
end;

Procedure TEzerionForm.WriteScore(Score:Integer);
Var
  SStr : String;
  I    : Integer;
Begin
  SStr := IntToStr(Score);
  for I := 1 to 9 - Length(SStr) do
    SStr := '0' + SStr;
  for I := 1 to 9 do
    if (SStr[I] <> OldPoint[I]) then
    Begin
      case I of
        1  : score1Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
        2  : score2Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
        3  : score3Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
        4  : score4Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
        5  : score5Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
        6  : score6Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
        7  : score7Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
        8  : score8Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
        9  : score9Image.Bitmap.LoadFromFile(FormatToDevice('z' + SStr[I] + '.png',qtImage, guNone));
      end;
    End;
  OldPoint := SStr;
End;

Procedure TEzerionForm.ShowLevelResult(Res:ResultType);
Begin
  if GameTabControl.ActiveTab = WinLoseTabItem then
    Exit;
  case Res of
    scWin  : Begin
               SaveWinnerLevel;
               Inc(Game.GameLife);
               PlaySound(stLevelEnd);
               WinLoseImage.Bitmap.LoadFromFile(FormatToDevice('game_win_'+ Game.Lang +'.png',qtImage, Game.Universe));
             End;
    scLose : Begin
               PlaySound(stFail);
               WinLoseImage.Bitmap.LoadFromFile(FormatToDevice('game_lose_'+ Game.Lang +'.png',qtImage, Game.Universe));
             End;
  end;
  ClearSavedLevel;
  GameTabControl.ActiveTab := WinLoseTabItem;
  WinLoseTimer.Enabled     := True;
  if Game.ActiveLevel > 12 then
  Begin
    AdsLevel := 2;
    EzerionAd.Cache;
  End;
End;

Procedure TEzerionForm.ShowWinLose;
Begin
  if LevelEnd then
    Exit;
  LevelEnd := True;
  StopMusic;
  If Winner = 1 then
  Begin
    if Game.CompState < 8 then
    Begin
      Inc(Game.CompState);
      SaveUserGameInfo;
    End;
    ShowLevelResult(scWin);
    EzerionAnalytics.TrackEvent('Game', 'Level', 'Win', Game.ActiveLevel);
  End
  Else
  Begin
    if Game.CompState > 1 then
    Begin
      Dec(Game.CompState);
      SaveUserGameInfo;
    End;
    ShowLevelResult(scLose);
    EzerionAnalytics.TrackEvent('Game', 'Level', 'Lose', Game.ActiveLevel);
  End;
End;

Function TEzerionForm.GetZeroHandPosX(dX, dY:Integer):Single;
Var
  T     : Single;
  cName : String;
  fI    : TImage;
Begin
  Result := 0;
  cName := 'Frame_' + IntToStr(dX) + '_' + IntToStr(dY);
  fI := GameTabItem.FindComponent(cName) As TImage;
  if fI <> Nil then
  Begin
    T := fI.Position.X;
    T := T + (fI.Width / 2) - HandImage.Width;
    Result := T;
  End;
End;

Function TEzerionForm.GetZeroHandPosY(dX, dY:Integer):Single;
Var
  T     : Single;
  cName : String;
  fI    : TImage;
Begin
  Result := 0;
  cName := 'Frame_' + IntToStr(dX) + '_' + IntToStr(dY);
  fI := GameTabItem.FindComponent(cName) As TImage;
  if fI <> Nil then
  Begin
    T := fI.Position.Y;
    T := T + (fI.Height / 2);
    Result := T;
  End;
End;


procedure TEzerionForm.sm1ImageClick(Sender: TObject);
begin
  LastTabStatus := StartTabItem.Index;
  SetWebBowser('https://www.instagram.com/qulvargamestudio');
  GameTabControl.ActiveTab := WebTabItem;
end;

procedure TEzerionForm.sm2ImageClick(Sender: TObject);
begin
  LastTabStatus := StartTabItem.Index;
  SetWebBowser('https://www.twitter.com/qulvargames');
  GameTabControl.ActiveTab := WebTabItem;
end;

procedure TEzerionForm.sm3ImageClick(Sender: TObject);
begin
  LastTabStatus := StartTabItem.Index;
  SetWebBowser('https://www.facebook.com/qulvargamestudio');
  GameTabControl.ActiveTab := WebTabItem;
end;

procedure TEzerionForm.sm4ImageClick(Sender: TObject);
begin
  LastTabStatus := StartTabItem.Index;
  SetWebBowser('https://www.linkedin.com/company/qulvar-game-studio');
  GameTabControl.ActiveTab := WebTabItem;
end;

Function TEzerionForm.GetWinner:Integer;
Var
  I, J, K,
  p1, p2, p3, p4, p5, p6  : Integer;
Begin
  p1 := 0; p2 := 0; p3 := 0; p4 := 0; p5 := 0; p6 := 0; k := 0;
  for I := 1 to Level.MatrixX do
    for J := 1 to Level.MatrixY do
    Begin
      case Level.Frame[I][J].FType of
        2 : Inc(p1);
        3 : Inc(p2);
        4 : Inc(p3);
        5 : Inc(p4);
        6 : Inc(p5);
        7 : Inc(p6);
      end;
    End;
  if p1 > 0 then
    Inc(k);
  if p2 > 0 then
    Inc(k);
  if p3 > 0 then
    Inc(k);
  if p4 > 0 then
    Inc(k);
  if p5 > 0 then
    Inc(k);
  if p6 > 0 then
    Inc(k);
  if p1 < 1 then
  Begin
    Result := 2;
    Exit;
  End;
  if K > 1 then
    Result := 0
  Else
    Result := 1
End;

function TEzerionForm.CheckCurrentLang: String;
{$IFDEF MACOS}
  var
    Languages: NSArray;
  begin
    Languages := TNSLocale.OCClass.preferredLanguages;
    Result := TNSString.Wrap(Languages.objectAtIndex(0)).UTF8String;
{$ENDIF}
{$IFDEF ANDROID}
  var
    LocServ: IFMXLocaleService;
  begin
    if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, IInterface(LocServ)) then
      Result := LocServ.GetCurrentLangID;
{$ENDIF}
{$IFDEF MSWINDOWS}
  var
    buffer: MarshaledString;
    UserLCID: LCID;
    BufLen: Integer;
  begin // defaults
    UserLCID := GetUserDefaultLCID;
    BufLen := GetLocaleInfo(UserLCID, LOCALE_SISO639LANGNAME, nil, 0);
    buffer := StrAlloc(BufLen);
    if GetLocaleInfo(UserLCID, LOCALE_SISO639LANGNAME, buffer, BufLen) <> 0
    then
      Result := buffer
    else
      Result := 'en';
    StrDispose(buffer);
{$ENDIF}
  if Result = 'tu' then
    Result := 'tr';

  if (Result <> 'tr') and (Result <> 'en') then
    Result := 'en'
end; { code }

Procedure TEzerionForm.ComputerPlay(P:Integer);
Var
  cPoint     : Integer;
  simLevel     : LevelType;

  procedure CalculateTheFrame(X, Y, P :Integer;pC:Char);
  Var
    kMax, WL, I      : Integer;
    OldFrame         : FrameType;
    Explode          : Boolean;

    Procedure simPFrame(pX, pY:Integer;CheckQueue:Boolean);
    Begin
      if (pX > 0) And (pY > 0) And (pX <= Level.MatrixX) And (pY <= Level.MatrixY) then
      Begin
        If Level.Frame[pX][pY].FType in [1..9] Then
          CalculateTheFrame(pX,pY, P, pC);
      End;
    End;

  Begin
    Explode  := False;
    OldFrame := simLevel.Frame[X][Y];
    Case simLevel.Frame[X][Y].FType Of
      2,3,4,5,6,7
         : simLevel.Frame[X][Y].Value := simLevel.Frame[X][Y].Value + 1;
      1  : simLevel.Frame[X][Y].Value := 1;
      9  : Begin
             simLevel.Frame[X][Y].FType := 101;  //After bombing
             kMax := simLevel.MatrixX;
             if simLevel.MatrixY > kMax then
               kMax := simLevel.MatrixY;
             Case simLevel.Frame[X][Y].Value of
               1,2,3
                 : Begin
                     // 1 Frame explode
                     simPFrame(X-1,Y-1, False);
                     simPFrame(X  ,Y-1, False);
                     simPFrame(X+1,Y-1, False);
                     simPFrame(X-1,Y  , False);
                     simPFrame(X+1,Y  , False);
                     simPFrame(X-1,Y+1, False);
                     simPFrame(X  ,Y+1, False);
                     simPFrame(X+1,Y+1, False);
                     If simLevel.Frame[X][Y].Value > 1 Then
                     Begin
                       // 2 Frame explode
                       simPFrame(X-2,Y-2, False);
                       simPFrame(X-1,Y-2, False);
                       simPFrame(X  ,Y-2, False);
                       simPFrame(X+1,Y-2, False);
                       simPFrame(X+2,Y-2, False);
                       simPFrame(X-2,Y-1, False);
                       simPFrame(X+2,Y-1, False);
                       simPFrame(X-2,Y  , False);
                       simPFrame(X+2,Y  , False);
                       simPFrame(X-2,Y+1, False);
                       simPFrame(X+2,Y+1, False);
                       simPFrame(X-2,Y+2, False);
                       simPFrame(X-1,Y+2, False);
                       simPFrame(X  ,Y+2, False);
                       simPFrame(X+1,Y+2, False);
                       simPFrame(X+2,Y+2, False);
                     End;
                     If simLevel.Frame[X][Y].Value > 2 Then
                     Begin
                       // 3 Frame explode
                       simPFrame(X-3,Y-3, False);
                       simPFrame(X-2,Y-3, False);
                       simPFrame(X-1,Y-3, False);
                       simPFrame(X  ,Y-3, False);
                       simPFrame(X+1,Y-3, False);
                       simPFrame(X+2,Y-3, False);
                       simPFrame(X+3,Y-3, False);
                       simPFrame(X-3,Y-2, False);
                       simPFrame(X+3,Y-2, False);
                       simPFrame(X-3,Y-1, False);
                       simPFrame(X+3,Y-1, False);
                       simPFrame(X-3,Y  , False);
                       simPFrame(X+3,Y  , False);
                       simPFrame(X-3,Y+1, False);
                       simPFrame(X+3,Y+1, False);
                       simPFrame(X-3,Y+2, False);
                       simPFrame(X+3,Y+2, False);
                       simPFrame(X-3,Y+3, False);
                       simPFrame(X-2,Y+3, False);
                       simPFrame(X-1,Y+3, False);
                       simPFrame(X  ,Y+3, False);
                       simPFrame(X+1,Y+3, False);
                       simPFrame(X+2,Y+3, False);
                       simPFrame(X+3,Y+3, False);
                     End;
                   End;
               4 : Begin
                     for I := 1 to kMax do
                       simPFrame(X-I,Y+I, False);
                   End;
               5 : Begin
                     for I := 1 to kMax do
                       simPFrame(X-I,Y-I, False);
                   End;
               6 : Begin
                     for I := 1 to kMax do
                       simPFrame(X+I,Y-I, False);
                   End;
               7 : Begin
                     for I := 1 to kMax do
                       simPFrame(X+I,Y+I, False);
                   End;
               8 : Begin
                     for I := 1 to kMax do
                       simPFrame(X-I,Y-I, False);
                     for I := 1 to kMax do
                       simPFrame(X+I,Y+I, False);
                   End;
               9 : Begin
                     for I := 1 to kMax do
                       simPFrame(X-I,Y+I, False);
                     for I := 1 to kMax do
                       simPFrame(X+I,Y-I, False);
                   End;
             End;
           End;
    End;
    if simLevel.Frame[X][Y].FType < 100 then
    Begin
      simLevel.Frame[X][Y].FType := P;
      simLevel.Frame[X][Y].cCode := pC;
    End;
    if simLevel.Frame[X][Y].Value > simLevel.Frame[X][Y].MaxValue then
    Begin
      simLevel.Frame[X][Y].Value := 1;
      Explode := True;
    End;
    Inc(cPoint,1);
    if Explode then
    Begin
      Inc(cPoint,3);
      simPFrame(X-1,Y  , True);
      simPFrame(X  ,Y-1, True);
      simPFrame(X+1,Y  , True);
      simPFrame(X  ,Y+1, True);
    End;
    if (OldFrame.FType in [2..8]) and (OldFrame.FType <> P) then
      Inc(cPoint,5);
  End;

  Function GetOptionForCompState(oCount:Integer):Integer;
  Var
    I   : Integer;
    sMax, sMin, sAverage : Integer;
  Begin
    Result := 1;
    case Game.CompState of
      1,2 : Result := Random(oCount - 1) + 1;
      3,4 : Begin
              sMin := CPlay[1].Score;
              for I := 2 to oCount do
                if CPlay[I].Score < sMin then
                  sMin := CPlay[I].Score;
              for I := 1 to oCount do
                if CPlay[I].Score = sMin Then
                Begin
                  Result := I;
                  Exit;
                End;
            End;
      5,6 : Begin
              sAverage := 0;
              for I := 1 to oCount do
                sAverage := sAverage + CPlay[I].Score;
              sAverage := sAverage Div oCount;

              sMin := Abs(CPlay[1].Score - sAverage);
              for I := 2 to oCount do
                if Abs(CPlay[I].Score - sAverage) < sMin then
                  sMin := Abs(CPlay[I].Score - sAverage);
              for I := 1 to oCount do
                if Abs(CPlay[I].Score - sAverage) = sMin Then
                Begin
                  Result := I;
                  Exit;
                End;
            End;
      7,8 : Begin
              sMax := CPlay[1].Score;
              for I := 2 to oCount do
                if CPlay[I].Score > sMax then
                  sMax := CPlay[I].Score;
              for I := 1 to oCount do
                if CPlay[I].Score = sMax Then
                Begin
                  Result := I;
                  Exit;
                End;
            End;
    end;
  End;

Var
  I, J, K,
  sIndex   : Integer;
Begin
  sIndex  := 0;
  P       := P + 1;
  FillChar(cPlay,Sizeof(cPlayType), 0);
  for I := 1 to Level.MatrixX do
  Begin
    for J := 1 to Level.MatrixY do
    Begin
      if Level.Frame[I][J].FType = P then
      Begin
        Inc(sIndex);
        if sIndex <= MaxSimulatorTry then
        Begin
          CPlay[sIndex].X     := I;
          CPlay[sIndex].Y     := J;
          CPlay[sIndex].Score := 0;
        End;
        if sIndex >= MaxSimulatorTry then
          Break;
      End;
    End;
    if sIndex >= MaxSimulatorTry then
      Break;
  End;
  if sIndex = 0 then
    Exit;
  if sIndex > MaxSimulatorTry then
    sIndex := MaxSimulatorTry;

  if Game.ActiveLevel = 0 then
  Begin
    PushTheFrame(ZeroLevel[ZeroMove].P2MoveX , ZeroLevel[ZeroMove].P2MoveY, P, pC[P-1]);
  End
  Else
  Begin
    if sIndex = 1 then
    Begin
      PushTheFrame(CPlay[sIndex].X, CPlay[sIndex].Y, P, pC[P-1]);
    End
    Else
    Begin
      // Play game simulation and select best/avarage/worst option
      for I := 1 to sIndex do
      Begin
        simLevel := Level;
        cPoint   := 0;
        CalculateTheFrame(CPlay[I].X, CPlay[I].Y, P, pC[P]);
        CPlay[I].Score := cPoint;
      End;
      K := GetOptionForCompState(sIndex);
      PushTheFrame(CPlay[K].X, CPlay[K].Y, P, pC[P-1]);
    End;
  End;
End;

Procedure TEzerionForm.StopMusic;
Begin
  MusicTimer.Enabled := False;
End;

Procedure TEzerionForm.PlayMusic(FName:String;MC:Integer);
Var
  Duration : Double;
Begin
  if GameTabControl.ActiveTab <> GameTabItem then
    Exit;
  MusicTimer.Enabled       := False;
  {$IFDEF IOS}
    case MC of
      1  : Duration := 16;
      2  : Duration := 16;
      3  : Duration := 9;
      4  : Duration := 43;
      5  : Duration := 45;
      6  : Duration := 18;
      7  : Duration := 12;
      8  : Duration := 32;
      9  : Duration := 12;
      10 : Duration := 42
      Else Duration := 10;
    end;
    PlayMusicMp3(FName,Duration);
  {$ENDIF}
  {$IFDEF ANDROID}
    MusicMediaPlayer.FileName := FName;
    MusicMediaPlayer.Volume   := Game.MusicVolume;
    Duration                  := MusicMediaPlayer.Duration / MediaTimeScale;
    MusicMediaPlayer.Play;
  {$ENDIF}
  MusicTimer.Interval       := Trunc(Duration * 1000) ;
  MusicTimer.Enabled := True;
End;

Procedure TEzerionForm.SetWebBowser(OUrl:String);
Begin
  GameWebBrowser.URL := OUrl;
End;

Procedure TEzerionForm.PlaySound(sType:SoundType);
Begin
  case sType of
    stBlink    : PlaySoundMp3(FormatToDevice('blink.mp3', qtMP3, guNone));
    stBomb     : PlaySoundMp3(FormatToDevice('bomb.mp3', qtMP3, guNone));
    stBigBomb  : PlaySoundMp3(FormatToDevice('big_bomb.mp3', qtMP3, guNone));
    stFail     : PlaySoundMp3(FormatToDevice('fail.mp3', qtMP3, guNone));
    stLevelEnd : PlaySoundMp3(FormatToDevice('levelend.mp3', qtMP3, guNone));
    stBreak    : PlaySoundMp3(FormatToDevice('break.mp3', qtMP3, guNone));
    stTeleport : PlaySoundMp3(FormatToDevice('teleport.mp3', qtMP3, guNone));
  end;
End;

procedure TEzerionForm.PlayerTimerTimer(Sender: TObject);
begin
  PlayerTimer.Enabled := False;
  if Winner > 0 then
  Begin
    Exit;
  End;
  SetTurn;
  if Turn >= 2 then
  Begin
    if (Not LevelEnd) then
      ComputerPlay(Turn);
  End
  Else
    InClick := False;
end;

procedure TEzerionForm.PauseContinueImageClick(Sender: TObject);
begin
  ClearSavedLevel;
  GameTabControl.ActiveTab := GameTabItem;
end;

procedure TEzerionForm.PauseImageClick(Sender: TObject);
begin
  if Turn = 1 then
  Begin
    SetPauseScreen;
    GameTabControl.ActiveTab := PauseTabItem;
  End;
end;

procedure TEzerionForm.PauseMainMenuImageClick(Sender: TObject);
begin
  ExitFromScreen(etButton);
end;

Function TEzerionForm.PlayerLive(P:Integer):Boolean;
Var
  I, J : Integer;
Begin
  Result := False;
  for I := 1 to Level.MatrixX do
    for J := 1 to Level.MatrixY do
      if Level.Frame[I][J].FType = (P+1) then
      Begin
        Result := True;
        Exit;
      End;

End;

Procedure TEzerionForm.SetTurn;
Var
  PLive : Boolean;
Begin
  case Turn of
    1 : p1Image.Opacity := 0.5;
    2 : p2Image.Opacity := 0.5;
    3 : p3Image.Opacity := 0.5;
    4 : p4Image.Opacity := 0.5;
    5 : p5Image.Opacity := 0.5;
    6 : p6Image.Opacity := 0.5;
  end;
  Repeat
    if Turn >= Level.MaxPlayer then
      Turn := 1
    Else
      Inc(Turn);
    PLive := PlayerLive(Turn);
    if Not PLive then
    Begin
      case Turn of
        1 : p1Image.Opacity := 0;
        2 : p2Image.Opacity := 0;
        3 : p3Image.Opacity := 0;
        4 : p4Image.Opacity := 0;
        5 : p5Image.Opacity := 0;
        6 : p6Image.Opacity := 0;
      end;
    End;
  Until PLive;
  case Turn of
    1 : p1Image.Opacity := 1;
    2 : p2Image.Opacity := 1;
    3 : p3Image.Opacity := 1;
    4 : p4Image.Opacity := 1;
    5 : p5Image.Opacity := 1;
    6 : p6Image.Opacity := 1;
  end;
End;

Function TEzerionForm.FormatToDevice(InStr:String; QFT:QFType; Universe:Universes):String;
Var
  Uni, Path : String;
Begin
  case Universe of
    guNone  : Uni := '';
    guWater : Uni := 'water/';
    guRock  : Uni := 'rock/';
    guFire  : Uni := 'fire/';
    guSpace : Uni := 'space/'
    Else Uni := ''
  end;
  InStr := LowerCase(InStr);
  {$IFDEF MSWINDOWS}
    Path  := GetCurrentDir + PathDelim + 'assets' + PathDelim;
    Path  := 'D:\project\github\Ezerion\Assets\';

    Result := Path + Uni + InStr;
    if Not FileExists(Result) then
    Begin
      if QFT = qtImage then
        Result := Path + 'no_image.png';
    End;
  {$ENDIF}
  {$IFDEF MACOS}
      // Do something...
  {$ENDIF}
  {$IFDEF iOS}
      // For iOS, set the Remote Path to StartUp\Documents
    Path  := TPath.GetDocumentsPath + PathDelim;
    Result := Path + Uni + InStr;
    if QFT = qtMp3 then
      Result := StringReplace(Result,'mp3','caf',[]);
    if Not FileExists(Result) then
    Begin
      if QFT = qtImage then
        Result := Path + 'no_image.png';
    End;
  {$ENDIF}
  {$IFDEF ANDROID}
    Path  := TPath.GetDocumentsPath + PathDelim;
    Result := Path + Uni + InStr;
    if Not FileExists(Result) then
    Begin
      if QFT = qtImage then
        Result := Path + 'no_image.png';
    End;
  {$ENDIF}
End;

Function TEzerionForm.ConnectDB(DBName:String):Boolean;
Begin
  Try
    DataForm.GameConnection.Connected := False;
    DataForm.GameConnection.Database := DBName;
    DataForm.GameConnection.SpecificOptions.Values['Direct']               := 'True';
    DataForm.GameConnection.SpecificOptions.Values['UseUnicode']           := 'True';
    DataForm.GameConnection.Open;
    Result := True;
  Except
    Result := False;
  End;
End;

Procedure TEzerionForm.DisconnectDB;
Begin
  if DataForm.GameConnection.Connected then
    DataForm.GameConnection.Connected := False;
End;

procedure TEzerionForm.FrameFloatAnimationFinish(Sender: TObject);
begin
  (Sender as TFloatAnimation).Enabled := False;
end;


Procedure TEzerionForm.CreateLevelSquare(Frame:FrameType; cW, cL, cT:Integer;cN:String;Sender:TFmxObject);
Var
  gmI         : TImage;
  gmF         : TFloatAnimation;
  gmL         : TBitmapListAnimation;
  Scale       : Single;
Begin
  gmI := TImage.Create(GameTabItem);

  gmI.Position.X := cL;
  gmI.Position.Y := cT;
  gmI.Height     := cW;
  gmI.Width      := cW;
  gmI.WrapMode   := TImageWrapMode.Stretch;

  gmI.Name       := 'Frame_' + cN;
  gmI.Parent     := GameTabItem;
  gmI.Opacity    := 1;


  IComp.Add(gmI.Name);

  case Frame.FType of
    0    : ;
    1    : gmI.Bitmap.LoadFromFile(FormatToDevice('t0.png',qtImage, Game.Universe));
    2,3,4,5,6,7
         : if Frame.Value <> Frame.MaxValue then
             gmI.Bitmap.LoadFromFile(FormatToDevice(Frame.cCode + IntToStr(Frame.Value) + '.png',qtImage, guNone))
           Else
             gmI.Bitmap.LoadFromFile(FormatToDevice(Frame.cCode + IntToStr(Frame.Value) + 'p.png',qtImage, guNone));
    8    : case Frame.Value of
             1 : gmI.Bitmap.LoadFromFile(FormatToDevice('wall_1.png',qtImage, Game.Universe));
             2 : gmI.Bitmap.LoadFromFile(FormatToDevice('wall_2.png',qtImage, Game.Universe));
             3 : gmI.Bitmap.LoadFromFile(FormatToDevice('wall_3.png',qtImage, Game.Universe));
           end;
    9    : Case Frame.Value Of
             1 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomb1.png',qtImage, Game.Universe));
             2 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomb2.png',qtImage, Game.Universe));
             3 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomb3.png',qtImage, Game.Universe));
             4 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomby1.png',qtImage, Game.Universe));
             5 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomby2.png',qtImage, Game.Universe));
             6 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomby3.png',qtImage, Game.Universe));
             7 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomby4.png',qtImage, Game.Universe));
             8 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomby5.png',qtImage, Game.Universe));
             9 : gmI.Bitmap.LoadFromFile(FormatToDevice('bomby6.png',qtImage, Game.Universe));
           End;
    10   : gmI.Bitmap.LoadFromFile(FormatToDevice('mine.png',qtImage, Game.Universe));
    11   : gmI.Bitmap.LoadFromFile(FormatToDevice('teleport_'+ IntToStr(Frame.Value) +'.png',qtImage, Game.Universe));
    101  : gmI.Bitmap.LoadFromFile(FormatToDevice('expof.png',qtImage, Game.Universe));
    Else gmI.Bitmap.LoadFromFile(FormatToDevice('xxxxxx.png',qtImage, guNone));
  end;

  if Frame.FType in [1..8,11] then
  Begin
    if Game.ActiveLevel = 0 then
      gmI.OnClick := onZeroFrameClick
    Else
      gmI.OnClick := onFrameClick;
    Scale := cW * 0.2;

    gmF := TFloatAnimation.Create(gmI);
    gmF.PropertyName := 'Size.Width';
    gmF.Enabled      := False;
    gmF.Duration     := 0.2;
    gmF.Parent       := gmI;
    gmF.StartValue   := cW;
    gmF.StopValue    := cW + (2 * Scale);
    gmF.AutoReverse  := True;
    gmF.Name         := 'AnimeW_' + cN;
    gmF.OnFinish     := FrameFloatAnimationFinish;

    gmF := TFloatAnimation.Create(gmI);
    gmF.PropertyName := 'Size.Height';
    gmF.Enabled      := False;
    gmF.Duration     := 0.2;
    gmF.Parent       := gmI;
    gmF.StartValue   := cW;
    gmF.StopValue    := cW + (2 * Scale);
    gmF.AutoReverse  := True;
    gmF.Name         := 'AnimeH_' + cN;
    gmF.OnFinish     := FrameFloatAnimationFinish;

    gmF := TFloatAnimation.Create(gmI);
    gmF.PropertyName := 'Position.X';
    gmF.Enabled      := False;
    gmF.Duration     := 0.2;
    gmF.Parent       := gmI;
    gmF.StartValue   := cL;
    gmF.StopValue    := cL - Scale;
    gmF.AutoReverse  := True;
    gmF.Name         := 'AnimeX_' + cN;
    gmF.OnFinish     := FrameFloatAnimationFinish;

    gmF := TFloatAnimation.Create(gmI);
    gmF.PropertyName := 'Position.Y';
    gmF.Enabled      := False;
    gmF.Duration     := 0.2;
    gmF.Parent       := gmI;
    gmF.StartValue   := cT;
    gmF.StopValue    := cT - Scale;
    gmF.AutoReverse  := True;
    gmF.Name         := 'AnimeY_' + cN;
    gmF.OnFinish     := FrameFloatAnimationFinish;

  End;

  if Frame.FType in [9,10] then
  Begin
    gmL := TBitmapListAnimation.Create(gmI);
    gmL.PropertyName         := 'Bitmap';
    gmL.AnimationCount       := 9;
    gmL.AnimationRowCount    := 3;
    gmL.Enabled              := False;
    gmL.Duration             := 2;
    gmL.Parent               := gmI;
    gmL.Name                 := 'ListAnime_' + cN;
    gmL.AnimationBitmap.LoadFromFile(FormatToDevice('expo.png',qtImage, Game.Universe));
  End;
End;

procedure TEzerionForm.SaveLevelData;
Var
  LevelQuery : TUniQuery;
Begin
  Try
    ClearSavedLevel;
    SaveScore;

    LevelQuery            := TUniQuery.Create(nil);
    LevelQuery.Connection := DataForm.GameConnection;
    LevelQuery.SQL.Add('INSERT INTO saved_level (id, matrix_value)');
    LevelQuery.SQL.Add('values (:id, :matrix_value)');
    LevelQuery.ParamByName('id').AsInteger           := Game.ActiveLevel;
    LevelQuery.ParamByName('matrix_value').AsString  := ArrayMatrixToTextMatrix;
    LevelQuery.ExecSQL;
    LevelQuery.Free;
  Except

  End;
End;

procedure TEzerionForm.ExitFromScreen(EType:ExitType);
Begin
  case GameTabControl.TabIndex of
    0 : Begin
          //StartTabItem
          Close;
        End;
    1 : Begin
          //LevelTabItem
          FreeAndNilLevelSelect;
          SetStartScreen;
          GameTabControl.ActiveTab := StartTabItem;
        End;
    11,
    2 : Begin
          //GameTabItem
          if EType <> etBack then
          Begin
            FreeAndNilLevel;
            StopMusic;
            if MoveCount > 0 then
              SaveLevelData
            Else
              Inc(Game.GameLife);
            SetStartScreen;
            MoveCount := 0;
            GameTabControl.ActiveTab := StartTabItem;
          End;
        End;
    3 : Begin
          //SettingsTabItem
          GameTabControl.TabIndex := LastTabStatus;
        End;
    4 : Begin
          //LanguageTabItem
          GameTabControl.ActiveTab := SettingsTabItem;
        End;
    5 : Begin
          //SoundTabItem
          GameTabControl.ActiveTab := SettingsTabItem;
        End;
    6 : Begin
          //WebTabItem
          SetStartScreen;
          GameTabControl.ActiveTab := StartTabItem;
        End;
    7 : Begin
          //WinLoseTabItem
          GameTabControl.ActiveTab := LevelTabItem;
        End;
  end;
End;

procedure TEzerionForm.ExitImageClick(Sender: TObject);
begin
  ExitFromScreen(etButton);
end;

procedure TEzerionForm.FreeAndNilLevel;
Var
  I     : Integer;
  fI    : TImage;
  Name  : String;
begin
  if IComp = nil then
    Exit;
  for I := 0 to IComp.Count -1 do
  Begin
    Name := IComp.Strings[I];
    fI := GameTabItem.FindComponent(Name) As TImage;
    if fI <> Nil then
      FreeAndNil(fI);
  End;
  FreeAndNil(IComp);
end;


procedure TEzerionForm.FreeAndNilLevelSelect;
Var
  I     : Integer;
  fI    : TImage;
  Name  : String;
begin
  if sComp = nil then
    Exit;
  for I := 0 to sComp.Count -1 do
  Begin
    Name := sComp.Strings[I];
    fI := LevelTabItem.FindComponent(Name) As TImage;
    if fI <> Nil then
    Begin
      FreeAndNil(fI);
    End;
  End;
  FreeAndNil(sComp);
end;

Function TEzerionForm.ArrayMatrixToTextMatrix:String;
Var
   TextMatrix : String;
   I,J        : Integer;
   rCode      : Char;
Begin
  TextMatrix := '';
  for I := 1 to Level.MatrixX do
  Begin
    for J := 1 to Level.MatrixY do
    Begin
      if Level.Frame[I][J].cCode = #0 then
        rCode := '0'
      Else
        rCode := Level.Frame[I][J].cCode;

      TextMatrix := TextMatrix + IntToStr(I) + ':' +
                                 IntToStr(J) + ':' +
                                 IntToStr(Level.Frame[I][J].FType) + ':' +
                                 IntToStr(Level.Frame[I][J].Value) + ':' +
                                 rCode + ';';
    End;
  End;
  Result := TextMatrix;
End;

Procedure TEzerionForm.TextMatrixToArrayMatrix(TextMatrix:String;MaxPlayer:Integer);
Var
  InStr, sX, sY, sT, sD, sC     : String;
  iX, iY, iT, iD, X, Y          : Integer;
Begin
  Repeat
    X := Pos(';',TextMatrix);
    if X <> 0 then
    Begin
    InStr := Copy(TextMatrix,1,X);
    Delete(TextMatrix, 1, X);
    End
    Else
      InStr := TextMatrix;

    If InStr <> '' then
    Begin
      sX := '0';
      sY := '0';
      sT := '0';
      sD := '0';
      sC := 'a';
      Y  := Pos(':',InStr);
      if Y > 0 then
      Begin
        sX := Copy(InStr, 1, Y -1);
        Delete(InStr,1,Y);
      End;
      Y  := Pos(':',InStr);
      if Y > 0 then
      Begin
        sY := Copy(InStr, 1, Y -1);
        Delete(InStr,1,Y);
      End;
      Y  := Pos(':',InStr);
      if Y > 0 then
      Begin
        sT := Copy(InStr, 1, Y -1);
        Delete(InStr,1,Y);
      End;
      Y  := Pos(':',InStr);
      if Y > 0 then
      Begin
        sD := Copy(InStr, 1, Y -1);
        Delete(InStr,1,Y);
      End;
      if InStr <> '' then
      Begin
        sC := InStr;
      End;
      iX := MyStrToInt(sX);
      iY := MyStrToInt(sY);
      iT := MyStrToInt(sT);
      iD := MyStrToInt(sD);


      Level.Frame[iX][iY].FType   := iT;
      Level.Frame[iX][iY].Value   := iD;

      case iT of
        2 : Level.Frame[iX][iY].cCode := pC[1];
        3 : Level.Frame[iX][iY].cCode := pC[2];
        4 : Level.Frame[iX][iY].cCode := pC[3];
        5 : Level.Frame[iX][iY].cCode := pC[4];
        6 : Level.Frame[iX][iY].cCode := pC[5];
        7 : Level.Frame[iX][iY].cCode := pC[6];
      end;
    End;
  Until X = 0;
  //   1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;
End;


Function  TEzerionForm.LoadScore:Integer;
Var
  UserQuery   : TUniQuery;
Begin
  Result := 0;
  Try
    UserQuery            := TUniQuery.Create(nil);
    UserQuery.Connection := DataForm.GameConnection;
    UserQuery.SQL.Add('SELECT score FROM user');
    UserQuery.Open;
    if UserQuery.RecordCount > 0 then
      Result := UserQuery.FieldByName('score').AsInteger;
    UserQuery.Close;
    UserQuery.Free;
  Except

  End;
End;

Procedure TEzerionForm.SaveScore;
Var
  UserQuery   : TUniQuery;
Begin
  Try
    UserQuery            := TUniQuery.Create(nil);
    UserQuery.Connection := DataForm.GameConnection;
    UserQuery.SQL.Add('UPDATE user set score = :pscore');
    UserQuery.ParamByName('pscore').AsInteger := Game.Score;
    UserQuery.ExecSQL;
    UserQuery.Free;
  Except

  End;
End;

Procedure TEzerionForm.SaveWinnerLevel;
Var
  UserQuery   : TUniQuery;
  LevelQuery  : TUniQuery;
Begin
  if Game.ActiveLevel >= Game.MaxLevel then
  Begin
    Try
      if Game.ActiveLevel < LastLevel then
      Begin
        Game.MaxLevel        := Game.ActiveLevel + 1;
        Game.ActiveLevel     := Game.ActiveLevel + 1;
      End;
      UserQuery            := TUniQuery.Create(nil);
      UserQuery.Connection := DataForm.GameConnection;
      UserQuery.SQL.Add('UPDATE user set level = :level, max_level = :mlevel, score = :pscore');
      UserQuery.ParamByName('level').AsInteger  := Game.ActiveLevel;
      UserQuery.ParamByName('mlevel').AsInteger := Game.MaxLevel;
      UserQuery.ParamByName('pscore').AsInteger := Game.Score;
      UserQuery.ExecSQL;
      UserQuery.Free;
      AnimatedLevel := True;
    Except

    End;
  End
  Else
  Begin
    Try
      if Game.ActiveLevel < LastLevel then
      Begin
        Game.ActiveLevel     := Game.ActiveLevel + 1;
      End;
      UserQuery            := TUniQuery.Create(nil);
      UserQuery.Connection := DataForm.GameConnection;
      UserQuery.SQL.Add('UPDATE user set level = :level, score = :pscore');
      UserQuery.ParamByName('level').AsInteger  := Game.ActiveLevel;
      UserQuery.ParamByName('pscore').AsInteger := Game.Score;
      UserQuery.ExecSQL;
      UserQuery.Free;
    Except

    End;
  End;

  Try
    LevelQuery            := TUniQuery.Create(nil);
    LevelQuery.Connection := DataForm.GameConnection;
    LevelQuery.SQL.Add('DELETE FROM user_level');
    LevelQuery.SQL.Add('WHERE (id = :ID)');
    LevelQuery.ParamByName('ID').AsInteger := Game.ActiveLevel;
    LevelQuery.ExecSQL;

    LevelQuery.SQL.Clear;
    LevelQuery.SQL.Add('INSERT INTO user_level (id, level_score, finish_date)');
    LevelQuery.SQL.Add('values (:id, :level_score, :finish_date)');
    LevelQuery.ParamByName('id').AsInteger           := Game.ActiveLevel;
    LevelQuery.ParamByName('level_score').AsInteger  := Level.pScore;
    LevelQuery.ParamByName('finish_date').AsDateTime := Now;
    LevelQuery.ExecSQL;
    LevelQuery.Free;
  Except

  End;
End;

Function TEzerionForm.IsLevelExists(Lv:Integer):Boolean;
Var
  LevelQuery : TUniQuery;
Begin
  Try
    LevelQuery            := TUniQuery.Create(nil);
    LevelQuery.Connection := DataForm.GameConnection;
    LevelQuery.SQL.Add('SELECT * FROM level');
    LevelQuery.SQL.Add('WHERE (id = :LID)');
    LevelQuery.ParamByName('LID').AsInteger := Lv;
    LevelQuery.Open;
    if LevelQuery.RecordCount > 0 then
      Result := True
    Else
      Result := False;
    LevelQuery.Close;
    LevelQuery.Free;
  Except
    Result := False;
  End;
End;

procedure TEzerionForm.GameTabControlChange(Sender: TObject);
begin
  OnTabChangeAnimation.Enabled := True;
  case GameTabControl.TabIndex of
    0 : Begin
        End;
    1 : Begin
          //UserTabItem
        End;
    2 : Begin
          //LevelTabItem
        End;
    3 : Begin
          //GameTabItem
        End;
    4 : Begin
          //SettingsTabItem
        End;
    5 : Begin
          //LanguageTabItem
        End;
    6 : Begin
          //ScoreTabItem
        End;
    7 : Begin
          //LoginTabItem
        End;
    8 : Begin
          //SoundTabItem
        End;
    9 : Begin
          //WebTabItem
        End;
  end;
end;

Function TEzerionForm.GetLevelInfo:Boolean;
Var
  LevelQuery : TUniQuery;
Begin
  Result := False;
  Try
    LevelQuery            := TUniQuery.Create(nil);
    LevelQuery.Connection := DataForm.GameConnection;
    LevelQuery.SQL.Add('SELECT * FROM level');
    LevelQuery.SQL.Add('WHERE (id = :LID)');
    LevelQuery.ParamByName('LID').AsInteger := Game.ActiveLevel;
    LevelQuery.Open;
    if LevelQuery.RecordCount > 0 then
    Begin
      Level.MatrixX   := LevelQuery.FieldByName('matrix_x').AsInteger;
      Level.MatrixY   := LevelQuery.FieldByName('matrix_y').AsInteger;
      Level.BackI     := LevelQuery.FieldByName('back_image').asString;
      Level.MaxPlayer := LevelQuery.FieldByName('player_count').AsInteger;
      TextMatrixToArrayMatrix(LevelQuery.FieldByName('matrix_value').asString,Level.MaxPlayer);
      Result := True;
    End;
    LevelQuery.Close;
    LevelQuery.Free;
  Except

  End;
End;

procedure TEzerionForm.LangBackImageClick(Sender: TObject);
begin
  GameTabControl.ActiveTab := SettingsTabItem;
End;

procedure TEzerionForm.LangEnImageClick(Sender: TObject);
begin
  if Game.Lang <> 'en' then
  Begin
    Game.Lang := 'en';
    SetScreenLang;
    SaveUserGameInfo;
  End;
  GameTabControl.ActiveTab := SettingsTabItem;
end;

procedure TEzerionForm.LangTrImageClick(Sender: TObject);
begin
  if Game.Lang <> 'tr' then
  Begin
    Game.Lang := 'tr';
    SetScreenLang;
    SaveUserGameInfo;
  End;
  GameTabControl.ActiveTab := SettingsTabItem;
end;

procedure TEzerionForm.SavedLevelNoImageClick(Sender: TObject);
begin
  ClearSavedLevel;
  PlayLevel(Game.ActiveLevel, False)
end;

procedure TEzerionForm.SavedLevelPlay(SLId:Integer);
Begin
  SavedLevelYesImage.Tag := SLId;
  SetSavedLevelScreen;
  GameTabControl.ActiveTab := SavedLevelTabItem;
End;

Procedure TEzerionForm.FillAgeGender;
Var
  Age    : Integer;
  Gender : TJVEAdMobGender;
Begin
  if Game.BirthYear > 0 then
    Age := CurrentYear - Game.BirthYear + 1
  Else
    Age := 0;
  case Game.Gender of
    ' ', '0' : Gender := agUnknown;
    '1'      : Gender := agFemale;
    '2'      : Gender := agMale;
  end;

  EzerionAdMob.UserGender      := Gender;
  EzerionAdMob.UserAgeYears    := Age;
  EzerionAd.UserGender         := Gender;
  EzerionAd.UserAgeYears       := Age;
  EzerionRewardAd.UserGender   := Gender;
  EzerionRewardAd.UserAgeYears := Age;
End;

procedure TEzerionForm.SavedLevelYesImageClick(Sender: TObject);
begin
  PlayLevel(SavedLevelYesImage.Tag , True)
end;

procedure TEzerionForm.s1ImageClick(Sender: TObject);
Var
  SId : Integer;
begin
  {$IFDEF ANDROID}
  FillAgeGender;
  {$ENDIF}
  SId := GetSavedLevelId;
  if SId > 0 then
    SavedLevelPlay(SId)
  Else
    PlayLevel(Game.ActiveLevel, False)
end;

procedure TEzerionForm.s4ImageClick(Sender: TObject);
begin
  SetSettingScreenLang;
  LastTabStatus := StartTabItem.Index;
  GameTabControl.ActiveTab := SettingsTabItem;
end;

Procedure TEzerionForm.LevelScreenView;
Var
  sX, sY, sT  : Integer;
begin
  sX := Trunc(LevelBackgroundImage.Width);
  sY := Trunc(LevelBackgroundImage.Height);
  if sX > sY then
  Begin
    sT := sX;
    sX := sY;
    sY := sT;
  End;

  If sComp <> nil Then
  Begin
    FreeAndNilLevelSelect;
  End;
  sComp := TStringList.Create;

  LExitImage.Position.X := LevelBackgroundImage.Width - 45;
  LExitImage.Position.Y := 5;
  LExitImage.Bitmap.LoadFromFile(FormatToDevice('button_exit.png',qtImage, guNone));


  CreateSelectLevelArea(sX, sY);
  GameTabControl.ActiveTab := LevelTabItem;
end;

procedure TEzerionForm.PlayLevel(Lv:Integer;IsSavedLavel:Boolean);
Var
  sX, sY, sT  : Integer;
  sMatrix     : String;

  Procedure SetZeroLevelMoves;
  Begin
    FillZeroArray;

    HandImage.Visible    := True;
    MessageImage.Visible := True;
    ZeroTimer.Enabled    := True;

    HandImage.BringToFront;
  End;

Begin
  If Not IsLevelExists(Lv) Then
    Exit;

  FreeAndNilLevel;
  AnimatedLevel := False;
  CheckGameLife;

  if Game.GameLife < 1 then
  Begin
    SetADSScreen;
    EzerionRewardAd.Cache;
    EzerionRewardAd.Reward   := True;
    GameTabControl.ActiveTab := ADSTabItem;
    Exit;
  End;
  Game.GameLife := Game.GameLife - 1;

  sX := Trunc(GameBackgroundImage.Width);
  sY := Trunc(GameBackgroundImage.Height);
  if sX > sY then
  Begin
    sT := sX;
    sX := sY;
    sY := sT;
  End;

  if (AdsLevel = 2) then
  Begin
    if EzerionAd.IsCached then
    Begin
      EzerionAd.Show;
      AdsLevel := 0;
    End;
  End
  Else
  Begin
    Inc(AdsLevel);
    if AdsLevel = 1 then
      EzerionAd.Cache;
  End;
  If iComp <> nil Then
    FreeAndNil(iComp);
  iComp := TStringList.Create;
  Game.ActiveLevel := Lv;
  Turn             := 1;
  Winner           := 0;
  LevelEnd         := False;
  InClick          := False;


  AnimationEndTimer.Enabled     := False;

  FillChar(Level, Sizeof(LevelType), 0);
  GetLevelInfo;
  if IsSavedLavel then
  Begin
    SMatrix      := GetSavedLevelMatrix;
    Game.Score   := LoadScore;
    if SMatrix <> '' then
      TextMatrixToArrayMatrix(SMatrix, Level.MaxPlayer);
  End;
  CreateLevelArea(sX, sY);
  LastTabStatus := LevelTabItem.Index;
  GameTabControl.ActiveTab := GameTabItem;

  Lv           := (Game.ActiveLevel Mod 10) + 1;
  FMusicName   := FormatToDevice('music'+IntToStr(Lv)+'.mp3', qtMP3, guNone);
  PlayMusic(FMusicName, Lv);

  if Game.ActiveLevel = 0 then
  Begin
    SetZeroLevelMoves;
  End
  Else
  Begin
    HandImage.Visible     := False;
    MessageImage.Visible  := False;
  End;

End;

procedure TEzerionForm.onSelectLevelClick(Sender: TObject);
Var
  Lv  : Integer;
  SId : Integer;
begin
  Lv  := (Sender as TImage).Tag;
  SId := GetSavedLevelId;
  if SId > 0 then
  Begin
    Game.ActiveLevel := Lv;
    SavedLevelPlay(SId)
  End
  Else
    PlayLevel(Lv, False);
End;

procedure TEzerionForm.OnTabChangeAnimationFinish(Sender: TObject);
begin
  OnTabChangeAnimation.Enabled := False;
end;

procedure TEzerionForm.p1ImageClick(Sender: TObject);
begin
  GameTabControl.ActiveTab := StartTabItem;
end;

procedure TEzerionForm.SettingMusicImageClick(Sender: TObject);
begin
  GameTabControl.ActiveTab := SoundTabItem;
end;

procedure TEzerionForm.SettingUserImageClick(Sender: TObject);
begin
  SetUserNameScreen;
  GameTabControl.ActiveTab := UserNameTabItem;
end;

procedure TEzerionForm.SettingVibrationImageClick(Sender: TObject);
begin
  if Game.Vibration then
  Begin
    SettingVibrationImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_4_off_' + Game.Lang + '.png',qtImage, guNone));
    Game.Vibration := False;
  End
  Else
  Begin
    SettingVibrationImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_4_on_' + Game.Lang + '.png',qtImage, guNone));
    Game.Vibration := True;
    Vibration(100);
  End;
  SaveUserGameInfo;
end;

procedure TEzerionForm.SettingLangImageClick(Sender: TObject);
begin
  GameTabControl.ActiveTab := LanguageTabItem;
end;

procedure TEzerionForm.SettingBackImageClick(Sender: TObject);
begin
  GameTabControl.TabIndex := LastTabStatus;
end;

Procedure TEzerionForm.CalculateMaxValue;
Var
  I, J, mValue  : Byte;
Begin
  for I := 1 to Level.MatrixX do
    for J := 1 to Level.MatrixY do
    Begin
      if Level.Frame[I][J].FType in [1..7] then
      Begin
        mValue := 0;
        if (I - 1) > 0 then
          If Level.Frame[I - 1][J].FType in [1..11] Then
            Inc(mValue);
        if (J - 1) > 0 then
          If Level.Frame[I][J - 1].FType in [1..11] Then
            Inc(mValue);
        if (I + 1) <= MaxX then
          If Level.Frame[I + 1][J].FType in [1..11] Then
            Inc(mValue);
        if (J + 1) <= MaxY then
          If Level.Frame[I][J + 1].FType in [1..11] Then
            Inc(mValue);
        Level.Frame[I][J].MaxValue := mValue;
      End
      Else
        Level.Frame[I][J].MaxValue := 99;
    End;
End;

Procedure TEzerionForm.CalculateFrameMaxValue(X,Y:Integer);
Var
  mValue  : Byte;
Begin
  if Level.Frame[X][Y].FType in [1..7] then
  Begin
    mValue := 0;
    if (X - 1) > 0 then
      If Level.Frame[X - 1][Y].FType in [1..11] Then
        Inc(mValue);
    if (Y - 1) > 0 then
      If Level.Frame[X][Y - 1].FType in [1..11] Then
        Inc(mValue);
    if (X + 1) <= MaxX then
      If Level.Frame[X + 1][Y].FType in [1..11] Then
        Inc(mValue);
    if (Y + 1) <= MaxY then
      If Level.Frame[X][Y + 1].FType in [1..11] Then
        Inc(mValue);
    Level.Frame[X][Y].MaxValue := mValue;
  End
  Else
    Level.Frame[X][Y].MaxValue := 99;
End;

Procedure TEzerionForm.SetPlayerBoard;
Var
  Name,
  UFlag,
  Nation       : String;
  pW, pH       : Double;
Begin
  pH := 30;
  p1Image.Position.X := 0;
  p1Image.Position.Y := 0;

  fl1Image.Bitmap.LoadFromFile(FormatToDevice('flags/' + Game.Flag,qtImage, guNone));
  p1Text.Text     := Game.UserName;

  GetRandomName(Name,Nation, UFlag);
  fl2Image.Bitmap.LoadFromFile(FormatToDevice('flags/' + UFlag ,qtImage, guNone));
  p2Text.Text     := Name;

  GetRandomName(Name,Nation, UFlag);
  fl3Image.Bitmap.LoadFromFile(FormatToDevice('flags/' + UFlag ,qtImage, guNone));
  p3Text.Text     := Name;

  GetRandomName(Name,Nation, UFlag);
  fl4Image.Bitmap.LoadFromFile(FormatToDevice('flags/' + UFlag ,qtImage, guNone));
  p4Text.Text     := Name;

  GetRandomName(Name,Nation, UFlag);
  fl5Image.Bitmap.LoadFromFile(FormatToDevice('flags/' + UFlag ,qtImage, guNone));
  p5Text.Text     := Name;

  GetRandomName(Name,Nation, UFlag);
  fl6Image.Bitmap.LoadFromFile(FormatToDevice('flags/' + UFlag ,qtImage, guNone));
  p6Text.Text     := Name;


  p3Image.Visible := False;
  p4Image.Visible := False;
  p5Image.Visible := False;
  p6Image.Visible := False;

  p1Image.Opacity := 1;
  p2Image.Opacity := 0.65;
  p3Image.Opacity := 0.65;
  p4Image.Opacity := 0.65;
  p5Image.Opacity := 0.65;
  p6Image.Opacity := 0.65;
  case Level.MaxPlayer of
    2 : Begin
          pW := GameBackgroundImage.Width / 2;
          p1Image.Width := pW;

          p2Image.Position.X := pW;
          p2Image.Position.Y := 0;
          p2Image.Width := pW;
        End;
    3 : Begin
          pW := GameBackgroundImage.Width / 3;
          p3Image.Visible := True;

          p1Image.Width := pW;

          p2Image.Position.X := pW;
          p2Image.Position.Y := 0;
          p2Image.Width := pW;

          p3Image.Position.X := pW * 2;
          p3Image.Position.Y := 0;
          p3Image.Width := pW;
        End;
    4 : Begin
          pW := GameBackgroundImage.Width / 2;
          p3Image.Visible := True;
          p4Image.Visible := True;

          p1Image.Width := pW;

          p2Image.Position.X := pW;
          p2Image.Position.Y := 0;
          p2Image.Width := pW;

          p3Image.Position.X := 0;
          p3Image.Position.Y := 30;
          p3Image.Width := pW;

          p4Image.Position.X := pW;
          p4Image.Position.Y := 30;
          p4Image.Width := pW;
        End;
    5 : Begin
          pW := GameBackgroundImage.Width / 3;
          p3Image.Visible := True;
          p4Image.Visible := True;
          p5Image.Visible := True;

          p1Image.Width := pW;

          p2Image.Position.X := pW;
          p2Image.Position.Y := 0;
          p2Image.Width := pW;

          p3Image.Position.X := pW * 2;
          p3Image.Position.Y := 0;
          p3Image.Width := pW;

          p4Image.Position.X := 0;
          p4Image.Position.Y := 30;
          p4Image.Width := pW;

          p5Image.Position.X := pW;
          p5Image.Position.Y := 30;
          p5Image.Width := pW;

        End;
    6 : Begin
          pW := GameBackgroundImage.Width / 3;
          p3Image.Visible := True;
          p4Image.Visible := True;
          p5Image.Visible := True;
          p6Image.Visible := True;

          p1Image.Width := pW;

          p2Image.Position.X := pW;
          p2Image.Position.Y := 0;
          p2Image.Width := pW;

          p3Image.Position.X := pW * 2;
          p3Image.Position.Y := 0;
          p3Image.Width := pW;

          p4Image.Position.X := 0;
          p4Image.Position.Y := 30;
          p4Image.Width := pW;

          p5Image.Position.X := pW;
          p5Image.Position.Y := 30;
          p5Image.Width := pW;

          p6Image.Position.X := pW * 2;
          p6Image.Position.Y := 30;
          p6Image.Width := pW;
        End;
  end;
  fl1Image.Position.X := p1Image.Width - 30;
  fl1Image.Position.Y := 5;
  fl1Image.Width      := pH - 10;
  fl1Image.Height     := pH - 10;

  fl2Image.Position.X := p2Image.Width - 30;
  fl2Image.Position.Y := 5;
  fl2Image.Width      := pH - 10;
  fl2Image.Height     := pH - 10;

  fl3Image.Position.X := p3Image.Width - 30;
  fl3Image.Position.Y := 5;
  fl3Image.Width      := pH - 10;
  fl3Image.Height     := pH - 10;

  fl4Image.Position.X := p4Image.Width - 30;
  fl4Image.Position.Y := 5;
  fl4Image.Width      := pH - 10;
  fl4Image.Height     := pH - 10;

  fl5Image.Position.X := p5Image.Width - 30;
  fl5Image.Position.Y := 5;
  fl5Image.Width      := pH - 10;
  fl5Image.Height     := pH - 10;

  fl6Image.Position.X := p6Image.Width - 30;
  fl6Image.Position.Y := 5;
  fl6Image.Width      := pH - 10;
  fl6Image.Height     := pH - 10;

End;

Procedure TEzerionForm.CreateLevelArea(ScreenWidth, ScreenHeight:Integer);
Var
  Lv, bC,
  bL, oL, yL,
  I, J, bT, bB,
  mW, wW, hW   : Integer;
  sL, sT : Integer;
Begin
  bC := Random(4) + 1;
  GameBackgroundImage.Bitmap.LoadFromFile(FormatToDevice('back_' + IntToStr(bC) + '.png',qtImage, Game.Universe));
  if Level.MaxPlayer in [1,2,3] then
    bT := 65
  Else
    bt := 95;

  SetGameScreen(bT);
  Lv := Game.ActiveLevel;
  case Lv of
    1..9     : Begin
                 L1Image.Visible := True;
                 L2Image.Visible := False;
                 L3Image.Visible := False;
                 L1Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(Lv) + '.png',qtImage, guNone));
               End;
    10..99   : Begin
                 oL := Lv Div 10;
                 bL := Lv Mod 10;
                 L1Image.Visible := True;
                 L2Image.Visible := True;
                 L3Image.Visible := False;
                 L1Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(bL) + '.png',qtImage, guNone));
                 L2Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(oL) + '.png',qtImage, guNone));
               End;
    100..999 : Begin
                 yL := Lv Div 100;
                 oL := (Lv Div 10) Mod 10;
                 bL := Lv Mod 10;
                 L1Image.Visible := True;
                 L2Image.Visible := True;
                 L3Image.Visible := True;
                 L1Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(bL) + '.png',qtImage, guNone));
                 L2Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(oL) + '.png',qtImage, guNone));
                 L3Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(yL) + '.png',qtImage, guNone));
               End;
  end;

  HandImage.Bitmap.LoadFromFile(FormatToDevice('hand.png',qtImage, guNone));
  MessageImage.Bitmap.LoadFromFile(FormatToDevice('mess.png',qtImage, guNone));
  ScreenHeight := ScreenHeight - bT;
  ScreenWidth  := ScreenWidth - 20;

  hW   := ScreenHeight div Level.MatrixY;
  wW   := ScreenWidth div Level.MatrixX;
  SetPlayerBoard;
  if hW > wW then
    mW := wW
  Else
    mW := hw;

  WriteScore(Game.Score);


  MoveCount := 0;

  CalculateMaxValue;
  sL := 10 + ((ScreenWidth - (Level.MatrixX * mW)) Div 2);
  sT := bT + ((ScreenHeight - (Level.MatrixY * mW)) Div 2);
  for I := 1 to Level.MatrixX do
    for J := 1 to Level.MatrixY do
      CreateLevelSquare(Level.Frame[I][J], mW, sL + ( (I-1) * mW), sT + ( (J-1) * mW), IntToStr(I) + '_' + IntToStr(J), GameBackgroundImage);
  FillChar(AnimeQueue, SizeOf(AnimeQueueType),0);
  AnimeInProgress := False;
  AnimeMax := 0;
  AnimeRun := 0;

  MessageImage.Position.X     := sL + (mW * 3);
  MessageImage.Position.Y     := sT + (mW * 7);
  MessageImage.Width          := mW * 4;
  MessageImage.Height         := mW * 4;
  MessageImage.Margins.Left   := MessageImage.Height * 0.15;
  MessageImage.Margins.Right  := MessageImage.Height * 0.15;
  MessageImage.Margins.Top    := MessageImage.Height * 0.15;
  MessageImage.Margins.Bottom := MessageImage.Height * 0.15;
End;

Procedure TEzerionForm.CreateSelectLevelArea(ScreenWidth, ScreenHeight:Integer);
Var
  I, PLv   : Integer;
  wH, wW   : Double;
Begin
  case Game.LevelPage of
     1,2,3    : Game.Universe := guWater;
     4,5,6    : Game.Universe := guRock;
     7,8,9    : Game.Universe := guFire;
     10,11,12 : Game.Universe := guSpace;
    Else Game.Universe := guWater;
  end;

  case Game.LevelPage of
    1      : Begin
               UpArrowImage.Visible   := True;
               DownArrowImage.Visible := False;
             End;
    2..11  : Begin
               UpArrowImage.Visible   := True;
               DownArrowImage.Visible := True;
             End;
    12     : Begin
               UpArrowImage.Visible   := False;
               DownArrowImage.Visible := True;
             End;
  end;
  LevelBackgroundImage.Bitmap.LoadFromFile(FormatToDevice('back.png',qtImage, Game.Universe));
  wH   := LevelBackgroundImage.Height / 35;
  wW   := LevelBackgroundImage.Width / 30;

  DownArrowImage.Width      := wW * 5;
  DownArrowImage.Height     := wH * 4;
  DownArrowImage.Position.X := wW * 2;
  DownArrowImage.Position.Y := wH * 27;
  DownArrowImage.Bitmap.LoadFromFile(FormatToDevice('button_down.png',qtImage, guNone));

  UpArrowImage.Width      := wW * 5;
  UpArrowImage.Height     := wH * 4;
  UpArrowImage.Position.X := wW * 23;
  UpArrowImage.Position.Y := wH * 4;
  UpArrowImage.Bitmap.LoadFromFile(FormatToDevice('button_up.png',qtImage, guNone));

  AvatarImage.Bitmap.LoadFromFile(FormatToDevice('avatar.png',qtImage, guNone));
  AvatarImage.Visible := False;

  AvatarXFloatAnimation.StartValue := AvatarImage.Position.X;
  AvatarYFloatAnimation.StartValue := AvatarImage.Position.Y;

  for I := 1 to 10 do
    CreateSelectLevelSquare(I, LevelBackgroundImage);

  if AvatarImage.Visible And AnimatedLevel then
  Begin
    if (AvatarXFloatAnimation.StartValue = 0) And (AvatarYFloatAnimation.StartValue = 0)  then
    Begin
      PLv := (Game.MaxLevel-1) Mod 10;
      case PLv of
        0 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 30) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 33) - (3 * wW);
            End;
        1 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 23) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 29) - (3 * wW);
            End;
        2 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 16) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 26) - (3 * wW);
            End;
        3 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 9) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 23) - (3 * wW);
            End;
        4 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 2) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 20) - (3 * wW);
            End;
        5 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 9) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 17) - (3 * wW);
            End;
        6 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 16) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 14) - (3 * wW);
            End;
        7 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 23) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 11) - (3 * wW);
            End;
        8 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 16) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 8) - (3 * wW);
            End;
        9 : Begin
              AvatarXFloatAnimation.StartValue := (wW * 9) + wW;
              AvatarYFloatAnimation.StartValue := (wH * 5) - (3 * wW);
            End;
      end;
    End;
    AvatarXFloatAnimation.StopValue := AvatarImage.Position.X;
    AvatarYFloatAnimation.StopValue := AvatarImage.Position.Y;
    AvatarXFloatAnimation.Enabled   := True;
    AvatarYFloatAnimation.Enabled   := True;
  End;

End;

Procedure TEzerionForm.CreateSelectLevelSquare(Lv:Integer; Sender:TFmxObject);
Var
  nH, nW,
  wH, wW            : Double;
  gmI, gs1I,
  gs2I, gs3I        : TImage;
  sTag              : String;
  gmF               : TFloatAnimation;
Begin
  gmI := TImage.Create(LevelTabItem);

  wH   := LevelBackgroundImage.Height / 35;
  wW   := LevelBackgroundImage.Width / 30;

  case Lv of
    1 : Begin
          gmI.Position.X := wW * 23;
          gmI.Position.Y := wH * 29;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_1.png',qtImage, Game.Universe));
        End;
    2 : Begin
          gmI.Position.X := wW * 16;
          gmI.Position.Y := wH * 26;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_1.png',qtImage, Game.Universe));
        End;
    3 : Begin
          gmI.Position.X := wW * 9;
          gmI.Position.Y := wH * 23;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_1.png',qtImage, Game.Universe));
        End;
    4 : Begin
          gmI.Position.X := wW * 2;
          gmI.Position.Y := wH * 20;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_2.png',qtImage, Game.Universe));
        End;
    5 : Begin
          gmI.Position.X := wW * 9;
          gmI.Position.Y := wH * 17;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_2.png',qtImage, Game.Universe));
        End;
    6 : Begin
          gmI.Position.X := wW * 16;
          gmI.Position.Y := wH * 14;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_2.png',qtImage, Game.Universe));
        End;
    7 : Begin
          gmI.Position.X := wW * 23;
          gmI.Position.Y := wH * 11;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_2.png',qtImage, Game.Universe));
        End;
    8 : Begin
          gmI.Position.X := wW * 16;
          gmI.Position.Y := wH * 8;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_3.png',qtImage, Game.Universe));
        End;
    9 : Begin
          gmI.Position.X := wW * 9;
          gmI.Position.Y := wH * 5;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_3.png',qtImage, Game.Universe));
        End;
    10: Begin
          gmI.Position.X := wW * 2;
          gmI.Position.Y := wH * 2;
          gmI.Height     := wH * 4;
          gmI.Width      := wW * 5;
          gmI.Bitmap.LoadFromFile(FormatToDevice('level_3.png',qtImage, Game.Universe));
        End;
  end;

  gmI.Name       := 'Select_Frame_' + IntToStr(Lv);
  gmI.Tag        := ((Game.LevelPage - 1) * 10) + Lv;
  gmI.Parent     := LevelTabItem;
  gmI.Opacity    := 1;

  sComp.Add(gmI.Name);

  If gmI.Tag <= Game.MaxLevel Then
  Begin
    gmF := TFloatAnimation.Create(gmI);
    gmF.PropertyName := 'Size.Width';
    gmF.Duration     := 1;
    gmF.Parent       := gmI;
    gmF.StartValue   := gmI.Width;
    gmF.StopValue    := gmI.Width+ (gmI.Width * 0.06);
    gmF.AutoReverse  := True;
    gmF.Name         := 'AnimeW_' + gmI.Name;
    gmF.OnFinish     := FrameFloatAnimationFinish;
    gmF.Loop         := True;
    gmF.Enabled      := True;

    gmF := TFloatAnimation.Create(gmI);
    gmF.PropertyName := 'Size.Height';
    gmF.Enabled      := False;
    gmF.Duration     := 1;
    gmF.Parent       := gmI;
    gmF.StartValue   := gmI.Height;
    gmF.StopValue    := gmI.Height + (gmI.Height * 0.06);
    gmF.AutoReverse  := True;
    gmF.Name         := 'AnimeH_' + gmI.Name;;
    gmF.OnFinish     := FrameFloatAnimationFinish;
    gmF.Loop         := True;
    gmF.Enabled      := True;

    gmF := TFloatAnimation.Create(gmI);
    gmF.PropertyName := 'Position.X';
    gmF.Enabled      := False;
    gmF.Duration     := 1;
    gmF.Parent       := gmI;
    gmF.StartValue   := gmI.Position.X;
    gmF.StopValue    := gmI.Position.X - (gmI.Width * 0.03);
    gmF.AutoReverse  := True;
    gmF.Name         := 'AnimeX_' + gmI.Name;;
    gmF.OnFinish     := FrameFloatAnimationFinish;
    gmF.Loop         := True;
    gmF.Enabled      := True;

    gmF := TFloatAnimation.Create(gmI);
    gmF.PropertyName := 'Position.Y';
    gmF.Enabled      := False;
    gmF.Duration     := 1;
    gmF.Parent       := gmI;
    gmF.StartValue   := gmI.Position.Y;
    gmF.StopValue    := gmI.Position.Y - (gmI.Height * 0.03);
    gmF.AutoReverse  := True;
    gmF.Name         := 'AnimeY_' + gmI.Name;
    gmF.OnFinish     := FrameFloatAnimationFinish;
    gmF.Loop         := True;
    gmF.Enabled      := True;
  End;

  if gmI.Tag = Game.MaxLevel then
  Begin
    AvatarImage.Visible     := True;
    AvatarImage.Width       := wW * 3;
    AvatarImage.Height      := wW * 3;
    AvatarImage.Position.X  := gmI.Position.X + wW;
    AvatarImage.Position.Y  := gmI.Position.Y - (3 * wW);
  End;

  if gmI.Tag > Game.MaxLevel then
  Begin
    gmI.Opacity := 0.6;
  End
  else
  begin
    gmI.OnClick    := onSelectLevelClick;
    gmI.Opacity := 1;
  end;

  sTag := IntToStr(gmI.Tag);
  nH   := Trunc (gmI.Width  * 0.3);
  nW   := nH / 2;
  Case gmI.Tag of
    0..9      : Begin
                  gs1I := TImage.Create(gmI);
                  gs1I.Parent       := gmI;
                  gs1I.Opacity      := 1;
                  gs1I.Name         := 'Select_Frame_s1_' + IntToStr(Lv);
                  gs1I.Height       := nH;
                  gs1I.Width        := nW;
                  gs1I.Position.X   := 0;
                  gs1I.Position.Y   := 0;
                  gs1I.OnClick      := gmI.OnClick;
                  gs1I.Tag          := gmI.Tag;
                  gs1I.Bitmap.LoadFromFile(FormatToDevice('z' + sTag+ '.png',qtImage, guNone));
                  if gmI.Tag > Game.MaxLevel then
                    gs1I.Opacity := 0.6
                  else
                    gs1I.Opacity := 1;
                End;
    10..99    : Begin
                  gs1I := TImage.Create(gmI);
                  gs1I.Parent       := gmI;
                  gs1I.Opacity      := 1;
                  gs1I.Name         := 'Select_Frame_s1_' + IntToStr(Lv);
                  gs1I.Height       := nH;
                  gs1I.Width        := nW;
                  gs1I.Position.X   := 0;
                  gs1I.Position.Y   := 0;
                  gs1I.OnClick      := gmI.OnClick;
                  gs1I.Tag          := gmI.Tag;
                  gs1I.Bitmap.LoadFromFile(FormatToDevice('z' + sTag[2] + '.png', qtImage, guNone));

                  gs2I := TImage.Create(gmI);
                  gs2I.Parent       := gmI;
                  gs2I.Opacity      := 1;
                  gs2I.Name         := 'Select_Frame_s2_' + IntToStr(Lv);
                  gs2I.Height       := nH;
                  gs2I.Width        := nW;
                  gs2I.Position.X   := gs1I.Position.X - (nW * 1.1);
                  gs2I.Position.Y   := 0;
                  gs2I.OnClick      := gmI.OnClick;
                  gs2I.Tag          := gmI.Tag;
                  gs2I.Bitmap.LoadFromFile(FormatToDevice('z' + sTag[1] + '.png', qtImage, guNone));

                  if gmI.Tag > Game.MaxLevel then
                  Begin
                    gs1I.Opacity := 0.6;
                    gs2I.Opacity := 0.6;
                  End
                  else
                  begin
                    gs1I.Opacity := 1;
                    gs2I.Opacity := 1;
                  end;
                End;
    100..999  : Begin
                  gs1I := TImage.Create(gmI);
                  gs1I.Parent       := gmI;
                  gs1I.Opacity      := 1;
                  gs1I.Name         := 'Select_Frame_s1_' + IntToStr(Lv);
                  gs1I.Height       := nH;
                  gs1I.Width        := nW;
                  gs1I.Position.X   := 0;
                  gs1I.Position.Y   := 0;
                  gs1I.OnClick      := gmI.OnClick;
                  gs1I.Tag          := gmI.Tag;
                  gs1I.Bitmap.LoadFromFile(FormatToDevice('z' + sTag[3] + '.png', qtImage, guNone));

                  gs2I := TImage.Create(gmI);
                  gs2I.Parent       := gmI;
                  gs2I.Opacity      := 1;
                  gs2I.Name         := 'Select_Frame_s2_' + IntToStr(Lv);
                  gs2I.Height       := nH;
                  gs2I.Width        := nW;
                  gs2I.Position.X   := gs1I.Position.X - (nW * 1.1);
                  gs2I.Position.Y   := 0;
                  gs2I.OnClick      := gmI.OnClick;
                  gs2I.Tag          := gmI.Tag;
                  gs2I.Bitmap.LoadFromFile(FormatToDevice('z' + sTag[2] + '.png', qtImage, guNone));

                  gs3I := TImage.Create(gmI);
                  gs3I.Parent       := gmI;
                  gs3I.Opacity      := 1;
                  gs3I.Name         := 'Select_Frame_s3_' + IntToStr(Lv);
                  gs3I.Height       := nH;
                  gs3I.Width        := nW;
                  gs3I.Position.X   := gs1I.Position.X - ((nW * 1.1) * 2);
                  gs3I.Position.Y   := 0;
                  gs3I.OnClick      := gmI.OnClick;
                  gs3I.Tag          := gmI.Tag;
                  gs3I.Bitmap.LoadFromFile(FormatToDevice('z' + sTag[1] + '.png', qtImage, guNone));

                  if gmI.Tag > Game.MaxLevel then
                  Begin
                    gs1I.Opacity := 0.6;
                    gs2I.Opacity := 0.6;
                    gs3I.Opacity := 0.6;
                  End
                  else
                  begin
                    gs1I.Opacity := 1;
                    gs2I.Opacity := 1;
                    gs3I.Opacity := 1;
                  end;
                End;
  End;

End;

Procedure TEzerionForm.GetRandomName(Var Name, Nation, Flag:String);
Var
  PName     : String;
  NameQuery : TUniQuery;

  Function LowerName(InStr:String):String;
  Var
    I   : Integer;
    FC  : Boolean;
  Begin
    FC  := True;
    Result := '';
    for I := 1 to Length(InStr) do
    Begin
      if FC then
      Begin
        if Nation = 'tr' then
        Begin
          case InStr[I] of
            'ð' : Result := Result + 'Ð';
            'ü' : Result := Result + 'Ü';
            'þ' : Result := Result + 'Þ';
            'i' : Result := Result + 'Ý';
            'ý' : Result := Result + 'I';
            'ö' : Result := Result + 'Ö';
            'ç' : Result := Result + 'Ç';
            'Ð' : Result := Result + 'Ð';
            'Ü' : Result := Result + 'Ü';
            'Þ' : Result := Result + 'Þ';
            'Ý' : Result := Result + 'Ý';
            'I' : Result := Result + 'I';
            'Ö' : Result := Result + 'Ö';
            'Ç' : Result := Result + 'Ç'
            Else Result := Result + UpCase(InStr[I])
          end;
        End
        Else
        Begin
          Result := Result + UpCase(InStr[I]);
        End;
        FC := False;
      End
      Else
      Begin
        if Nation = 'tr' then
        Begin
          case InStr[I] of
            ' ' : Begin
                    Result := Result + ' ';
                    FC := True;
                  End;
            'ð' : Result := Result + 'ð';
            'ü' : Result := Result + 'ü';
            'þ' : Result := Result + 'þ';
            'i' : Result := Result + 'i';
            'ý' : Result := Result + 'ý';
            'ö' : Result := Result + 'ö';
            'ç' : Result := Result + 'ç';
            'Ð' : Result := Result + 'ð';
            'Ü' : Result := Result + 'ü';
            'Þ' : Result := Result + 'þ';
            'Ý' : Result := Result + 'i';
            'I' : Result := Result + 'ý';
            'Ö' : Result := Result + 'ö';
            'Ç' : Result := Result + 'ç'
            Else Result := Result + LowerCase(InStr[I])
          end;
        End
        Else
        Begin
          if InStr[I] = ' ' then
          Begin
            Result := Result + ' ';
            FC := True;
          End
          Else
            Result := Result + LowerCase(InStr[I]);
        End;
      End;
    End;
  End;

Begin
  Try
    NameQuery            := TUniQuery.Create(nil);
    NameQuery.Connection := DataForm.GameConnection;
    NameQuery.SQL.Add('SELECT name, lang, file_name FROM names');
    NameQuery.SQL.Add('ORDER BY RANDOM() LIMIT 1');
    NameQuery.Open;
    if NameQuery.RecordCount > 0 then
    Begin
      PName  := NameQuery.FieldByName('name').AsString;
      Nation := NameQuery.FieldByName('lang').AsString;
      Flag   := NameQuery.FieldByName('file_name').AsString;
      Name   := LowerName(PName);
    End;
    NameQuery.Close;
    NameQuery.Free;
  Except
  End;
End;

Function TEzerionForm.GetLevelPage(Lv:Integer):Integer;
Begin
  if (Lv mod 10) = 0 then
    Result := Lv Div 10
  Else
    Result := (Lv Div 10) + 1;
End;

Function TEzerionForm.LoadUserGameInfo:Boolean;
Var
  LUniverse : Byte;
  UserQuery : TUniQuery;
Begin
  Try
    Result := False;
    UserQuery            := TUniQuery.Create(nil);
    UserQuery.Connection := DataForm.GameConnection;
    UserQuery.SQL.Add('SELECT * FROM user');
    UserQuery.Open;
    if UserQuery.RecordCount > 0 then
    Begin
      With Game Do
      Begin
        UserId        := UserQuery.FieldByName('id').AsInteger;
        ActiveLevel   := UserQuery.FieldByName('level').AsInteger;
        MaxLevel      := UserQuery.FieldByName('max_level').AsInteger;
        Sound         := UserQuery.FieldByName('sound').AsBoolean;
        SoundVolume   := UserQuery.FieldByName('sound_volume').AsFloat;
        Music         := UserQuery.FieldByName('music').AsBoolean;
        MusicVolume   := UserQuery.FieldByName('music_volume').AsFloat;
        Lang          := UserQuery.FieldByName('lang').AsString;
        Score         := UserQuery.FieldByName('score').AsInteger;
        Vibration     := UserQuery.FieldByName('online_game').AsBoolean;
        EMail         := UserQuery.FieldByName('e_mail').AsString;
        UserName      := UserQuery.FieldByName('user_name').AsString;
        Password      := UserQuery.FieldByName('password').AsString;
        AutoLogin     := UserQuery.FieldByName('auto_login').AsBoolean;
        ServerLogin   := UserQuery.FieldByName('server_login').AsBoolean;
        ColorSet      := UserQuery.FieldByName('color_set').AsInteger;
        CompState     := UserQuery.FieldByName('comp_state').AsInteger;
        UserCount     := 2;
        LevelPage     := GetLevelPage(ActiveLevel);
        GameLife      := UserQuery.FieldByName('game_life').AsInteger;
        Flag          := UserQuery.FieldByName('flag').AsString;
        LUniverse     := GetLevelPage(MaxLevel);
        BirthYear     := UserQuery.FieldByName('birth_year').AsInteger;
        if UserQuery.FieldByName('gender').AsString <> '' then
          Gender := UserQuery.FieldByName('gender').AsString[1];
        case LUniverse of
          1,2,3    :  Universe := guWater;
          4,5,6    :  Universe := guRock;
          7,8,9    :  Universe := guFire;
          10,11,12 :  Universe := guSpace;
          Else Universe := guWater;
        end;
      End;
      Result := True;
    End;
    UserQuery.Close;
    UserQuery.Free;
  Except
    Result := False;
  End;
End;

procedure TEzerionForm.MapListImageClick(Sender: TObject);
begin
  LevelScreenView;
end;

procedure TEzerionForm.MusicTimerTimer(Sender: TObject);
begin
  PlayMusic(FMusicName,(Game.ActiveLevel Mod 10) + 1);
end;

procedure TEzerionForm.MusicTrackBarChange(Sender: TObject);
begin
  if MusicTrackBar.Value > 1.2 then
    Game.MusicVolume := MusicTrackBar.Value / 10
  Else
    Game.MusicVolume := 0;
end;

procedure TEzerionForm.WebBackImageClick(Sender: TObject);
begin
  ExitFromScreen(etButton);
end;

procedure TEzerionForm.WinLoseImageClick(Sender: TObject);
begin
  Game.LevelPage  := GetLevelPage(Game.ActiveLevel);
  FreeAndNilLevel;
  LevelScreenView;
end;

procedure TEzerionForm.WinLoseTimerTimer(Sender: TObject);
begin
  WinLoseTimer.Enabled := False;
  if GameTabControl.ActiveTab = WinLoseTabItem Then
  Begin
    WinLoseImageClick(Sender);
  End;
end;

Procedure TEzerionForm.CheckGameLife;

  Function CheckLife:Integer;
  Var
    LogQuery : TUniQuery;
    LgTime   : TDateTime;
    Delta    : Real;
  Begin
    Try
      Result := 0;
      LogQuery            := TUniQuery.Create(nil);
      LogQuery.Connection := DataForm.GameConnection;
      LogQuery.SQL.Add('select log_date from ezlog');
      LogQuery.SQL.Add('where (log_type = :lt)');
      LogQuery.SQL.Add('order by log_date desc');
      LogQuery.ParamByName('lt').AsInteger := EZ_ADD_LIVE;
      LogQuery.Open;
      if LogQuery.RecordCount > 0 then
      Begin
        LgTime := LogQuery.FieldByName('log_date').AsDateTime;
        Delta  := (Now - LgTime) * 1440;
        Result := Trunc(Delta) Div 20;
      End
      Else
        Result := 5;
      LogQuery.Close;
      LogQuery.Free;
    Except
    End;
  End;

Var
  AddLife : Integer;
Begin
  AddLife := CheckLife;
  if AddLife > 0 then
  Begin
    if (Game.GameLife + AddLife) > 5 then
      Game.GameLife := 5
    Else
      Inc(Game.GameLife, AddLife);
    WriteLog(EZ_ADD_LIVE);
  End;
End;

Procedure TEzerionForm.WriteLog(LogType:Integer);
Var
  LogQuery : TUniQuery;
Begin
  Try
    LogQuery            := TUniQuery.Create(nil);
    LogQuery.Connection := DataForm.GameConnection;
    LogQuery.SQL.Add('INSERT INTO ezlog (log_type, log_date)');
    LogQuery.SQL.Add('values (:log_type, :log_date)');
    LogQuery.ParamByName('log_type').AsInteger  := LogType;
    LogQuery.ParamByName('log_date').AsDateTime := Now;
    LogQuery.ExecSQL;
    LogQuery.Close;
    LogQuery.Free;
  Except
  End;
End;

procedure TEzerionForm.YukariKaydirExecute(Sender: TObject);
begin
  DownArrowImageClick(Sender);
end;

procedure TEzerionForm.ZeroTimerTimer(Sender: TObject);
begin
  ZeroTimer.Enabled := False;
  HandImage.Position.X := 0;
  HandImage.Position.Y := GameBackgroundImage.Height / 2;
  HandImage.Visible    := True;

  ZeroXFloatAnimation.StartValue := HandImage.Position.X;
  ZeroYFloatAnimation.StartValue := HandImage.Position.Y;

  ZeroXFloatAnimation.StopValue  := GetZeroHandPosX(ZeroLevel[ZeroMove].P1MoveX,ZeroLevel[ZeroMove].P1MoveY);
  ZeroYFloatAnimation.StopValue  := GetZeroHandPosY(ZeroLevel[ZeroMove].P1MoveX,ZeroLevel[ZeroMove].P1MoveY);

  if Game.Lang = 'tr' then
    MessageText.Text             := ZeroLevel[ZeroMove].TrMessage
  Else
    MessageText.Text             := ZeroLevel[ZeroMove].EnMessage;

  if MessageText.Text <> '' then
    MessageImage.Visible            := True
  Else
    MessageImage.Visible            := False;

  ZeroXFloatAnimation.Enabled    := True;
  ZeroYFloatAnimation.Enabled    := True;
end;

Function TEzerionForm.SaveUserGameInfo:Boolean;
Var
  UserQuery : TUniQuery;
Begin
  Result := False;
  Try
    UserQuery            := TUniQuery.Create(nil);
    UserQuery.Connection := DataForm.GameConnection;
    UserQuery.SQL.Add('DELETE FROM user');
    UserQuery.ExecSQL;

    UserQuery.SQL.Clear;
    UserQuery.SQL.Add('INSERT INTO user (id, level, sound, music, lang, score, online_game,');
    UserQuery.SQL.Add('e_mail, user_name, password, auto_login, server_login, color_set, birth_year,');
    UserQuery.SQL.Add('comp_state, music_volume, sound_volume, game_life, flag, max_level, gender)');
    UserQuery.SQL.Add('values (:id, :level, :sound, :music, :lang, :score, :online_game,');
    UserQuery.SQL.Add(':e_mail, :user_name, :password, :auto_login, :server_login, :color_set, :birth_year,');
    UserQuery.SQL.Add(':comp_state, :music_volume, :sound_volume, :game_life, :flag, :max_level, :gender)');
    With Game Do
    Begin
      UserQuery.ParamByName('id').AsInteger            := UserId;
      UserQuery.ParamByName('level').AsInteger         := ActiveLevel;
      UserQuery.ParamByName('max_level').AsInteger     := MaxLevel;
      UserQuery.ParamByName('sound').AsBoolean         := Sound;
      UserQuery.ParamByName('sound_volume').AsFloat    := SoundVolume;
      UserQuery.ParamByName('music').AsBoolean         := Music;
      UserQuery.ParamByName('music_volume').AsFloat    := MusicVolume;
      UserQuery.ParamByName('lang').AsString           := Lang;
      UserQuery.ParamByName('score').AsInteger         := Score;
      UserQuery.ParamByName('online_game').AsBoolean   := Vibration;
      UserQuery.ParamByName('e_mail').AsString         := EMail;
      UserQuery.ParamByName('user_name').AsString      := UserName;
      UserQuery.ParamByName('password').AsString       := Password;
      UserQuery.ParamByName('auto_login').AsBoolean    := AutoLogin;
      UserQuery.ParamByName('server_login').AsBoolean  := ServerLogin;
      UserQuery.ParamByName('color_set').AsInteger     := ColorSet;
      UserQuery.ParamByName('comp_state').AsInteger    := CompState;
      UserQuery.ParamByName('game_life').AsInteger     := GameLife;
      UserQuery.ParamByName('flag').AsString           := Flag;
      UserQuery.ParamByName('birth_year').AsInteger    := BirthYear;
      UserQuery.ParamByName('gender').AsString         := Gender;
    End;
    UserQuery.ExecSQL;
    UserQuery.Free;
    Result := True;
  Except
    Result := False;
  End;
End;

Procedure TEzerionForm.SetScreenLang;
Begin
  SetSettingScreenLang;
  SetLanguageScreenLang;
  SetSoundScreenLang;
  SetStartScreenLang;
End;

procedure TEzerionForm.SetSettingScreen;
Var
  sH, sA, sT, sW, bH, bW, bX        : Extended;
Begin
  SettingBackGroundImage.Bitmap.LoadFromFile(FormatToDevice('menu_back.jpg',qtImage, guNone));
  sH := SettingBackGroundImage.Height;
  sW := SettingBackGroundImage.Width;

  bW := sW * 0.7;
  bH := bW / 4;
  bX := sW * 0.15;

  sA := (sH - (bH * 5)) / 6;
  sT := sA;

  SettingLangImage.Position.X       := bX;
  SettingLangImage.Position.Y       := sT;
  SettingLangImage.Width            := bW;
  SettingLangImage.Height           := bH;

  sT := sT + bH + sA;

  SettingMusicImage.Position.X      := bX;
  SettingMusicImage.Position.Y      := sT;
  SettingMusicImage.Width           := bW;
  SettingMusicImage.Height          := bH;

  sT := sT + bH + sA;

  SettingUserImage.Position.X       := bX;
  SettingUserImage.Position.Y       := sT;
  SettingUserImage.Width            := bW;
  SettingUserImage.Height           := bH;

  sT := sT + bH + sA;

  SettingVibrationImage.Position.X  := bX;
  SettingVibrationImage.Position.Y  := sT;
  SettingVibrationImage.Width       := bW;
  SettingVibrationImage.Height      := bH;

  sT := sT + bH + sA;

  SettingBackImage.Position.X       := bX;
  SettingBackImage.Position.Y       := sT;
  SettingBackImage.Width            := bW;
  SettingBackImage.Height           := bH;

  SetSettingScreenLang;
End;

procedure TEzerionForm.SetSettingScreenLang;
Begin
  SettingLangImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_1_' + Game.Lang + '.png',qtImage, guNone));
  SettingMusicImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_2_' + Game.Lang + '.png',qtImage, guNone));
  SettingUserImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_3_' + Game.Lang + '.png',qtImage, guNone));
  if Game.Vibration then
    SettingVibrationImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_4_on_' + Game.Lang + '.png',qtImage, guNone))
  Else
    SettingVibrationImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_4_off_' + Game.Lang + '.png',qtImage, guNone));
  SettingBackImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_5_' + Game.Lang + '.png',qtImage, guNone));
End;

procedure TEzerionForm.SetLanguageScreen;
Var
  sT, sH, sA, sW, bH, bW, bX        : Extended;
Begin
  LangBackGroundImage.Bitmap.LoadFromFile(FormatToDevice('menu_back.jpg',qtImage, guNone));

  sH := LangBackGroundImage.Height;
  sW := LangBackGroundImage.Width;

  bW := sW * 0.7;
  bH := bW / 4;
  bX := sW * 0.15;

  sA := (sH - (bH * 4)) / 5;
  sT := sA;

  LangImage.Position.X := bX;
  LangImage.Position.Y := sT;
  LangImage.Width      := bW;
  LangImage.Height     := bH;

  sT := sT + bH + sA;

  LangEnImage.Position.X := bX;
  LangEnImage.Position.Y := sT;
  LangEnImage.Width      := bW;
  LangEnImage.Height     := bH;

  sT := sT + bH + sA;

  LangTrImage.Position.X := bX;
  LangTrImage.Position.Y := sT;
  LangTrImage.Width      := bW;
  LangTrImage.Height     := bH;

  sT := sT + bH + sA;

  LangBackImage.Position.X := bX;
  LangBackImage.Position.Y := sT;
  LangBackImage.Width      := bW;
  LangBackImage.Height     := bH;

  SetLanguageScreenLang;
End;

procedure TEzerionForm.SetLanguageScreenLang;
Begin
  LangImage.Bitmap.LoadFromFile(FormatToDevice('menu_lang_1_' + Game.Lang + '.png',qtImage, guNone));
  LangTrImage.Bitmap.LoadFromFile(FormatToDevice('menu_lang_2_' + Game.Lang + '.png',qtImage, guNone));
  LangEnImage.Bitmap.LoadFromFile(FormatToDevice('menu_lang_3_' + Game.Lang + '.png',qtImage, guNone));
  LangBackImage.Bitmap.LoadFromFile(FormatToDevice('menu_lang_4_' + Game.Lang + '.png',qtImage, guNone));
End;

procedure TEzerionForm.SetStartScreenLang;
Var
  sB, sO, sY  : Byte;
Begin
  s1Image.Bitmap.LoadFromFile(FormatToDevice('play.png',qtImage, guNone));
  sUserInfoImage.Bitmap.LoadFromFile(FormatToDevice('user_info.png',qtImage, guNone));
  sUserFlagImage.Bitmap.LoadFromFile(FormatToDevice('user_flag.png' ,qtImage, guNone));
  sUFlagImage.Bitmap.LoadFromFile(FormatToDevice('flags/' + Game.Flag ,qtImage, guNone));
  UsernameText.Text   := Game.UserName;
  sm1Image.Bitmap.LoadFromFile(FormatToDevice('instagram.png',qtImage, guNone));
  sm2Image.Bitmap.LoadFromFile(FormatToDevice('twitter.png',qtImage, guNone));
  sm3Image.Bitmap.LoadFromFile(FormatToDevice('facebook.png',qtImage, guNone));
  sm4Image.Bitmap.LoadFromFile(FormatToDevice('linkedin.png',qtImage, guNone));
  SSettingImage.Bitmap.LoadFromFile(FormatToDevice('button_settings.png',qtImage, guNone));
  MaplistImage.Bitmap.LoadFromFile(FormatToDevice('button_list.png',qtImage, guNone));
  HelpImage.Bitmap.LoadFromFile(FormatToDevice('button_help.png',qtImage, guNone));
  InfoImage.Bitmap.LoadFromFile(FormatToDevice('button_info.png',qtImage, guNone));

  sHImage.Bitmap.LoadFromFile(FormatToDevice('heart.png',qtImage, guNone));
  sXImage.Bitmap.LoadFromFile(FormatToDevice('zx.png',qtImage, guNone));
  sLImage.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(Game.GameLife) + '.png',qtImage, guNone));
  case Game.MaxLevel of
    0..9     : Begin
                 sS1Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(Game.MaxLevel) + '.png',qtImage, guNone));
                 sS2Image.Visible := False;
                 sS3Image.Visible := False;
               End;
    10..99   : Begin
                 sB := Game.MaxLevel Mod 10;
                 sO := Game.MaxLevel Div 10;
                 sS2Image.Visible := True;
                 sS3Image.Visible := False;
                 sS1Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(sB) + '.png',qtImage, guNone));
                 sS2Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(sO) + '.png',qtImage, guNone));
               End;
    100..999 : Begin
                 sY := Game.MaxLevel Div 100;
                 sO := (Game.MaxLevel Div 10) Mod 10;
                 sB := Game.MaxLevel Mod 10;
                 sS2Image.Visible := True;
                 sS3Image.Visible := True;
                 sS1Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(sB) + '.png',qtImage, guNone));
                 sS2Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(sO) + '.png',qtImage, guNone));
                 sS3Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(sY) + '.png',qtImage, guNone));
               End;
  end;
  if Game.Lang = 'tr' then
    EzerionAppRater.Question := 'Bu oyunu sevdiyseniz, onu deðerlendirmek için bir dakikanýzý ayýrýr mýsýnýz? Hayýr''ý seçerseniz, sizi tekrar rahatsýz etmeyiz.'
  Else
    EzerionAppRater.Question := 'If you enjoy playing this game, would you mind taking a moment to rate it? If you choose No, we won''t bug you again.'
End;

procedure TEzerionForm.SetGameScreen(bT:Integer);
Begin
  GExitImage.Position.X := GameBackgroundImage.Width - 45;
  GExitImage.Position.Y := bT - 32;
  GExitImage.Bitmap.LoadFromFile(FormatToDevice('button_exit.png',qtImage, guNone));

  PauseImage.Position.X := GameBackgroundImage.Width - 80;
  PauseImage.Position.Y := bT - 32;
  PauseImage.Bitmap.LoadFromFile(FormatToDevice('button_pause.png',qtImage, guNone));

  GSettingImage.Position.X := GameBackgroundImage.Width - 115;
  GSettingImage.Position.Y := bT - 32;
  GSettingImage.Bitmap.LoadFromFile(FormatToDevice('button_settings.png',qtImage, guNone));

  L1Image.Position.X := GameBackgroundImage.Width - 139;
  L1Image.Position.Y := bT - 32;

  L2Image.Position.X := GameBackgroundImage.Width - 153;
  L2Image.Position.Y := bT - 32;

  L3Image.Position.X := GameBackgroundImage.Width - 167;
  L3Image.Position.Y := bT - 32;

  Heart1Image.Position.X  := 10;
  Heart1Image.Position.Y  := bT - 29;
  Heart1Image.Bitmap.LoadFromFile(FormatToDevice('z' + IntToStr(Game.GameLife) + '.png',qtImage, guNone));

  Heart2Image.Position.X  := 26;
  Heart2Image.Position.Y  := bT - 29;
  Heart2Image.Bitmap.LoadFromFile(FormatToDevice('zx.png',qtImage, guNone));

  Heart3Image.Position.X  := 42;
  Heart3Image.Position.Y  := bT - 29;
  Heart3Image.Bitmap.LoadFromFile(FormatToDevice('heart.png',qtImage, guNone));

  score1Image.Position.X  := 90;
  score1Image.Position.Y  := bT - 29;
  score1Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  score2Image.Position.X  := 103;
  score2Image.Position.Y  := bT - 29;
  score2Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  score3Image.Position.X  := 116;
  score3Image.Position.Y  := bT - 29;
  score3Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  score4Image.Position.X  := 129;
  score4Image.Position.Y  := bT - 29;
  score4Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  score5Image.Position.X  := 142;
  score5Image.Position.Y  := bT - 29;
  score5Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  score6Image.Position.X  := 155;
  score6Image.Position.Y  := bT - 29;
  score6Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  score7Image.Position.X  := 168;
  score7Image.Position.Y  := bT - 29;
  score7Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  score8Image.Position.X  := 181;
  score8Image.Position.Y  := bT - 29;
  score8Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  score9Image.Position.X  := 194;
  score9Image.Position.Y  := bT - 29;
  score9Image.Bitmap.LoadFromFile(FormatToDevice('z0.png',qtImage, guNone));

  OldPoint := '000000000';

  HandImage.Visible    := False;
  HandImage.Height     := GameBackgroundImage.Height / 6;
  HandImage.Width      := HandImage.Height * 110 / 210;
  HandImage.Position.X := 0;
  HandImage.Position.Y := GameBackgroundImage.Height / 2;
End;

procedure TEzerionForm.SetStartScreen;
Var
  hH, hW,
  iT  : Extended;

  sH, iH, smH, tH, tW,
  sA, sW, bW, bH, bX, iW, iK        : Integer;
Begin
  StartBackgroundImage.Bitmap.LoadFromFile(FormatToDevice('menu_back.jpg',qtImage, guNone));

  sH := Trunc(StartBackgroundImage.Height);
  sW := Trunc(StartBackgroundImage.Width);


  iW := Trunc((sW - 40) / 4.1);
  iH := iW;

  sUserFlagImage.Position.X     := 20;
  sUserFlagImage.Position.Y     := 20;
  sUserFlagImage.Width          := iW;
  sUserFlagImage.Height         := iW;

  sUFlagImage.Height            := sUserFlagImage.Height * 0.6;
  sUFlagImage.Width             := sUserFlagImage.Height * 0.6;
  sUFlagImage.Position.X        := sUserFlagImage.Height * 0.2;
  sUFlagImage.Position.Y        := sUserFlagImage.Height * 0.2;

  sUserInfoImage.Position.X     := 20 + (iW * 1.1);
  sUserInfoImage.Position.Y     := 20;
  sUserInfoImage.Width          := (iW * 3);
  sUserInfoImage.Height         := iW;

  iT := iW / 20;

  UsernameText.Position.X   := iT * 6;
  UsernameText.Position.Y   := iT * 4;
  UsernameText.Height       := iT * 5;
  UsernameText.Width        := iT * 48;

  hH := iT * 5;
  hW := (hH * 76) / 135;

  sHImage.Width             := hH;
  sHImage.Height            := hH;
  sHImage.Position.X        := iT * 6;
  sHImage.Position.Y        := iT * 11;

  sXImage.Width             := hW;
  sXImage.Height            := hH;
  sXImage.Position.X        := iT * 13;
  sXImage.Position.Y        := iT * 11;

  sLImage.Width             := hW;
  sLImage.Height            := hH;
  sLImage.Position.X        := iT * 18;
  sLImage.Position.Y        := iT * 11;

  hW := (hH * 76) / 135;

  sS1Image.Width             := hW;
  sS1Image.Height            := hH;
  sS1Image.Position.X        := (iT * 54) - hW;
  sS1Image.Position.Y        := iT * 11;

  If Game.MaxLevel > 9 Then
  Begin
    sS2Image.Width             := hW;
    sS2Image.Height            := hH;
    sS2Image.Position.X        := (iT * 54) - ((hW * 1.1) * 2);
    sS2Image.Position.Y        := iT * 11;
    If Game.MaxLevel > 99 Then
    Begin
      sS3Image.Width             := hW;
      sS3Image.Height            := hH;
      sS3Image.Position.X        := (iT * 54) - ((hW * 1.1) * 3);
      sS3Image.Position.Y        := iT * 11;
    End;
  End;


  smH := (sW - 40) div 7;

  MapListImage.Width        := smH;
  MapListImage.Height       := smH;
  MapListImage.Position.X   := 20;
  MapListImage.Position.Y   := 20 + iW + 40;

  SSettingImage.Width       := smH;
  SSettingImage.Height      := smH;
  SSettingImage.Position.X  := 20 + (smH * 2);
  SSettingImage.Position.Y  := 20 + iW + 40;;

  InfoImage.Width           := smH;
  InfoImage.Height          := smH;
  InfoImage.Position.X      := 20 + (smH * 4);
  InfoImage.Position.Y      := 20 + iW + 40;

  HelpImage.Width           := smH;
  HelpImage.Height          := smH;
  HelpImage.Position.X      := 20 + (smH * 6);
  HelpImage.Position.Y      := 20 + iW + 40;

  tW := Trunc(sW * 0.7);
  iT := 60 + iW + smH + (((sH - (60 + iW + (3 * smH)))-tW) Div 2);

  s1Image.Position.X    := (sW - iW) div 2;
  s1Image.Position.Y    := iT;
  s1Image.Width         := tW;
  s1Image.Height        := tW;

  s1WidthFloatAnimation.StartValue  := tW;
  s1WidthFloatAnimation.StopValue   := tW + 30;

  s1HeightFloatAnimation.StartValue := tW;
  s1HeightFloatAnimation.StopValue  := tW + 30;

  s1XFloatAnimation.StartValue      := (sW - tW) div 2;
  s1XFloatAnimation.StopValue       := ((sW - tW) div 2) - 15;

  s1YFloatAnimation.StartValue      := iT;
  s1YFloatAnimation.StopValue       := iT - 15;

  s1WidthFloatAnimation.Enabled     := True;
  s1HeightFloatAnimation.Enabled    := True;
  s1XFloatAnimation.Enabled         := True;
  s1YFloatAnimation.Enabled         := True;

  iT  := StartBackgroundImage.Height - (2 * smH);

  sm1Image.Position.X    := 20;
  sm1Image.Position.Y    := iT;
  sm1Image.Width         := smH;
  sm1Image.Height        := smH;

  sm2Image.Position.X    := 20 + (smH * 2);
  sm2Image.Position.Y    := iT;
  sm2Image.Width         := smH;
  sm2Image.Height        := smH;

  sm3Image.Position.X    := 20 + (smH * 4);
  sm3Image.Position.Y    := iT;
  sm3Image.Width         := smH;
  sm3Image.Height        := smH;

  sm4Image.Position.X    := 20 + (smH * 6);
  sm4Image.Position.Y    := iT;
  sm4Image.Width         := smH;
  sm4Image.Height        := smH;

  SetStartScreenLang;
End;

procedure TEzerionForm.SetSoundScreen;
Var
  sH, sT, sA, sW, bW, bH, bX        : Extended;
Begin
  //Sound Screen
  SoundBackgroundImage.Bitmap.LoadFromFile(FormatToDevice('menu_back.jpg',qtImage, guNone));
  sH := SoundBackgroundImage.Height;
  sW := SoundBackgroundImage.Width;

  bW := sW * 0.7;
  bH := bW / 4;
  bX := sW * 0.15;

  sA := (sH - (bH * 6)) / 7;
  sT := sA;

  SoundTitleImage.Position.X        := bX;
  SoundTitleImage.Position.Y        := sT;
  SoundTitleImage.Width             := bW;
  SoundTitleImage.Height            := bH;

  sT := sT + bH + sA;

  SoundSoundImage.Position.X        := bX;
  SoundSoundImage.Position.Y        := sT;
  SoundSoundImage.Width             := bW;
  SoundSoundImage.Height            := bH;

  sT := sT + bH + sA;

  SoundSoundVolumeImage.Position.X  := bX;
  SoundSoundVolumeImage.Position.Y  := sT;
  SoundSoundVolumeImage.Width       := bW;
  SoundSoundVolumeImage.Height      := bH;


  SoundTrackBar.Position.X          := (sW - (bW * 0.85)) / 2;
  SoundTrackBar.Position.Y          := sT + (bH / 3);
  SoundTrackBar.Width               := Trunc(bW * 0.85);
  SoundTrackBar.Value               := Trunc(Game.SoundVolume * 10);
  SoundTrackBar.Height              := bH / 3;

  sT := sT + bH + sA;

  SoundMusicImage.Position.X        := bX;
  SoundMusicImage.Position.Y        := sT;
  SoundMusicImage.Width             := bW;
  SoundMusicImage.Height            := bH;

  sT := sT + bH + sA;

  SoundMusicVolumeImage.Position.X  := bX;
  SoundMusicVolumeImage.Position.Y  := sT;
  SoundMusicVolumeImage.Width       := bW;
  SoundMusicVolumeImage.Height      := bH;

  MusicTrackBar.Position.X          := (sW - (bW * 0.85)) / 2;
  MusicTrackBar.Position.Y          := sT + (bH / 3);
  MusicTrackBar.Width               := Trunc(bW * 0.85);
  MusicTrackBar.Value               := Trunc(Game.MusicVolume * 10);
  MusicTrackBar.Height              := bH / 3;

  sT := sT + bH + sA;

  SoundBackImage.Position.X         := bX;
  SoundBackImage.Position.Y         := sT;
  SoundBackImage.Width              := bW;
  SoundBackImage.Height             := bH;

  SetSoundScreenLang;
End;

procedure TEzerionForm.SetUserNameScreen;
Var
  sH, sA, sW, iH, iW        : Double;
Begin
  //Sound Screen
  UserNameBackgroundImage.Bitmap.LoadFromFile(FormatToDevice('back.png',qtImage, Game.Universe));
  sH := UserNameBackgroundImage.Height;
  sW := UserNameBackgroundImage.Width;

  iW := sW - 40;
  iH := (iW * 2004) / 1515;

  sA := Trunc(iH) div 20;

  UserNameMenuImage.Width      := iW;
  UserNameMenuImage.Height     := iH;
  UserNameMenuImage.Position.X := 20;
  UserNameMenuImage.Position.Y := (sH - iH) / 2;

  UserNameEdit.Height          := sA;
  UserNameEdit.Width           := sA * 10;
  UserNameEdit.Position.X      := (iW - (sA * 10)) / 2;
  UserNameEdit.Position.Y      := sA * 3;

  BirthYearComboBox.Height     := sA;
  BirthYearComboBox.Width      := sA * 4;
  BirthYearComboBox.ItemIndex  := -1;
  BirthYearComboBox.Position.X := (iW - (sA * 4)) / 2;
  BirthYearComboBox.Position.Y := sA * 7;

  GenderComboBox.Height        := sA;
  GenderComboBox.Width         := sA * 6;
  GenderComboBox.ItemIndex     := -1;
  GenderComboBox.Position.X    := (iW - (sA * 6)) / 2;
  GenderComboBox.Position.Y    := sA * 11;

  CountryComboBox.Height       := sA;
  CountryComboBox.Width        := sA * 10;
  CountryComboBox.ItemIndex    := -1;
  CountryComboBox.Position.X   := (iW - (sA * 10)) / 2;
  CountryComboBox.Position.Y   := sA * 15;

  UserNameOkImage.Height       := sA * 2;
  UserNameOkImage.Width        := (sA * 2 * 500) / 200;
  UserNameOkImage.Position.X   := (iW - UserNameOkImage.Width) / 2;
  UserNameOkImage.Position.Y   := sA * 17;

  SetUserNameScreenLang;

  UserNameEdit.Text := Game.UserName;
  case Game.Gender of
    ' ' : GenderComboBox.ItemIndex := -1;
    '0' : GenderComboBox.ItemIndex := 0;
    '1' : GenderComboBox.ItemIndex := 1;
    '2' : GenderComboBox.ItemIndex := 2;
  end;
  if Game.BirthYear > 0 then
    BirthYearComboBox.ItemIndex := BirthYearComboBox.Items.IndexOf(IntToStr(Game.BirthYear))
  Else
    BirthYearComboBox.ItemIndex := -1;
  if Game.Flag <> '' then
    CountryComboBox.ItemIndex := CountryComboBox.Items.IndexOf(GetCountryFromFlag(Game.Flag));
End;

procedure TEzerionForm.SetWebScreen;
Var
  sH, sW, bW, bH        : Double;
Begin
  sH := BackRectangle.Height;
  sW := BackRectangle.Width;

  WebBackImage.Height := sH * 0.8;
  WebBackImage.Width  := WebBackImage.Height * 4;

  WebBackImage.Position.X  := (sW - WebBackImage.Width)/2 ;
  WebBackImage.Position.Y  := (sH - WebBackImage.Height)/2 ;

  SetWebScreenLang;
End;


procedure TEzerionForm.SetWebScreenLang;
Begin
  WebBackImage.Bitmap.LoadFromFile(FormatToDevice('menu_settings_5_'+ Game.Lang +'.png',qtImage, guNone));
End;

procedure TEzerionForm.SetADSScreenLang;
Begin
  ADSMessageImage.Bitmap.LoadFromFile(FormatToDevice('mess_lives_'+ Game.Lang +'.png',qtImage, guNone));
  AdsViewImage.Bitmap.LoadFromFile(FormatToDevice('mess_lives_wad_'+ Game.Lang +'.png',qtImage, guNone));
  ADSMenuImage.Bitmap.LoadFromFile(FormatToDevice('mess_lives_wm_'+ Game.Lang +'.png',qtImage, guNone));
End;

procedure TEzerionForm.SetADSScreen;
Var
  sH, sA, sW, iW, iH        : Double;
Begin
  //Sound Screen
  ADSBackgroundImage.Bitmap.LoadFromFile(FormatToDevice('back.png',qtImage, Game.Universe));
  sH := ADSBackgroundImage.Height;
  sW := ADSBackgroundImage.Width;

  iW := sW - 40;
  iH := (iW * 2004) / 1515;

  sA := Trunc(iH) div 20;

  ADSMessageImage.Width      := iW;
  ADSMessageImage.Height     := iH;
  ADSMessageImage.Position.X := 20;
  ADSMessageImage.Position.Y := (sH - iH) / 2;

  AdsViewImage.Height        := sA * 2;
  AdsViewImage.Width         := sA * 6;
  AdsViewImage.Position.X    := sA * 1;
  AdsViewImage.Position.Y    := sA * 2;

  ADSMenuImage.Height        := sA * 2;
  ADSMenuImage.Width         := sA * 6;
  ADSMenuImage.Position.X    := sA * 8;
  ADSMenuImage.Position.Y    := sA * 16;

  SetADSScreenLang;
End;

procedure TEzerionForm.SetSavedLevelScreenLang;
Begin
  SavedLevelMenuImage.Bitmap.LoadFromFile(FormatToDevice('mess_saved_game_'+ Game.Lang +'.png',qtImage, guNone));
  SavedLevelYesImage.Bitmap.LoadFromFile(FormatToDevice('mess_yes_'+ Game.Lang +'.png',qtImage, guNone));
  SavedLevelNoImage.Bitmap.LoadFromFile(FormatToDevice('mess_no_'+ Game.Lang +'.png',qtImage, guNone));
End;

procedure TEzerionForm.SetSavedLevelScreen;
Var
  sH, sA, sW, iW, iH        : Double;
Begin
  //Sound Screen
  SavedLevelBackgroundImage.Bitmap.LoadFromFile(FormatToDevice('back.png',qtImage, Game.Universe));
  sH := SavedLevelBackgroundImage.Height;
  sW := SavedLevelBackgroundImage.Width;

  iW := sW - 40;
  iH := (iW * 2004) / 1515;

  sA := Trunc(iH) div 20;

  SavedLevelMenuImage.Width      := iW;
  SavedLevelMenuImage.Height     := iH;
  SavedLevelMenuImage.Position.X := 20;
  SavedLevelMenuImage.Position.Y := (sH - iH) / 2;

  SavedLevelYesImage.Height        := sA * 2;
  SavedLevelYesImage.Width         := sA * 6;
  SavedLevelYesImage.Position.X    := sA * 1;
  SavedLevelYesImage.Position.Y    := sA * 16;

  SavedLevelNoImage.Height        := sA * 2;
  SavedLevelNoImage.Width         := sA * 6;
  SavedLevelNoImage.Position.X    := sA * 8;
  SavedLevelNoImage.Position.Y    := sA * 16;

  SetSavedLevelScreenLang;
End;

procedure TEzerionForm.SetPauseScreenLang;
Begin
  PauseMenuImage.Bitmap.LoadFromFile(FormatToDevice('mess_pause_'+ Game.Lang +'.png',qtImage, guNone));
  PauseMainMenuImage.Bitmap.LoadFromFile(FormatToDevice('mess_lives_wm_'+ Game.Lang +'.png',qtImage, guNone));
  PauseContinueImage.Bitmap.LoadFromFile(FormatToDevice('mess_continue_'+ Game.Lang +'.png',qtImage, guNone));
End;

procedure TEzerionForm.SetPauseScreen;
Var
  sH, sA, sW, iW, iH        : Double;
Begin
  //Pause Screen
  PauseBackgroundImage.Bitmap.LoadFromFile(FormatToDevice('back.png',qtImage, Game.Universe));
  sH := PauseBackgroundImage.Height;
  sW := PauseBackgroundImage.Width;

  iW := sW - 40;
  iH := (iW * 2004) / 1515;

  sA := Trunc(iH) div 20;

  PauseMenuImage.Width      := iW;
  PauseMenuImage.Height     := iH;
  PauseMenuImage.Position.X := 20;
  PauseMenuImage.Position.Y := (sH - iH) / 2;

  PauseMainMenuImage.Height        := sA * 2;
  PauseMainMenuImage.Width         := sA * 6;
  PauseMainMenuImage.Position.X    := sA * 1;
  PauseMainMenuImage.Position.Y    := sA * 16;

  PauseContinueImage.Height        := sA * 2;
  PauseContinueImage.Width         := sA * 6;
  PauseContinueImage.Position.X    := sA * 8;
  PauseContinueImage.Position.Y    := sA * 16;

  SetPauseScreenLang;
End;

Function TEzerionForm.GetFlagFromCountry(Country:String):String;
Var
  ComboQuery : TUniQuery;
  FieldName  : String;
Begin
  Try
    Result := '';
    FieldName := Game.Lang + '_name';
    ComboQuery            := TUniQuery.Create(nil);
    ComboQuery.Connection := DataForm.GameConnection;
    ComboQuery.SQL.Add('SELECT file_name FROM country');
    ComboQuery.SQL.Add('WHERE ' + FieldName + ' = :FCOUNTRY');
    ComboQuery.ParamByName('FCOUNTRY').AsString  := Country;
    ComboQuery.Open;
    if ComboQuery.RecordCount > 0 then
    Begin
      Result := ComboQuery.FieldByName('file_name').AsString;
    End;
    ComboQuery.Close;
    ComboQuery.Free;
  Except

  End;
End;

Function TEzerionForm.GetCountryFromFlag(Flag:String):String;
Var
  ComboQuery : TUniQuery;
  FieldName  : String;
Begin
  Try
    Result := '';
    FieldName := Game.Lang + '_name';
    ComboQuery            := TUniQuery.Create(nil);
    ComboQuery.Connection := DataForm.GameConnection;
    ComboQuery.SQL.Add('SELECT ' + FieldName + ' FROM country');
    ComboQuery.SQL.Add('WHERE file_name = :FFLAG');
    ComboQuery.ParamByName('FFLAG').AsString  := Flag;
    ComboQuery.Open;
    if ComboQuery.RecordCount > 0 then
    Begin
      Result := ComboQuery.FieldByName(FieldName).AsString;
    End;
    ComboQuery.Close;
    ComboQuery.Free;
  Except

  End;
End;

Function  TEzerionForm.GetSavedLevelMatrix:String;
Var
  LevelQuery : TUniQuery;
Begin
  Try
    Result := '';
    LevelQuery            := TUniQuery.Create(nil);
    LevelQuery.Connection := DataForm.GameConnection;
    LevelQuery.SQL.Add('SELECT matrix_value FROM saved_level');
    LevelQuery.Open;
    if LevelQuery.RecordCount > 0 then
    Begin
      Result := LevelQuery.FieldByName('matrix_value').AsString;
    End;
    LevelQuery.Close;
    LevelQuery.Free;
  Except

  End;
End;

Procedure TEzerionForm.ClearSavedLevel;
Var
  LevelQuery : TUniQuery;
Begin
  Try
    LevelQuery            := TUniQuery.Create(nil);
    LevelQuery.Connection := DataForm.GameConnection;
    LevelQuery.SQL.Add('DELETE FROM saved_level');
    LevelQuery.ExecSQL;
    LevelQuery.Free;
  Except

  End;
End;


Function  TEzerionForm.GetSavedLevelId:Integer;
Var
  LevelQuery : TUniQuery;
Begin
  Try
    Result := 0;
    LevelQuery            := TUniQuery.Create(nil);
    LevelQuery.Connection := DataForm.GameConnection;
    LevelQuery.SQL.Add('SELECT id FROM saved_level');
    LevelQuery.Open;
    if LevelQuery.RecordCount > 0 then
    Begin
      Result := LevelQuery.FieldByName('id').AsInteger;
    End;
    LevelQuery.Close;
    LevelQuery.Free;
  Except

  End;
End;

Function  TEzerionForm.GetVersion:String;
Var
  VersionQuery : TUniQuery;
Begin
  Try
    Result := '';
    VersionQuery            := TUniQuery.Create(nil);
    VersionQuery.Connection := DataForm.GameConnection;
    VersionQuery.SQL.Add('SELECT version FROM ezcon');
    VersionQuery.Open;
    if VersionQuery.RecordCount > 0 then
    Begin
      Result := VersionQuery.FieldByName('version').AsString;
    End;
    VersionQuery.Close;
    VersionQuery.Free;
  Except

  End;
End;

Procedure TEzerionForm.SetVersion(Version:String);
Var
  VersionQuery : TUniQuery;
Begin
  Try
    VersionQuery            := TUniQuery.Create(nil);
    VersionQuery.Connection := DataForm.GameConnection;
    VersionQuery.SQL.Add('UPDATE ezcon SET version = ''' + Version + '''');
    VersionQuery.ExecSQL;
    VersionQuery.Free;
  Except

  End;
End;

procedure TEzerionForm.FillComboBox;
Var
  ComboQuery : TUniQuery;
  FieldName  : String;
Begin
  Try
    CountryComboBox.Items.Clear;
    FieldName := Game.Lang + '_name';
    ComboQuery            := TUniQuery.Create(nil);
    ComboQuery.Connection := DataForm.GameConnection;
    ComboQuery.SQL.Add('SELECT ' + FieldName + ' FROM country');
    ComboQuery.SQL.Add('ORDER BY ' + FieldName);
    ComboQuery.Open;
    While Not ComboQuery.EOF Do
    Begin
      CountryComboBox.Items.Add(ComboQuery.FieldByName(FieldName).AsString);
      ComboQuery.Next;
    End;
    if Game.Lang = 'tr' then
      CountryComboBox.ItemIndex := CountryComboBox.Items.IndexOf('Türkiye')
    Else
      CountryComboBox.ItemIndex := 0;
    ComboQuery.Close;
    ComboQuery.Free;

    GenderComboBox.Items.Clear;
    if Game.Lang = 'tr' then
    Begin
      GenderComboBox.Items.Add('Özel');
      GenderComboBox.Items.Add('Kadýn');
      GenderComboBox.Items.Add('Erkek');
    End
    Else
    Begin
      GenderComboBox.Items.Add('Prived');
      GenderComboBox.Items.Add('Female');
      GenderComboBox.Items.Add('Male');
    End;
  Except

  End;
End;

procedure TEzerionForm.SetUserNameScreenLang;
Begin
  FillComboBox;
  UserNameMenuImage.Bitmap.LoadFromFile(FormatToDevice('mess_username_'+ Game.Lang +'.png',qtImage, guNone));
  UserNameOkImage.Bitmap.LoadFromFile(FormatToDevice('mess_ok_'+ Game.Lang +'.png',qtImage, guNone));
End;


procedure TEzerionForm.SetSoundScreenLang;
Begin
  SoundTitleImage.Bitmap.LoadFromFile(FormatToDevice('menu_sound_1_'+ Game.Lang +'.png',qtImage, guNone));
  SoundSoundImage.Bitmap.LoadFromFile(FormatToDevice('menu_sound_2_'+ Game.Lang +'.png',qtImage, guNone));
  SoundMusicImage.Bitmap.LoadFromFile(FormatToDevice('menu_sound_3_'+ Game.Lang +'.png',qtImage, guNone));
  SoundSoundVolumeImage.Bitmap.LoadFromFile(FormatToDevice('volume.png',qtImage, guNone));
  SoundMusicVolumeImage.Bitmap.LoadFromFile(FormatToDevice('volume.png',qtImage, guNone));
  SoundBackImage.Bitmap.LoadFromFile(FormatToDevice('menu_sound_4_'+ Game.Lang +'.png',qtImage, guNone));
End;

procedure TEzerionForm.SoundBackImageClick(Sender: TObject);
begin
  SaveUserGameInfo;
  GameTabControl.ActiveTab := SettingsTabItem;
end;

procedure TEzerionForm.SoundTrackBarChange(Sender: TObject);
begin
  if  SoundTrackBar.Value > 1.2 then
    Game.SoundVolume := SoundTrackBar.Value / 10
  Else
    Game.SoundVolume := 0;
end;

procedure TEzerionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if AppCanClose then
  Begin
    AnimeTimer.Enabled  := False;
    MusicTimer.Enabled  := False;
    PlayerTimer.Enabled := False;
    DisconnectDB;
    FreeAndNilLevel;
    FreeAndNilLevelSelect;
  End
  Else
    Action := TCloseAction.caNone;
end;

Function TEzerionForm.HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject):Boolean;
begin
  if Not CanBeShow then
    Exit;
    case AAppEvent of
      TApplicationEvent.aeFinishedLaunching    : ;         // Your application has been launched.
      TApplicationEvent.aeBecameActive         : ;         // Your application has gained the focus.
      TApplicationEvent.aeWillBecomeInactive   : StopMusic;         // Your application is going to loose the focus.
      TApplicationEvent.aeEnteredBackground    : ;         // The user is no longer using your application, but your application is still running in the background.
      TApplicationEvent.aeWillBecomeForeground : PlayMusic(FMusicName, (Game.ActiveLevel Mod 10) + 1);         // The user is now using your application, which was previously in the background.
      TApplicationEvent.aeWillTerminate        : ;         // The user is quitting your application.
      TApplicationEvent.aeLowMemory            : ;         // This warns your application that the device is running out of memory.
      TApplicationEvent.aeTimeChange           : ;         // There has been a significant change in time.
      TApplicationEvent.aeOpenURL              : ;         // You application has received a request to open an URL.
    end;
  Result := True;
end;

procedure TEzerionForm.HelpImageClick(Sender: TObject);
Var
  SId : Integer;
begin
  SId := GetSavedLevelId;
  if SId > 0 then
  Begin
    Game.ActiveLevel := 0;
    SavedLevelPlay(SId);
  End
  Else
  Begin
    PlayLevel(0, False)
  End;
end;

procedure TEzerionForm.InfoImageClick(Sender: TObject);
begin
  LastTabStatus := StartTabItem.Index;
  {$IFDEF ANDROID}
    SetWebBowser('file:///' + FormatToDevice('how_to_play_' + Game.Lang +'.html', qtNone, guNone));
  {$ENDIF}
  {$IFDEF IOS}
    SetWebBowser('file://' + FormatToDevice('how_to_play_' + Game.Lang +'.html', qtNone, guNone));
  {$ENDIF}
  GameTabControl.ActiveTab := WebTabItem;
end;

procedure TEzerionForm.FormCreate(Sender: TObject);
var
  aFMXApplicationEventService: IFMXApplicationEventService;
begin
  CanBeShow := False;

  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(aFMXApplicationEventService)) then
    aFMXApplicationEventService.SetApplicationEventHandler(HandleAppEvent);

  { This defines the default active tab at runtime }
  LastTabStatus := StartTabItem.Index;
  GameTabControl.TabIndex := 0;

  With Game Do
  Begin
    UserId        := 0;
    {$IFDEF DEBUG}
      ActiveLevel   := 120;
      MaxLevel      := 120;
    {$ELSE}
      ActiveLevel   := 0;
      MaxLevel      := 0;
    {$ENDIF}
    Sound         := True;
    SoundVolume   := 0.6;
    Music         := True;
    MusicVolume   := 0.4;
    Lang          := CheckCurrentLang;
    Score         := 0;
    Vibration     := True;
    EMail         := '';
    UserName      := '';
    Password      := '';
    AutoLogin     := False;
    ServerLogin   := False;
    ColorSet      := 1;
    Login         := False;
    CompState     := 1;
    LevelPage     := 1;
    UserCount     := 2;
    GameLife      := 5;
    Universe      := guWater;
    Flag          := '';
    BirthYear     := 0;
    Gender        := ' ';
  End;

  AdsLevel := 0;

  GameTabControl.ActiveTab := StartTabItem;

  Randomize;

  case Game.ColorSet of
    1 : Begin
          pC[1] := 'g'; // Green
          pC[2] := 'r'; // Red
          pC[3] := 's'; // Yellow
          pC[4] := 'm'; // Blue
          pC[5] := 'b'; // Brown
          pC[6] := 'n'; // Pink
        End;
  end;

  CanBeShow    := True;
  AppCanClose  := False;

end;

procedure TEzerionForm.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    ExitFromScreen(etBack);
    Key := 0;
  end
end;

procedure TEzerionForm.CheckVersion;
Var
  Version      : String;
  UpdateQuery  : TUniQuery;
Begin
  Version := GetVersion;
  if Version = '0.1.0' then
  Begin
    Try
      UpdateQuery            := TUniQuery.Create(nil);
      UpdateQuery.Connection := DataForm.GameConnection;
      UpdateQuery.SQL.Add('CREATE TABLE saved_level(');
      UpdateQuery.SQL.Add('id INTEGER PRIMARY KEY,');
      UpdateQuery.SQL.Add('matrix_value TEXT)');
      UpdateQuery.ExecSQL;

      UpdateQuery.SQL.Clear;
      UpdateQuery.SQL.Add('ALTER TABLE user');
      UpdateQuery.SQL.Add('ADD COLUMN gender VARCHAR2(1)');
      UpdateQuery.ExecSQL;

      UpdateQuery.SQL.Clear;
      UpdateQuery.SQL.Add('ALTER TABLE user');
      UpdateQuery.SQL.Add('ADD COLUMN birth_year INTEGER');
      UpdateQuery.ExecSQL;

      AddNewLevel;
    Except

    End;
    SetVersion('0.1.2');
  End;
  if Version = '0.1.1' then
  Begin
    Try
      UpdateQuery            := TUniQuery.Create(nil);
      UpdateQuery.Connection := DataForm.GameConnection;
      UpdateQuery.SQL.Add('DELETE FROM level');
      UpdateQuery.SQL.Add('WHERE id > 80');
      UpdateQuery.ExecSQL;

      AddNewLevel;
    Except

    End;
    SetVersion('0.1.2');
  End;
End;

procedure TEzerionForm.FormShow(Sender: TObject);
Var
  Age     : Integer;
  Gender  : TJVEAdMobGender;
begin
  EzerionForm.ConnectDB(FormatToDevice('ezerion.db', qtDB, guNone));
  CheckVersion;

  If Not LoadUserGameInfo Then
  Begin
    SetUserNameScreen;
    GameTabControl.ActiveTab := UserNameTabItem;
  End
  Else
  Begin
    SetStartScreen;
    SetSettingScreen;
    SetLanguageScreen;
    SetSoundScreen;
    SetWebScreen;

    SettingBackGroundImage.Opacity    := 0.85;
    LangBackgroundImage.Opacity       := 0.85;
    StartBackgroundImage.Opacity      := 0.85;
    LevelBackgroundImage.Opacity      := 0.85;
    SoundBackgroundImage.Opacity      := 0.85;
    GameBackgroundImage.Opacity       := 0.65;
    UserNameBackgroundImage.Opacity   := 0.85;
    ADSBackgroundImage.Opacity        := 0.85;
    SavedLevelBackgroundImage.Opacity := 0.85;
  End;

  p1Image.Bitmap.LoadFromFile(FormatToDevice(pC[1] + '.png', qtImage, guNone));
  p2Image.Bitmap.LoadFromFile(FormatToDevice(pC[2] + '.png', qtImage, guNone));
  p3Image.Bitmap.LoadFromFile(FormatToDevice(pC[3] + '.png', qtImage, guNone));
  p4Image.Bitmap.LoadFromFile(FormatToDevice(pC[4] + '.png', qtImage, guNone));
  p5Image.Bitmap.LoadFromFile(FormatToDevice(pC[5] + '.png', qtImage, guNone));
  p6Image.Bitmap.LoadFromFile(FormatToDevice(pC[6] + '.png', qtImage, guNone));


  WriteLog(EZ_LOGIN);

  {$IFDEF IOS}
  JVERequestTrackingAuthorization;
  {$ENDIF}
end;

Procedure TEzerionForm.IncPlayerPoint(P, Point:Integer);
Begin
  if P = 2 then
  Begin
    Game.Score := Game.Score + Point;
  End;
End;

procedure TEzerionForm.ADSMenuImageClick(Sender: TObject);
begin
  ShowStartScreen;
end;

procedure TEzerionForm.AdsViewImageClick(Sender: TObject);
begin
  EzerionRewardAd.Show;
end;

procedure TEzerionForm.AnimationEndTimerTimer(Sender: TObject);
begin
  If AnimeRun >= AnimeMax Then
  Begin
    AnimationEndTimer.Enabled := False;
    AnimeTimer.Enabled  := False;
    StopMusic;
    ShowWinLose;
  End;
end;

procedure TEzerionForm.AnimeTimerTimer(Sender: TObject);
begin
  AnimeTimer.Enabled  := False;
  if AnimeRun < AnimeMax then
  Begin
    AnimeInProgress := True;
    Inc(AnimeRun);
    With AnimeQueue[AnimeRun] Do
      ReImageFrame(OldFrame, Level.Frame[X][Y], X, Y, Sound);
    AnimeTimer.Enabled  := True;
    AnimeInProgress := False;

    if (AnimeQueue[AnimeRun].WinLose > 0) And (Not AnimationEndTimer.Enabled) then
    Begin
      Winner := AnimeQueue[AnimeRun].WinLose;
      PlayerTimer.Enabled := False;
      AnimationEndTimer.Enabled := True;
      Exit;
    End;
  End
  Else
  Begin
    GoToNextPlayer;
  End;
end;

procedure TEzerionForm.AsagiKaydirExecute(Sender: TObject);
begin
  UpArrowImageClick(Sender);
end;

procedure TEzerionForm.AvatarXFloatAnimationFinish(Sender: TObject);
begin
  AvatarXFloatAnimation.Enabled := False;
  AvatarYFloatAnimation.Enabled := False;
  PlayLevel(Game.ActiveLevel, False);
end;

Procedure TEzerionForm.GoToNextPlayer;
Begin
  FillChar(AnimeQueue, SizeOf(AnimeQueueType),0);
  AnimeInProgress := False;
  AnimeMax := 0;
  AnimeRun := 0;
  PlayerTimer.Interval := 130;
  PlayerTimer.Enabled := True;
  Inc(MoveCount);
End;

Procedure TEzerionForm.AddAnimeQueue(OldFrame, NewFrame:FrameType; X, Y, P, WL : Integer; Sound:SoundType);
Begin
  if NewFrame.FType < 100 then
  Begin
    if AnimeMax >= 500 then
      Exit;
    Inc(AnimeMax);
    AnimeQueue[AnimeMax].OldFrame := OldFrame;
    AnimeQueue[AnimeMax].NewFrame := NewFrame;
    AnimeQueue[AnimeMax].X        := X;
    AnimeQueue[AnimeMax].Y        := Y;
    AnimeQueue[AnimeMax].Sound    := Sound;
    AnimeQueue[AnimeMax].Player   := P;
    AnimeQueue[AnimeMax].WinLose  := WL;
    AnimeTimer.Enabled            := True;
  End;
End;

Function TEzerionForm.InQueue(X,Y,P:Integer):Boolean;
Var
  I   : Integer;
Begin
  Result := False;
  for I := 1 to AnimeMax do
  Begin
    if (AnimeQueue[I].X = X) And (AnimeQueue[I].Y = Y) And (AnimeQueue[I].NewFrame.FType = P) then
    Begin
      Result := True;
      Exit;
    End;
  End;
End;

procedure TEzerionForm.PushTheFrame(X, Y, P :Integer;pC:Char);
Var
  tX, tY,
  kMax, WL, I      : Integer;
  OldFrame         : FrameType;
  Explode          : Boolean;

  Function FindAnotherTeleport(tI:Integer;Var aX, aY:Integer):Boolean;
  Var
    K, J  : Integer;
  Begin
    Result := False;
    for K := 1 to MaxX do
      for J := 1 to MaxY do
        if (Level.Frame[K][J].FType = 11) And (Level.Frame[K][J].Value = tI) then
          if (K <> aX) or (J <> aY) then
          Begin
            aX := K;
            aY := J;
            Result := True;
            Exit;
          End;
  End;

  Procedure PFrame(pX, pY:Integer;CheckQueue:Boolean);
  Begin
    if CheckQueue then
    Begin
      if (pX > 0) And (pY > 0) And (pX <= Level.MatrixX) And (pY <= Level.MatrixY) then
      Begin
        If Level.Frame[pX][pY].FType in [1..11] Then
          if Not InQueue(pX,pY, P) then
            PushTheFrame(pX,pY, P, pC);
      End;
    End
    Else
    Begin
      if (pX > 0) And (pY > 0) And (pX <= Level.MatrixX) And (pY <= Level.MatrixY) then
      Begin
        If Level.Frame[pX][pY].FType in [1..11] Then
          PushTheFrame(pX,pY, P, pC);
      End;
    End;
  End;

  Procedure DeactiveFrame(dX, dY:Integer);
  Var
    cName : String;
    fI    : TImage;
  Begin
    If Level.Frame[dX][dY].FType in [2..7] Then
    Begin
      OldFrame := Level.Frame[dX][dY];
      Level.Frame[dX][dY].FType := 1;
      Level.Frame[dX][dY].Value := 0;
      CalculateFrameMaxValue(dX,dY);
      AddAnimeQueue(OldFrame,Level.Frame[dX][dY],dX,dY,P, WL, stNone);

      cName := 'Frame_' + IntToStr(dX) + '_' + IntToStr(dY);
      fI := GameTabItem.FindComponent(cName) As TImage;
      if fI <> Nil then
        fI.OnClick := onFrameClick;
    End;
  End;

  Procedure ReActiveFrame(dP, dX, dY:Integer);
  Var
    cName : String;
    fI    : TImage;
  Begin
    If Level.Frame[dX][dY].FType = 8 Then
    Begin
      OldFrame := Level.Frame[dX][dY];
      Level.Frame[dX][dY].FType := dP;
      Level.Frame[dX][dY].Value := 1;
      Level.Frame[dX][dY].cCode := pC;
      CalculateFrameMaxValue(dX,dY);
      AddAnimeQueue(OldFrame,Level.Frame[dX][dY],dX,dY,P, WL, stNone);

      cName := 'Frame_' + IntToStr(dX) + '_' + IntToStr(dY);
      fI := GameTabItem.FindComponent(cName) As TImage;
      if fI <> Nil then
        fI.OnClick := onFrameClick;
    End;
  End;

Begin
  If Winner > 0 Then
    Exit;
  Explode  := False;
  OldFrame := Level.Frame[X][Y];
  WL := GetWinner;
  Case Level.Frame[X][Y].FType Of
    2,3,4,5,6,7         // Players
       : Begin
           if OldFrame.FType <> P then
             IncPlayerPoint(P,6)
           Else
             IncPlayerPoint(P,1);

           Level.Frame[X][Y].Value := Level.Frame[X][Y].Value + 1;
           Level.Frame[X][Y].FType := P;
           Level.Frame[X][Y].cCode := pC;
         End;
    1  : Begin         // Frame
           IncPlayerPoint(P,1);
           Level.Frame[X][Y].Value := 1;
           Level.Frame[X][Y].FType := P;
           Level.Frame[X][Y].cCode := pC;
         End;   
    8  : if Level.Frame[X][Y].Value < 3 then  // Walls
         Begin
           IncPlayerPoint(P,3);
           PlaySound(stBreak);
           Level.Frame[X][Y].Value := Level.Frame[X][Y].Value + 1;
           AddAnimeQueue(OldFrame,Level.Frame[X][Y],X,Y,P, WL, stBlink);
         End
         Else
         Begin
           IncPlayerPoint(P,5);
           PlaySound(stBreak);
           ReActiveFrame(P, X, Y);
         End;
    9  : Begin
           // Dynamits
           ExplodeFrame(X,Y,stBomb);
           Level.Frame[X][Y].FType := 101;  //After bombing
           kMax := Level.MatrixX;
           if Level.MatrixY > kMax then
             kMax := Level.MatrixY;
           Case Level.Frame[X][Y].Value of
             1,2,3
               : Begin
                   IncPlayerPoint(P,3);
                   // 1 Frame explode
                   PFrame(X-1,Y-1, False);
                   PFrame(X  ,Y-1, False);
                   PFrame(X+1,Y-1, False);
                   PFrame(X-1,Y  , False);
                   PFrame(X+1,Y  , False);
                   PFrame(X-1,Y+1, False);
                   PFrame(X  ,Y+1, False);
                   PFrame(X+1,Y+1, False);
                   If Level.Frame[X][Y].Value > 1 Then
                   Begin
                     // 2 Frame explode
                     IncPlayerPoint(P,3);
                     PFrame(X-2,Y-2, False);
                     PFrame(X-1,Y-2, False);
                     PFrame(X  ,Y-2, False);
                     PFrame(X+1,Y-2, False);
                     PFrame(X+2,Y-2, False);
                     PFrame(X-2,Y-1, False);
                     PFrame(X+2,Y-1, False);
                     PFrame(X-2,Y  , False);
                     PFrame(X+2,Y  , False);
                     PFrame(X-2,Y+1, False);
                     PFrame(X+2,Y+1, False);
                     PFrame(X-2,Y+2, False);
                     PFrame(X-1,Y+2, False);
                     PFrame(X  ,Y+2, False);
                     PFrame(X+1,Y+2, False);
                     PFrame(X+2,Y+2, False);
                   End;
                   If Level.Frame[X][Y].Value > 2 Then
                   Begin
                     // 3 Frame explode
                     IncPlayerPoint(P,3);
                     PFrame(X-3,Y-3, False);
                     PFrame(X-2,Y-3, False);
                     PFrame(X-1,Y-3, False);
                     PFrame(X  ,Y-3, False);
                     PFrame(X+1,Y-3, False);
                     PFrame(X+2,Y-3, False);
                     PFrame(X+3,Y-3, False);
                     PFrame(X-3,Y-2, False);
                     PFrame(X+3,Y-2, False);
                     PFrame(X-3,Y-1, False);
                     PFrame(X+3,Y-1, False);
                     PFrame(X-3,Y  , False);
                     PFrame(X+3,Y  , False);
                     PFrame(X-3,Y+1, False);
                     PFrame(X+3,Y+1, False);
                     PFrame(X-3,Y+2, False);
                     PFrame(X+3,Y+2, False);
                     PFrame(X-3,Y+3, False);
                     PFrame(X-2,Y+3, False);
                     PFrame(X-1,Y+3, False);
                     PFrame(X  ,Y+3, False);
                     PFrame(X+1,Y+3, False);
                     PFrame(X+2,Y+3, False);
                     PFrame(X+3,Y+3, False);
                   End;
                 End;
             4 : Begin
                   IncPlayerPoint(P,3);
                   for I := 1 to kMax do
                     PFrame(X-I,Y+I, False);
                 End;
             5 : Begin
                   IncPlayerPoint(P,3);
                   for I := 1 to kMax do
                     PFrame(X-I,Y-I, False);
                 End;
             6 : Begin
                   IncPlayerPoint(P,3);
                   for I := 1 to kMax do
                     PFrame(X+I,Y-I, False);
                 End;
             7 : Begin
                   IncPlayerPoint(P,3);
                   for I := 1 to kMax do
                     PFrame(X+I,Y+I, False);
                 End;
             8 : Begin
                   IncPlayerPoint(P,3);
                   for I := 1 to kMax do
                     PFrame(X-I,Y-I, False);
                   for I := 1 to kMax do
                     PFrame(X+I,Y+I, False);
                 End;
             9 : Begin
                   IncPlayerPoint(P,3);
                   for I := 1 to kMax do
                     PFrame(X-I,Y+I, False);
                   for I := 1 to kMax do
                     PFrame(X+I,Y-I, False);
                 End;
           End;
         End;
    10 : Begin
           // Mines
           IncPlayerPoint(P,-10);
           ExplodeFrame(X,Y,stBigBomb);
           DeactiveFrame(X-1,Y-1);
           DeactiveFrame(X  ,Y-1);
           DeactiveFrame(X+1,Y-1);
           DeactiveFrame(X-1,Y  );
           DeactiveFrame(X+1,Y  );
           DeactiveFrame(X-1,Y+1);
           DeactiveFrame(X  ,Y+1);
           DeactiveFrame(X+1,Y+1);
           Level.Frame[X][Y].FType := 101;  //After bombing
         End;
    11 : Begin
           //Teleport
           tX := X;
           tY := Y;
           PlaySound(stTeleport);
           if FindAnotherTeleport(Level.Frame[X][Y].Value, tX, tY) then
           Begin
             if Level.Frame[tX-1][tY].FType in [1..7] then
               PFrame(tX-1,tY  , True);
             if Level.Frame[tX][tY-1].FType in [1..7] then
               PFrame(tX  ,tY-1, True);
             if Level.Frame[tX+1][tY].FType in [1..7] then
               PFrame(tX+1,tY  , True);
             if Level.Frame[tX][tY+1].FType in [1..7] then
               PFrame(tX  ,tY+1, True);
           End;
         End;
  End;
  WL := GetWinner;
  if (Level.Frame[X][Y].FType in [2,3,4,5,6,7]) And (Not (OldFrame.FType in  [8, 10])) then
  Begin
    if Level.Frame[X][Y].Value > Level.Frame[X][Y].MaxValue then
    Begin
      Level.Frame[X][Y].Value := 1;
      Explode := True;
    End;
    if Explode then
      AddAnimeQueue(OldFrame,Level.Frame[X][Y],X,Y,P, WL, stBomb)
    Else
      AddAnimeQueue(OldFrame,Level.Frame[X][Y],X,Y,P, WL, stBlink);
    if Explode then
    Begin
      IncPlayerPoint(P,5);
      //First normal frame
      if Level.Frame[X-1][Y].FType in [1..7] then
        PFrame(X-1,Y  , True);
      if Level.Frame[X][Y-1].FType in [1..7] then
        PFrame(X  ,Y-1, True);
      if Level.Frame[X+1][Y].FType in [1..7] then
        PFrame(X+1,Y  , True);
      if Level.Frame[X][Y+1].FType in [1..7] then
        PFrame(X  ,Y+1, True);

      // next Special Frame  
      if Level.Frame[X-1][Y].FType in [8..11] then
        PFrame(X-1,Y  , True);
      if Level.Frame[X][Y-1].FType in [8..11] then
        PFrame(X  ,Y-1, True);
      if Level.Frame[X+1][Y].FType in [8..11] then
        PFrame(X+1,Y  , True);
      if Level.Frame[X][Y+1].FType in [8..11] then
        PFrame(X  ,Y+1, True);
    End;
  End;
End;

procedure TEzerionForm.onFrameClick(Sender: TObject);
Var
  sX, sY, CName : String;
  iX, iY, X     : Integer;
begin
  if (Turn <> 1) Or (InClick) then
    Exit;

  if LevelEnd then
  Begin
    Exit;
  End;
  CName := (Sender as TImage).Name;
  X := Pos('_',CName);
  Delete(CName,1,X);
  X := Pos('_',CName);
  sX := Copy(CName,1, X -1);
  Delete(CName,1,X);
  sY := CName;
  iX := MyStrToInt(sX);
  iY := MyStrToInt(sY);
  if ((Turn = 1) And (Level.Frame[iX][iY].FType = 2)) Then
  Begin
    PushTheFrame(iX, iY, 2, pC[Turn]);
    InClick := True;
  End;
end;

procedure TEzerionForm.onZeroFrameClick(Sender: TObject);
Var
  sX, sY, CName : String;
  iX, iY, X     : Integer;
begin
  if (Turn <> 1) Or (InClick) then
    Exit;

  if LevelEnd then
  Begin
    Exit;
  End;
  CName := (Sender as TImage).Name;
  X := Pos('_',CName);
  Delete(CName,1,X);
  X := Pos('_',CName);
  sX := Copy(CName,1, X -1);
  Delete(CName,1,X);
  sY := CName;
  iX := MyStrToInt(sX);
  iY := MyStrToInt(sY);
  if (ZeroLevel[ZeroMove].P1MoveX = iX) And (ZeroLevel[ZeroMove].P1MoveY = iY) then
    if ((Turn = 1) And (Level.Frame[iX][iY].FType = 2)) Then
    Begin
      ZeroXFloatAnimation.Enabled := False;
      ZeroYFloatAnimation.Enabled := False;
      HandImage.Visible           := False;
      PushTheFrame(iX, iY, 2, pC[Turn]);
      InClick := True;
      If ZeroMove < 10 Then
        Inc(ZeroMove);
      ZeroTimer.Enabled := True;
    End;
end;

Procedure TEzerionForm.ExplodeFrame(X, Y : Integer; Sound:SoundType);
Var
  fI    : TImage;
  fLA   : TBitmapListAnimation;
  Name  : String;
begin
  Name := 'Frame_' + IntToStr(X) + '_' + IntToStr(Y);
  fI := GameTabItem.FindComponent(Name) As TImage;
  if fI <> Nil then
  Begin
    Name := StringReplace(Name,'Frame','ListAnime',[]);
    fLA  := fI.FindComponent(Name) As TBitmapListAnimation;
    if fLA <> Nil then
    Begin
      fLA.Enabled  := True;
      PlaySound(Sound);
    End;
  End;
End;

procedure TEzerionForm.EzerionRewardAdAdClosed;
begin
  ShowStartScreen;
end;

procedure TEzerionForm.EzerionRewardAdNoAd(Sender: TJVEAdMobInterstitial;
  Error: string);
begin
  if Game.GameLife = 0 then
  Begin
    Inc(Game.GameLife);
    SetStartScreenLang;
    ShowStartScreen;
  End;
end;

procedure TEzerionForm.EzerionRewardAdReward(Sender: TJVEAdMobInterstitial;
  Kind: string; Amount: Double);
begin
  Game.GameLife := Game.GameLife + 3;
  SetStartScreenLang;
end;

Procedure TEzerionForm.ReImageFrame(OldFrame, NewFrame:FrameType; X, Y : Integer; Sound:SoundType);
Var
  fI       : TImage;
  fFW, fFH,
  fFX, fFY : TFloatAnimation;
  Name     : String;
  Scale    : Single;
begin
  if Not NewFrame.FType in [1..7,8,10] then
    Exit;
  Name := 'Frame_' + IntToStr(X) + '_' + IntToStr(Y);
  fI := GameTabItem.FindComponent(Name) As TImage;
  if fI <> Nil then
  Begin
    if NewFrame.FType < 100 then
    Begin
      case NewFrame.FType of
        1  : fI.Bitmap.LoadFromFile(FormatToDevice('t0.png',qtImage, Game.Universe));    //fI.Bitmap.LoadFromFile(FormatToDevice('t' + IntToStr(NewFrame.Value) + '.png',qtImage));
        2,3,4,5,6,7
           : if NewFrame.Value <> NewFrame.MaxValue then
               fI.Bitmap.LoadFromFile(FormatToDevice(NewFrame.cCode + IntToStr(NewFrame.Value) + '.png',qtImage, guNone))
             Else
               fI.Bitmap.LoadFromFile(FormatToDevice(NewFrame.cCode + IntToStr(NewFrame.Value) + 'p.png',qtImage, guNone));
        8  : fI.Bitmap.LoadFromFile(FormatToDevice('wall_' + IntToStr(NewFrame.Value) + '.png',qtImage, Game.Universe));
        10 : fI.Bitmap.LoadFromFile(FormatToDevice('mine.png',qtImage, Game.Universe));
      end;
      if Sound <> stBlink then
      Begin
        Name := StringReplace(Name,'Frame','AnimeW',[]);
        fFW := fI.FindComponent(Name) As TFloatAnimation;
        Name := StringReplace(Name,'AnimeW','AnimeH',[]);
        fFH := fI.FindComponent(Name) As TFloatAnimation;
        Name := StringReplace(Name,'AnimeH','AnimeX',[]);
        fFX := fI.FindComponent(Name) As TFloatAnimation;
        Name := StringReplace(Name,'AnimeX','AnimeY',[]);
        fFY := fI.FindComponent(Name) As TFloatAnimation;
        if (fFW <> Nil) And (fFH <> Nil) And (fFX <> Nil) And (fFY <> Nil) then
        Begin
          Scale := fI.Width * 0.2;

          fFW.StopValue    := fI.Width + (2 * Scale);
          fFH.StopValue    := fI.Width + (2 * Scale);
          fFX.StopValue    := fI.Position.X - Scale;
          fFY.StopValue    := fI.Position.Y - Scale;

          fFX.Enabled     := True;
          fFY.Enabled     := True;
          fFW.Enabled     := True;
          fFH.Enabled     := True;
        End;
        Vibration(100);
      End
      Else
      Begin
        Name := StringReplace(Name,'Frame','AnimeW',[]);
        fFW := fI.FindComponent(Name) As TFloatAnimation;
        Name := StringReplace(Name,'AnimeW','AnimeH',[]);
        fFH := fI.FindComponent(Name) As TFloatAnimation;
        Name := StringReplace(Name,'AnimeH','AnimeX',[]);
        fFX := fI.FindComponent(Name) As TFloatAnimation;
        Name := StringReplace(Name,'AnimeX','AnimeY',[]);
        fFY := fI.FindComponent(Name) As TFloatAnimation;
        if (fFW <> Nil) And (fFH <> Nil) And (fFX <> Nil) And (fFY <> Nil) then
        Begin
          Scale := fI.Width * 0.1;

          fFW.StopValue    := fI.Width + (2 * Scale);
          fFH.StopValue    := fI.Width + (2 * Scale);
          fFX.StopValue    := fI.Position.X - Scale;
          fFY.StopValue    := fI.Position.Y - Scale;

          fFX.Enabled     := True;
          fFY.Enabled     := True;
          fFW.Enabled     := True;
          fFH.Enabled     := True;
        End;
      End;
      PlaySound(Sound);
      WriteScore(Game.Score);
    End;
  End;
End;

procedure TEzerionForm.DownArrowImageClick(Sender: TObject);
begin
  if Game.LevelPage > 1 then
  Begin
    Game.LevelPage := Game.LevelPage - 1;
    FreeAndNilLevelSelect;
    PlaySound(stBlink);
    LevelScreenView;
  End;
end;

procedure TEzerionForm.UpArrowImageClick(Sender: TObject);
begin
  if Game.LevelPage < 12 then
  Begin
    Game.LevelPage := Game.LevelPage + 1;
    FreeAndNilLevelSelect;
    PlaySound(stBlink);
    LevelScreenView;
  End;
end;


procedure TEzerionForm.UserNameOkImageClick(Sender: TObject);
begin
  if UserNameEdit.Text = '' then
  Begin
    If Game.Lang = 'tr' Then
      Game.UserName := 'Oyuncu'
    Else
      Game.UserName := 'Player';
  End
  Else
    Game.UserName := UserNameEdit.Text;
  case GenderComboBox.ItemIndex of
    0 : Game.Gender := '0';
    1 : Game.Gender := '1';
    2 : Game.Gender := '2';
  end;
  game.BirthYear := 1950 + BirthYearComboBox.ItemIndex;
  Game.Flag      := GetFlagFromCountry(CountryComboBox.Items[CountryComboBox.ItemIndex]);
  SaveUserGameInfo;
  ShowStartScreen;
  EzerionAnalytics.TrackEvent('Login', 'Input', Game.Flag, 1);
end;

procedure TEzerionForm.ScoreBackImageClick(Sender: TObject);
begin
  GameTabControl.ActiveTab := SettingsTabItem;
end;

procedure TEzerionForm.SettingImageClick(Sender: TObject);
begin
  if GameTabControl.ActiveTab <> SettingsTabItem then
  Begin
    SetSettingScreenLang;
    LastTabStatus := GameTabControl.TabIndex;
    GameTabControl.ActiveTab := SettingsTabItem;
  End;
end;

Procedure TEzerionForm.ShowStartScreen;
Begin
  SetStartScreen;
  SetSettingScreen;
  SetLanguageScreen;
  SetSoundScreen;
  SetWebScreen;

  SettingBackGroundImage.Opacity  := 0.85;
  LangBackgroundImage.Opacity     := 0.85;
  StartBackgroundImage.Opacity    := 0.85;
  LevelBackgroundImage.Opacity    := 0.85;
  SoundBackgroundImage.Opacity    := 0.85;
  GameBackgroundImage.Opacity     := 0.85;
  UserNameBackgroundImage.Opacity := 0.85;

  GameTabControl.ActiveTab := StartTabItem;
End;

Procedure TEzerionForm.FillZeroArray;
Begin
  ZeroMove  := 1;
  FillChar(ZeroLevel, SizeOf(ZeroLevelType),0);
  // 1. Move
  ZeroLevel[1].P1MoveX   := 3;
  ZeroLevel[1].P1MoveY   := 4;
  ZeroLevel[1].P2MoveX   := 5;
  ZeroLevel[1].P2MoveY   := 6;
  ZeroLevel[1].TrMessage := 'Bu oyunda amaç, kendi renginizdeki zarlarla kareleri iþgal ederek rakibinizi yenmektir. Sadece kendi renginizdeki zarlara týklayabilirsiniz. Ýþaret edilen zara týklayýnýz.';
  ZeroLevel[1].EnMessage := 'The goal is to beat your opponent by conquering the squares with your dices. You can only click dices that are your color. Click on the shown dice. ';


  // 2. Move
  ZeroLevel[2].P1MoveX   := 3;
  ZeroLevel[2].P1MoveY   := 4;
  ZeroLevel[2].P2MoveX   := 5;
  ZeroLevel[2].P2MoveY   := 6;
  ZeroLevel[2].TrMessage := 'Her zar, en fazla komþu karelerinin sayýsý (alt, üst, sol, sað) kadar deðer alýr. Zar deðeri, daðýlma deðerine geldiðinde, zar noktalarýnýn rengi deðiþir. Bir daha týklandýðýnda zar komþularýna daðýlýr.';
  ZeroLevel[2].EnMessage := 'Every dice can take value up to the number of their neighbour squares (above, below, left and right) at most. When the value of the dice gets to the dices bursting value, color of the dice dots changes.';

  // 3. Move
  ZeroLevel[3].P1MoveX   := 3;
  ZeroLevel[3].P1MoveY   := 5;
  ZeroLevel[3].P2MoveX   := 5;
  ZeroLevel[3].P2MoveY   := 6;
  ZeroLevel[3].TrMessage := 'Zar patlayýp daðýldýðýnda komþu kareleri ele geçirir ve deðerlerini bir arttýrýr. Bu zarýn da 3 komþu karesi (üst, alt ve sol) var. Yani en fazla 3 deðerini alabilir.';
  ZeroLevel[3].EnMessage := 'When the dice bursts and spreads, it conquers the neighbour squares and increases their value by one. This dice has 3 neighbour squares (above, below and left). So its value can be 3 at most.';

  // 4. Move
  ZeroLevel[4].P1MoveX   := 3;
  ZeroLevel[4].P1MoveY   := 5;
  ZeroLevel[4].P2MoveX   := 5;
  ZeroLevel[4].P2MoveY   := 6;
  ZeroLevel[4].TrMessage := 'Her oyuncu sadece kendi renginde zarlara týklayabilir. Bu seviyede iki oyuncu var. Her bir seviyede, 2-6 arasý oyuncu olabilir. Sizin dýþýnýzdaki oyuncular yapay zeka ile kontrol edilir.';
  ZeroLevel[4].EnMessage := 'Each player can only click dices that are their color. There two players in this level. There could be 2 to 6 players in each level. The players, except you, are controlled by the AI.';

  // 5. Move
  ZeroLevel[5].P1MoveX   := 3;
  ZeroLevel[5].P1MoveY   := 5;
  ZeroLevel[5].P2MoveX   := 5;
  ZeroLevel[5].P2MoveY   := 5;
  ZeroLevel[5].TrMessage := 'Bu zarýn 3 komþu karesi olduðu için en fazla 3 deðerini alabilir. Bir daha bu zara týklandýðýnda, patlayýp daðýlýr.';
  ZeroLevel[5].EnMessage := 'This dice has 3 neighbour squares so its value can be 3 at most. If its clicked one more time, the dice bursts and spreads.';

  // 6. Move
  ZeroLevel[6].P1MoveX   := 3;
  ZeroLevel[6].P1MoveY   := 6;
  ZeroLevel[6].P2MoveX   := 5;
  ZeroLevel[6].P2MoveY   := 5;
  ZeroLevel[6].TrMessage := 'Bu zarýn ise 2 komþu karesi (üst ve sað) var, bu yüzden en fazla 2 deðerini alabilir. Oyun ilerledikçe yapay zeka sizden öðrenecek, daha zeki ve daha zorlu olacaktýr.';
  ZeroLevel[6].EnMessage := 'This dice has 2 neighbour squares (above and right), so its value can be 2 at most. As the level increases, the AI will learn the way you play so it will be more clever and more challenging.';

  // 7. Move
  ZeroLevel[7].P1MoveX   := 3;
  ZeroLevel[7].P1MoveY   := 6;
  ZeroLevel[7].P2MoveX   := 5;
  ZeroLevel[7].P2MoveY   := 5;
  ZeroLevel[7].TrMessage := 'Bu þekilde alanda daðýlarak rakip alaný ele geçirmelisiniz. Rakibin renginden zar kalmadýðýnda oyunu kazanýrsýnýz.';
  ZeroLevel[7].EnMessage := 'You should conquer your opponents side by spreading through the area like this. You win the game if there aren''t any of your opponents dices left on the area.';

  // 8. Move
  ZeroLevel[8].P1MoveX   := 4;
  ZeroLevel[8].P1MoveY   := 6;
  ZeroLevel[8].P2MoveX   := 5;
  ZeroLevel[8].P2MoveY   := 4;
  ZeroLevel[8].TrMessage := 'Ekranýn üst kýsmýnda oyuncu bilgileri, puanýnýz, seviye bilgileri ve kaç canýnýz olduðu yer alýr.';
  ZeroLevel[8].EnMessage := 'There are your player information, your points, level information and how many lives you have, shown at the top of the screen.';

  // 9. Move
  ZeroLevel[9].P1MoveX   := 4;
  ZeroLevel[9].P1MoveY   := 5;
  ZeroLevel[9].P2MoveX   := 5;
  ZeroLevel[9].P2MoveY   := 5;
  ZeroLevel[9].TrMessage := 'Adýnýzýn yazdýðý alanýn rengi sizin zar renginizdir. Sýra size geldiðinde sizin adýnýz aktif olur. Sadece o zaman kendi zarlarýnýza týklayabilirsiniz.';
  ZeroLevel[9].EnMessage := 'The color of the area where your player name is written, is your dices color. When its your turn, your name gets activated. Only then you can click your dices.';

  // 10. Move
  ZeroLevel[10].P1MoveX   := 4;
  ZeroLevel[10].P1MoveY   := 5;
  ZeroLevel[10].P2MoveX   := 5;
  ZeroLevel[10].P2MoveY   := 5;
  ZeroLevel[10].TrMessage := 'Seviye arttýkça kare sayýsý ve rakip sayýsý artar. Ayrýca oyuna bombalar, dinamitler, ýþýnlanma ve mayýnlar eklenir. Haydi oyun baþlasýn!';
  ZeroLevel[10].EnMessage := 'As the level increases, square number and opponent number increase as well. Also bombs, dynamites and mines gets added on the area. Let the game begin!';

End;

Procedure TEzerionForm.AddNewLevel;
Type
  NLAType     = Array [1..40] of NLType;
Var
  I           : Integer;
  NLA         : NLAType;
  LevelQuery  : TUniQuery;

  Procedure FillArray;
  Begin
    //Level 81
    NLA[1].Id            := 81;
    NLA[1].Matrix_X      := 11;
    NLA[1].Matrix_Y      := 16;
    NLA[1].Player_Count  := 6;
    NLA[1].Matrix_Value  := '1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;1:4:0:0:0;1:5:0:0:0;1:6:0:0:0;1:7:0:0:0;1:8:0:0:0;1:9:0:0:0;1:10:0:0:0;1:11:0:0:0;1:12:4:1:s;1:13:0:0:0;1:14:0:0:0;1:15:0:0:0;1:16:0:0:0;2:1:0:0:0;2:2:0:0:0;2:3:0:0:0;2:4:0:0:0;2:5:2:1:g;2:6:0:0:0;2:7:0:0:0;2:8:0:0:0;2:9'+
                            ':0:0:0;2:10:0:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:0:0:0;2:15:0:0:0;2:16:0:0:0;3:1:0:0:0;3:2:0:0:0;3:3:9:7:0;3:4:1:0:0;3:5:1:0:0;3:6:1:0:0;3:7:1:0:0;3:8:0:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:1:0:0;3:13:1:0:0;3:14:9:6:0;3:15:0:0:0;3:16:0:0:0' +
                            ';4:1:0:0:0;4:2:0:0:0;4:3:1:0:0;4:4:1:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:1:0:0;4:9:9:7:0;4:10:1:0:0;4:11:1:0:0;4:12:0:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:0:0:0;5:1:0:0:0;5:2:1:6:0;5:3:1:0:0;5:4:1:0:0;5:5:0:0:0;5:6:1:0:0;5:7:1:6:0;5:8:1:6:0;5:' +
                            '9:1:6:0;5:10:1:0:0;5:11:0:0:0;5:12:0:0:0;5:13:0:0:0;5:14:1:0:0;5:15:1:6:0;5:16:1:6:0;6:1:6:1:b;6:2:1:6:0;6:3:1:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:10:0:0;6:8:1:0:d;6:9:9:1:0;6:10:1:0:0;6:11:1:0:0;6:12:10:0:0;6:13:1:2:0;6:14:1:0:0;6:15:1:6:0;6:16:7:' +
                            '1:n;7:1:0:0:0;7:2:1:6:0;7:3:1:0:0;7:4:1:0:0;7:5:0:0:0;7:6:1:0:0;7:7:1:6:0;7:8:1:6:0;7:9:1:6:0;7:10:1:0:0;7:11:0:0:0;7:12:0:0:0;7:13:0:0:0;7:14:1:0:0;7:15:1:6:0;7:16:1:6:0;8:1:0:0:0;8:2:0:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:1:0:0' +
                            ';8:9:9:4:0;8:10:1:0:0;8:11:1:0:0;8:12:0:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:0:0:0;9:1:0:0:0;9:2:0:0:0;9:3:9:4:0;9:4:1:0:0;9:5:1:0:0;9:6:1:0:0;9:7:1:0:0;9:8:0:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:1:0:0;9:13:1:0:0;9:14:9:5:0;9:15:0:0:0;9:16:0' +
                            ':0:0;10:1:0:0:0;10:2:0:0:0;10:3:0:0:0;10:4:0:0:0;10:5:3:1:r;10:6:0:0:0;10:7:0:0:0;10:8:0:0:0;10:9:0:0:0;10:10:0:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:0;10:14:0:0:0;10:15:0:0:0;10:16:0:0:0;11:1:0:0:0;11:2:0:0:0;11:3:0:0:0;11:4:0:0:0;11:5:0:0:0;11:6:0:' +
                            '0:0;11:7:0:0:0;11:8:0:0:0;11:9:0:0:0;11:10:0:0:0;11:11:0:0:0;11:12:5:1:m;11:13:0:0:0;11:14:0:0:0;11:15:0:0:0;11:16:0:0:0;';

    //Level 82
    NLA[2].Id            := 82;
    NLA[2].Matrix_X      := 7;
    NLA[2].Matrix_Y      := 17;
    NLA[2].Player_Count  := 6;
    NLA[2].Matrix_Value  := '1:1:2:1:e;1:2:0:0:0;1:3:0:0:0;1:4:0:0:0;1:5:1:1:0;1:6:1:1:0;1:7:1:1:0;1:8:1:1:0;1:9:4:1:a;1:10:0:0:0;1:11:0:0:0;1:12:1:1:0;1:13:1:1:0;1:14:1:1:0;1:15:0:0:0;1:16:0:0:0;1:17:6:1:p;2:1:1:1:0;2:2:1:6:k;2:3:9:7:0;2:4:0:0:0;2:5:0:0:0;2:6:1:3:0;2:7:1:1:0;2:'+
                            '8:1:5:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:5:0;2:13:1:1:0;2:14:1:3:0;2:15:1:0:0;2:16:1:6:k;2:17:1:1:0;3:1:1:1:0;3:2:1:6:0;3:3:1:0:0;3:4:1:6:0;3:5:1:0:0;3:6:1:3:0;3:7:1:1:0;3:8:1:5:0;3:9:1:0:0;3:10:1:0:0;3:11:1:0:0;3:12:1:5:0;3:13:1:1:0;3:14:9:9:0' +
                            ';3:15:1:0:0;3:16:1:6:0;3:17:1:1:0;4:1:0:0:0;4:2:0:0:0;4:3:9:1:0;4:4:1:6:0;4:5:1:6:0;4:6:10:0:0;4:7:1:1:0;4:8:1:5:0;4:9:0:0:0;4:10:9:8:0;4:11:0:0:0;4:12:8:1:0;4:13:8:1:0;4:14:0:0:0;4:15:0:0:0;4:16:9:1:0;4:17:0:0:0;5:1:1:1:0;5:2:1:6:0;5:3:1:0:0;5:4:1:6' +
                            ':0;5:5:1:0:0;5:6:1:3:0;5:7:1:1:0;5:8:1:5:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:5:0;5:13:1:1:0;5:14:9:8:0;5:15:1:0:0;5:16:1:6:0;5:17:1:1:0;6:1:1:1:0;6:2:1:6:e;6:3:9:4:0;6:4:0:0:0;6:5:0:0:0;6:6:1:3:0;6:7:1:1:0;6:8:1:5:0;6:9:1:0:0;6:10:1:0:0;6:11:1:0' +
                            ':0;6:12:1:5:0;6:13:1:1:0;6:14:1:3:0;6:15:1:0:0;6:16:1:6:e;6:17:1:1:0;7:1:3:1:k;7:2:0:0:0;7:3:0:0:0;7:4:0:0:0;7:5:1:1:0;7:6:1:1:0;7:7:1:1:0;7:8:1:1:0;7:9:5:1:d;7:10:0:0:0;7:11:0:0:0;7:12:1:1:0;7:13:1:1:0;7:14:1:1:0;7:15:0:0:0;7:16:0:0:0;7:17:7:1:y;';

    //Level 83
    NLA[3].Id            := 83;
    NLA[3].Matrix_X      := 11;
    NLA[3].Matrix_Y      := 17;
    NLA[3].Player_Count  := 6;
    NLA[3].Matrix_Value  := '1:1:1:0:0;1:2:1:0:0;1:3:11:1:0;1:4:1:0:0;1:5:1:0:0;1:6:0:0:0;1:7:1:0:0;1:8:1:0:0;1:9:11:5:0;1:10:1:0:0;1:11:1:0:0;1:12:0:0:0;1:13:1:0:0;1:14:1:0:0;1:15:11:3:0;1:16:1:0:0;1:17:1:0:0;2:1:0:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:0:0:0;2:6:0:0:0;2:7:0:0:0'+
                            ';2:8:1:0:0;2:9:1:0:0;2:10:1:0:0;2:11:0:0:0;2:12:0:0:0;2:13:0:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:0:0:0;3:1:0:0:0;3:2:0:0:0;3:3:2:1:e;3:4:0:0:0;3:5:0:0:0;3:6:11:4:0;3:7:0:0:0;3:8:0:0:0;3:9:3:1:k;3:10:0:0:0;3:11:0:0:0;3:12:11:2:0;3:13:0:0:0;3:14:' +
                            '0:0:0;3:15:4:1:a;3:16:0:0:0;3:17:0:0:0;4:1:0:0:0;4:2:0:0:0;4:3:0:0:0;4:4:0:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:0:0:0;4:9:0:0:0;4:10:0:0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:0:0:0;4:15:0:0:0;4:16:0:0:0;4:17:0:0:0;5:1:0:0:0;5:2:0:0:0;5:3:0:0:0;5:4' +
                            ':1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:0:0:0;5:16:0:0:0;5:17:0:0:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:11:5:0;6:5:1:0:0;6:6:9:1:0;6:7:1:0:0;6:8:10:0:0;6:9:0:0:0;6:10:10:0:0;6' +
                            ':11:1:0:0;6:12:9:1:0;6:13:1:0:0;6:14:11:6:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:0:0:0;7:2:0:0:0;7:3:0:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:0:0:0;7:16:0:0:0;7:17:0' +
                            ':0:0;8:1:0:0:0;8:2:0:0:0;8:3:0:0:0;8:4:0:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:0:0:0;8:9:0:0:0;8:10:0:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:0:0:0;8:15:0:0:0;8:16:0:0:0;8:17:0:0:0;9:1:0:0:0;9:2:0:0:0;9:3:5:1:d;9:4:0:0:0;9:5:0:0:0;9:6:11:3:0;9:7:0:' +
                            '0:0;9:8:0:0:0;9:9:6:1:p;9:10:0:0:0;9:11:0:0:0;9:12:11:1:0;9:13:0:0:0;9:14:0:0:0;9:15:7:1:y;9:16:0:0:0;9:17:0:0:0;10:1:0:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:0:0:0;10:6:0:0:0;10:7:0:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:0:0:0;10:12:0:0:0;10' +
                            ':13:0:0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:0:0:0;11:1:1:0:0;11:2:1:0:0;11:3:11:2:0;11:4:1:0:0;11:5:1:0:0;11:6:0:0:0;11:7:1:0:0;11:8:1:0:0;11:9:11:6:0;11:10:1:0:0;11:11:1:0:0;11:12:0:0:0;11:13:1:0:0;11:14:1:0:0;11:15:11:4:0;11:16:1:0:0;11:17:' +
                            '1:0:0;';

    //Level 84
    NLA[4].Id            := 84;
    NLA[4].Matrix_X      := 10;
    NLA[4].Matrix_Y      := 16;
    NLA[4].Player_Count  := 4;
    NLA[4].Matrix_Value  := '1:1:2:1:e;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:0:0:0;1:6:0:0:0;1:7:0:0:0;1:8:11:1:0;1:9:1:0:0;1:10:0:0:0;1:11:0:0:0;1:12:0:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:4:1:a;2:1:1:0:0;2:2:1:0:0;2:3:0:0:0;2:4:1:0:0;2:5:1:0:0;2:6:0:0:0;2:7:0:0:0;2:8:1:0:0;2:'+
                            '9:1:0:0;2:10:0:0:0;2:11:0:0:0;2:12:1:0:0;2:13:1:0:0;2:14:0:0:0;2:15:1:0:0;2:16:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:1:0:0;3:6:8:1:0;3:7:9:7:0;3:8:1:0:0;3:9:1:0:0;3:10:9:6:0;3:11:8:1:0;3:12:1:0:0;3:13:0:0:0;3:14:0:0:0;3:15:1:0:0;3:16:1:0:' +
                            '0;4:1:0:0:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:1:0:0;4:6:8:1:0;4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:8:1:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:0:0:0;5:1:0:0:0;5:2:0:0:0;5:3:0:0:0;5:4:8:1:0;5:5:8:1:0;5:6:8:1:0;5:7:1:0:0;5:8:0:0:0;5' +
                            ':9:0:0:0;5:10:1:0:0;5:11:8:1:0;5:12:8:1:0;5:13:8:1:0;5:14:0:0:0;5:15:0:0:0;5:16:0:0:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:8:1:0;6:5:8:1:0;6:6:8:1:0;6:7:1:0:0;6:8:0:0:0;6:9:0:0:0;6:10:1:0:0;6:11:8:1:0;6:12:8:1:0;6:13:8:1:0;6:14:0:0:0;6:15:0:0:0;6:16:0:0' +
                            ':0;7:1:0:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:8:1:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:8:1:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:0:0:0;8:1:1:0:0;8:2:1:0:0;8:3:0:0:0;8:4:0:0:0;8:5:1:0:0;8:6:8:1:0;8:7:9:4:0;8:8:1:0:0;' +
                            '8:9:1:0:0;8:10:9:5:0;8:11:8:1:0;8:12:1:0:0;8:13:0:0:0;8:14:0:0:0;8:15:1:0:0;8:16:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:0:0:0;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:0:0:0;9:8:1:0:0;9:9:1:0:0;9:10:0:0:0;9:11:0:0:0;9:12:1:0:0;9:13:1:0:0;9:14:0:0:0;9:15:1:0:0;9:16:1:' +
                            '0:0;10:1:3:1:k;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:0:0:0;10:6:0:0:0;10:7:0:0:0;10:8:1:0:0;10:9:11:1:0;10:10:0:0:0;10:11:0:0:0;10:12:0:0:0;10:13:1:0:0;10:14:1:0:0;10:15:1:0:0;10:16:5:1:d;';

    //Level 85
    NLA[5].Id            := 85;
    NLA[5].Matrix_X      := 7;
    NLA[5].Matrix_Y      := 17;
    NLA[5].Player_Count  := 6;
    NLA[5].Matrix_Value  := '1:1:2:1:g;1:2:0:0:0;1:3:0:0:0;1:4:0:0:0;1:5:1:1:0;1:6:1:1:0;1:7:1:1:0;1:8:1:1:0;1:9:4:1:s;1:10:0:0:0;1:11:0:0:0;1:12:1:1:0;1:13:1:1:0;1:14:1:1:0;1:15:0:0:0;1:16:0:0:0;1:17:6:1:b;2:1:1:1:0;2:2:1:6:k;2:3:1:0:0;2:4:0:0:0;2:5:0:0:0;2:6:1:3:0;2:7:0:0:0;2:'+
                            '8:1:5:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:5:0;2:13:0:0:0;2:14:1:3:0;2:15:1:0:0;2:16:1:6:k;2:17:1:1:0;3:1:1:1:0;3:2:1:6:0;3:3:1:0:0;3:4:9:8:0;3:5:1:6:0;3:6:1:3:0;3:7:1:1:0;3:8:1:5:0;3:9:1:0:0;3:10:1:0:0;3:11:1:0:0;3:12:1:5:0;3:13:9:9:0;3:14:1:3:0' +
                            ';3:15:1:0:0;3:16:1:6:0;3:17:1:1:0;4:1:0:0:0;4:2:9:1:0;4:3:1:0:0;4:4:8:1:0;4:5:1:6:0;4:6:10:0:0;4:7:1:1:0;4:8:8:1:0;4:9:0:0:0;4:10:9:1:0;4:11:0:0:0;4:12:8:1:0;4:13:8:1:0;4:14:8:1:0;4:15:0:0:0;4:16:9:1:0;4:17:0:0:0;5:1:1:1:0;5:2:1:6:0;5:3:1:0:0;5:4:9:9' +
                            ':0;5:5:1:6:0;5:6:1:3:0;5:7:1:1:0;5:8:1:5:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:5:0;5:13:9:8:0;5:14:1:3:0;5:15:1:0:0;5:16:1:6:0;5:17:1:1:0;6:1:1:1:0;6:2:1:6:e;6:3:1:0:0;6:4:0:0:0;6:5:0:0:0;6:6:1:3:0;6:7:0:0:0;6:8:1:5:0;6:9:1:0:0;6:10:1:0:0;6:11:1:0' +
                            ':0;6:12:1:5:0;6:13:0:0:0;6:14:1:3:0;6:15:1:0:0;6:16:1:6:e;6:17:1:1:0;7:1:3:1:r;7:2:0:0:0;7:3:0:0:0;7:4:0:0:0;7:5:1:1:0;7:6:1:1:0;7:7:1:1:0;7:8:1:1:0;7:9:5:1:m;7:10:0:0:0;7:11:0:0:0;7:12:1:1:0;7:13:1:1:0;7:14:1:1:0;7:15:0:0:0;7:16:0:0:0;7:17:7:1:n;';

    //Level 86
    NLA[6].Id            := 86;
    NLA[6].Matrix_X      := 11;
    NLA[6].Matrix_Y      := 15;
    NLA[6].Player_Count  := 6;
    NLA[6].Matrix_Value  := '1:1:2:1:e;1:2:1:0:0;1:3:1:0:0;1:4:0:0:0;1:5:1:0:0;1:6:1:0:0;1:7:11:4:0;1:8:0:0:0;1:9:1:0:0;1:10:1:0:0;1:11:7:1:y;1:12:0:0:0;1:13:1:0:0;1:14:1:0:0;1:15:5:1:d;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:0:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;2:8:0:0:0;2:9:1:0:0;2:1'+
                            '0:1:0:0;2:11:1:0:0;2:12:0:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:11:1:0;3:4:0:0:0;3:5:1:0:0;3:6:1:0:0;3:7:1:0:0;3:8:0:0:0;3:9:11:6:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:11:5:0;3:14:1:0:0;3:15:1:0:0;4:1:0:0:0;4:2:0:0:0;4:3:0:0:' +
                            '0;4:4:0:0:0;4:5:1:0:0;4:6:9:1:0;4:7:1:0:0;4:8:0:0:0;4:9:0:0:0;4:10:0:0:0;4:11:0:0:0;4:12:0:0:0;4:13:0:0:0;4:14:0:0:0;4:15:0:0:0;5:1:1:0:0;5:2:1:0:0;5:3:1:0:0;5:4:1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:8:1:0;5:9:11:3:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:' +
                            '0;5:13:1:0:0;5:14:1:0:0;5:15:11:2:0;6:1:1:0:0;6:2:1:0:0;6:3:1:0:0;6:4:9:1:0;6:5:1:0:0;6:6:1:0:0;6:7:1:0:0;6:8:8:1:0;6:9:1:0:0;6:10:1:0:0;6:11:1:0:0;6:12:9:1:0;6:13:1:0:0;6:14:1:0:0;6:15:1:0:0;7:1:11:5:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0' +
                            ':0;7:7:11:6:0;7:8:8:1:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;8:1:0:0:0;8:2:0:0:0;8:3:0:0:0;8:4:0:0:0;8:5:0:0:0;8:6:0:0:0;8:7:0:0:0;8:8:0:0:0;8:9:1:0:0;8:10:9:1:0;8:11:1:0:0;8:12:0:0:0;8:13:0:0:0;8:14:0:0:0;8:15:' +
                            '0:0:0;9:1:1:0:0;9:2:1:0:0;9:3:11:2:0;9:4:0:0:0;9:5:1:0:0;9:6:1:0:0;9:7:11:3:0;9:8:0:0:0;9:9:1:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:11:4:0;9:14:1:0:0;9:15:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:0:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:0:0' +
                            ':0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:0:0:0;10:13:1:0:0;10:14:1:0:0;10:15:1:0:0;11:1:3:1:k;11:2:1:0:0;11:3:1:0:0;11:4:0:0:0;11:5:4:1:a;11:6:1:0:0;11:7:1:0:0;11:8:0:0:0;11:9:11:1:0;11:10:1:0:0;11:11:1:0:0;11:12:0:0:0;11:13:1:0:0;11:14:1:0:0;11:1' +
                            '5:6:1:p;';

    //Level 87
    NLA[7].Id            := 87;
    NLA[7].Matrix_X      := 11;
    NLA[7].Matrix_Y      := 15;
    NLA[7].Player_Count  := 5;
    NLA[7].Matrix_Value  := '1:1:2:1:g;1:2:1:0:0;1:3:1:0:0;1:4:0:0:0;1:5:11:2:0;1:6:1:0:0;1:7:1:0:0;1:8:1:0:0;1:9:1:0:0;1:10:11:3:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:5:1:m;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:0:0:0;2:5:1:0:0;2:6:1:0:0;2:7:10:0:0;2:8:1:0:0;2:9:1:0:0;2'+
                            ':10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;3:1:1:0:0;3:2:9:1:0;3:3:1:0:0;3:4:0:0:0;3:5:1:0:0;3:6:1:0:0;3:7:1:0:0;3:8:1:0:0;3:9:1:0:0;3:10:10:0:0;3:11:1:0:0;3:12:1:0:0;3:13:1:0:0;3:14:9:1:0;3:15:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:1:0:' +
                            '0;4:4:0:0:0;4:5:1:0:0;4:6:9:1:0;4:7:1:0:0;4:8:0:0:0;4:9:0:0:0;4:10:0:0:0;4:11:0:0:0;4:12:0:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:1:0:0;5:4:0:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:0:0:0' +
                            ';5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;6:1:11:3:0;6:2:1:0:0;6:3:10:0:0;6:4:0:0:0;6:5:1:0:0;6:6:1:0:0;6:7:1:0:0;6:8:1:0:0;6:9:10:0:0;6:10:1:0:0;6:11:11:1:0;6:12:0:0:0;6:13:10:0:0;6:14:1:0:0;6:15:11:1:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:0:0:0;7:5:6:1:b;7:6:' +
                            '1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:0:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:0:0:0;8:5:0:0:0;8:6:0:0:0;8:7:0:0:0;8:8:0:0:0;8:9:0:0:0;8:10:0:0:0;8:11:0:0:0;8:12:0:0:0;8:13:1:0:0;8:14:1:0:0;8:1' +
                            '5:1:0:0;9:1:1:0:0;9:2:9:1:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:1:0:0;9:7:1:0:0;9:8:10:0:0;9:9:1:0:0;9:10:1:0:0;9:11:1:0:0;9:12:1:0:0;9:13:1:0:0;9:14:9:1:0;9:15:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:9:1:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0' +
                            ':0;10:9:1:0:0;10:10:1:0:0;10:11:9:1:0;10:12:1:0:0;10:13:1:0:0;10:14:1:0:0;10:15:1:0:0;11:1:3:1:r;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:11:2:0;11:9:1:0:0;11:10:1:0:0;11:11:1:0:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:1' +
                            '5:4:1:s;';

    //Level 88
    NLA[8].Id            := 88;
    NLA[8].Matrix_X      := 11;
    NLA[8].Matrix_Y      := 13;
    NLA[8].Player_Count  := 6;
    NLA[8].Matrix_Value  := '1:1:7:1:y;1:2:1:0:0;1:3:1:0:0;1:4:8:1:0;1:5:1:0:0;1:6:1:0:0;1:7:11:2:0;1:8:1:0:0;1:9:1:0:0;1:10:8:1:0;1:11:1:0:0;1:12:1:0:0;1:13:3:1:k;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;2:8:1:0:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:1'+
                            '2:1:0:0;2:13:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:1:0:0;3:4:8:1:0;3:5:1:0:0;3:6:1:0:0;3:7:9:1:0;3:8:1:0:0;3:9:1:0:0;3:10:8:1:0;3:11:1:0:0;3:12:1:0:0;3:13:1:0:0;4:1:0:0:0;4:2:0:0:0;4:3:0:0:0;4:4:0:0:0;4:5:0:0:0;4:6:0:0:0;4:7:0:0:0;4:8:0:0:0;4:9:0:0:0;4:10:0:' +
                            '0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:1:0:0;5:4:1:0:0;5:5:8:1:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:0:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;6:1:5:1:d;6:2:1:0:0;6:3:1:0:0;6:4:11:1:0;6:5:8:1:0;6:6:11:2:0;6:7:1:0:0;6:8:1:0' +
                            ':0;6:9:6:1:p;6:10:0:0:0;6:11:1:0:0;6:12:1:0:0;6:13:9:1:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:8:1:0;7:6:1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:0:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;8:1:0:0:0;8:2:0:0:0;8:3:0:0:0;8:4:0:0:0;8:5:0:0:0;8:6:0:0:0' +
                            ';8:7:0:0:0;8:8:0:0:0;8:9:0:0:0;8:10:0:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:8:1:0;9:5:1:0:0;9:6:1:0:0;9:7:9:1:0;9:8:1:0:0;9:9:1:0:0;9:10:8:1:0;9:11:1:0:0;9:12:1:0:0;9:13:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0' +
                            ':0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:0;11:1:2:1:e;11:2:1:0:0;11:3:1:0:0;11:4:8:1:0;11:5:1:0:0;11:6:1:0:0;11:7:11:1:0;11:8:1:0:0;11:9:1:0:0;11:10:8:1:0;11:11:1:0:0;11:12:1:0:0;11:13:4:' +
                            '1:a;';

    //Level 89
    NLA[9].Id            := 89;
    NLA[9].Matrix_X      := 11;
    NLA[9].Matrix_Y      := 12;
    NLA[9].Player_Count  := 4;
    NLA[9].Matrix_Value  := '1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;1:4:0:0:0;1:5:1:0:0;1:6:1:0:0;1:7:0:0:0;1:8:1:0:0;1:9:0:0:0;1:10:0:0:0;1:11:0:0:0;1:12:0:0:0;2:1:0:0:0;2:2:3:1:r;2:3:1:0:0;2:4:0:0:0;2:5:1:0:0;2:6:0:0:0;2:7:0:0:0;2:8:1:0:0;2:9:4:1:s;2:10:0:0:0;2:11:0:0:0;2:12:0:0:0;3:1:'+
                            '1:0:0;3:2:1:0:0;3:3:1:0:0;3:4:1:0:0;3:5:1:0:0;3:6:1:0:0;3:7:8:1:0;3:8:1:0:0;3:9:1:0:0;3:10:0:0:0;3:11:1:0:0;3:12:1:0:0;4:1:0:0:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:9:1:0;4:6:1:0:0;4:7:8:1:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:9:1:0;4:12:1:0:0;5:1:1:0:' +
                            '0;5:2:1:0:0;5:3:0:0:0;5:4:1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:0:0:0;5:8:0:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;6:1:9:1:0;6:2:8:1:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:1:0:0;6:10:0:0:0;6:11:0:0:0;6:12:8:1:0;7:1:1:0:0;7:' +
                            '2:1:0:0;7:3:0:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:0:0:0;7:8:0:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;8:1:0:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:9:1:0;8:6:1:0:0;8:7:8:1:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:9:1:0;8:12:1:0:0;9:1:1:0:0;9:2:1:' +
                            '0:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:1:0:0;9:7:8:1:0;9:8:1:0:0;9:9:1:0:0;9:10:0:0:0;9:11:1:0:0;9:12:1:0:0;10:1:0:0:0;10:2:1:0:0;10:3:1:0:0;10:4:0:0:0;10:5:1:0:0;10:6:0:0:0;10:7:0:0:0;10:8:1:0:0;10:9:5:1:m;10:10:0:0:0;10:11:0:0:0;10:12:0:0:0;11:1:0:0' +
                            ':0;11:2:2:1:g;11:3:0:0:0;11:4:0:0:0;11:5:1:0:0;11:6:1:0:0;11:7:0:0:0;11:8:1:0:0;11:9:0:0:0;11:10:0:0:0;11:11:0:0:0;11:12:0:0:0;';

    //Level 90
    NLA[10].Id            := 90;
    NLA[10].Matrix_X      := 11;
    NLA[10].Matrix_Y      := 11;
    NLA[10].Player_Count  := 5;
    NLA[10].Matrix_Value  := '1:1:1:0:0;1:2:1:0:0;1:3:11:2:0;1:4:1:0:0;1:5:1:0:0;1:6:11:3:0;1:7:1:0:0;1:8:1:0:0;1:9:11:1:0;1:10:1:0:0;1:11:1:0:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;2:8:1:0:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3'+
                            ':1:0:0;3:4:10:0:0;3:5:1:0:0;3:6:1:0:0;3:7:1:0:0;3:8:10:0:0;3:9:1:0:0;3:10:1:0:0;3:11:1:0:0;4:1:0:0:0;4:2:0:0:0;4:3:1:0:0;4:4:1:0:0;4:5:1:0:0;4:6:0:0:0;4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:0:0:0;4:11:0:0:0;5:1:0:0:0;5:2:0:0:0;5:3:1:0:0;5:4:1:0:0;5:5:1:0' +
                            ':0;5:6:0:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:0:0:0;5:11:0:0:0;6:1:0:0:0;6:2:2:1:e;6:3:0:0:0;6:4:3:1:k;6:5:0:0:0;6:6:4:1:a;6:7:0:0:0;6:8:6:1:p;6:9:0:0:0;6:10:5:1:d;6:11:0:0:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:0:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8' +
                            ':0:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:0:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:0:0:0;8:9:1:0:0;8:10:1:0:0;8:11:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:1:0:0;9:7:1:0:0;9:8:1:0:0;9:9:1:0:0;9:10:1:0:' +
                            '0;9:11:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;11:1:1:0:0;11:2:11:1:0;11:3:1:0:0;11:4:9:1:0;11:5:1:0:0;11:6:11:2:0;11:7:1:0:0;11:8:9:1:0;11:9:1:0:0;11:10:11:3:0;' +
                            '11:11:1:0:0;';

    //Level 91
    NLA[11].Id            := 91;
    NLA[11].Matrix_X      := 11;
    NLA[11].Matrix_Y      := 17;
    NLA[11].Player_Count  := 4;
    NLA[11].Matrix_Value  := '1:1:2:1:g;1:2:1:0:0;1:3:0:0:0;1:4:11:4:0;1:5:1:0:e;1:6:0:0:0;1:7:0:0:0;1:8:1:0:0;1:9:0:0:0;1:10:1:0:0;1:11:0:0:0;1:12:0:0:0;1:13:1:0:p;1:14:11:2:0;1:15:0:0:0;1:16:1:0:0;1:17:4:1:s;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:9:7:0;2:7:1:0:0;'+
                            '2:8:1:0:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:12:9:6:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:0:0:0;3:2:0:0:0;3:3:0:0:0;3:4:1:0:0;3:5:8:1:0;3:6:1:0:0;3:7:1:0:0;3:8:0:0:0;3:9:0:0:0;3:10:0:0:0;3:11:1:0:0;3:12:1:0:0;3:13:8:1:0;3:14:1:0' +
                            ':0;3:15:0:0:0;3:16:0:0:0;3:17:0:0:0;4:1:1:0:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:8:1:0;4:6:1:0:0;4:7:11:1:0;4:8:1:0:0;4:9:8:1:0;4:10:1:0:0;4:11:11:3:0;4:12:1:0:0;4:13:8:1:0;4:14:1:0:0;4:15:1:0:0;4:16:1:0:0;4:17:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:0:0:0;5:4:' +
                            '1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:8:1:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:0:0:0;5:16:1:0:0;5:17:1:0:0;6:1:1:0:0;6:2:0:0:0;6:3:0:0:0;6:4:10:0:0;6:5:1:0:0;6:6:1:0:0;6:7:9:1:0;6:8:1:0:0;6:9:8:1:0;6:10:1:0:0;6:11' +
                            ':9:1:0;6:12:1:0:0;6:13:1:0:0;6:14:10:0:0;6:15:0:0:0;6:16:0:0:0;6:17:1:0:0;7:1:1:0:0;7:2:1:0:0;7:3:0:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:8:1:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:0:0:0;7:16:1:0:0;7:17:1:0:' +
                            '0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:8:1:0;8:6:1:0:0;8:7:11:2:0;8:8:1:0:0;8:9:8:1:0;8:10:1:0:0;8:11:11:4:0;8:12:1:0:0;8:13:8:1:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;8:17:1:0:0;9:1:0:0:0;9:2:0:0:0;9:3:0:0:0;9:4:1:0:0;9:5:8:1:0;9:6:1:0:0;9:7:1:0:' +
                            '0;9:8:0:0:0;9:9:0:0:0;9:10:0:0:0;9:11:1:0:0;9:12:1:0:0;9:13:8:1:0;9:14:1:0:0;9:15:0:0:0;9:16:0:0:0;9:17:0:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:9:4:0;10:7:1:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:9:5:0;10:13' +
                            ':1:0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:3:1:r;11:2:1:0:0;11:3:0:0:0;11:4:11:3:0;11:5:1:0:k;11:6:0:0:0;11:7:0:0:0;11:8:1:0:0;11:9:0:0:0;11:10:1:0:0;11:11:0:0:0;11:12:0:0:0;11:13:1:0:a;11:14:11:1:0;11:15:0:0:0;11:16:1:0:0;11:17:5:1:' +
                            'm;';

    //Level 92
    NLA[12].Id            := 92;
    NLA[12].Matrix_X      := 11;
    NLA[12].Matrix_Y      := 17;
    NLA[12].Player_Count  := 4;
    NLA[12].Matrix_Value  := '1:1:2:1:g;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:11:1:0;1:8:0:0:0;1:9:0:0:0;1:10:0:0:0;1:11:11:4:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:5:1:m;2:1:1:6:0;2:2:1:0:0;2:3:0:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:0:0:0;'+
                            '2:8:0:0:0;2:9:0:0:0;2:10:0:0:0;2:11:0:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:0:0:0;2:16:1:0:0;2:17:1:6:0;3:1:1:6:0;3:2:0:0:0;3:3:0:0:0;3:4:1:0:0;3:5:1:0:0;3:6:0:0:0;3:7:0:0:0;3:8:0:0:0;3:9:11:1:0;3:10:0:0:0;3:11:0:0:0;3:12:0:0:0;3:13:1:0:0;3:14:1:' +
                            '0:0;3:15:0:0:0;3:16:0:0:0;3:17:1:6:0;4:1:1:6:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:0:0:0;4:6:0:0:0;4:7:0:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:0:0:0;4:12:0:0:0;4:13:0:0:0;4:14:1:0:0;4:15:1:0:0;4:16:1:0:0;4:17:1:6:0;5:1:0:0:0;5:2:1:0:0;5:3:1:0:0;5:4:0' +
                            ':0:0;5:5:0:0:0;5:6:0:0:0;5:7:1:0:0;5:8:8:1:0;5:9:8:1:0;5:10:8:1:0;5:11:1:0:0;5:12:0:0:0;5:13:0:0:0;5:14:0:0:0;5:15:1:0:0;5:16:1:0:0;5:17:0:0:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:11:2:0;6:7:1:0:0;6:8:8:1:0;6:9:9:2:0;6:10:8:1:0;6:11:' +
                            '1:0:0;6:12:11:4:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:0:0:0;7:2:1:0:0;7:3:1:0:0;7:4:0:0:0;7:5:0:0:0;7:6:0:0:0;7:7:1:0:0;7:8:8:1:0;7:9:8:1:0;7:10:8:1:0;7:11:1:0:0;7:12:0:0:0;7:13:0:0:0;7:14:0:0:0;7:15:1:0:0;7:16:1:0:0;7:17:0:0:0' +
                            ';8:1:1:6:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:0:0:0;8:6:0:0:0;8:7:0:0:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:0:0:0;8:12:0:0:0;8:13:0:0:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;8:17:1:6:0;9:1:1:6:0;9:2:0:0:0;9:3:0:0:0;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:0:0:0;9' +
                            ':8:0:0:0;9:9:11:3:0;9:10:0:0:0;9:11:0:0:0;9:12:0:0:0;9:13:1:0:0;9:14:1:0:0;9:15:0:0:0;9:16:0:0:0;9:17:1:6:0;10:1:1:6:0;10:2:1:0:0;10:3:0:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:0:0:0;10:8:0:0:0;10:9:0:0:0;10:10:0:0:0;10:11:0:0:0;10:12:1:0:0;10:13:1' +
                            ':0:0;10:14:1:0:0;10:15:0:0:0;10:16:1:0:0;10:17:1:6:0;11:1:3:1:r;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:11:2:0;11:8:0:0:0;11:9:0:0:0;11:10:0:0:0;11:11:11:3:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:4:1:s;';

    //Level 93
    NLA[13].Id            := 93;
    NLA[13].Matrix_X      := 11;
    NLA[13].Matrix_Y      := 12;
    NLA[13].Player_Count  := 6;
    NLA[13].Matrix_Value  := '1:1:1:0:0;1:2:0:0:0;1:3:1:0:0;1:4:1:0:0;1:5:11:1:0;1:6:0:0:0;1:7:0:0:0;1:8:0:0:0;1:9:1:0:0;1:10:1:0:0;1:11:1:0:0;1:12:1:0:0;2:1:0:0:0;2:2:2:1:e;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:0:0:0;2:8:0:0:0;2:9:0:0:0;2:10:0:0:0;2:11:1:0:0;2:12:1:0:0;3:1'+
                            ':0:0:0;3:2:0:0:0;3:3:1:0:0;3:4:1:0:0;3:5:11:6:0;3:6:0:0:0;3:7:0:0:0;3:8:11:3:0;3:9:1:0:0;3:10:1:0:0;3:11:0:0:0;3:12:0:0:0;4:1:0:0:0;4:2:0:0:0;4:3:0:0:0;4:4:0:0:0;4:5:0:0:0;4:6:0:0:0;4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:5:1:d;4:12:0:0:0;5:1:0' +
                            ':0:0;5:2:1:0:0;5:3:1:0:0;5:4:11:1:0;5:5:0:0:0;5:6:1:0:0;5:7:0:0:0;5:8:11:4:0;5:9:1:0:0;5:10:1:0:0;5:11:0:0:0;5:12:0:0:0;6:1:3:1:k;6:2:1:0:0;6:3:1:0:0;6:4:1:0:0;6:5:0:0:0;6:6:1:0:0;6:7:1:0:0;6:8:0:0:0;6:9:0:0:0;6:10:0:0:0;6:11:1:0:0;6:12:0:0:0;7:1:0:0' +
                            ':0;7:2:1:0:0;7:3:1:0:0;7:4:11:2:0;7:5:0:0:0;7:6:1:0:0;7:7:0:0:0;7:8:0:0:0;7:9:0:0:0;7:10:11:4:0;7:11:1:0:0;7:12:11:5:0;8:1:0:0:0;8:2:0:0:0;8:3:0:0:0;8:4:0:0:0;8:5:0:0:0;8:6:0:0:0;8:7:7:1:y;8:8:0:0:0;8:9:0:0:0;8:10:1:0:0;8:11:1:0:0;8:12:1:0:0;9:1:11:2' +
                            ':0;9:2:1:0:0;9:3:1:0:0;9:4:0:0:0;9:5:0:0:0;9:6:1:0:0;9:7:1:0:0;9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:4:1:a;10:5:0:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:0:0:0;10:11:6:1:p;10:12:0:0:0' +
                            ';11:1:11:3:0;11:2:1:0:0;11:3:1:0:0;11:4:0:0:0;11:5:0:0:0;11:6:11:6:0;11:7:1:0:0;11:8:11:5:0;11:9:0:0:0;11:10:0:0:0;11:11:0:0:0;11:12:1:0:0;';

    //Level 94
    NLA[14].Id            := 94;
    NLA[14].Matrix_X      := 11;
    NLA[14].Matrix_Y      := 17;
    NLA[14].Player_Count  := 6;
    NLA[14].Matrix_Value  := '1:1:9:7:0;1:2:1:0:0;1:3:11:1:0;1:4:0:0:0;1:5:0:0:0;1:6:2:1:e;1:7:0:0:0;1:8:0:0:0;1:9:0:0:0;1:10:0:0:0;1:11:0:0:0;1:12:7:1:y;1:13:0:0:0;1:14:0:0:0;1:15:11:2:0;1:16:1:0:0;1:17:9:6:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:0:0:0;2:5:1:0:0;2:6:1:0:0;2:7:0:0:0;'+
                            '2:8:0:0:0;2:9:1:0:0;2:10:0:0:0;2:11:0:0:0;2:12:1:0:0;2:13:1:0:0;2:14:0:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:0:0:0;3:2:0:0:0;3:3:1:0:0;3:4:1:0:0;3:5:1:0:0;3:6:1:0:0;3:7:0:0:0;3:8:1:0:0;3:9:10:0:0;3:10:1:0:0;3:11:0:0:0;3:12:1:0:0;3:13:1:0:0;3:14:1:' +
                            '0:0;3:15:1:0:0;3:16:0:0:0;3:17:0:0:0;4:1:0:0:0;4:2:0:0:0;4:3:1:0:0;4:4:1:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:0:0:0;4:17:0:0:0;5:1:0:0:0;5:2:1:0:0;5:3:1:0:0;5:4:1' +
                            ':0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:1:0:0;5:17:0:0:0;6:1:3:1:k;6:2:1:0:0;6:3:1:0:0;6:4:8:1:0;6:5:9:1:0;6:6:8:1:0;6:7:1:0:0;6:8:8:1:0;6:9:9:1:0;6:10:8:1:0;6:11:1' +
                            ':0:0;6:12:8:1:0;6:13:9:1:0;6:14:8:1:0;6:15:1:0:0;6:16:1:0:0;6:17:6:1:p;7:1:0:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:0:0:0;8' +
                            ':1:0:0:0;8:2:0:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:0:0:0;8:17:0:0:0;9:1:0:0:0;9:2:0:0:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:1:0:0;9:7:0:0:0;9:8' +
                            ':1:0:0;9:9:10:0:0;9:10:1:0:0;9:11:0:0:0;9:12:1:0:0;9:13:1:0:0;9:14:1:0:0;9:15:1:0:0;9:16:0:0:0;9:17:0:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:0:0:0;10:5:1:0:0;10:6:1:0:0;10:7:0:0:0;10:8:0:0:0;10:9:1:0:0;10:10:0:0:0;10:11:0:0:0;10:12:1:0:0;10:13:1:0' +
                            ':0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:9:4:0;11:2:1:0:0;11:3:11:2:0;11:4:0:0:0;11:5:0:0:0;11:6:4:1:a;11:7:0:0:0;11:8:0:0:0;11:9:0:0:0;11:10:0:0:0;11:11:0:0:0;11:12:5:1:d;11:13:0:0:0;11:14:0:0:0;11:15:11:1:0;11:16:1:0:0;11:17:9:5:0;';

    //Level 95
    NLA[15].Id            := 95;
    NLA[15].Matrix_X      := 10;
    NLA[15].Matrix_Y      := 14;
    NLA[15].Player_Count  := 6;
    NLA[15].Matrix_Value  := '1:1:7:1:n;1:2:1:0:0;1:3:1:0:0;1:4:11:6:0;1:5:0:0:0;1:6:3:1:r;1:7:1:0:0;1:8:1:0:0;1:9:11:3:0;1:10:0:0:0;1:11:11:5:0;1:12:1:0:0;1:13:1:0:0;1:14:5:1:m;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:0:0:0;2:6:1:0:0;2:7:1:0:0;2:8:1:0:0;2:9:1:0:0;2:10:0:0:0;2'+
                            ':11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:1:0:0;3:4:1:0:0;3:5:0:0:0;3:6:1:0:0;3:7:1:0:0;3:8:1:0:0;3:9:1:0:0;3:10:0:0:0;3:11:1:0:0;3:12:1:0:0;3:13:1:0:0;3:14:1:0:0;4:1:11:1:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:0:0:0;4:6:11:2:0;' +
                            '4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:0:0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:11:4:0;5:1:0:0:0;5:2:0:0:0;5:3:0:0:0;5:4:0:0:0;5:5:0:0:0;5:6:0:0:0;5:7:0:0:0;5:8:0:0:0;5:9:0:0:0;5:10:1:0:0;5:11:0:0:0;5:12:0:0:0;5:13:0:0:0;5:14:0:0:0;6:1:0:0:0;6:2:0:0:0' +
                            ';6:3:0:0:0;6:4:0:0:0;6:5:1:0:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:0:0:0;6:10:0:0:0;6:11:0:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;7:1:11:2:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:0:0:0;7:6:1:0:a;7:7:1:0:0;7:8:1:0:0;7:9:11:4:0;7:10:0:0:0;7:11:1:0:0;7:12:1:0:0' +
                            ';7:13:1:0:0;7:14:11:6:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:0:0:0;8:6:1:0:0;8:7:1:0:0;8:8:1:0:0;8:9:1:0:0;8:10:0:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:1:0:0;9:5:0:0:0;9:6:1:0:0;9:7:1:0:0;9:8:1:0:0;9' +
                            ':9:1:0:0;9:10:0:0:0;9:11:1:0:0;9:12:1:0:0;9:13:1:0:0;9:14:1:0:0;10:1:2:1:g;10:2:1:0:0;10:3:1:0:0;10:4:11:1:0;10:5:0:0:0;10:6:11:3:0;10:7:1:0:0;10:8:1:0:0;10:9:4:1:s;10:10:0:0:0;10:11:11:5:0;10:12:1:0:0;10:13:1:0:0;10:14:6:1:b;';

    //Level 96
    NLA[16].Id            := 96;
    NLA[16].Matrix_X      := 11;
    NLA[16].Matrix_Y      := 15;
    NLA[16].Player_Count  := 6;
    NLA[16].Matrix_Value  := '1:1:2:2:g;1:2:1:0:0;1:3:9:7:0;1:4:8:1:0;1:5:1:0:0;1:6:1:0:0;1:7:1:0:0;1:8:7:1:n;1:9:1:0:0;1:10:1:0:0;1:11:1:0:0;1:12:8:1:0;1:13:9:6:0;1:14:1:0:0;1:15:4:2:s;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:8:1:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;2:8:1:0:0;2:9:1:0:0;2:10'+
                            ':1:0:0;2:11:1:0:0;2:12:8:1:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:1:0:0;3:4:0:0:0;3:5:1:0:0;3:6:1:0:0;3:7:1:0:0;3:8:1:0:0;3:9:1:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:1:0:0;3:14:1:0:0;3:15:1:0:0;4:1:1:0:0;4:2:9:1:0;4:3:1:0:0;4:' +
                            '4:0:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:9:1:0;4:9:1:0:0;4:10:1:0:0;4:11:1:0:0;4:12:0:0:0;4:13:1:0:0;4:14:9:1:0;4:15:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:1:0:0;5:4:0:0:0;5:5:1:0:0;5:6:9:9:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:0:0:0;5:1' +
                            '3:1:0:0;5:14:1:0:0;5:15:1:0:0;6:1:8:1:0;6:2:8:1:0;6:3:0:0:0;6:4:8:1:0;6:5:0:0:0;6:6:0:0:0;6:7:8:1:0;6:8:10:0:0;6:9:8:1:0;6:10:0:0:0;6:11:0:0:0;6:12:8:1:0;6:13:0:0:0;6:14:8:1:0;6:15:8:1:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:0:0:0;7:5:1:0:0;7:6:1:0:0;7:7' +
                            ':1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:9:9:0;7:11:1:0:0;7:12:0:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;8:1:1:0:0;8:2:9:1:0;8:3:1:0:0;8:4:0:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:9:1:0;8:9:1:0:0;8:10:1:0:0;8:11:1:0:0;8:12:0:0:0;8:13:1:0:0;8:14:9:1:0;8:15:1:0:0;9' +
                            ':1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:0:0:0;9:5:1:0:0;9:6:1:0:0;9:7:1:0:0;9:8:1:0:0;9:9:1:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:1:0:0;9:14:1:0:0;9:15:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:8:1:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:1:' +
                            '0:0;10:10:1:0:0;10:11:1:0:0;10:12:8:1:0;10:13:1:0:0;10:14:1:0:0;10:15:1:0:0;11:1:3:2:r;11:2:1:0:0;11:3:9:4:0;11:4:8:1:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:6:1:b;11:9:1:0:0;11:10:1:0:0;11:11:1:0:0;11:12:8:1:0;11:13:9:5:0;11:14:1:0:0;11:15:5:2:m;';

    //Level 97
    NLA[17].Id            := 97;
    NLA[17].Matrix_X      := 11;
    NLA[17].Matrix_Y      := 15;
    NLA[17].Player_Count  := 4;
    NLA[17].Matrix_Value  := '1:1:2:1:e;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:11:1:0;1:7:0:0:0;1:8:0:0:0;1:9:0:0:0;1:10:11:2:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:4:1:a;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:0:0:0;2:7:0:0:0;2:8:1:0:0;2:9:0:0:0;2:'+
                            '10:0:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;3:1:0:0:0;3:2:0:0:0;3:3:1:0:0;3:4:1:0:0;3:5:0:0:0;3:6:0:0:0;3:7:9:7:0;3:8:1:0:0;3:9:9:6:0;3:10:0:0:0;3:11:0:0:0;3:12:1:0:0;3:13:1:0:0;3:14:0:0:0;3:15:0:0:0;4:1:0:0:0;4:2:1:0:0;4:3:1:0:0;' +
                            '4:4:1:0:0;4:5:0:0:0;4:6:1:0:0;4:7:1:0:0;4:8:0:0:0;4:9:1:0:0;4:10:1:0:0;4:11:0:0:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:0:0:0;5:1:1:0:0;5:2:1:0:0;5:3:1:0:0;5:4:8:1:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:8:1:0;5' +
                            ':13:1:0:0;5:14:1:0:0;5:15:1:0:0;6:1:10:0:0;6:2:1:0:0;6:3:8:1:0;6:4:1:0:0;6:5:1:0:0;6:6:0:0:0;6:7:1:0:0;6:8:9:2:0;6:9:1:0:0;6:10:0:0:0;6:11:1:0:0;6:12:1:0:0;6:13:8:1:0;6:14:1:0:0;6:15:10:0:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:8:1:0;7:5:1:0:0;7:6:1:0:0;' +
                            '7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:8:1:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;8:1:0:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:0:0:0;8:6:1:0:0;8:7:1:0:0;8:8:0:0:0;8:9:1:0:0;8:10:1:0:0;8:11:0:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:0:0:' +
                            '0;9:1:0:0:0;9:2:0:0:0;9:3:1:0:0;9:4:1:0:0;9:5:0:0:0;9:6:0:0:0;9:7:9:4:0;9:8:1:0:0;9:9:9:5:0;9:10:0:0:0;9:11:0:0:0;9:12:1:0:0;9:13:1:0:0;9:14:0:0:0;9:15:0:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:0:0:0;10:7:0:0:0;10:8:1:0:0;10:9' +
                            ':0:0:0;10:10:0:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:0;10:14:1:0:0;10:15:1:0:0;11:1:3:1:k;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:11:2:0;11:7:0:0:0;11:8:0:0:0;11:9:0:0:0;11:10:11:1:0;11:11:1:0:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:15:5:1:' +
                            'd;';

    //Level 98
    NLA[18].Id            := 98;
    NLA[18].Matrix_X      := 11;
    NLA[18].Matrix_Y      := 16;
    NLA[18].Player_Count  := 6;
    NLA[18].Matrix_Value  := '1:1:2:1:e;1:2:1:0:0;1:3:0:0:0;1:4:0:0:0;1:5:0:0:0;1:6:9:7:0;1:7:1:0:0;1:8:0:0:0;1:9:0:0:0;1:10:1:0:0;1:11:9:6:0;1:12:0:0:0;1:13:0:0:0;1:14:0:0:0;1:15:1:0:0;1:16:7:1:y;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:8:1:0;2:6:1:0:0;2:7:1:0:0;2:8:0:0:0;2:9'+
                            ':0:0:0;2:10:1:0:0;2:11:1:0:0;2:12:8:1:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;3:1:0:0:0;3:2:1:0:0;3:3:1:0:0;3:4:1:0:0;3:5:8:1:0;3:6:1:0:0;3:7:1:0:0;3:8:1:0:0;3:9:1:0:0;3:10:1:0:0;3:11:1:0:0;3:12:8:1:0;3:13:1:0:0;3:14:1:0:0;3:15:1:0:0;3:16:0:0:0' +
                            ';4:1:0:0:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:0:0:0;4:6:8:1:0;4:7:8:1:0;4:8:0:0:0;4:9:0:0:0;4:10:8:1:0;4:11:8:1:0;4:12:0:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:0:0:0;5:1:0:0:0;5:2:1:0:0;5:3:9:1:0;5:4:1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:8:1:0;5:8:1:0:0;5:' +
                            '9:1:0:0;5:10:8:1:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:9:1:0;5:15:1:0:0;5:16:0:0:0;6:1:1:0:0;6:2:1:0:0;6:3:1:0:0;6:4:1:0:0;6:5:1:0:0;6:6:1:0:0;6:7:8:1:0;6:8:1:0:0;6:9:1:0:0;6:10:8:1:0;6:11:1:0:0;6:12:1:0:0;6:13:1:0:0;6:14:1:0:0;6:15:1:0:0;6:16:1:0:' +
                            '0;7:1:1:0:0;7:2:0:0:0;7:3:0:0:0;7:4:0:0:0;7:5:0:0:0;7:6:1:0:0;7:7:8:1:0;7:8:1:0:0;7:9:1:0:0;7:10:8:1:0;7:11:1:0:0;7:12:0:0:0;7:13:0:0:0;7:14:0:0:0;7:15:0:0:0;7:16:1:0:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0:0;8:7:0:0:0;8:8:1:0:0;8' +
                            ':9:1:0:0;8:10:0:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;9:1:0:0:0;9:2:1:0:0;9:3:0:0:0;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:0:0:0;9:8:1:0:0;9:9:1:0:0;9:10:0:0:0;9:11:0:0:0;9:12:1:0:0;9:13:1:0:0;9:14:0:0:0;9:15:1:0:0;9:16:0:0' +
                            ':0;10:1:1:0:0;10:2:1:0:0;10:3:0:0:0;10:4:1:0:0;10:5:1:0:0;10:6:0:0:0;10:7:0:0:0;10:8:1:0:0;10:9:1:0:0;10:10:0:0:0;10:11:0:0:0;10:12:1:0:0;10:13:1:0:0;10:14:0:0:0;10:15:1:0:0;10:16:1:0:0;11:1:3:1:k;11:2:1:0:0;11:3:0:0:0;11:4:1:0:e;11:5:4:1:a;11:6:0:0:' +
                            '0;11:7:0:0:0;11:8:1:0:a;11:9:1:0:k;11:10:0:0:0;11:11:0:0:0;11:12:5:1:d;11:13:1:0:a;11:14:0:0:0;11:15:1:0:0;11:16:6:1:p;';

    //Level 99
    NLA[19].Id            := 99;
    NLA[19].Matrix_X      := 11;
    NLA[19].Matrix_Y      := 13;
    NLA[19].Player_Count  := 6;
    NLA[19].Matrix_Value  := '1:1:7:1:y;1:2:1:0:0;1:3:1:0:0;1:4:11:3:0;1:5:0:0:0;1:6:0:0:0;1:7:11:1:0;1:8:0:0:0;1:9:0:0:0;1:10:11:2:0;1:11:1:0:0;1:12:1:0:0;1:13:4:1:a;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:0:0:0;2:5:0:0:0;2:6:1:0:0;2:7:1:0:0;2:8:1:0:0;2:9:0:0:0;2:10:0:0:0;2:11:1:0:0;2'+
                            ':12:1:0:0;2:13:1:0:0;3:1:1:0:y;3:2:1:0:0;3:3:1:0:0;3:4:1:0:0;3:5:0:0:0;3:6:1:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:1:0:0;3:13:1:0:a;4:1:0:0:0;4:2:0:0:0;4:3:0:0:0;4:4:0:0:0;4:5:11:2:0;4:6:1:0:0;4:7:1:0:0;4:8:1:0:0;4:9:11:3:0;4:1' +
                            '0:0:0:0;4:11:0:0:0;4:12:0:0:0;4:13:0:0:0;5:1:1:0:0;5:2:1:0:0;5:3:1:0:0;5:4:11:5:0;5:5:0:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:0:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;6:1:2:1:e;6:2:1:0:0;6:3:1:0:0;6:4:0:0:0;6:5:0:0:0;6:6:8:1:0;6:7:8:1:0;6:8:' +
                            '8:1:0;6:9:0:0:0;6:10:0:0:0;6:11:1:0:0;6:12:1:0:0;6:13:5:1:d;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:0:0:0;7:6:1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:0:0:0;7:10:11:6:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;8:1:0:0:0;8:2:0:0:0;8:3:0:0:0;8:4:0:0:0;8:5:11:5:0;8:6:' +
                            '1:0:0;8:7:1:0:0;8:8:1:0:0;8:9:11:4:0;8:10:0:0:0;8:11:0:0:0;8:12:0:0:0;8:13:0:0:0;9:1:1:0:k;9:2:1:0:0;9:3:1:0:0;9:4:1:0:0;9:5:0:0:0;9:6:1:0:0;9:7:1:0:0;9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:1:0:0;9:13:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10' +
                            ':4:0:0:0;10:5:0:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:0:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:0;11:1:3:1:k;11:2:1:0:0;11:3:1:0:0;11:4:11:4:0;11:5:0:0:0;11:6:0:0:0;11:7:11:6:0;11:8:0:0:0;11:9:0:0:0;11:10:11:1:0;11:11:1:0:0;11:12:1:0:0;' +
                            '11:13:6:1:p;';

    //Level 100
    NLA[20].Id            := 100;
    NLA[20].Matrix_X      := 11;
    NLA[20].Matrix_Y      := 15;
    NLA[20].Player_Count  := 6;
    NLA[20].Matrix_Value  := '1:1:2:2:g;1:2:1:0:0;1:3:1:0:0;1:4:0:0:0;1:5:0:0:0;1:6:1:0:0;1:7:1:0:0;1:8:6:1:b;1:9:1:0:0;1:10:1:0:0;1:11:0:0:0;1:12:0:0:0;1:13:1:0:0;1:14:1:0:0;1:15:5:2:m;2:1:0:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;2:8:1:0:0;2:9:1:0:0;2:10'+
                            ':1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:0:0:0;3:1:0:0:0;3:2:0:0:0;3:3:1:0:0;3:4:1:0:0;3:5:1:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:1:0:0;3:10:1:0:0;3:11:0:0:0;3:12:1:0:0;3:13:1:0:0;3:14:0:0:0;3:15:0:0:0;4:1:11:1:0;4:2:0:0:0;4:3:0:0:0;4' +
                            ':4:1:0:0;4:5:1:0:0;4:6:0:0:0;4:7:8:1:0;4:8:8:1:0;4:9:0:0:0;4:10:1:0:0;4:11:1:0:0;4:12:1:0:0;4:13:0:0:0;4:14:0:0:0;4:15:11:2:0;5:1:1:0:0;5:2:0:0:0;5:3:1:0:0;5:4:9:7:0;5:5:8:1:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:0:0:0;5:11:9:6:0;5:12:1:0:0;5' +
                            ':13:1:0:0;5:14:0:0:0;5:15:1:0:0;6:1:1:0:0;6:2:1:0:0;6:3:1:0:y;6:4:1:0:0;6:5:8:1:0;6:6:1:0:0;6:7:1:0:0;6:8:9:2:0;6:9:1:0:0;6:10:8:1:0;6:11:1:0:0;6:12:1:0:0;6:13:1:0:0;6:14:1:0:0;6:15:1:0:0;7:1:1:0:0;7:2:0:0:0;7:3:1:0:0;7:4:9:4:0;7:5:8:1:0;7:6:1:0:0;7:' +
                            '7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:0:0:0;7:11:9:5:0;7:12:1:0:0;7:13:1:0:0;7:14:0:0:0;7:15:1:0:0;8:1:11:2:0;8:2:0:0:0;8:3:0:0:0;8:4:1:0:0;8:5:1:0:0;8:6:0:0:0;8:7:8:1:0;8:8:8:1:0;8:9:0:0:0;8:10:1:0:0;8:11:1:0:0;8:12:1:0:0;8:13:0:0:0;8:14:0:0:0;8:15:11:1:' +
                            '0;9:1:0:0:0;9:2:0:0:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:1:0:0;9:8:1:0:0;9:9:1:0:0;9:10:1:0:0;9:11:0:0:0;9:12:1:0:0;9:13:1:0:0;9:14:0:0:0;9:15:0:0:0;10:1:0:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9' +
                            ':1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:0;10:14:1:0:0;10:15:0:0:0;11:1:3:2:r;11:2:1:0:0;11:3:1:0:0;11:4:0:0:0;11:5:0:0:0;11:6:1:0:0;11:7:1:0:0;11:8:7:1:n;11:9:1:0:0;11:10:1:0:0;11:11:0:0:0;11:12:0:0:0;11:13:1:0:0;11:14:1:0:0;11:15:4:2:s;';

    //Level 101
    NLA[21].Id            := 101;
    NLA[21].Matrix_X      := 11;
    NLA[21].Matrix_Y      := 17;
    NLA[21].Player_Count  := 6;
    NLA[21].Matrix_Value  := '1:1:0:0:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:1:0:0;1:8:0:0:0;1:9:0:0:0;1:10:0:0:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:0:0:0;2:1:7:1:y;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;2:'+
                            '8:1:0:0;2:9:0:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:6:1:p;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:0:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:0:0:0;3:14:0:0:0' +
                            ';3:15:0:0:0;3:16:1:0:0;3:17:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:0:0:0;4:4:1:0:0;4:5:3:1:k;4:6:0:0:0;4:7:1:0:0;4:8:11:2:0;4:9:0:0:0;4:10:11:1:0;4:11:1:0:0;4:12:0:0:0;4:13:1:0:0;4:14:2:1:e;4:15:0:0:0;4:16:1:0:0;4:17:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:0:0:0;5:4:1:' +
                            '0:0;5:5:1:0:0;5:6:0:0:0;5:7:1:0:0;5:8:1:0:0;5:9:0:0:0;5:10:1:0:0;5:11:1:0:0;5:12:0:0:0;5:13:1:0:0;5:14:1:0:0;5:15:0:0:0;5:16:1:0:0;5:17:1:0:0;6:1:1:0:0;6:2:1:0:0;6:3:0:0:0;6:4:1:0:0;6:5:1:0:0;6:6:1:0:0;6:7:1:0:0;6:8:1:0:0;6:9:0:0:0;6:10:1:0:0;6:11:1:' +
                            '0:0;6:12:1:0:0;6:13:1:0:0;6:14:1:0:0;6:15:0:0:0;6:16:1:0:0;6:17:1:0:0;7:1:1:0:0;7:2:1:0:0;7:3:0:0:0;7:4:0:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:0:0:0;7:9:0:0:0;7:10:0:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:0:0:0;7:15:0:0:0;7:16:1:0:0;7:17:1:0:0;8:' +
                            '1:1:0:0;8:2:1:0:0;8:3:0:0:0;8:4:0:0:0;8:5:0:0:0;8:6:0:0:0;8:7:0:0:0;8:8:0:0:0;8:9:0:0:0;8:10:0:0:0;8:11:0:0:0;8:12:0:0:0;8:13:0:0:0;8:14:0:0:0;8:15:0:0:0;8:16:1:0:0;8:17:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:1:0:0;9:7:1:0:0;9:8:' +
                            '1:0:0;9:9:1:0:0;9:10:1:0:0;9:11:1:0:0;9:12:1:0:0;9:13:1:0:0;9:14:1:0:0;9:15:1:0:0;9:16:1:0:0;9:17:1:0:0;10:1:4:1:a;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:0' +
                            ';10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:5:1:d;11:1:0:0:0;11:2:1:0:0;11:3:0:0:0;11:4:10:0:0;11:5:0:0:0;11:6:11:3:0;11:7:0:0:0;11:8:11:1:0;11:9:0:0:0;11:10:11:2:0;11:11:0:0:0;11:12:11:3:0;11:13:0:0:0;11:14:10:0:0;11:15:0:0:0;11:16:1:0:0;11:17:0:0:0;';

    //Level 102
    NLA[22].Id            := 102;
    NLA[22].Matrix_X      := 11;
    NLA[22].Matrix_Y      := 17;
    NLA[22].Player_Count  := 6;
    NLA[22].Matrix_Value  := '1:1:1:0:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:0:0:0;1:6:1:0:0;1:7:1:0:0;1:8:0:0:0;1:9:1:0:0;1:10:0:0:0;1:11:1:0:0;1:12:1:0:0;1:13:0:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:1:0:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:0:0:0;2:6:1:0:0;2:7:1:0:0;2:'+
                            '8:1:0:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:0:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:0:0:0;3:3:0:0:0;3:4:11:1:0;3:5:0:0:0;3:6:11:5:0;3:7:0:0:0;3:8:0:0:0;3:9:5:1:d;3:10:0:0:0;3:11:0:0:0;3:12:1:0:0;3:13:0:0:0;3:14:11:' +
                            '3:0;3:15:0:0:0;3:16:0:0:0;3:17:1:0:0;4:1:4:1:a;4:2:0:0:0;4:3:11:6:0;4:4:0:0:0;4:5:1:0:0;4:6:0:0:0;4:7:11:4:0;4:8:0:0:0;4:9:0:0:0;4:10:0:0:0;4:11:11:2:0;4:12:0:0:0;4:13:1:0:0;4:14:0:0:0;4:15:1:0:0;4:16:0:0:0;4:17:6:1:p;5:1:0:0:0;5:2:1:0:0;5:3:1:0:0;5:' +
                            '4:1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:1:0:0;5:17:0:0:0;6:1:10:0:0;6:2:1:0:0;6:3:0:0:0;6:4:1:0:0;6:5:9:1:0;6:6:1:0:0;6:7:0:0:0;6:8:1:0:0;6:9:9:1:0;6:10:1:0:0;6:' +
                            '11:0:0:0;6:12:1:0:0;6:13:9:1:0;6:14:1:0:0;6:15:0:0:0;6:16:1:0:0;6:17:10:0:0;7:1:0:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:0:' +
                            '0:0;8:1:7:1:y;8:2:0:0:0;8:3:1:0:0;8:4:0:0:0;8:5:1:0:0;8:6:0:0:0;8:7:11:3:0;8:8:0:0:0;8:9:0:0:0;8:10:0:0:0;8:11:11:1:0;8:12:0:0:0;8:13:1:0:0;8:14:0:0:0;8:15:11:5:0;8:16:0:0:0;8:17:0:0:0;9:1:1:0:0;9:2:0:0:0;9:3:0:0:0;9:4:11:2:0;9:5:0:0:0;9:6:1:0:0;9:7:' +
                            '0:0:0;9:8:0:0:0;9:9:2:1:e;9:10:0:0:0;9:11:0:0:0;9:12:11:6:0;9:13:0:0:0;9:14:11:4:0;9:15:0:0:0;9:16:0:0:0;9:17:3:1:k;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:0:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0' +
                            ';10:13:0:0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:1:0:0;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:0:0:0;11:6:1:0:0;11:7:1:0:0;11:8:0:0:0;11:9:1:0:0;11:10:0:0:0;11:11:1:0:0;11:12:1:0:0;11:13:0:0:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:' +
                            '1:0:0;';

    //Level 103
    NLA[23].Id            := 103;
    NLA[23].Matrix_X      := 11;
    NLA[23].Matrix_Y      := 17;
    NLA[23].Player_Count  := 4;
    NLA[23].Matrix_Value  := '1:1:11:3:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:1:0:0;1:8:11:2:0;1:9:0:0:0;1:10:11:2:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:9:7:0;1:15:0:0:0;1:16:1:0:0;1:17:5:1:d;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0'+
                            ';2:8:1:0:0;2:9:0:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:0:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:0:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:1:0:0;3:14:1:' +
                            '0:0;3:15:0:0:0;3:16:1:0:0;3:17:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:0:0:0;4:4:2:1:e;4:5:1:0:0;4:6:0:0:0;4:7:1:0:0;4:8:1:0:0;4:9:0:0:0;4:10:1:0:0;4:11:1:0:0;4:12:0:0:0;4:13:1:0:0;4:14:1:0:0;4:15:0:0:0;4:16:1:0:0;4:17:1:0:0;5:1:9:7:0;5:2:1:0:0;5:3:0:0:0;5:4:1' +
                            ':0:0;5:5:1:0:0;5:6:0:0:0;5:7:1:0:0;5:8:1:0:0;5:9:0:0:0;5:10:1:0:0;5:11:1:0:0;5:12:0:0:0;5:13:1:0:0;5:14:1:0:0;5:15:0:0:0;5:16:1:0:0;5:17:1:0:0;6:1:1:0:0;6:2:1:0:0;6:3:0:0:0;6:4:1:0:0;6:5:1:0:0;6:6:0:0:0;6:7:1:0:0;6:8:9:3:0;6:9:0:0:0;6:10:9:3:0;6:11:1' +
                            ':0:0;6:12:0:0:0;6:13:1:0:0;6:14:1:0:0;6:15:0:0:0;6:16:1:0:0;6:17:1:0:0;7:1:1:0:0;7:2:1:0:0;7:3:0:0:0;7:4:1:0:0;7:5:1:0:0;7:6:0:0:0;7:7:1:0:0;7:8:1:0:0;7:9:0:0:0;7:10:1:0:0;7:11:1:0:0;7:12:0:0:0;7:13:1:0:0;7:14:1:0:0;7:15:0:0:0;7:16:1:0:0;7:17:9:5:0;8' +
                            ':1:1:0:0;8:2:1:0:0;8:3:0:0:0;8:4:1:0:0;8:5:1:0:0;8:6:0:0:0;8:7:1:0:0;8:8:1:0:0;8:9:0:0:0;8:10:1:0:0;8:11:1:0:0;8:12:0:0:0;8:13:3:1:k;8:14:1:0:0;8:15:0:0:0;8:16:1:0:0;8:17:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:0:0:0;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:1:0:0;9:8' +
                            ':1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:0:0:0;9:14:0:0:0;9:15:0:0:0;9:16:1:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:0:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:' +
                            '0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:4:1:a;11:2:1:0:0;11:3:0:0:0;11:4:9:5:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:11:1:0;11:9:0:0:0;11:10:11:1:0;11:11:1:0:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:11:3:0;';

    //Level 104
    NLA[24].Id            := 104;
    NLA[24].Matrix_X      := 11;
    NLA[24].Matrix_Y      := 17;
    NLA[24].Player_Count  := 6;
    NLA[24].Matrix_Value  := '1:1:11:3:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:9:1:0;1:6:1:0:0;1:7:1:0:0;1:8:1:0:0;1:9:11:5:0;1:10:1:0:0;1:11:1:0:0;1:12:1:0:0;1:13:9:1:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:11:4:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0'+
                            ';2:8:1:0:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:1:0:0;3:4:0:0:0;3:5:0:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:0:0:0;3:14:0:' +
                            '0:0;3:15:1:0:0;3:16:1:0:0;3:17:1:0:0;4:1:0:0:0;4:2:0:0:0;4:3:0:0:0;4:4:0:0:0;4:5:4:1:a;4:6:0:0:0;4:7:0:0:0;4:8:0:0:0;4:9:3:1:k;4:10:0:0:0;4:11:0:0:0;4:12:0:0:0;4:13:6:1:p;4:14:0:0:0;4:15:0:0:0;4:16:0:0:0;4:17:0:0:0;5:1:1:0:0;5:2:1:0:0;5:3:1:0:0;5:4:1' +
                            ':0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:1:0:0;5:17:1:0:0;6:1:11:6:0;6:2:1:0:0;6:3:1:0:0;6:4:1:0:0;6:5:1:0:0;6:6:11:4:0;6:7:1:0:0;6:8:11:1:0;6:9:1:0:0;6:10:11:2:0;6:' +
                            '11:1:0:0;6:12:11:3:0;6:13:1:0:0;6:14:1:0:0;6:15:1:0:0;6:16:1:0:0;6:17:11:5:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:1' +
                            ':0:0;8:1:0:0:0;8:2:0:0:0;8:3:0:0:0;8:4:0:0:0;8:5:7:1:y;8:6:0:0:0;8:7:0:0:0;8:8:0:0:0;8:9:2:1:e;8:10:0:0:0;8:11:0:0:0;8:12:0:0:0;8:13:5:1:d;8:14:0:0:0;8:15:0:0:0;8:16:0:0:0;8:17:0:0:0;9:1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:0:0:0;9:5:0:0:0;9:6:0:0:0;9:7:1:0' +
                            ':0;9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:0:0:0;9:14:0:0:0;9:15:1:0:0;9:16:1:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0;10:1' +
                            '3:1:0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:11:2:0;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:9:1:0;11:6:1:0:0;11:7:1:0:0;11:8:1:0:0;11:9:11:6:0;11:10:1:0:0;11:11:1:0:0;11:12:1:0:0;11:13:9:1:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:11:' +
                            '1:0;';

    //Level 105
    NLA[25].Id            := 105;
    NLA[25].Matrix_X      := 11;
    NLA[25].Matrix_Y      := 15;
    NLA[25].Player_Count  := 4;
    NLA[25].Matrix_Value  := '1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;1:4:2:1:e;1:5:0:0:0;1:6:0:0:0;1:7:0:0:0;1:8:0:0:0;1:9:11:1:0;1:10:1:0:0;1:11:1:0:0;1:12:0:0:0;1:13:0:0:0;1:14:0:0:0;1:15:0:0:0;2:1:0:0:0;2:2:0:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:0:0:0;2:7:0:0:0;2:8:0:0:0;2:9:1:0:0;2:1'+
                            '0:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:0:0:0;2:14:0:0:0;2:15:0:0:0;3:1:0:0:0;3:2:1:0:0;3:3:1:0:0;3:4:0:0:0;3:5:1:0:0;3:6:1:0:0;3:7:0:0:0;3:8:0:0:0;3:9:1:0:0;3:10:0:0:0;3:11:1:0:0;3:12:1:0:0;3:13:5:1:d;3:14:0:0:0;3:15:0:0:0;4:1:1:0:0;4:2:1:0:0;4:3:0:0:0;4' +
                            ':4:0:0:0;4:5:0:0:0;4:6:1:0:0;4:7:1:0:0;4:8:0:0:0;4:9:1:0:0;4:10:1:0:0;4:11:1:0:0;4:12:1:0:0;4:13:0:0:0;4:14:0:0:0;4:15:0:0:0;5:1:11:2:0;5:2:1:0:0;5:3:1:0:0;5:4:1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:0:0:0;5' +
                            ':13:0:0:0;5:14:0:0:0;5:15:0:0:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:1:0:0;6:8:9:2:0;6:9:1:0:0;6:10:0:0:0;6:11:0:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;7:1:0:0:0;7:2:0:0:0;7:3:0:0:0;7:4:0:0:0;7:5:1:0:0;7:6:1:0:0;7:' +
                            '7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:11:2:0;8:1:0:0:0;8:2:0:0:0;8:3:0:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:0:0:0;8:9:1:0:0;8:10:1:0:0;8:11:0:0:0;8:12:0:0:0;8:13:0:0:0;8:14:1:0:0;8:15:1:0:0' +
                            ';9:1:0:0:0;9:2:0:0:0;9:3:3:1:k;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:1:0:0;9:8:0:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:1:0:0;9:14:1:0:0;9:15:0:0:0;10:1:0:0:0;10:2:0:0:0;10:3:0:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:0:0:0;10:9:' +
                            '0:0:0;10:10:0:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:0;10:14:0:0:0;10:15:0:0:0;11:1:0:0:0;11:2:0:0:0;11:3:0:0:0;11:4:0:0:0;11:5:1:0:0;11:6:1:0:0;11:7:11:1:0;11:8:0:0:0;11:9:0:0:0;11:10:0:0:0;11:11:0:0:0;11:12:4:1:a;11:13:0:0:0;11:14:0:0:0;11:15:0:0:0;';

    //Level 106
    NLA[26].Id            := 106;
    NLA[26].Matrix_X      := 11;
    NLA[26].Matrix_Y      := 17;
    NLA[26].Player_Count  := 4;
    NLA[26].Matrix_Value  := '1:1:9:2:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:1:0:0;1:8:1:0:0;1:9:0:0:0;1:10:1:0:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:9:2:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;2:'+
                            '8:11:2:0;2:9:0:0:0;2:10:11:4:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:0:0:0;3:6:0:0:0;3:7:0:0:0;3:8:0:0:0;3:9:0:0:0;3:10:0:0:0;3:11:0:0:0;3:12:0:0:0;3:13:0:0:0;3:14:0:0' +
                            ':0;3:15:0:0:0;3:16:1:0:0;3:17:11:5:0;4:1:11:6:0;4:2:1:0:0;4:3:0:0:0;4:4:11:1:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:1:0:0;4:9:0:0:0;4:10:1:0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:11:3:0;4:15:0:0:0;4:16:1:0:0;4:17:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:0:0:0;5:' +
                            '4:1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:4:1:a;5:9:0:0:0;5:10:3:1:k;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:0:0:0;5:16:1:0:0;5:17:1:0:0;6:1:8:1:0;6:2:8:1:0;6:3:0:0:0;6:4:8:1:0;6:5:8:1:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:0:0:0;6:10:0:0:0;6:1' +
                            '1:0:0:0;6:12:0:0:0;6:13:8:1:0;6:14:8:1:0;6:15:0:0:0;6:16:8:1:0;6:17:8:1:0;7:1:1:0:0;7:2:1:0:0;7:3:0:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:5:1:d;7:9:0:0:0;7:10:2:1:e;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:0:0:0;7:16:1:0:0;7:17:1:0:' +
                            '0;8:1:11:5:0;8:2:1:0:0;8:3:0:0:0;8:4:11:2:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:1:0:0;8:9:0:0:0;8:10:1:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:11:4:0;8:15:0:0:0;8:16:1:0:0;8:17:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:0:0:0;9:4:0:0:0;9:5:0:0:0;9:6:0:0:0;9:7:0:0' +
                            ':0;9:8:0:0:0;9:9:0:0:0;9:10:0:0:0;9:11:0:0:0;9:12:0:0:0;9:13:0:0:0;9:14:0:0:0;9:15:0:0:0;9:16:1:0:0;9:17:11:6:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:11:1:0;10:9:0:0:0;10:10:11:3:0;10:11:1:0:0;10:12:1:0:0;1' +
                            '0:13:1:0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:9:2:0;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:1:0:0;11:9:0:0:0;11:10:1:0:0;11:11:1:0:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:9:' +
                            '2:0;';

    //Level 107
    NLA[27].Id            := 107;
    NLA[27].Matrix_X      := 11;
    NLA[27].Matrix_Y      := 17;
    NLA[27].Player_Count  := 4;
    NLA[27].Matrix_Value  := '1:1:11:3:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:1:0:0;1:8:11:5:0;1:9:0:0:0;1:10:1:0:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:11:3:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:0:0:0;2:5:0:0:0;2:6:1:0:0;2:7:1:0:0'+
                            ';2:8:1:0:0;2:9:0:0:0;2:10:4:1:a;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:0:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:0:0:0;3:11:0:0:0;3:12:0:0:0;3:13:0:0:0;3:14:0:' +
                            '0:0;3:15:0:0:0;3:16:1:0:0;3:17:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:1:0:0;4:4:0:0:0;4:5:0:0:0;4:6:1:0:0;4:7:1:0:0;4:8:1:0:0;4:9:0:0:0;4:10:11:1:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:0:0:0;4:16:1:0:0;4:17:1:0:0;5:1:11:6:0;5:2:1:0:0;5:3:1:0:0;5:4' +
                            ':1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:11:2:0;5:9:0:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:2:1:e;5:15:0:0:0;5:16:1:0:0;5:17:1:0:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:8:1:0;6:5:8:1:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:0:0:0;6:10:1:0:0;6:1' +
                            '1:1:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:9:3:0;6:17:1:0:0;7:1:11:5:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:11:1:0;7:9:0:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:3:1:k;7:15:0:0:0;7:16:1:0:0;7:17:1:' +
                            '0:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:0:0:0;8:5:0:0:0;8:6:1:0:0;8:7:1:0:0;8:8:1:0:0;8:9:0:0:0;8:10:11:2:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:0:0:0;8:16:1:0:0;8:17:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:0:0:0;9:4:0:0:0;9:5:0:0:0;9:6:0:0:0;9:7:1:0' +
                            ':0;9:8:1:0:0;9:9:0:0:0;9:10:0:0:0;9:11:0:0:0;9:12:0:0:0;9:13:0:0:0;9:14:0:0:0;9:15:0:0:0;9:16:1:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:0:0:0;10:5:0:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:5:1:d;10:11:1:0:0;10:12:1:0:0;10:1' +
                            '3:1:0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:11:4:0;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:11:6:0;11:9:0:0:0;11:10:1:0:0;11:11:1:0:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:11:' +
                            '4:0;';

    //Level 108
    NLA[28].Id            := 108;
    NLA[28].Matrix_X      := 11;
    NLA[28].Matrix_Y      := 17;
    NLA[28].Player_Count  := 6;
    NLA[28].Matrix_Value  := '1:1:2:1:e;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:1:0:0;1:8:11:5:0;1:9:0:0:0;1:10:11:3:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:11:2:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0'+
                            ';2:8:1:0:0;2:9:0:0:0;2:10:1:0:0;2:11:1:0:0;2:12:0:0:0;2:13:0:0:0;2:14:0:0:0;2:15:0:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:0:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:5:1:d;3:14:1:' +
                            '0:0;3:15:0:0:0;3:16:1:0:0;3:17:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:1:0:0;4:9:0:0:0;4:10:1:0:0;4:11:1:0:0;4:12:0:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:1:0:0;4:17:1:0:0;5:1:0:0:0;5:2:11:1:0;5:3:1:0:0;5:4:' +
                            '1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:11:2:0;5:8:0:0:0;5:9:0:0:0;5:10:4:1:a;5:11:1:0:0;5:12:0:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:1:0:0;5:17:11:5:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:0:0:0;6:10:0:0:0;6:1' +
                            '1:0:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:11:4:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:11:3:0;7:9:0:0:0;7:10:11:4:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:6' +
                            ':1:p;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:1:0:0;8:9:0:0:0;8:10:1:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;8:17:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:0:0:0;9:4:0:0:0;9:5:0:0:0;9:6:0:0:0;9:7:1:0' +
                            ':0;9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:11:6:0;9:14:1:0:0;9:15:0:0:0;9:16:0:0:0;9:17:0:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0;10:' +
                            '13:1:0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:3:1:k;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:11:6:0;11:9:0:0:0;11:10:11:1:0;11:11:1:0:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:7:' +
                            '1:y;';

    //Level 109
    NLA[29].Id            := 109;
    NLA[29].Matrix_X      := 11;
    NLA[29].Matrix_Y      := 17;
    NLA[29].Player_Count  := 6;
    NLA[29].Matrix_Value  := '1:1:1:0:0;1:2:1:0:0;1:3:1:0:0;1:4:11:3:0;1:5:1:0:0;1:6:11:1:0;1:7:1:0:0;1:8:1:0:0;1:9:0:0:0;1:10:0:0:0;1:11:0:0:0;1:12:0:0:0;1:13:0:0:0;1:14:0:0:0;1:15:0:0:0;1:16:0:0:0;1:17:0:0:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;'+
                            '2:8:1:0:0;2:9:0:0:0;2:10:0:0:0;2:11:0:0:0;2:12:0:0:0;2:13:0:0:0;2:14:0:0:0;2:15:0:0:0;2:16:0:0:0;2:17:0:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:1:0:0;3:5:1:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:0:0:0;3:11:0:0:0;3:12:0:0:0;3:13:0:0:0;3:14:0:0' +
                            ':0;3:15:0:0:0;3:16:0:0:0;3:17:0:0:0;4:1:1:0:0;4:2:1:0:0;4:3:0:0:0;4:4:1:0:0;4:5:1:0:0;4:6:0:0:0;4:7:1:0:0;4:8:1:0:0;4:9:0:0:0;4:10:11:1:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:1:0:0;4:17:4:1:a;5:1:2:1:e;5:2:1:0:0;5:3:0:0:0;5:4:1' +
                            '1:4:0;5:5:1:0:0;5:6:0:0:0;5:7:1:0:0;5:8:3:1:k;5:9:0:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:1:0:0;5:17:1:0:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:0:0:0;6:10:1:0:0;6:11:' +
                            '1:0:0;6:12:0:0:0;6:13:11:3:0;6:14:1:0:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:11:2:0;7:7:1:0:0;7:8:11:4:0;7:9:0:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:1:0' +
                            ':0;8:1:7:1:y;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:1:0:0;8:9:0:0:0;8:10:11:2:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;8:17:5:1:d;9:1:0:0:0;9:2:0:0:0;9:3:0:0:0;9:4:0:0:0;9:5:0:0:0;9:6:0:0:0;9:7:1:0:' +
                            '0;9:8:1:0:0;9:9:0:0:0;9:10:0:0:0;9:11:0:0:0;9:12:0:0:0;9:13:0:0:0;9:14:0:0:0;9:15:0:0:0;9:16:0:0:0;9:17:0:0:0;10:1:0:0:0;10:2:0:0:0;10:3:0:0:0;10:4:0:0:0;10:5:0:0:0;10:6:0:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:0:0:0;10:11:0:0:0;10:12:0:0:0;10:13' +
                            ':0:0:0;10:14:0:0:0;10:15:0:0:0;10:16:0:0:0;10:17:0:0:0;11:1:0:0:0;11:2:0:0:0;11:3:0:0:0;11:4:0:0:0;11:5:0:0:0;11:6:0:0:0;11:7:6:1:p;11:8:1:0:0;11:9:0:0:0;11:10:0:0:0;11:11:0:0:0;11:12:0:0:0;11:13:0:0:0;11:14:0:0:0;11:15:0:0:0;11:16:0:0:0;11:17:0:0:0;';

    //Level 110
    NLA[30].Id            := 110;
    NLA[30].Matrix_X      := 11;
    NLA[30].Matrix_Y      := 17;
    NLA[30].Player_Count  := 6;
    NLA[30].Matrix_Value  := '1:1:2:1:e;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:0:0:0;1:6:0:0:0;1:7:1:0:0;1:8:11:2:0;1:9:0:0:0;1:10:11:3:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:4:1:a;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:0:0:0;2:6:0:0:0;2:7:1:0:0;'+
                            '2:8:1:0:0;2:9:0:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:0:0:0;3:2:0:0:0;3:3:1:0:0;3:4:1:0:0;3:5:0:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:11:6:0;3:14:1:' +
                            '0:0;3:15:0:0:0;3:16:0:0:0;3:17:0:0:0;4:1:1:0:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:1:0:0;4:9:0:0:0;4:10:1:0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:1:0:0;4:17:1:0:0;5:1:11:4:0;5:2:1:0:0;5:3:1:0:0;5:4:' +
                            '1:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:11:3:0;5:9:0:0:0;5:10:11:5:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:1:0:0;5:17:6:1:p;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:0:0:0;6:10:0:0:0;6:1' +
                            '1:0:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:11:4:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:11:2:0;7:6:0:0:0;7:7:3:1:k;7:8:1:0:0;7:9:0:0:0;7:10:11:1:0;7:11:1:0:0;7:12:0:0:0;7:13:0:0:0;7:14:0:0:0;7:15:0:0:0;7:16:0:0:0;7:17:0' +
                            ':0:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:0:0:0;8:7:1:0:0;8:8:1:0:0;8:9:0:0:0;8:10:1:0:0;8:11:1:0:0;8:12:0:0:0;8:13:0:0:0;8:14:0:0:0;8:15:0:0:0;8:16:0:0:0;8:17:0:0:0;9:1:1:0:0;9:2:1:0:0;9:3:0:0:0;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:1:0' +
                            ':0;9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:1:0:0;9:13:1:0:0;9:14:1:0:0;9:15:1:0:0;9:16:1:0:0;9:17:7:1:y;10:1:1:0:0;10:2:1:0:0;10:3:0:0:0;10:4:1:0:0;10:5:1:0:0;10:6:0:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:1:0:0;10:11:1:0:0;10:12:0:0:0;10:1' +
                            '3:0:0:0;10:14:0:0:0;10:15:0:0:0;10:16:0:0:0;10:17:0:0:0;11:1:5:1:d;11:2:1:0:0;11:3:0:0:0;11:4:11:1:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:11:5:0;11:9:0:0:0;11:10:11:6:0;11:11:1:0:0;11:12:0:0:0;11:13:0:0:0;11:14:0:0:0;11:15:0:0:0;11:16:0:0:0;11:17:0:' +
                            '0:0;';

    //Level 111
    NLA[31].Id            := 111;
    NLA[31].Matrix_X      := 11;
    NLA[31].Matrix_Y      := 17;
    NLA[31].Player_Count  := 6;
    NLA[31].Matrix_Value  := '1:1:11:2:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:1:0:0;1:8:11:1:0;1:9:0:0:0;1:10:11:4:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:11:3:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:'+
                            '0;2:8:1:0:0;2:9:0:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:1:0:0;3:5:1:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:0:0:0;3:14:0' +
                            ':0:0;3:15:0:0:0;3:16:1:0:0;3:17:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:0:0:0;4:4:1:0:0;4:5:1:0:0;4:6:0:0:0;4:7:1:0:0;4:8:1:0:0;4:9:0:0:0;4:10:1:0:0;4:11:1:0:0;4:12:1:0:0;4:13:0:0:0;4:14:0:0:0;4:15:1:0:0;4:16:1:0:0;4:17:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:3:1:k;5:4:' +
                            '0:0:0;5:5:11:5:0;5:6:1:0:0;5:7:1:0:0;5:8:0:0:0;5:9:0:0:0;5:10:0:0:0;5:11:4:1:a;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:11:6:0;5:17:0:0:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:0:0:0;6:10:0:0:0;6:1' +
                            '1:0:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:11:1:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:11:6:0;7:6:0:0:0;7:7:2:1:e;7:8:1:0:0;7:9:0:0:0;7:10:11:2:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:1' +
                            '1:3:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:0:0:0;8:7:1:0:0;8:8:1:0:0;8:9:0:0:0;8:10:1:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;8:17:1:0:0;9:1:0:0:0;9:2:0:0:0;9:3:0:0:0;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:1:' +
                            '0:0;9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:1:0:0;9:14:1:0:0;9:15:0:0:0;9:16:1:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:1:0:0;10:11:1:0:0;10:12:0:0:0;10:' +
                            '13:1:0:0;10:14:1:0:0;10:15:0:0:0;10:16:1:0:0;10:17:1:0:0;11:1:7:1:y;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:11:4:0;11:9:0:0:0;11:10:5:1:d;11:11:1:0:0;11:12:0:0:0;11:13:11:5:0;11:14:1:0:0;11:15:0:0:0;11:16:6:1:p;11:17:1:' +
                            '0:0;';

    //Level 112
    NLA[32].Id            := 112;
    NLA[32].Matrix_X      := 11;
    NLA[32].Matrix_Y      := 17;
    NLA[32].Player_Count  := 4;
    NLA[32].Matrix_Value  := '1:1:11:1:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:0:0:0;1:7:9:7:0;1:8:1:0:0;1:9:1:0:0;1:10:1:0:0;1:11:9:6:0;1:12:0:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:11:2:e;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:5:1:d;2:5:0:0:0;2:6:1:0:0;2:7:1:0:0;'+
                            '2:8:1:0:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:0:0:0;2:14:2:1:e;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:1:0:0;3:4:0:0:0;3:5:11:1:0;3:6:1:0:0;3:7:1:0:0;3:8:0:0:0;3:9:0:0:0;3:10:0:0:0;3:11:1:0:0;3:12:1:0:0;3:13:11:2:0;3:14:0' +
                            ':0:0;3:15:1:0:0;3:16:1:0:0;3:17:1:0:0;4:1:0:0:0;4:2:0:0:0;4:3:0:0:0;4:4:1:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:0:0:0;4:16:0:0:0;4:17:0:0:0;5:1:11:6:0;5:2:1:0:0;5:3:1:0:0;5:4' +
                            ':1:0:0;5:5:1:0:0;5:6:0:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:0:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:1:0:0;5:17:11:5:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:1:0:0;6:7:0:0:0;6:8:1:0:0;6:9:1:0:0;6:10:0:0:0;6:1' +
                            '1:1:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:11:5:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:0:0:0;7:9:0:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:11:' +
                            '6:0;8:1:0:0:0;8:2:0:0:0;8:3:0:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:0:0:0;8:16:0:0:0;8:17:0:0:0;9:1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:0:0:0;9:5:11:4:0;9:6:1:0:0;9:7:1:0' +
                            ':0;9:8:0:0:0;9:9:0:0:0;9:10:0:0:0;9:11:1:0:0;9:12:1:0:0;9:13:11:3:0;9:14:0:0:0;9:15:1:0:0;9:16:1:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:4:1:a;10:5:0:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0;10:' +
                            '13:0:0:0;10:14:3:1:k;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:11:4:0;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:0:0:0;11:7:9:4:0;11:8:1:0:0;11:9:1:0:0;11:10:1:0:0;11:11:9:5:0;11:12:0:0:0;11:13:1:0:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:11:' +
                            '3:0;';

    //Level 113
    NLA[33].Id            := 113;
    NLA[33].Matrix_X      := 11;
    NLA[33].Matrix_Y      := 17;
    NLA[33].Player_Count  := 4;
    NLA[33].Matrix_Value  := '1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;1:4:0:0:0;1:5:9:6:0;1:6:1:0:0;1:7:1:0:0;1:8:1:0:0;1:9:1:0:0;1:10:1:0:0;1:11:1:0:0;1:12:1:0:0;1:13:9:7:0;1:14:0:0:0;1:15:0:0:0;1:16:0:0:0;1:17:0:0:0;2:1:0:0:0;2:2:1:0:0;2:3:0:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:11:2:0;2'+
                            ':8:0:0:0;2:9:1:0:0;2:10:0:0:0;2:11:11:3:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:0:0:0;2:16:0:0:0;2:17:0:0:0;3:1:1:0:0;3:2:1:0:0;3:3:1:0:0;3:4:1:0:0;3:5:1:0:0;3:6:1:0:0;3:7:0:0:0;3:8:11:4:0;3:9:0:0:0;3:10:11:1:0;3:11:0:0:0;3:12:1:0:0;3:13:1:0:0;3:14:1' +
                            ':0:0;3:15:1:0:0;3:16:1:0:0;3:17:0:0:0;4:1:1:0:0;4:2:0:0:0;4:3:1:0:0;4:4:1:0:0;4:5:1:0:0;4:6:0:0:0;4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:1:0:0;4:12:0:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:1:0:0;4:17:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:1:0:0;5:4:' +
                            '1:0:0;5:5:0:0:0;5:6:1:0:0;5:7:1:0:0;5:8:0:0:0;5:9:3:1:k;5:10:0:0:0;5:11:1:0:0;5:12:1:0:0;5:13:0:0:0;5:14:1:0:0;5:15:1:0:0;5:16:0:0:0;5:17:0:0:0;6:1:0:0:0;6:2:1:0:0;6:3:0:0:0;6:4:1:0:0;6:5:1:0:0;6:6:0:0:0;6:7:1:0:0;6:8:4:1:a;6:9:0:0:0;6:10:2:1:e;6:11:' +
                            '1:0:0;6:12:0:0:0;6:13:1:0:0;6:14:1:0:0;6:15:0:0:0;6:16:1:0:0;6:17:0:0:0;7:1:0:0:0;7:2:0:0:0;7:3:0:0:0;7:4:1:0:0;7:5:0:0:0;7:6:1:0:0;7:7:1:0:0;7:8:0:0:0;7:9:5:1:d;7:10:0:0:0;7:11:1:0:0;7:12:1:0:0;7:13:0:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:1:0:0;' +
                            '8:1:0:0:0;8:2:0:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:0:0:0;8:7:1:0:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:1:0:0;8:12:0:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:0:0:0;8:17:1:0:0;9:1:0:0:0;9:2:1:0:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:1:0:0;9:7:0:0:0;9:' +
                            '8:11:3:0;9:9:0:0:0;9:10:11:2:0;9:11:0:0:0;9:12:1:0:0;9:13:1:0:0;9:14:1:0:0;9:15:1:0:0;9:16:1:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:11:1:0;10:8:0:0:0;10:9:1:0:0;10:10:0:0:0;10:11:11:4:0;10:12:1:0:0;10:13' +
                            ':1:0:0;10:14:1:0:0;10:15:0:0:0;10:16:1:0:0;10:17:0:0:0;11:1:0:0:0;11:2:0:0:0;11:3:0:0:0;11:4:0:0:0;11:5:9:5:0;11:6:1:0:0;11:7:1:0:0;11:8:1:0:0;11:9:1:0:0;11:10:1:0:0;11:11:1:0:0;11:12:1:0:0;11:13:9:4:0;11:14:0:0:0;11:15:0:0:0;11:16:0:0:0;11:17:0:0:0;';

    //Level 114
    NLA[34].Id            := 114;
    NLA[34].Matrix_X      := 11;
    NLA[34].Matrix_Y      := 17;
    NLA[34].Player_Count  := 4;
    NLA[34].Matrix_Value  := '1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;1:4:0:0:0;1:5:3:1:r;1:6:1:0:0;1:7:11:5:0;1:8:0:0:0;1:9:11:2:0;1:10:0:0:0;1:11:0:0:0;1:12:0:0:0;1:13:0:0:0;1:14:0:0:0;1:15:5:1:m;1:16:1:0:0;1:17:11:6:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:0:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0'+
                            ';2:8:0:0:0;2:9:1:0:0;2:10:0:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:0:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:0:0:0;3:3:1:0:0;3:4:0:0:0;3:5:1:0:0;3:6:1:0:0;3:7:1:0:0;3:8:0:0:0;3:9:1:0:0;3:10:0:0:0;3:11:1:0:0;3:12:0:0:0;3:13:1:0:0;3:14:0:' +
                            '0:0;3:15:1:0:0;3:16:1:0:0;3:17:1:0:0;4:1:0:0:0;4:2:0:0:0;4:3:0:0:0;4:4:0:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:0:0:0;4:9:1:0:0;4:10:0:0:0;4:11:0:0:0;4:12:0:0:0;4:13:0:0:0;4:14:0:0:0;4:15:1:0:0;4:16:1:0:0;4:17:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:11:1:0;5:4:' +
                            '0:0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:0:0:0;5:9:11:3:0;5:10:0:0:0;5:11:11:3:0;5:12:1:0:0;5:13:1:0:0;5:14:0:0:0;5:15:1:0:0;5:16:1:0:0;5:17:1:0:0;6:1:1:0:0;6:2:1:0:0;6:3:1:0:0;6:4:0:0:0;6:5:1:0:0;6:6:1:0:0;6:7:1:0:0;6:8:0:0:0;6:9:8:1:0;6:10:0:0:0;6:1' +
                            '1:1:0:0;6:12:1:0:0;6:13:1:0:0;6:14:0:0:0;6:15:1:0:0;6:16:1:0:0;6:17:1:0:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:0:0:0;7:5:1:0:0;7:6:1:0:0;7:7:11:4:0;7:8:0:0:0;7:9:11:4:0;7:10:0:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:0:0:0;7:15:11:2:0;7:16:1:0:0;7:17:1' +
                            ':0:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:0:0:0;8:5:0:0:0;8:6:0:0:0;8:7:0:0:0;8:8:0:0:0;8:9:1:0:0;8:10:0:0:0;8:11:1:0:0;8:12:1:0:0;8:13:1:0:0;8:14:0:0:0;8:15:0:0:0;8:16:0:0:0;8:17:0:0:0;9:1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:0:0:0;9:5:1:0:0;9:6:0:0:0;9:7:1:0' +
                            ':0;9:8:0:0:0;9:9:1:0:0;9:10:0:0:0;9:11:1:0:0;9:12:1:0:0;9:13:1:0:0;9:14:0:0:0;9:15:1:0:0;9:16:0:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:0:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:0:0:0;10:9:1:0:0;10:10:0:0:0;10:11:1:0:0;10:12:1:0:0;10:1' +
                            '3:1:0:0;10:14:0:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:11:6:0;11:2:1:0:0;11:3:4:1:s;11:4:0:0:0;11:5:0:0:0;11:6:0:0:0;11:7:0:0:0;11:8:0:0:0;11:9:11:1:0;11:10:0:0:0;11:11:11:5:0;11:12:1:0:0;11:13:2:1:g;11:14:0:0:0;11:15:0:0:0;11:16:0:0:0;11:17:0:' +
                            '0:0;';

    //Level 115
    NLA[35].Id            := 115;
    NLA[35].Matrix_X      := 11;
    NLA[35].Matrix_Y      := 17;
    NLA[35].Player_Count  := 6;
    NLA[35].Matrix_Value  := '1:1:11:2:0;1:2:1:0:0;1:3:0:0:0;1:4:0:0:0;1:5:1:0:a;1:6:1:0:0;1:7:1:0:0;1:8:2:1:e;1:9:0:0:0;1:10:4:1:a;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:0:0:e;1:15:0:0:0;1:16:1:0:0;1:17:11:3:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:0:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;'+
                            '2:8:0:0:0;2:9:6:1:p;2:10:0:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:0:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:1:0:0;3:6:1:0:0;3:7:0:0:0;3:8:1:0:0;3:9:1:0:0;3:10:1:0:0;3:11:0:0:0;3:12:1:0:0;3:13:1:0:0;3:14:0:0' +
                            ':0;3:15:0:0:0;3:16:1:0:0;3:17:1:0:0;4:1:9:7:0;4:2:1:0:0;4:3:1:0:0;4:4:1:0:0;4:5:1:0:0;4:6:0:0:0;4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:1:0:0;4:12:0:0:0;4:13:1:0:0;4:14:1:0:0;4:15:1:0:0;4:16:1:0:0;4:17:9:6:0;5:1:0:0:0;5:2:1:0:0;5:3:1:0:0;5:4:1:' +
                            '0:0;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:1:0:0;5:15:1:0:0;5:16:1:0:0;5:17:0:0:0;6:1:0:0:0;6:2:8:1:0;6:3:0:0:0;6:4:8:1:0;6:5:0:0:0;6:6:11:2:0;6:7:0:0:0;6:8:11:4:0;6:9:0:0:0;6:10:11:3:0;6:11' +
                            ':0:0:0;6:12:11:1:0;6:13:0:0:0;6:14:8:1:0;6:15:0:0:0;6:16:8:1:0;6:17:0:0:0;7:1:0:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:1:0:0;7:6:1:0:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:1:0:0;7:12:1:0:0;7:13:1:0:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:0:0:' +
                            '0;8:1:9:4:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:0:0:0;8:7:1:0:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:1:0:0;8:12:0:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;8:17:9:5:0;9:1:1:0:0;9:2:1:0:0;9:3:0:0:0;9:4:0:0:0;9:5:1:0:0;9:6:1:0:0;9:7:0:0:0;' +
                            '9:8:1:0:0;9:9:1:0:0;9:10:1:0:0;9:11:0:0:0;9:12:1:0:0;9:13:1:0:0;9:14:0:0:0;9:15:0:0:0;9:16:1:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:0:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:0:0:0;10:9:7:1:y;10:10:0:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1' +
                            ':0:0;10:14:0:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:11:4:0;11:2:1:0:0;11:3:0:0:0;11:4:0:0:0;11:5:1:0:k;11:6:1:0:0;11:7:1:0:0;11:8:3:1:k;11:9:0:0:0;11:10:5:1:d;11:11:1:0:0;11:12:1:0:0;11:13:1:0:0;11:14:0:0:d;11:15:0:0:0;11:16:1:0:0;11:17:11:1:0;';

    //Level 116
    NLA[36].Id            := 116;
    NLA[36].Matrix_X      := 13;
    NLA[36].Matrix_Y      := 13;
    NLA[36].Player_Count  := 4;
    NLA[36].Matrix_Value  := '1:1:0:0:0;1:2:2:1:e;1:3:1:0:0;1:4:1:0:0;1:5:0:0:0;1:6:0:0:0;1:7:0:0:0;1:8:0:0:0;1:9:0:0:0;1:10:1:0:0;1:11:1:0:0;1:12:1:0:0;1:13:0:0:0;2:1:3:1:k;2:2:0:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:11:4:0;2:7:0:0:0;2:8:11:2:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:'+
                            '12:0:0:0;2:13:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:1:0:0;3:5:1:0:0;3:6:1:0:0;3:7:0:0:0;3:8:1:0:0;3:9:1:0:0;3:10:1:0:0;3:11:0:0:0;3:12:1:0:0;3:13:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:1:0:0;4:4:0:0:0;4:5:1:0:0;4:6:1:0:0;4:7:0:0:0;4:8:1:0:0;4:9:1:0:0;4:10:0' +
                            ':0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;5:1:0:0:0;5:2:1:0:0;5:3:1:0:0;5:4:1:0:0;5:5:0:0:0;5:6:1:0:0;5:7:1:0:0;5:8:9:4:0;5:9:0:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:0:0:0;6:1:0:0:0;6:2:11:3:0;6:3:1:0:0;6:4:1:0:0;6:5:1:0:0;6:6:1:0:0;6:7:1:0:0;6:8:1:0' +
                            ':0;6:9:1:0:0;6:10:1:0:0;6:11:1:0:0;6:12:11:1:0;6:13:0:0:0;7:1:0:0:0;7:2:0:0:0;7:3:0:0:0;7:4:0:0:0;7:5:9:6:0;7:6:1:0:0;7:7:9:1:0;7:8:1:0:0;7:9:9:4:0;7:10:0:0:0;7:11:0:0:0;7:12:0:0:0;7:13:0:0:0;8:1:0:0:0;8:2:11:1:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0' +
                            ':0;8:7:1:0:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:1:0:0;8:12:11:3:0;8:13:0:0:0;9:1:0:0:0;9:2:1:0:0;9:3:1:0:0;9:4:1:0:0;9:5:0:0:0;9:6:1:0:0;9:7:9:6:0;9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:1:0:0;9:13:0:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:' +
                            '0:0:0;10:5:1:0:0;10:6:1:0:0;10:7:0:0:0;10:8:1:0:0;10:9:1:0:0;10:10:0:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1:0:0;11:1:1:0:0;11:2:1:0:0;11:3:0:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:0:0:0;11:8:1:0:0;11:9:1:0:0;11:10:1:0:0;11:11:0:0:0;11:12:1:0:0;11:13:' +
                            '1:0:0;12:1:1:0:0;12:2:0:0:0;12:3:1:0:0;12:4:1:0:0;12:5:1:0:0;12:6:11:2:0;12:7:0:0:0;12:8:11:4:0;12:9:1:0:0;12:10:1:0:0;12:11:1:0:0;12:12:0:0:0;12:13:5:1:d;13:1:0:0:0;13:2:1:0:0;13:3:1:0:0;13:4:1:0:0;13:5:0:0:0;13:6:0:0:0;13:7:0:0:0;13:8:0:0:0;13:9:0:' +
                            '0:0;13:10:1:0:0;13:11:1:0:0;13:12:4:1:a;13:13:0:0:0;';

    //Level 117
    NLA[37].Id            := 117;
    NLA[37].Matrix_X      := 11;
    NLA[37].Matrix_Y      := 17;
    NLA[37].Player_Count  := 6;
    NLA[37].Matrix_Value  := '1:1:11:2:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:1:0:0;1:8:1:0:0;1:9:8:1:0;1:10:1:0:0;1:11:1:0:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:11:2:0;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:1:0:0;'+
                            '2:8:1:0:0;2:9:8:1:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:0:0:0;3:6:0:0:0;3:7:0:0:0;3:8:0:0:0;3:9:0:0:0;3:10:0:0:0;3:11:0:0:0;3:12:0:0:0;3:13:0:0:0;3:14:0:0' +
                            ':0;3:15:0:0:0;3:16:1:0:0;3:17:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:0:0:0;4:4:1:0:0;4:5:1:0:0;4:6:1:0:0;4:7:1:0:0;4:8:11:4:0;4:9:0:0:0;4:10:11:3:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:0:0:0;4:16:1:0:0;4:17:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:0:0:0;5:4:' +
                            '2:1:e;5:5:1:0:0;5:6:1:0:0;5:7:1:0:0;5:8:1:0:0;5:9:0:0:0;5:10:1:0:0;5:11:1:0:0;5:12:1:0:0;5:13:1:0:0;5:14:5:1:d;5:15:0:0:0;5:16:1:0:0;5:17:1:0:0;6:1:1:0:0;6:2:1:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:1:0:0;6:8:1:0:0;6:9:0:0:0;6:10:1:0:0;6:11:' +
                            '1:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:1:0:0;6:17:1:0:0;7:1:1:0:0;7:2:1:0:0;7:3:1:0:0;7:4:1:0:0;7:5:3:1:k;7:6:0:0:0;7:7:1:0:0;7:8:1:0:0;7:9:0:0:0;7:10:1:0:0;7:11:1:0:0;7:12:0:0:0;7:13:6:1:p;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:1:0:0;' +
                            '8:1:11:4:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:0:0:0;8:7:1:0:0;8:8:1:0:0;8:9:0:0:0;8:10:1:0:0;8:11:1:0:0;8:12:0:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;8:17:11:3:0;9:1:0:0:0;9:2:0:0:0;9:3:0:0:0;9:4:0:0:0;9:5:0:0:0;9:6:0:0:0;9:7:1:0:0;' +
                            '9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:0:0:0;9:14:0:0:0;9:15:0:0:0;9:16:0:0:0;9:17:0:0:0;10:1:4:1:a;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:1:0:0;10:11:1:0:0;10:12:1:0:0;10:13:1' +
                            ':0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:7:1:y;11:1:1:0:0;11:2:1:0:0;11:3:1:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:1:0:0;11:8:11:1:0;11:9:0:0:0;11:10:11:1:0;11:11:1:0:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:15:1:0:0;11:16:1:0:0;11:17:1:0:0;';

    //Level 118
    NLA[38].Id            := 118;
    NLA[38].Matrix_X      := 11;
    NLA[38].Matrix_Y      := 17;
    NLA[38].Player_Count  := 4;
    NLA[38].Matrix_Value  := '1:1:2:1:e;1:2:1:0:0;1:3:1:0:0;1:4:0:0:0;1:5:11:1:0;1:6:1:0:0;1:7:1:0:0;1:8:1:0:0;1:9:8:1:0;1:10:1:0:0;1:11:1:0:0;1:12:1:0:0;1:13:11:3:0;1:14:0:0:0;1:15:1:0:0;1:16:1:0:0;1:17:4:1:a;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:0:0:0;2:6:1:0:0;2:7:1:0:0;'+
                            '2:8:0:0:0;2:9:0:0:0;2:10:0:0:0;2:11:1:0:0;2:12:1:0:0;2:13:0:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:1:0:0;3:4:1:0:0;3:5:1:0:0;3:6:0:0:0;3:7:1:0:0;3:8:1:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:1:0:0;3:14:1:0' +
                            ':0;3:15:1:0:0;3:16:1:0:0;3:17:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:0:0:0;4:4:1:0:0;4:5:1:0:0;4:6:1:0:0;4:7:0:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:0:0:0;4:12:1:0:0;4:13:1:0:0;4:14:1:0:0;4:15:0:0:0;4:16:1:0:0;4:17:1:0:0;5:1:1:0:0;5:2:1:0:0;5:3:0:0:0;5:4:0:' +
                            '0:0;5:5:1:0:0;5:6:1:0:0;5:7:11:3:0;5:8:0:0:0;5:9:8:1:0;5:10:0:0:0;5:11:11:1:0;5:12:1:0:0;5:13:1:0:0;5:14:0:0:0;5:15:0:0:0;5:16:1:0:0;5:17:1:0:0;6:1:8:1:0;6:2:8:1:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:1:0:0;6:7:1:0:0;6:8:8:1:0;6:9:8:1:0;6:10:8:1:0;6:11:' +
                            '1:0:0;6:12:1:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:8:1:0;6:17:8:1:0;7:1:1:0:0;7:2:1:0:0;7:3:0:0:0;7:4:0:0:0;7:5:1:0:0;7:6:1:0:0;7:7:11:4:0;7:8:0:0:0;7:9:8:1:0;7:10:0:0:0;7:11:11:2:0;7:12:1:0:0;7:13:1:0:0;7:14:0:0:0;7:15:0:0:0;7:16:1:0:0;7:17:1:0:' +
                            '0;8:1:1:0:0;8:2:1:0:0;8:3:0:0:0;8:4:1:0:0;8:5:1:0:0;8:6:1:0:0;8:7:0:0:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:0:0:0;8:12:1:0:0;8:13:1:0:0;8:14:1:0:0;8:15:0:0:0;8:16:1:0:0;8:17:1:0:0;9:1:1:0:0;9:2:1:0:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:0:0:0;9:7:1:0:0;' +
                            '9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:1:0:0;9:12:0:0:0;9:13:1:0:0;9:14:1:0:0;9:15:1:0:0;9:16:1:0:0;9:17:1:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:0:0:0;10:6:1:0:0;10:7:1:0:0;10:8:0:0:0;10:9:0:0:0;10:10:0:0:0;10:11:1:0:0;10:12:1:0:0;10:13:0' +
                            ':0:0;10:14:1:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:3:1:k;11:2:1:0:0;11:3:1:0:0;11:4:0:0:0;11:5:11:2:0;11:6:1:0:0;11:7:1:0:0;11:8:1:0:0;11:9:8:1:0;11:10:1:0:0;11:11:1:0:0;11:12:1:0:0;11:13:11:4:0;11:14:0:0:0;11:15:1:0:0;11:16:1:0:0;11:17:5:1:d;';

    //Level 119
    NLA[39].Id            := 119;
    NLA[39].Matrix_X      := 11;
    NLA[39].Matrix_Y      := 17;
    NLA[39].Player_Count  := 6;
    NLA[39].Matrix_Value  := '1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;1:4:1:0:0;1:5:1:0:0;1:6:1:0:0;1:7:0:0:0;1:8:6:1:p;1:9:0:0:0;1:10:0:0:0;1:11:11:2:0;1:12:1:0:0;1:13:1:0:0;1:14:1:0:0;1:15:0:0:0;1:16:0:0:0;1:17:0:0:0;2:1:0:0:0;2:2:0:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:1:0:0;2:7:0:0:0;2'+
                            ':8:1:0:0;2:9:0:0:0;2:10:1:0:0;2:11:1:0:0;2:12:1:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:0:0:0;2:17:0:0:0;3:1:0:0:0;3:2:1:0:0;3:3:1:0:0;3:4:1:0:0;3:5:1:0:0;3:6:1:0:0;3:7:0:0:0;3:8:1:0:0;3:9:1:0:0;3:10:1:0:0;3:11:1:0:0;3:12:1:0:0;3:13:1:0:0;3:14:1:0:' +
                            '0;3:15:1:0:0;3:16:1:0:0;3:17:0:0:0;4:1:1:0:0;4:2:1:0:0;4:3:1:0:0;4:4:0:0:0;4:5:1:0:0;4:6:1:0:0;4:7:0:0:0;4:8:1:0:0;4:9:1:0:0;4:10:0:0:0;4:11:1:0:0;4:12:1:0:0;4:13:1:0:0;4:14:0:0:0;4:15:1:0:0;4:16:1:0:0;4:17:1:0:0;5:1:4:1:a;5:2:1:0:a;5:3:0:0:0;5:4:0:0' +
                            ':0;5:5:1:0:0;5:6:1:0:0;5:7:0:0:0;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:0:0:0;5:12:1:0:0;5:13:1:0:0;5:14:0:0:0;5:15:0:0:0;5:16:1:0:0;5:17:2:1:e;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:11:1:0;6:5:1:0:0;6:6:1:0:0;6:7:0:0:0;6:8:8:1:0;6:9:8:1:0;6:10:8:1:0;6:11:0:' +
                            '0:0;6:12:1:0:0;6:13:1:0:0;6:14:11:1:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:5:1:d;7:2:1:0:0;7:3:0:0:0;7:4:0:0:0;7:5:1:0:0;7:6:1:0:0;7:7:0:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:0:0:0;7:12:1:0:0;7:13:1:0:0;7:14:0:0:0;7:15:0:0:0;7:16:1:0:0;7:17:3:1:k;8' +
                            ':1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:0:0:0;8:5:1:0:0;8:6:1:0:0;8:7:1:0:0;8:8:0:0:0;8:9:1:0:0;8:10:1:0:0;8:11:0:0:0;8:12:1:0:0;8:13:1:0:0;8:14:0:0:0;8:15:1:0:0;8:16:1:0:0;8:17:1:0:0;9:1:0:0:0;9:2:1:0:0;9:3:1:0:0;9:4:1:0:0;9:5:1:0:0;9:6:1:0:0;9:7:1:0:0;9:8' +
                            ':1:0:0;9:9:1:0:0;9:10:1:0:0;9:11:0:0:0;9:12:1:0:0;9:13:1:0:0;9:14:1:0:0;9:15:1:0:0;9:16:1:0:0;9:17:0:0:0;10:1:0:0:0;10:2:0:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:1:0:0;10:7:1:0:0;10:8:1:0:0;10:9:0:0:0;10:10:1:0:0;10:11:0:0:0;10:12:1:0:0;10:13:1:0:' +
                            '0;10:14:1:0:0;10:15:1:0:0;10:16:0:0:0;10:17:0:0:0;11:1:0:0:0;11:2:0:0:0;11:3:0:0:0;11:4:1:0:0;11:5:1:0:0;11:6:1:0:0;11:7:11:2:0;11:8:0:0:0;11:9:0:0:0;11:10:7:1:y;11:11:0:0:0;11:12:1:0:0;11:13:1:0:0;11:14:1:0:0;11:15:0:0:0;11:16:0:0:0;11:17:0:0:0;';

    //Level 120
    NLA[40].Id            := 120;
    NLA[40].Matrix_X      := 11;
    NLA[40].Matrix_Y      := 17;
    NLA[40].Player_Count  := 6;
    NLA[40].Matrix_Value  := '1:1:1:0:0;1:2:1:0:0;1:3:1:0:0;1:4:1:0:0;1:5:11:1:0;1:6:0:0:0;1:7:11:1:0;1:8:1:0:0;1:9:1:0:0;1:10:1:0:0;1:11:11:2:0;1:12:0:0:0;1:13:11:2:0;1:14:1:0:0;1:15:1:0:0;1:16:1:0:0;1:17:4:1:a;2:1:1:0:0;2:2:1:0:0;2:3:1:0:0;2:4:1:0:0;2:5:1:0:0;2:6:0:0:0;2:7:1:0:'+
                            '0;2:8:1:0:0;2:9:1:0:0;2:10:1:0:0;2:11:1:0:0;2:12:0:0:0;2:13:1:0:0;2:14:1:0:0;2:15:1:0:0;2:16:1:0:0;2:17:1:0:0;3:1:1:0:0;3:2:1:0:0;3:3:0:0:0;3:4:0:0:0;3:5:1:0:0;3:6:0:0:0;3:7:0:0:0;3:8:0:0:0;3:9:0:0:0;3:10:1:0:0;3:11:1:0:0;3:12:0:0:0;3:13:0:0:0;3:14:0' +
                            ':0:0;3:15:0:0:0;3:16:1:0:0;3:17:1:0:0;4:1:1:0:0;4:2:1:0:0;4:3:0:0:0;4:4:1:0:0;4:5:1:0:0;4:6:0:0:0;4:7:1:0:0;4:8:1:0:0;4:9:1:0:0;4:10:1:0:0;4:11:1:0:0;4:12:0:0:0;4:13:0:0:0;4:14:0:0:0;4:15:0:0:0;4:16:1:0:0;4:17:1:0:0;5:1:11:6:0;5:2:1:0:0;5:3:1:0:0;5:4' +
                            ':1:0:0;5:5:2:1:e;5:6:0:0:0;5:7:3:1:k;5:8:1:0:0;5:9:1:0:0;5:10:1:0:0;5:11:1:0:0;5:12:0:0:0;5:13:0:0:0;5:14:0:0:0;5:15:0:0:0;5:16:1:0:0;5:17:11:3:0;6:1:0:0:0;6:2:0:0:0;6:3:0:0:0;6:4:0:0:0;6:5:0:0:0;6:6:0:0:0;6:7:0:0:0;6:8:0:0:0;6:9:0:0:0;6:10:0:0:0;6:1' +
                            '1:0:0:0;6:12:0:0:0;6:13:0:0:0;6:14:0:0:0;6:15:0:0:0;6:16:0:0:0;6:17:0:0:0;7:1:11:3:0;7:2:1:0:0;7:3:0:0:0;7:4:0:0:0;7:5:0:0:0;7:6:0:0:0;7:7:1:0:0;7:8:1:0:0;7:9:1:0:0;7:10:1:0:0;7:11:11:5:0;7:12:0:0:0;7:13:11:5:0;7:14:1:0:0;7:15:1:0:0;7:16:1:0:0;7:17:1' +
                            '1:6:0;8:1:1:0:0;8:2:1:0:0;8:3:1:0:0;8:4:1:0:0;8:5:1:0:0;8:6:0:0:0;8:7:1:0:0;8:8:1:0:0;8:9:1:0:0;8:10:1:0:0;8:11:1:0:0;8:12:0:0:0;8:13:1:0:0;8:14:1:0:0;8:15:1:0:0;8:16:1:0:0;8:17:1:0:0;9:1:0:0:0;9:2:0:0:0;9:3:0:0:0;9:4:1:0:0;9:5:5:1:d;9:6:0:0:0;9:7:6:' +
                            '1:p;9:8:1:0:0;9:9:0:0:0;9:10:1:0:0;9:11:0:0:0;9:12:0:0:0;9:13:1:0:0;9:14:0:0:0;9:15:1:0:0;9:16:0:0:0;9:17:0:0:0;10:1:1:0:0;10:2:1:0:0;10:3:1:0:0;10:4:1:0:0;10:5:1:0:0;10:6:0:0:0;10:7:1:0:0;10:8:1:0:0;10:9:1:0:0;10:10:1:0:0;10:11:1:0:0;10:12:0:0:0;10:' +
                            '13:1:0:0;10:14:0:0:0;10:15:1:0:0;10:16:1:0:0;10:17:1:0:0;11:1:11:4:0;11:2:1:0:0;11:3:0:0:0;11:4:0:0:0;11:5:0:0:0;11:6:0:0:0;11:7:1:0:0;11:8:1:0:0;11:9:1:0:0;11:10:1:0:0;11:11:11:4:0;11:12:0:0:0;11:13:0:0:0;11:14:1:0:0;11:15:0:0:0;11:16:0:0:0;11:17:7:' +
                            '1:y;';
  End;

Begin
  FillChar(NLA,SizeOf(NLAType),0);
  FillArray;
  LevelQuery            := TUniQuery.Create(nil);
  LevelQuery.Connection := DataForm.GameConnection;
  LevelQuery.SQL.Add('INSERT INTO level (id, matrix_x, matrix_y, matrix_value, player_count)');
  LevelQuery.SQL.Add('values (:id, :matrix_x, :matrix_y, :matrix_value, :player_count)');
  Try
    for I := 1 to 40 do
    Begin
      LevelQuery.ParamByName('id').AsInteger           := NLA[I].Id;
      LevelQuery.ParamByName('matrix_x').AsInteger     := NLA[I].Matrix_X;
      LevelQuery.ParamByName('matrix_y').AsInteger     := NLA[I].Matrix_Y;
      LevelQuery.ParamByName('matrix_value').AsString  := NLA[I].Matrix_Value;
      LevelQuery.ParamByName('player_count').AsInteger := NLA[I].Player_Count;
      LevelQuery.ExecSQL;
    End;
  Except
  End;
  LevelQuery.Free;
End;

end.
