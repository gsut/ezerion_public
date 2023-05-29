unit MainMap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, MyUtils, MyConst,
  UniProvider, SQLiteUniProvider, Data.DB, DBAccess, Uni, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkroom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinOffice2019Black, dxSkinOffice2019Colorful,
  dxSkinOffice2019DarkGray, dxSkinOffice2019White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringtime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinTheBezier, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, MemDS, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, dxGDIPlusClasses, Vcl.Menus, Vcl.Buttons;

type
  TMainMapForm = class(TForm)
    MapPanel: TPanel;
    GameConnection: TUniConnection;
    SQLiteUniProvider1: TSQLiteUniProvider;
    GetLevelButton: TButton;
    Bevel2: TBevel;
    LevelEdit: TSpinEdit;
    SaveLevelButton: TButton;
    BackImage: TImage;
    LevelPanel: TPanel;
    Y: TLabel;
    XEdit: TSpinEdit;
    Label3: TLabel;
    YEdit: TSpinEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Image38: TImage;
    Image39: TImage;
    Image40: TImage;
    MaxXEdit: TSpinEdit;
    MaxYEdit: TSpinEdit;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    CreateLevelButton: TButton;
    DeleteLevelButton: TButton;
    CopyLevelButton: TButton;
    MoveLevelButton: TButton;
    SelectedImage: TImage;
    Label5: TLabel;
    PCountEdit: TSpinEdit;
    LevelGridDBTableView: TcxGridDBTableView;
    LevelGridLevel: TcxGridLevel;
    LevelGrid: TcxGrid;
    LevelQuery: TUniQuery;
    LevelDataSource: TUniDataSource;
    LevelGridDBTableViewid: TcxGridDBColumn;
    LevelGridDBTableViewmatrix_x: TcxGridDBColumn;
    LevelGridDBTableViewmatrix_y: TcxGridDBColumn;
    LevelGridDBTableViewplayer_count: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    SeiliSeviyeyiSil1: TMenuItem;
    Image41: TImage;
    Image42: TImage;
    Image43: TImage;
    Image44: TImage;
    Image45: TImage;
    Image46: TImage;
    Image47: TImage;
    Image48: TImage;
    Image49: TImage;
    Image50: TImage;
    Image51: TImage;
    Image52: TImage;
    Image53: TImage;
    Image54: TImage;
    Image55: TImage;
    Image56: TImage;
    Image57: TImage;
    Image58: TImage;
    Image59: TImage;
    Image60: TImage;
    Image61: TImage;
    Image62: TImage;
    Image63: TImage;
    Image64: TImage;
    BitBtn1: TBitBtn;
    procedure GetLevelButtonClick(Sender: TObject);
    procedure ItemImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveLevelButtonClick(Sender: TObject);
    procedure CreateLevelButtonClick(Sender: TObject);
    procedure DeleteLevelButtonClick(Sender: TObject);
    procedure CopyLevelButtonClick(Sender: TObject);
    procedure MoveLevelButtonClick(Sender: TObject);
    procedure LevelGridDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure SeiliSeviyeyiSil1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    ActiveLevel   : Integer;
    IComp         : TStrings;
    Game          : GameType;
    p1C, p2C, p3C,
    p4C, p5C, p6C : Char;
    LoadedMap     : Boolean;

    { Private declarations }
    Function  ConnectDB(DBName:String):Boolean;
    Procedure CreateGameSquare(Frame:FrameType;cW, cL, cT:Integer;cN:String;Sender:TPanel);
    Function  FormatToDevice(InStr:String):String;
    Procedure TextMatrixToArrayMatrix(TextMatrix:String);
    Function  ArrayMatrixToTextMatrix:String;
    Function  GetLevelInfo:Boolean;
    Function  LevelExists(Level:Integer):Boolean;
    Procedure DeleteLevel(Level:Integer);
    Procedure CreateGameArea(ScreenWidth, ScreenHeight:Integer);
    procedure FreeMap;
    procedure onMapImageClick(Sender: TObject);
    Function  SeviyeKopyala(OldLevel,NewLevel:Integer):Boolean;
    Function  SeviyeTasi(OldLevel,NewLevel:Integer):Boolean;
    Procedure GetLevelMap(Confirm:Boolean);
  public
    { Public declarations }
  end;

