unit myconst;
interface
Uses Controls, winSock, Classes;


Const
  SURUM_STR       = '0.0.1';


  USER_ADMIN      = 'A';
  USER_NORMAL     = 'N';
  USER_PASIF      = 'P';

  MaxX     = 32;
  MaxY     = 32;

Type

  FrameType = Record
                FType    : Byte;
                Value    : Byte;
                cCode    : Char;
                MaxValue : Byte;
              End;
  GameType  = Record
                p1Score  : Integer;
                p2Score  : Integer;
                MatrixX  : Integer;
                MatrixY  : Integer;
                BackI    : String[100];
                PCount   : Integer;
                Frame    : Array[1..MaxX,1..MaxY] of FrameType;
              End;

Var
  Aktif_User      : Integer;
  User_Type       : String;    // A Admin N Normal P Pasif
  /////////////////////////

  Function  GetLocalIP : String;
  Function  BoslukSil(Str:String):String;

implementation
Uses MyUtils,SysUtils;

Function BoslukSil(Str:String):String;
Var
  I  : Integer;
Begin
  Result := '';
  For I := 1 To Length(Str) Do
    If Str[I] in ['0','1','2','3','4','5','6','7','8','9'] Then
      Result := Result + Str[I];
End;

function GetLocalIP : String;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of AnsiChar;
  I,X: Integer;
  GInitData: TWSAData;
  Data:TStrings;
begin
  WSAStartup($101, GInitData);
  Data := TstringList.Create;
  Data.Clear;
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  I    := 0;
  while pPtr^[I] <> nil do
  begin
    Data.Add(inet_ntoa(pptr^[I]^));
    Inc(I);
  end;
  WSACleanup;
  for I := 0 to Data.Count-1 do
  Begin
    X := Pos('139.179.',Data[I]);
    if (X > 0) then
    Begin
      Result := Data[I];
      Exit;
    End;
  End;
end;


Function GetPart(Str:String;Sira:Integer;Ch:Char):String;
Var
  X,I  : Integer;
Begin
  Result := '';
  X := Pos(Ch,Str);
  I := 0;
  While (X <> 0) Do
  Begin
    Inc(I);
    Result := Copy(Str,1,X-1);
    If Sira = I Then Exit;
    Delete(Str,1,X);
    X := Pos(Ch,Str);
  End;
  If I < Sira Then
    Result := Str;
End;


end.
