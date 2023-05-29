unit myutils;

interface
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DBCtrls, Buttons, Menus, Grids, StdCtrls,
  ExtCtrls, Mask,Tabs;

Type
  TPlanType=(plnCopy,plnRename);
  TOptType=(oAC,oSEC);
  TTusType=(stTAMAM,stIPTAL,stEVET,stHAYIR);
  TDonType=(sdTAMAM,sdIPTAL,sdEVET,sdHAYIR);
  AcFormType=(afFREKANS,afDAGITIM,afRAPORLAR);
  TMyDate=Record
    Yil:Integer;
    Ay  :Integer;
    Gun:Integer;
  end;
  TMyWordDate=Record
    Yil:Word;
    Ay :Word;
    Gun:Word;
  end;
  TJustifyType=(NoJustify,LeftJustify,RightJustify);
  TDateType=(TurkishDate,EnglishDate);
  TYasTipi=(Gun,Ay,Yil);
  TTusKume= Set of TTusType;
Var
  {Turkce karakter kullan�l�p kullan�lmayacag� ana program�n bas�nda initialize
   edilmelidir}
  TURKCE_ATMA :Boolean;
  ProgramKapat : Boolean;

   //PROCEDURE ve FUNCTION'lar

  {�al��an exe'nin pathini dondurur}
  function GetExePath:String;

  {Path'i ve ad� gonderilen Exe'yi �al��t�r�r.}
  Function ExeCagir(ExeAdi,Param:String):Boolean;

  {Path'i ve ad� gonderilen Exe'yi �al��t�r�r.}
  Function GizliExeCagir(ExeAdi,Param:String):Boolean;

  {G�ndderilen Alias'�n pathini d�nd�r�r.}
  function  GetAliasDir(AliasName:String):String;

  {G�nderilen stringin numeric olup olmad�g�n� d�nd�r�r}
  Function IsNumeric(s:String):Boolean;

  {G�nderilen String i�inden numerik karakterleri d�nd�r�r.}
  function  NumericYap(s:String):String;

  {G�nderilen String i�inden verilen karakterleri temizler.}
  function  CharSil(s:string;ch:char):String;

  {G�nderilen karakterin decimal degerini yazar}
  function  CharDecimalDegeri(ch:char):String;

  {G�nderilen String numerik ise bir artt�r�r.}
  function  StrninBirArtirilmisi(Str:String):String;

  {Hex say�y� Longint'e �evirir.}
  Function  HexStrToLongint(Hex: String): Longint;

  {Windows directory'sinin path'inin getirir.}
  Function GetWindowsDir:String;

  {Windows temp directory'sinin path'inin getirir.}
  Function GetWindowsTempDir:String;

  {Windows system directory'sinin path'inin getirir.}
  Function GetWindowsSystemDir:String;

  {G�nderilen Dosyan�n ad�n�n getirir.}
  Function DosyaNameGetir(FileN:String):String;
  
  {G�nderilen Dosya ad�n�n Extention'�n� getirir.}
  Function GetFileTypeByEx(FileN:String):String;

  {�al��t�r�ld��� partion'�n disk size'�n� getirir.}
  Function GetHDSize:String;

  {�al��t�r�ld��� partion'�n seri numaras�n� getirir.}
  Function GetHDSerialNumber:String;

  {Tab ile field atlatma i�lemini Enter tu�u ilede yapman�z� sa�lar}
  procedure EnterBas(mform:Tform; var Key: Word;Shift: TShiftState);
  
  {Tab ile field atlatma i�lemini Down tu�u ilede yapman�z� sa�lar}
  procedure DownBas(mform:Tform; var Key: Word;Shift: TShiftState);

  {Tab ile field atlatma i�lemini Up tu�u ilede yapman�z� sa�lar}
  procedure UpBas(mform:Tform; var Key: Word;Shift: TShiftState);

  {Down tusuna bast�g�n�zda sizin belirttiginiz ozel bir field� aktif yapar}
  procedure OzelDown(mwnd:Twincontrol; var Key: Word;Shift: TShiftState);
  
  {Up tusuna bast�g�n�zda sizin belirttiginiz ozel bir field� aktif yapar}
  procedure OzelUp(mwnd:Twincontrol; var Key: Word;Shift: TShiftState);

  {G�nderilen stringteki turkce karakterleri ingilizce kars�l�klar� ile degistirir}
  Procedure TurkceAt(var s:String);

  {G�nderilen stringi i�indeki turkce karakterleri ile Upcase sekline �evirir}
  Procedure Upcase_T(var s:String);

  {G�nderilen stringi i�indeki turkce karakterleri ile Lowcase sekline �evirir}
  Procedure Lowcase_T(var s:String);

  {Verilen Stringi, Verilen uzakl�kta sola yaslar}
  Function  LTrim(TStr:String;Uz:Byte):String;

  {Verilen Stringi, Verilen uzakl�kta sa�a yaslar}
  Function  RTrim(TStr:String;Uz:Byte):String;

  {InStr'nin MainStr i�inde olup olmad�g�n� denetler}
  Function  StrInclude(MainStr,InStr:AnsiString):Boolean;

  {String i�inde g�nderilen karakterin tekrar say�s�n� d�nd�r�r.}
  function chsay(s:string;ch:char):integer;

  {String i�inde kac rakam oldugunu d�nd�r�r.}
  function digitsay(s:string):integer;

  {StrCat i�lemini ikinci stringin verilen uzunlugundan sonras� i�in yapar}
  procedure mstrcat(var ilks,ikis:string;bas:integer);

  {Stringin basindaki bosluklar� atar}
  procedure IlkBoslukAt(var s:string);

  {Stringin sonundaki bosluklar� atar}
  procedure sonboslukat(var s:string);

  {Gonderilen iki memofield�n� e�it olup olmad�g�n� kontrol eder}
  function  memoesit(memo1,memo2:tmemo):boolean;

  {iki memoyu e�itler}
  procedure memoesitle(memo1,memo2:tmemo);

  {Gonerilen iki say�dan k���k olan� getirir.}
  function mmin(x,y:integer):integer;

  {Gonerilen iki say�dan b�y�k olan� getirir.}
  function mmax(x,y:integer):integer;

  {G�nderilen milimetreyi pixel'e cevirir}
  function findpixel(mm:real):integer;

  {Gonderilen String'i Integer'e �evirir}
  function TextToInt(s:string):integer;

  {Gonderilen Stringi'i LongInt'e �evirir}
  function TextToLong(s:string):Longint;

  {Gonderilen String'i Real'e �evirir}
  function TextToReal(s:string):real;

  {Gonderilen LongInt'i String'e �evirir}
  function IntToText(x:longint):string;

  {Gonderilen Real'i String'e �evirir}
  function RealToText(x:real):string;

  {G�nderilen iki say�y� -ikincisi 0'dan farkl� ise- b�ler}
  function mdiv(a,b:real):real;

  {X �zeri y'yi hesaplar}
  function mpower(x:longint;y:integer):longint;

  {G�nderilen say�n�n roundunu al�r
   Delphi'deki bug nedeniyle ile bu procedure yaz�lm�st�r. Delphi'nin internal komutu
   olan round baz� ondal�k olan say�larda yanl�� sonu� dondurmektedir. �rn :
     148.5 * 0.003  = 0.444445
   internal round bu say�y� "0" olarak d�nd�r�r.}
  function mround(x:real):real;

  {G�nderilen iki stringn e�it olup olmad���n� kontrol -k���k b�y�k harf ay�r�m� ve
   T�rk�e karakter ay�m�n� yapmadan- eder}
  function  stresit(s1,s2:string):boolean;

  {G�nderilen stringi verilen uzunluga kadar soldan "0" ile doldurur}
  procedure basisifirla(var str:string;uzunluk:integer);

  {G�nderilen karakterin Numerik olup olmad�g�n� kontrol eder}
  function  NumericKaraker(ch:char):boolean;

  {G�nderilen Component'in bulundugu formu d�d�r�r.}
  function  OwnerForm(AComponent:TComponent):TForm; {Componentin owner formunu d�nd�r�r}

  {iki stringin yerini de�i�tirir}
  procedure StrSwap(var s1,s2:string);

  {c karakterinden olu�an n uzunlu�unda string yarat�r}
  function  conststr(c: char;n: byte): string;

  {s stringindeki gereksiz karakterleri atar}
  procedure truncate(var s: string);

  {string'i date e cevririrken truncate kullan�r}
  function  MyStrToDateTime(s:string):TDateTime;

  {string'i date e cevririrken truncate kullan�r}
  function  MyStrToDate(s:string):TDateTime;

  {string'i time a cevririrken truncate kullan�r}
  function  MyStrToTime(s:string):TDateTime;

  {string'i int64 e cevririrken truncate kullan�r}
  function MyStrToInt64(s:String):Int64;

  {string'i int e cevririrken truncate kullan�r}
  function  MyStrToInt(s:String):Longint;

  {string'i float a cevririrken truncate kullan�r}
  function  MyStrToFloat(s:String):Real;

  {string'i double a cevririrken truncate kullan�r}
  function  MyStrToDouble(s:String):Double;

  {string'i extended a cevririrken truncate kullan�r}
  function  MyStrToExtended(s:String):Extended;

  {stryi, len uzunlu�unda yapar, ba��na fillchar koyar}
  function  MyStrToStr(str:string;len:integer;fillchar:char;Justify:TJustifyType):String;

  {int i len uzunlu��nda stringe �evririrken ba��na fillchar koyar}
  function  MyIntToStr(sayi,len:integer;fillchar:char):String;

  {ba�tan ba�lay�p sep karakteri bulana kadar string d�nd�r�r}
  function  PosStrCopy(var bas:integer;s:string;sep:char):string;
  

  {G�nderilen Longint'i Hex'e �evirir.}
  function Hex(x:longint):String;

  {G�nderilen stringin tamamen say�sal olup olmad�g�n� denetler}
  function StrToValOlabilir(s:string):boolean;

  {WinControlun hangi form i�in aktif oldugunu dondurur}
  function  ParentForm(CurControl: TWinControl):TForm;

  {WinControlun Bir sonraki fielda gitmesini saglar}
  Procedure GotoNextControl(CurControl:TWinControl);

  {WinControlun Bir �nceki fielda gitmesini saglar}
  Procedure GotoPriorControl(CurControl:TWinControl);

  {G�nderilen tu�a bas�lmas�n� saglar}
  procedure Tusabas(Sender:TObject;Key:Word);

  {token karakterine kadar olan� d�nd�r�r}
  function  StrToken(s:string;token:char):string;

  {Belirtilen dosyayi verilen dizine kopyalar}
  Function  MyCopyFile(SourceName,TargetName:String):Boolean;

  {Belirtilen dizin ve alt dizinlerini siler}
  Procedure DeleteAllDir(Path:String);

  {Gonderilen Bytei ikili sisteme cevirir}
  Function ByteToIkiliMod(B:Byte):String;

  Function TersCevir(Str:String):String;

implementation

Function TersCevir(Str:String):String;
Var
  I  : Integer;
Begin
  Result := '';
  For I := Length(Str) DownTo 1 Do
    Result := Result + Str[I];
End;

Function ByteToIkiliMod(B:Byte):String;
Begin
  Result:='';
  While B>1 Do
  Begin
    Result := IntToStr(B Mod 2)+Result;
    B := B Div 2;
  End;
  Result := IntToStr(B)+Result;
  BasiSifirla(Result,8);
End;

Procedure DeleteAllDir(Path:String);
var
  DirInfo    : TSearchRec;
  r          : Integer;
Begin
  R:=FindFirst(Path+'\*.*', FaAnyfile, DirInfo);
  While R=0 Do
  Begin
    If Not (StrEsit(DirInfo.Name,'.') Or StrEsit(DirInfo.Name,'..')) Then
    Begin
      If DirInfo.Attr = faDirectory then
      Begin
        DeleteAllDir(Path+'\'+DirInfo.Name);
        RemoveDir(Path+'\'+DirInfo.Name);
      End
      Else
      Begin
        SysUtils.DeleteFile(Path+'\'+DirInfo.Name);
      End;
    End;
    R:=FindNext(DirInfo);
  End;
End;

Function GetHDSerialNumber:String;
var
  VolumeSerialNumber : DWORD;
  MaximumComponentLength : DWORD;
  FileSystemFlags : DWORD;
begin
  GetVolumeInformation(nil,nil,0,@VolumeSerialNumber,MaximumComponentLength,
                       FileSystemFlags,nil,0);
  Result := IntToHex(HiWord(VolumeSerialNumber), 4) +'-' +
            IntToHex(LoWord(VolumeSerialNumber), 4);
end;

Function GetHDSize:String;
Begin
  Try
    Result:=IntToStr(DiskSize(0));
  Except
    Result:='!!!';
  End;
End;

Function GetWindowsDir:String;
var
  sWinDir     : String;
  iLength     : Integer;
begin
  // Initialize Variable
  iLength := 255;
  setLength(sWinDir, iLength);
  iLength := GetWindowsDirectory(PChar(sWinDir), iLength);
  setLength(sWinDir, iLength);
  Result:=sWinDir;
End;

Function GetWindowsTempDir:String;
Begin
  Result:=GetWindowsDir+'\TEMP';
End;

Function GetWindowsSystemDir:String;
Begin
  Result:=GetWindowsDir+'\SYSTEM';
End;

Function DosyaNameGetir(FileN:String):String;
Var
  x : Integer;
Begin
  X:=Pos('.',FileN);
  Result:=Copy(FileN,1,X-1);
End;

Function GetFileTypeByEx(FileN:String):String;
Var
  x : Integer;
Begin
  X:=Pos('.',FileN);
  Result:=Copy(FileN,X+1,3);
End;

Function LTrim(TStr:String;Uz:Byte):String;
Var
  I       : Byte;
Begin
  Result:=TStr;
  If Length(TStr)<Uz Then
  Begin
     For I:=1 to Uz-Length(TStr) do
       Result:=Result+' ';
  End
End;

Function RTrim(TStr:String;Uz:Byte):String;
Var
  I       : Byte;
Begin
  Result:='';
  If Length(TStr)<Uz Then
  Begin
     For I:=1 to Uz-Length(TStr) do
       Result:=Result+' ';
  End;
  Result:=Result+TStr;
End;

procedure Tusabas(Sender:TObject;Key:Word);
begin
  PostMessage((Sender as TWinControl).Handle, WM_KEYDOWN, Key, 0);
  PostMessage((Sender as TwinControl).Handle, WM_KEYUP, Key, 0);
end;

procedure EnterBas(mform:Tform; var Key: Word;Shift: TShiftState);
begin
  if(key=VK_RETURN)and(shift=[]) then
  begin
    {Key := 0;}
    SendMessage(mform.Handle, WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure DownBas(mform:Tform; var Key: Word;Shift: TShiftState);
begin
  if(key=VK_UP)and(shift=[]) then
  begin
    Key := 0;
    SendMessage(mform.Handle, WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure UpBas(mform:Tform; var Key: Word;Shift: TShiftState);
begin
  if(key=VK_DOWN)and(shift=[]) then
  begin
    Key := 0;
    SendMessage(mform.Handle, WM_NEXTDLGCTL, 1, 0);
  end;
end;

procedure OzelDown(mwnd:Twincontrol; var Key: Word;Shift: TShiftState);
begin
  if(key=VK_DOWN)and(shift=[]) then
  begin
    key:=0;
    mwnd.setfocus;
  end;
end;

procedure OzelUp(mwnd:Twincontrol; var Key: Word;Shift: TShiftState);
begin
  if(key=VK_UP)and(shift=[]) then
  begin
    key:=0;
    mwnd.setfocus;
  end;
end;

Procedure TurkceAt(var s:String);
var i:integer;
begin
  if TURKCE_ATMA then
    exit;
  for i:=1 to length(s) do
  begin
    case s[i] of
      '�':s[i]:='G';
      '�':s[i]:='U';
      '�':s[i]:='S';
      '�':s[i]:='I';
      '�':s[i]:='O';
      '�':s[i]:='C';
      '�':s[i]:='g';
      '�':s[i]:='u';
      '�':s[i]:='s';
      '�':s[i]:='i';
      '�':s[i]:='o';
      '�':s[i]:='c';
    end;
  end
end;

function C_Upcase_T(c:char):char;
begin
  case c of
    '�':result:='�';
    '�':result:='�';
    '�':result:='�';
    '�':result:='I';
    '�':result:='�';
    '�':result:='�';
    'i':result:='�';
  else
    result:=upcase(c);
  end;
end;

Procedure Upcase_T(var s:String);
var i:integer;
begin
  for i:=1 to length(s) do
  begin
    s[i]:=C_Upcase_T(s[i]);
  end
end;

Procedure Lowcase_T(var s:String);
var i:integer;
begin
  for i:=1 to length(s) do
  begin
    if s[i] in ['A'..'H','J'..'Z'] then
    begin
      s[i]:=chr(ord(s[i])+32);
    end
    else
    begin
      case s[i] of
        '�':s[i]:='�';
        '�':s[i]:='�';
        '�':s[i]:='�';
        'I':s[i]:='�';
        '�':s[i]:='�';
        '�':s[i]:='�';
        '�':s[i]:='i';
      end
    end;
  end
end;

function chsay(s:string;ch:char):integer;
var i,top:integer;
begin
  top:=0;
  for i:=1 to length(s) do
  begin
    if(s[i]=ch) then
      inc(top);
  end;
  result:=top;
end;

function digitsay(s:string):integer;
var i,top:integer;
begin
  top:=0;
  for i:=1 to length(s) do
  begin
    if(s[i]>='0')and(s[i]<='9') then
      inc(top);
  end;
  result:=top;
end;

procedure mstrcat(var ilks,ikis:string;bas:integer);
var i:integer;
begin
  for i:=bas to length(ikis) do
     ilks:=ilks+ikis[i];
end;

procedure sonboslukat(var s:string);
var i:integer;
var s2:string;
begin
  s2:=s;
  i:=length(s2);
  if i>0 then
  begin
    while (s2[i]=' ') and(i>=1) do
    begin
      dec(i);
    end;
    s:=Copy(s2,1,i);
  end;
end;

procedure IlkBoslukAt(var s:string);
var
  i   :integer;
begin
  If s='' Then Exit;
  I:=1;
  While I<=Length(S) Do
  Begin
    If S[I]=' ' Then
      Delete(S,I,1)
    Else
      Inc(I);
  End;
end;

function memoesit(memo1,memo2:tmemo):boolean;
var i:integer;
    res:boolean;
begin
  res:=true;
  i:=1;
  while (i<=memo2.lines.count)and(res=True) do
  begin
      if memo1.lines.strings[0]<>memo2.lines.strings[i] then
         res:=false;
  end;
  result:=res;
end;

procedure memoesitle(memo1,memo2:tmemo);
var i:integer;
begin
  memo1.lines.clear;
  for i:=1 to memo2.lines.count do
    memo1.lines.add(memo2.lines.strings[i]);
end;



function sonsozcuk(s:string;length:integer;var bas:integer;var sozcuk:string):boolean;
var i:integer;
begin
   i:=length;
   while(i>=1)and(s[i]<>' ') do
   begin
     dec(i);
   end;
   if(i>=1)and(s[i]=' ') then
   begin
     sozcuk:=copy(s,i+1,length-i);
     bas:=i;
     result:=True;
   end
   else
   begin
     result:=False;
   end;
end;

function mmin(x,y:integer):integer;
begin
  if(x<y) then
    result:=x
  else
    result:=y;
end;

function mmax(x,y:integer):integer;
begin
  if(x>y) then
    result:=x
  else
    result:=y;
end;

function findpixel(mm:real):integer;
begin
  mm:=mm/25.4;
  result:=trunc(screen.pixelsperinch*mm);
end;

function TextToInt(s:string):integer;
var
  dumreal:real;
  dumint:integer;
begin
  Val(s,dumreal,dumint);
  result:=trunc(dumreal);
end;

function TextToLong(s:string):longint;
var
  dumreal:real;
  dumint:integer;
begin
  Val(s,dumreal,dumint);
  result:=trunc(dumreal);
end;

function TextToReal(s:string):real;
var
  dumreal:real;
  dumint:integer;
begin
  Val(s,dumreal,dumint);
  result:=dumreal;
end;

function isdigit(ch:char):boolean;
begin
  if (ord(ch)>=ord('0'))and(ord(ch)<=ord('9')) then
    result:=True
  else
    result:=False
end;


function mdiv(a,b:real):real;
begin
  if b=0 then
    result:=0
  else
    result:=a/b;
end;

function mpower(x:longint;y:integer):longint;
var i:integer;
begin
  if y>10 then
  begin
    result:=1;  // integer overflow
    exit;
  end;
  result:=1;
  for i:=1 to y do
  begin
    result:=result*x;
  end;
end;

function mround(x:real):real;
var tam,onda,absx:real;
    eksi:boolean;
begin
  { ondalik 0.44444445 olursa 1 d�nd�rmesi laz�m, onun i�in,
    ondal��a 0.5555555 ilave et 0.55555=5/9 yani onda+(5/9) veya
    (9.onda+5)/9 olur

    148.15*0.003 = 0.44445
  }

  if x<0 then
    eksi:=True
  else
    eksi:=False;

  absx:=abs(x);
  tam:=int(absx);
  onda:=absx-tam;
  if (((9*onda)+5)/9)>=1.0 then
    result:=tam+1
  else
    result:=tam;

  if eksi then
    result:=-1*result;

end;

function stresit(s1,s2:string):boolean;
Var
  I,A,B  : Integer;


begin
  Result := True;
  upcase_T(s1);
  upcase_T(s2);
  turkceat(s1);
  turkceat(s2);
  A:= Length(S1);
  B:= Length(S2);
  If A <> B Then
  Begin
    Result := False;
    Exit;
  End;
  For I:=1 To Length(S1) Do
  Begin
    If S1[I]<>S2[I] Then
    Begin
      Result := False;
      Break;
    End;
  End;
end;

function IntToText(x:longint):string;
var s:string;
begin
  str(x,s);
  result:=s;
end;

function RealToText(x:real):string;
var s:string;
begin
  str(x,s);
  result:=s;
end;

procedure basisifirla(var str:string;uzunluk:integer);
var dum:string;
    i:integer;
begin
  dum:='';
  if uzunluk>length(str) then
  begin
    for i:=1 to uzunluk-length(str) do
    begin
      dum:=dum+'0';
    end;
    dum:=dum+str;
    str:=dum;
  end;
end;

function OwnerForm(AComponent:TComponent):TForm;
begin
  if AComponent.Owner is TForm then
    result:=AComponent.Owner As TForm
  else
    result:=OwnerForm(AComponent.Owner);
end;

procedure StrSwap(var s1,s2:string);
var dum:string;
begin
  dum:=s1;
  s1:=s2;
  s2:=dum;
end;

function conststr(c: char;n: byte): string;
var
 s : string;
begin {conststr}
  setlength(s,n);
  fillchar(s[1],n,c);
  conststr:=s
end; {conststr}

procedure truncate(var s: string);
var
 temp   : real;
 kk     : integer;
 num    : boolean;
begin {truncate}
  if (s<>'')and(length(s)<>0) then
  begin
    while (length(s)>=1)and(s[1] in [#255,#32,#0]) and (s<>'') do
      delete(s,1,1);
    while (length(s)>=1)and(s[length(s)] in [#255,#32,#0]) and (s<>'') do
      delete(s,length(s),1);
    if (s=conststr('0',length(s))) And (Length(s)>1) then s:='';
    val(s,temp,kk); if kk=0 then num:=true else num:=false;
    if temp=0 then
       while num and (pos('.',s)<>0) and (s[length(s)]='0') and (s<>'') do
             delete(s,length(s),1);
    if (pos('.',s)<>0) and (s[1] in ['-','0'..'9']) then
       while s[length(s)] in ['.'] do delete(s,length(s),1);
    while (pos(#13,s)<>0) and (s<>'') do delete(s,pos(#13,s),1);
  end;
end;  {truncate}

function MyStrToDateTime(s:string):TDateTime;
begin
  truncate(s);
  result:=strtodateTime(s);
end;

function MyStrToDate(s:string):TDateTime;
begin
  truncate(s);
  if s<>'' then
    result:=strtodate(s)
  else
    result:=0;
end;

function MyStrToTime(s:string):TDateTime;
begin
  truncate(s);
  result:=strtotime(s);
end;

function MyStrToInt(s:String):Longint;
Var e:Extended;
begin
  result:=0;
  truncate(s);
  if StrToValOlabilir(s) then
    if s<>'' then
    begin
      //result:=StrToInt(s)
      e:=MyStrToExtended(s);
      result:=Round(e);
    end;
end;

function MyStrToInt64(s:String):Int64;
Var e:Extended;
begin
  result:=0;
  truncate(s);
  if StrToValOlabilir(s) then
    if s<>'' then
    begin
      //result:=StrToInt(s)
      e:=MyStrToExtended(s);
      result:=Round(e);
    end;
end;

function MyStrToFloat(s:String):Real;
var
  dumreal:real;
  dumint:integer;
begin
  Val(s,dumreal,dumint);
  if dumint=0 then
    result:=dumreal
  else
    result:=0;
end;

function MyStrToDouble(s:String):Double;
var
  dumreal:double;
  dumint:integer;
begin
  Val(s,dumreal,dumint);
  if dumint=0 then
    result:=dumreal
  else
    result:=0;
end;

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


function MyStrToStr(str:string;len:integer;fillchar:char;Justify:TJustifyType):String;
var dum:string;
    var i:integer;
begin
  dum:=str;
  truncate(dum);
  str:='';
  for i:=1 to len-length(dum) do
    str:=str+fillchar;
  if Justify=RightJustify then
    str:=str+dum;
  if Justify=LeftJustify then
    str:=dum+str;
  if Justify=NoJustify then
    str:=dum;
  {truncate(str);}
  result:=str;
end;

function MyIntToStr(sayi,len:integer;fillchar:char):String;
var dum:string;
begin
  dum:=IntToStr(sayi);
  result:=MyStrToStr(dum,len,fillchar,RightJustify);
end;

function PosStrCopy(var bas:integer;s:string;sep:char):string;
begin
  result:='';
  while(bas<=length(s))and(s[bas]=Sep) do {ba�taki seperatorleri atla}
    inc(bas);
  while(bas<=length(s))and(s[bas]<>Sep) do {ba�taki seperatorleri atla}
  begin
    result:=result+s[bas];
    inc(bas);
  end;
end;


function Hex(x:longint):String;
Const H: Array [0..15] Of Char= ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
Var s:string;
begin
  s:='';
  if x<256 then
    s:=H[x Div 16]+H[x mod 16]
  else
    s:='';
  result:=s;
end;

function StrToValOlabilir(s:string):boolean;
var
  dumreal:real;
  dumint:integer;
begin
  Val(s,dumreal,dumint);
  result:=((dumint=0)and(dumreal<>0)); {dumreal<>0 gereksiz gibi ancak hata vermesin diye, zatendumreal=0 ise result 0 oluyor}
end;

function ParentForm(CurControl: TWinControl):TForm;
begin
  if CurControl is TForm then
    result:=(CurControl As TForm)
  else
    result:=ParentForm(CurControl.Parent);
end;

Procedure GotoNextControl(CurControl:TWinControl);
begin
  SendMessage(ParentForm(CurControl).Handle, WM_NEXTDLGCTL, 0, 0);
end;

Procedure GotoPriorControl(CurControl:TWinControl);
begin
  SendMessage(ParentForm(CurControl).Handle, WM_NEXTDLGCTL, 1, 0);
end;


function StrToken(s:string;token:char):string;
var i:integer;
begin
  result:='';
  i:=pos(token,s);
  if i>0 then
  begin
    result:=copy(s,1,i-1);
  end;
end;

Function ExeCagir(ExeAdi,Param:String):Boolean;
var ProcInfo: TProcessInformation;
    StartInfo: TStartupInfo;
begin
  If FileExists(ExeAdi) Then
  Begin
    Result:=True;
    If Param<>'' Then ExeAdi:=ExeAdi+' '+Param;
    FillMemory(@StartInfo, sizeof(StartInfo), 0);
    StartInfo.cb := sizeof(StartInfo);
    CreateProcess(
                  nil,
                  PChar(ExeAdi),
                  nil, Nil, False,
                  NORMAL_PRIORITY_CLASS,
                  nil, nil,
                  StartInfo,
                  ProcInfo);
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  End
  Else
  Begin
    Result:=False;
    ShowMessage('�al��t�r�lacak Dosya Bulunamad� !');
  End;
end;

Function GizliExeCagir(ExeAdi,Param:String):Boolean;
var ProcInfo: TProcessInformation;
    StartInfo: TStartupInfo;
begin
  If FileExists(ExeAdi) Then
  Begin
    Result:=True;
    If Param<>'' Then ExeAdi:=ExeAdi+' '+Param;
    FillMemory(@StartInfo, sizeof(StartInfo), 0);
    StartInfo.wShowWindow := SW_HIDE;
    StartInfo.cb := sizeof(StartInfo);
    CreateProcess(
                  nil,
                  PChar(ExeAdi),
                  nil, Nil, False,
                  NORMAL_PRIORITY_CLASS,
                  nil, nil,
                  StartInfo,
                  ProcInfo);
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  End
  Else
  Begin
    Result:=False;
    ShowMessage('�al��t�r�lacak Dosya Bulunamad� !');
  End;
end;

function GetExePath:String;
var
  iLength:Integer;
  sExeDir:string;
begin
  Result:='sdfsasd';
  iLength := 255;
  setLength(sExeDir, iLength);
  iLength := GetCurrentDirectory(iLength,PChar(sExeDir));
  setLength(sExeDir, iLength);
  Result:=sExeDir;
end;

function GetAliasDir(AliasName:String):String;
Var L: TStrings;
Begin
  L := TStringList.Create;
  Result := Copy(L[0], 6, Length(L[0]));
  L.Free;
End;

function NumericKaraker(ch:char):boolean;
begin
  result:=False;
  if (ch>='0')and(ch<='9') then
    result:=True;
  if ch=',' then
    result:=True;
  if ch='.' then
    result:=True;
end;

Function IsNumeric(s:String):Boolean;
Var
  I  : Integer;
Begin
  Result:=True;
  For I:=1 to Length(S) do
    If Not (S[I] in ['0'..'9',',','.']) Then Result:=False;
End;

function NumericKismi(s:String):String;
Var i:integer;
    sonuc:string;
begin
  sonuc:='';
  i:=1;
  while(i<=length(s))and NumericKaraker(s[i]) do
  begin
    sonuc:=sonuc+s[i];
    inc(i);
  end;
  result:=Sonuc;
end;

function NumericYap(s:String):String;
Var sonuc:string;
begin
  sonuc:=s;
  if length(s)>0 then
  begin
    if NumericKaraker(s[1]) then
      sonuc:=NumericKismi(s);
  end;
  result:=sonuc;
end;

function CharSil(s:string;ch:char):String;
Var i:integer;
begin
  i:=pos(ch,s);
  while (i>0) do
  begin
    delete(s,i,1);
    i:=pos(ch,s);
  end;
  truncate(s);
  result:=s;
end;

function CharDecimalDegeri(ch:char):String;
begin
  result:='['+IntToText(ord(ch))+']';
end;


function StrninBirArtirilmisi(Str:String):String;
Var i:longint;
begin
  i:=MystrToInt(Str);
  inc(i);
  result:=IntTostr(i);
end;

Function  HexStrToLongint(Hex: String): Longint;
Var
  KatSayi: Longint;

  Function CharToNum(C: Char): Integer;
  Begin
    Result := 0;
    Case C Of
     'A'..'F' : Result := Ord(C) - Ord('A') + 10;
     'a'..'f' : Result := Ord(C) - Ord('a') + 10;
     '0'..'9' : Result := StrToInt(C);
    End;
  End;

Begin
  Result := 0;
  KatSayi := 1;
  While Hex <> '' Do
  Begin
    Result := Result + (KatSayi * CharToNum(Hex[Length(Hex)]));
    Delete(Hex, Length(Hex), 1);
    KatSayi := KatSayi * 16;
  End;
End;

Function  StrInclude(MainStr,InStr:AnsiString):Boolean;
Var
  I  : Integer;
Begin
  Result:=False;
  If StrEsit(InStr,MainStr) Then Result:=True;
  If (Length(InStr)>=Length(MainStr)) Or (InStr='') Or (MainStr='') Then Exit;
  For I:=0 to Length(Mainstr)-Length(InStr) do
    If StrEsit(Copy(MainStr,I+1,Length(InStr)),InStr) Then Result:=True;
End;

Function MyCopyFile(SourceName,TargetName:String):Boolean;
Var
  S1,S2  : PChar;
Begin
  Result:=False;
  If Not FileExists(SourceName) Then Exit;
  S1:=Stralloc(Length(SourceName)+1);
  S2:=Stralloc(Length(TargetName)+1);
  StrPCopy(S1,SourceName);
  StrPCopy(S2,TargetName);
  Result:=CopyFile(S1,S2,False);
  StrDispose(S1);
  StrDispose(S2);
End;

end.