var
  MainMapForm: TMainMapForm;

implementation


{$R *.dfm}

procedure TMainMapForm.onMapImageClick(Sender: TObject);
Var
  Hint, sX, sY, CName : String;
  Tag, X, Y           : Integer;
  fI                  : TImage;
begin
  CName := (Sender as TImage).Name;
  X := Pos('_',CName);
  Delete(CName,1,X);
  X := Pos('_',CName);
  sX := Copy(CName,1, X -1);
  Delete(CName,1,X);
  sY := CName;
  X := MyStrToInt(sX);
  Y := MyStrToInt(sY);
  XEdit.Value := X;
  YEdit.Value := Y;

  Tag  := SelectedImage.Tag;
  Hint := SelectedImage.Hint;

  if Tag < 0 then
    Exit;

  case Tag of
    0 : Begin
          Game.Frame[X][Y].FType := 0;
          Game.Frame[X][Y].Value := MyStrToInt(Hint);
        End;
    1 : Begin
          Game.Frame[X][Y].FType := 1;
          Game.Frame[X][Y].Value := MyStrToInt(Hint);
        End;
    2, 3, 4, 5, 6, 7
      : Begin
          if Length(Hint) < 2 then
          Begin
            ShowMessage('Resim bilgi (hint) hatasý!');
            Exit;
          End;
          Game.Frame[X][Y].FType := Tag;
          Game.Frame[X][Y].Value := MyStrToInt(Hint[2]);
          Game.Frame[X][Y].cCode := Hint[1];
        End;
    8 : Begin
          Game.Frame[X][Y].FType := 8;
          Game.Frame[X][Y].Value := MyStrToInt(Hint);
        End;
    9 : Begin
          Game.Frame[X][Y].FType := 9;
          Game.Frame[X][Y].Value := MyStrToInt(Hint);
        End;
    10: Begin
          Game.Frame[X][Y].FType := 10;
          Game.Frame[X][Y].Value := MyStrToInt(Hint);
        End;
    11: Begin
          Game.Frame[X][Y].FType := 11;
          Game.Frame[X][Y].Value := MyStrToInt(Hint);
        End;
    99: Begin
          Game.Frame[X][Y].FType := 0;
          Game.Frame[X][Y].Value := MyStrToInt(Hint);
        End;
  end;
  Name := 'Frame_' + IntToStr(X) + '_' + IntToStr(Y);

  fI := MapPanel.FindComponent(Name) As TImage;
  if fI <> Nil then
  Begin
    case Game.Frame[X][Y].FType of
      99   : fI.Picture.Bitmap := nil;
      0    : If Game.Frame[X][Y].Value = 0 Then
               fI.Picture.LoadFromFile(FormatToDevice('frame.png'));
      8    : case Game.Frame[X][Y].Value of
               1 : fI.Picture.LoadFromFile(FormatToDevice('water/wall_1.png'));
               2 : fI.Picture.LoadFromFile(FormatToDevice('water/wall_2.png'));
               3 : fI.Picture.LoadFromFile(FormatToDevice('water/wall_3.png'));
             end;
      9    : Case Game.Frame[X][Y].Value Of
               1 : fI.Picture.LoadFromFile(FormatToDevice('water/bomb1.png'));
               2 : fI.Picture.LoadFromFile(FormatToDevice('water/bomb2.png'));
               3 : fI.Picture.LoadFromFile(FormatToDevice('water/bomb3.png'));
               4 : fI.Picture.LoadFromFile(FormatToDevice('water/bomby1.png'));
               5 : fI.Picture.LoadFromFile(FormatToDevice('water/bomby2.png'));
               6 : fI.Picture.LoadFromFile(FormatToDevice('water/bomby3.png'));
               7 : fI.Picture.LoadFromFile(FormatToDevice('water/bomby4.png'));
               8 : fI.Picture.LoadFromFile(FormatToDevice('water/bomby5.png'));
               9 : fI.Picture.LoadFromFile(FormatToDevice('water/bomby6.png'));
             End;
      10   : fI.Picture.LoadFromFile(FormatToDevice('water/mine.png'));
      11   : fI.Picture.LoadFromFile(FormatToDevice('water/teleport_'+ IntToStr(Game.Frame[X][Y].Value) +'.png'));
      1    : fI.Picture.LoadFromFile(FormatToDevice('water/t0.png'))
      Else fI.Picture.LoadFromFile(FormatToDevice('' + Game.Frame[X][Y].cCode + IntToStr(Game.Frame[X][Y].Value) + '.png'));
    end;
  End;

end;


Procedure TMainMapForm.CreateGameArea(ScreenWidth, ScreenHeight:Integer);
Var
  I, J,
  mW, wW, hW : Integer;
  sL, sT : Integer;
Begin
  hW   := ScreenHeight div Game.MatrixY;
  wW   := ScreenWidth  div Game.MatrixX;
  if hW > wW then
    mW := wW
  Else
    mW := hw;
  sL := (ScreenWidth - (Game.MatrixX * mW)) Div 2;
  sT := (ScreenHeight - (Game.MatrixY * mW)) Div 2;
  for I := 1 to Game.MatrixX do
    for J := 1 to Game.MatrixY do
      CreateGameSquare(Game.Frame[I][J], mW, sL + ( (I-1) * mW), sT + ( (J-1) * mW), IntToStr(I) + '_' + IntToStr(J),MapPanel);
End;

Function TMainMapForm.LevelExists(Level:Integer):Boolean;
Var
  SLevelQuery : TUniQuery;
Begin
  Try
    Result := False;
    SLevelQuery            := TUniQuery.Create(nil);
    SLevelQuery.Connection := GameConnection;
    SLevelQuery.SQL.Add('SELECT * FROM LEVEL');
    SLevelQuery.SQL.Add('WHERE (ID = :LID)');
    SLevelQuery.ParamByName('LID').AsInteger := Level;
    SLevelQuery.Open;
    if SLevelQuery.RecordCount > 0 then
      Result := True;
    SLevelQuery.Close;
    SLevelQuery.Free;
  Except
    on E: Exception do
      ShowMessage('Hata : ' + E.Message);
  End;
End;

procedure TMainMapForm.LevelGridDBTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  LevelEdit.Value := LevelQuery.FieldByName('ID').AsInteger;
  GetLevelButtonClick(Sender);
end;

procedure TMainMapForm.MoveLevelButtonClick(Sender: TObject);
Var
  LevelStr  : String;
  L         : Integer;
begin
  if Not LoadedMap then
  Begin
    ShowMessage('Hiç bir seviye seçilmedi. Ýlk önce seviyeyi okutunuz!');
    Exit;
  End;

  LevelStr := InputBox('Seviye Taþýma','Hangi seviyeye taþýnacak?','');
  L := MyStrToInt(LevelStr);

  if L < 1 then
  Begin
    ShowMessage('Yanlýþ seviye numarasý!');
    Exit;
  End;
  if LevelExists(L) then
  Begin
    ShowMessage('Hedef seviye mevcut! Taþýma yapýlamaz!');
    Exit;
  End;
  If SeviyeTasi(ActiveLevel, L) Then
  Begin
    ShowMessage('Seviye taþýndý.');
    LevelEdit.Value := L;
    GetLevelMap(False);
    LevelQuery.Refresh;
  End;
end;

Procedure TMainMapForm.DeleteLevel(Level:Integer);
Var
  SLevelQuery : TUniQuery;
Begin
  Try
    GameConnection.StartTransaction;
    SLevelQuery            := TUniQuery.Create(nil);
    SLevelQuery.Connection := GameConnection;
    SLevelQuery.SQL.Add('DELETE FROM LEVEL');
    SLevelQuery.SQL.Add('WHERE (ID = :LID)');
    SLevelQuery.ParamByName('LID').AsInteger := Level;
    SLevelQuery.ExecSQL;
    SLevelQuery.Free;
    GameConnection.Commit;
  Except
    on E: Exception do
    Begin
      GameConnection.Rollback;
      ShowMessage('Hata : ' + E.Message);
    End;
  End;
End;

Function TMainMapForm.GetLevelInfo:Boolean;
Var
  SLevelQuery : TUniQuery;
Begin
  Try
    Result := False;
    SLevelQuery            := TUniQuery.Create(nil);
    SLevelQuery.Connection := GameConnection;
    SLevelQuery.SQL.Add('SELECT * FROM LEVEL');
    SLevelQuery.SQL.Add('WHERE (ID = :LID)');
    SLevelQuery.ParamByName('LID').AsInteger := ActiveLevel;
    SLevelQuery.Open;
    if SLevelQuery.RecordCount > 0 then
    Begin
      Game.MatrixX := SLevelQuery.FieldByName('MATRIX_X').AsInteger;
      Game.MatrixY := SLevelQuery.FieldByName('MATRIX_Y').AsInteger;
      Game.BackI   := 'background.png';
      Game.PCount  := SLevelQuery.FieldByName('PLAYER_COUNT').AsInteger;
      TextMatrixToArrayMatrix(SLevelQuery.FieldByName('MATRIX_VALUE').asString);
      Result := True;
    End;
    SLevelQuery.Close;
    SLevelQuery.Free;
  Except
    on E: Exception do
      ShowMessage('Hata : ' + E.Message);
  End;
End;

procedure TMainMapForm.ItemImageClick(Sender: TObject);
Var
  Hint         : String;
  Tag, X , Y   : Integer;
  fI           : TImage;
begin
  Hint := (Sender as TImage).Hint;
  Tag  := (Sender as TImage).Tag;

  if Tag >= 0 then
  Begin
    SelectedImage.Picture := (Sender as TImage).Picture;
    SelectedImage.Tag     := Tag;
    SelectedImage.Hint    := Hint;
  End;
end;


procedure TMainMapForm.SaveLevelButtonClick(Sender: TObject);
Var
  MapMatrix  : String;
  SLevelQuery : TUniQuery;
begin
  if MessageDlg('Seviye kaydedilecek. Emin misiniz?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;

  MapMatrix    := ArrayMatrixToTextMatrix;
  Game.PCount  := PCountEdit.Value;
  SLevelQuery            := TUniQuery.Create(nil);
  SLevelQuery.Connection := GameConnection;
  if Not LevelExists(ActiveLevel) then
  Begin
    SLevelQuery.SQL.Add('INSERT INTO LEVEL (ID, MATRIX_X, MATRIX_Y, MATRIX_VALUE, BACK_IMAGE, PLAYER_COUNT)');
    SLevelQuery.SQL.Add('VALUES (:ID, :MATRIX_X, :MATRIX_Y, :MATRIX_VALUE, :BACK_IMAGE, :PLAYER_COUNT)');
  End
  Else
  Begin
    SLevelQuery.SQL.Add('UPDATE LEVEL SET MATRIX_X = :MATRIX_X, MATRIX_Y = :MATRIX_Y,');
    SLevelQuery.SQL.Add('MATRIX_VALUE = :MATRIX_VALUE, BACK_IMAGE = :BACK_IMAGE, PLAYER_COUNT = :PLAYER_COUNT');
    SLevelQuery.SQL.Add('WHERE (ID = :ID)');
  End;
  SLevelQuery.ParamByName('ID').AsInteger           := ActiveLevel;
  SLevelQuery.ParamByName('MATRIX_X').AsInteger     := Game.MatrixX;
  SLevelQuery.ParamByName('MATRIX_Y').AsInteger     := Game.MatrixY;
  SLevelQuery.ParamByName('MATRIX_VALUE').AsString  := MapMatrix;
  SLevelQuery.ParamByName('BACK_IMAGE').AsString    := Game.BackI;
  SLevelQuery.ParamByName('PLAYER_COUNT').AsInteger := Game.PCount;
  Try
    GameConnection.StartTransaction;
    SLevelQuery.ExecSQL;
    GameConnection.Commit;
  Except
    on E: Exception do
    Begin
      GameConnection.Rollback;
      ShowMessage('Hata : ' + E.Message);
      SLevelQuery.Free;
      Exit;
    End;
  End;
  SLevelQuery.Free;
  LevelQuery.Refresh;
  FreeMap;
end;

Function TMainMapForm.ArrayMatrixToTextMatrix:String;
Var
   TextMatrix : String;
   I,J        : Integer;
   rCode      : Char;
Begin
  //   1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;
  TextMatrix := '';
  for I := 1 to Game.MatrixX do
  Begin
    for J := 1 to Game.MatrixY do
    Begin
      if Game.Frame[I][J].cCode = #0 then
        rCode := '0'
      Else
        rCode := Game.Frame[I][J].cCode;

      TextMatrix := TextMatrix + IntToStr(I) + ':' +
                                 IntToStr(J) + ':' +
                                 IntToStr(Game.Frame[I][J].FType) + ':' +
                                 IntToStr(Game.Frame[I][J].Value) + ':' +
                                 rCode + ';';
    End;
  End;
  Result := TextMatrix;
End;

Procedure TMainMapForm.TextMatrixToArrayMatrix(TextMatrix:String);
Var
  InStr, sX, sY, sT, sD, sC     : String;
  iX, iY, iT, iD, X             : Integer;
Begin
  X := Pos(';',TextMatrix);
  while X > 0 do
  Begin
    InStr := '';
    InStr := Copy(TextMatrix,1,X);
    Delete(TextMatrix, 1, X);
    if InStr <> '' then
    Begin
      sX := '0';
      sY := '0';
      sT := '0';
      sD := '0';
      sC := 'a';
      X  := Pos(':',InStr);
      if X > 0 then
      Begin
        sX := Copy(InStr, 1, X -1);
        Delete(InStr,1,X);
      End;
      X  := Pos(':',InStr);
      if X > 0 then
      Begin
        sY := Copy(InStr, 1, X -1);
        Delete(InStr,1,X);
      End;
      X  := Pos(':',InStr);
      if X > 0 then
      Begin
        sT := Copy(InStr, 1, X -1);
        Delete(InStr,1,X);
      End;
      X  := Pos(':',InStr);
      if X > 0 then
      Begin
        sD := Copy(InStr, 1, X -1);
        Delete(InStr,1,X);
      End;
      if InStr <> '' then
      Begin
        sC := InStr;
      End;
      iX := MyStrToInt(sX);
      iY := MyStrToInt(sY);
      iT := MyStrToInt(sT);
      iD := MyStrToInt(sD);
      Game.Frame[iX][iY].FType   := iT;
      Game.Frame[iX][iY].Value := iD;
      Game.Frame[iX][iY].cCode := sC[1];

      case iT of
        2 : Game.Frame[iX][iY].cCode := p1C;
        3 : Game.Frame[iX][iY].cCode := p2C;
        4 : Game.Frame[iX][iY].cCode := p3C;
        5 : Game.Frame[iX][iY].cCode := p4C;
        6 : Game.Frame[iX][iY].cCode := p5C;
        7 : Game.Frame[iX][iY].cCode := p6C;
      end;

    End;
    X := Pos(';',TextMatrix);
  End;
  //   1:1:0:0:0;1:2:0:0:0;1:3:0:0:0;
End;

procedure TMainMapForm.FreeMap;
Var
  I     : Integer;
  fI    : TImage;
  Name  : String;
begin
  for I := 0 to IComp.Count -1 do
  Begin
    Name := IComp.Strings[I];
    fI := MapPanel.FindComponent(Name) As TImage;
    if fI <> Nil then
    Begin
      FreeAndNil(fI);
    End;
  End;
  LevelPanel.Visible := False;
  LoadedMap := False;
End;

Procedure TMainMapForm.GetLevelMap(Confirm:Boolean);
Var
  sX, sY, sT  : Integer;
begin
  if Confirm then
  Begin
    if LoadedMap then
    Begin
      if MessageDlg('Bu seviye daha kaydedilmedi. Çýkmak istediðinizden emin misiniz?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
        FreeMap
      Else
        Exit;
    End;
  End
  Else
  Begin
    if LoadedMap then
      FreeMap;
  End;


  ActiveLevel := LevelEdit.Value;

  sX := Trunc(MapPanel.Width);
  sY := Trunc(MapPanel.Height);
  if sX > sY then
  Begin
    sT := sX;
    sX := sY;
    sY := sT;
  End;

  If iComp <> nil Then
    iComp.Free;
  iComp := TStringList.Create;

  FillChar(Game, Sizeof(GameType), 0);
  If GetLevelInfo Then
  Begin
    MaxXEdit.Value   := Game.MatrixX;
    MaxYEdit.Value   := Game.MatrixY;
    PCountEdit.Value := Game.PCount;
    BackImage.Picture.LoadFromFile(FormatToDevice(game.BackI));
    CreateGameArea(sX, sY);
    LoadedMap := True;
    LevelPanel.Visible := True;
  End
  Else
  Begin
    ShowMessage('Seviye bilgisi bulunamadý! Ýlk önce seviyeyi oluþturun!');
  End;

End;

procedure TMainMapForm.GetLevelButtonClick(Sender: TObject);
begin
  GetLevelMap(True);
end;

procedure TMainMapForm.BitBtn1Click(Sender: TObject);
Var
  TF          : TextFile;
  SLevelQuery : TUniQuery;
  I           : Integer;
  MValue      : String;
begin
  AssignFile(TF,'text.txt');
  Rewrite(TF);
  SLevelQuery            := TUniQuery.Create(nil);
  SLevelQuery.Connection := GameConnection;
  SLevelQuery.SQL.Add('SELECT * FROM LEVEL');
  SLevelQuery.SQL.Add('WHERE (ID > 80)');
  SLevelQuery.Open;
  SLevelQuery.First;
  I := 1;
  while Not SLevelQuery.EOF do
  Begin
    WriteLn(TF,'    //Level ' + SLevelQuery.FieldByName('id').AsString);
    WriteLn(TF,'    NLA[' + IntToStr(I) + '].Id            := ' + SLevelQuery.FieldByName('id').AsString + ';');
    WriteLn(TF,'    NLA[' + IntToStr(I) + '].Matrix_X      := ' + SLevelQuery.FieldByName('matrix_x').AsString + ';');
    WriteLn(TF,'    NLA[' + IntToStr(I) + '].Matrix_Y      := ' + SLevelQuery.FieldByName('matrix_y').AsString + ';');
    WriteLn(TF,'    NLA[' + IntToStr(I) + '].Player_Count  := ' + SLevelQuery.FieldByName('player_count').AsString + ';');
    MValue := SLevelQuery.FieldByName('matrix_value').AsString;
    WriteLn(TF,'    NLA[' + IntToStr(I) + '].Matrix_Value  := ''' + Copy(MValue,1,250) + '''+');
    Delete(MValue,1,250);
    while Length(MValue) > 0 do
    Begin
      Write(TF,'                            ''' + Copy(MValue,1,250) + '''');
      Delete(MValue,1,250);
      if MValue <> '' then
        WriteLn(TF,' +')
      Else
        WriteLn(TF,';')
    End;
    WriteLn(TF,'');
    SLevelQuery.Next;
    Inc(I);
  End;
  SLevelQuery.Close;
  SLevelQuery.Free;
  CloseFile(TF);
  ShowMessage('Dosya Hazýrlandý!');
end;

Function TMainMapForm.ConnectDB(DBName:String):Boolean;
Begin
  Result := False;
  Try
    if GameConnection.Connected then
      GameConnection.Connected := False;
    GameConnection.Database := DBName;
    GameConnection.SpecificOptions.Values['Direct']               := 'True';
    GameConnection.SpecificOptions.Values['UseUnicode']           := 'True';
    GameConnection.Open;
    Result := True;
  Except
    Result := False;
  End;
End;

procedure TMainMapForm.CopyLevelButtonClick(Sender: TObject);
Var
  LevelStr  : String;
  L         : Integer;
begin
  if Not LoadedMap then
  Begin
    ShowMessage('Hiç bir seviye seçilmedi. Ýlk önce seviyeyi okutunuz!');
    Exit;
  End;

  LevelStr := InputBox('Seviye Kopyala','Hangi seviyeye kopyalanacak?','');
  L := MyStrToInt(LevelStr);
  if L < 1 then
  Begin
    ShowMessage('Yanlýþ seviye numarasý!');
    Exit;
  End;
  if LevelExists(L) then
  Begin
    ShowMessage('Hedef seviye mevcut! Kopyalama yapýlamaz!');
    Exit;
  End;
  If SeviyeKopyala(ActiveLevel, L) Then
  Begin
    ShowMessage('Seviye kopyalandý.');
    LevelEdit.Value := L;
    GetLevelMap(False);
    LevelQuery.Refresh;
  End;
end;

procedure TMainMapForm.SeiliSeviyeyiSil1Click(Sender: TObject);
Var
  SLevel  : Integer;
begin
  SLevel := LevelQuery.FieldByName('ID').AsInteger;
  if MessageDlg(IntToStr(SLevel) + ' Nolu seviye silinecek. Devam etmek istediðinize emin misiniz?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;
  if LevelExists(SLevel) then
  Begin
    DeleteLevel(SLevel);
    FreeMap;
    if LevelQuery.Active then
      LevelQuery.Close;
    LevelQuery.Open;
  End
  Else
    ShowMessage('Bu kayýtlý bir seviye deðil! Silinemez!');
end;

Function TMainMapForm.SeviyeKopyala(OldLevel,NewLevel:Integer):Boolean;
Var
  SLevelQuery : TUniQuery;
Begin
  Try
    Result := False;
    GameConnection.StartTransaction;
    SLevelQuery            := TUniQuery.Create(nil);
    SLevelQuery.Connection := GameConnection;
    SLevelQuery.SQL.Add('INSERT INTO LEVEL (ID, MATRIX_X, MATRIX_Y, MATRIX_VALUE, BACK_IMAGE, PLAYER_COUNT)');
    SLevelQuery.SQL.Add('SELECT :NID, MATRIX_X, MATRIX_Y, MATRIX_VALUE, BACK_IMAGE, PLAYER_COUNT FROM LEVEL');
    SLevelQuery.SQL.Add('WHERE ID = :OID ');
    SLevelQuery.ParamByName('OID').AsInteger := OldLevel;
    SLevelQuery.ParamByName('NID').AsInteger := NewLevel;
    SLevelQuery.ExecSQL;
    SLevelQuery.Free;
    GameConnection.Commit;
    Result := True;
  Except
    on E: Exception do
    Begin
      GameConnection.Rollback;
      ShowMessage('Hata : ' + E.Message);
    End;
  End;
End;

Function TMainMapForm.SeviyeTasi(OldLevel,NewLevel:Integer):Boolean;
Var
  SLevelQuery : TUniQuery;
Begin
  Try
    Result := False;
    GameConnection.StartTransaction;
    SLevelQuery            := TUniQuery.Create(nil);
    SLevelQuery.Connection := GameConnection;
    SLevelQuery.SQL.Add('UPDATE LEVEL SET ID = :NID');
    SLevelQuery.SQL.Add('WHERE (ID = :OID)');
    SLevelQuery.ParamByName('OID').AsInteger := OldLevel;
    SLevelQuery.ParamByName('NID').AsInteger := NewLevel;
    SLevelQuery.ExecSQL;
    SLevelQuery.Free;
    GameConnection.Commit;
    Result := True;
  Except
    on E: Exception do
    Begin
      GameConnection.Rollback;
      ShowMessage('Hata : ' + E.Message);
    End;
  End;
End;

Function TMainMapForm.FormatToDevice(InStr:String):String;
Var
  Path : String;
Begin
  InStr := LowerCase(InStr);
  {$IFDEF DEBUG}
    InStr := 'D:\project\Github\Ezerion\Assets\' + InStr;
  {$ELSE}
    InStr := GetExePath + '\Assets\' + InStr;
  {$ENDIF}
  Result := InStr;
End;

procedure TMainMapForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if LevelQuery.Active then
    LevelQuery.Close;
  If GameConnection.Connected Then
    GameConnection.Connected := False;
end;

procedure TMainMapForm.FormCreate(Sender: TObject);
begin
  If Not ConnectDB(FormatToDevice('ezerion.db')) Then
  Begin
    ShowMessage('DB Baðlanmadý');
    Halt;
  End;
  if Not LevelQuery.Active then
    LevelQuery.Open;

  p1C := 'g';
  p2C := 'r';
  p3C := 's';
  p4C := 'm';
  p5C := 'b';
  p6C := 'n';
  ActiveLevel := 0;
  LoadedMap   := False;
end;

Procedure TMainMapForm.CreateGameSquare(Frame:FrameType; cW, cL, cT:Integer;cN:String;Sender:TPanel);
Var
  gmI  : TImage;
Begin
  gmI := TImage.Create(Sender);

  gmI.Left        := cL;
  gmI.Top         := cT;
  gmI.Height      := cW;
  gmI.Width       := cW;
  gmI.Stretch     := True;
  gmI.AutoSize    := False;
  gmI.Transparent := True;

  gmI.Name       := 'Frame_' + cN;
  gmI.Parent     := Sender;
  gmI.OnClick    := onMapImageClick;

  case Frame.FType of
    0    : if Frame.Value = 0 then
             gmI.Picture.LoadFromFile(FormatToDevice('frame.png'));
    1    : gmI.Picture.LoadFromFile(FormatToDevice('water/t0.png'));
    8    : case Frame.Value of
             1 : gmI.Picture.LoadFromFile(FormatToDevice('water/wall_1.png'));
             2 : gmI.Picture.LoadFromFile(FormatToDevice('water/wall_2.png'));
             3 : gmI.Picture.LoadFromFile(FormatToDevice('water/wall_3.png'));
           end;
    9    : Case Frame.Value Of
               1 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomb1.png'));
               2 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomb2.png'));
               3 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomb3.png'));
               4 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomby1.png'));
               5 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomby2.png'));
               6 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomby3.png'));
               7 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomby4.png'));
               8 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomby5.png'));
               9 : gmI.Picture.LoadFromFile(FormatToDevice('water/bomby6.png'));
           End;
    10   : gmI.Picture.LoadFromFile(FormatToDevice('water/mine.png'));
    11   : gmI.Picture.LoadFromFile(FormatToDevice('water/teleport_'+ IntToStr(Frame.Value) +'.png'));
    99   : ;
    Else gmI.Picture.LoadFromFile(FormatToDevice(Frame.cCode + IntToStr(Frame.Value) + '.png'));
  end;

  IComp.Add(gmI.Name);
End;


procedure TMainMapForm.CreateLevelButtonClick(Sender: TObject);
Var
  sX, sY, sT  : Integer;
begin
  if LoadedMap then
  Begin
    if MessageDlg('Bu harita daha kaydedilmedi. Çýkmak isteiðinizden emin misiniz?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
      FreeMap
    Else
      Exit;
  End;
  if (LevelEdit.Value <= 0) Or (PCountEdit.Value <= 0) Or (MaxXEdit.Value <= 0) or (MaxYEdit.Value <= 0) then
  Begin
    ShowMessage('Seviye, Oyuncu Sayýsý, X ve Y deðerleri 0 (sýfýr) büyük olmalýdýr!');
    Exit;
  End;

  if (MaxXEdit.Value > 32) or (MaxYEdit.Value > 32) then
  Begin
    ShowMessage('X ve Y deðerleri 32''den küçük olmalýdýr!');
    Exit;
  End;

  ActiveLevel := LevelEdit.Value;

  if LevelExists(ActiveLevel) then
  Begin
    ShowMessage('Oluþturmak istediðiniz seviye mevcut. "Seviye Haritasý Getir" iþlemi ile seviyeyi okuyunuz!');
    Exit;
  End;

  sX := Trunc(MapPanel.Width);
  sY := Trunc(MapPanel.Height);
  if sX > sY then
  Begin
    sT := sX;
    sX := sY;
    sY := sT;
  End;

  If iComp <> nil Then
    iComp.Free;
  iComp := TStringList.Create;

  FillChar(Game, Sizeof(GameType), 0);
  Game.MatrixX := MaxXEdit.Value;
  Game.MatrixY := MaxYEdit.Value;
  Game.PCount  := PCountEdit.Value;
  Game.BackI   := 'background.png';

  BackImage.Picture.LoadFromFile(FormatToDevice(game.BackI));
  CreateGameArea(sX, sY);
  LoadedMap := True;
  LevelPanel.Visible := True;
end;

procedure TMainMapForm.DeleteLevelButtonClick(Sender: TObject);
begin
  if Not LoadedMap then
  Begin
    ShowMessage('Hiç bir seviye seçilmedi. Ýlk önce seviyeyi okutunuz!');
    Exit;
  End;

  if MessageDlg(IntToStr(ActiveLevel) + '  Nolu seviye silinecek. Devam etmek istediðinize emin misiniz?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;
  ActiveLevel := LevelEdit.Value;
  if LevelExists(ActiveLevel) then
  Begin
    DeleteLevel(ActiveLevel);
    FreeMap;
    LevelQuery.Refresh;
  End
  Else
    ShowMessage('Bu kayýtlý bir seviye deðil! Silinemez!');
end;

end.
