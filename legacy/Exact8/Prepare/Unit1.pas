unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Gauges, Unit2, ExtCtrls;

type
  TForm1 = class(TForm)
    Gauge1: TGauge;
    Gauge2: TGauge;
    Label1: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  f: file of integer;
  i,j,cn: integer;
  ct: extended;
  TimeMark,StartingTime: TTime;
  progress,prev: extended;


implementation

procedure MakeD6;
var i,j: word;
    cn: integer;
    f: file of word;
begin
  cn:=0;
  assign(f,'c:\mbf\d6.dat');
  rewrite(f);
  for i:=0 to Max5 do
  for j:=i to Max5 do
  if C5(i,j) then
  begin
    if j=i then Application.ProcessMessages;
    Form1.Gauge1.Progress:=round(100*cn/max6);
    write(f,j);
    inc(cn);
  end;
  close(f);
end;

procedure MakeNFHL5;
var i,j: integer;
begin
  for i:=0 to Max5 do
  begin
    NFH5[i]:=0;
    NFL5[i]:=0
  end;

  for i:=0 to Max5 do
  begin
  Form1.Gauge1.Progress:=round(100*i/Max5);
  for j:=0 to i do
    if C5(j,i) then
    begin
      inc(NFH5[j]);
      inc(NFL5[i])
    end;
  end;
end;

procedure MakeFileNFL6;
var f1: textfile;
    buf: array[0..1023] of integer;
    RRead,pos,dummyi: integer;
begin
  assignfile(f,'c:\mbf\NFL6.dat');
  {$I-}
  reset(f);
  {$I+}
  if IOResult<>0 then rewrite(f);
  ct:=0;
  while not EOF(f) do
  begin
    BlockRead(f,Buf,1024,RREad);
    for dummyi:=0 to RRead-1 do
    ct:=ct+buf[dummyi];
  end;
  assignfile(f1,'c:\mbf\nfl.txt');
  {$I-}
  reset(f1);
  {$I+} if IOResult=0 then
  begin
    read(f1,i,j,pos,ct);
    close(f1);
  end
  else begin
    i:=0;j:=0;pos:=0;ct:=0;
  end;
  seek(f,pos);
  Form1.Timer1.OnTimer:=Form1.Timer3Timer;
  Form1.Timer1.Enabled:=true;
end;

procedure MakeFileNFH6;
var f1: file of integer;
    buf: array[0..1023] of integer;
    RRead,pos: integer;
    dummyi: integer;
begin
  assignfile(f,'c:\mbf\NFH6.dat');
  {$I-}
  reset(f);
  {$I+}
  if IOResult<>0 then rewrite(f);
  ct:=0;
  while not EOF(f) do
  begin
    BlockRead(f,Buf,1024,RREad);
    for dummyi:=0 to RRead-1 do
    ct:=ct+buf[dummyi];
  end;
  assignfile(f1,'c:\mbf\nfh.txt');
  {$I-}
  reset(f1);
  {$I+} if IOResult=0 then
  begin
    read(f1,i,j,pos);
    close(f1);
  end
  else begin
    i:=0;j:=0;pos:=0;
  end;
  seek(f,pos);
  Form1.Timer1.OnTimer:=Form1.Timer1Timer;
  Form1.Timer1.Enabled:=true;
end;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  InitArrays;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var p,k,s: integer;
begin
 p:=0;
 while p<800 do
 begin
  if j>Max5 then
  begin
    inc(i);
    j:=i;
  end;
  if i>Max5 then
  begin
    p:=1000;
    Timer1.Enabled:=false;
    CloseFile(f);
  end else
  begin
    s:=0;
    if j and 31=0 then Form1.Gauge2.Progress:=round(100*j/Max5);
    for k:=i to Max5 do
      if C5(i,k) then s:=s+NFH5[FFF5[FH4[D5[j,0],D5[k,0]],FH4[D5[j,1],D5[k,1]]]];
    write(f,s);
    ct:=ct+s;
    Form1.Label1.Caption:=FloatToStr(ct);
    Form1.Gauge1.Progress:=round(100*ct/2.414E12);
    inc(j);
    inc(p);
    while (j<=Max5) and (not C5(i,j)) do inc(j);
  end;
 end;
 Timer2Timer(Self);
end;

procedure TForm1.Timer3Timer(Sender: TObject);
var p,k,s: integer;
begin
 p:=0;
 while p<800 do
 begin
  if j>max5 then
  begin
    inc(i);
    j:=i;
  end;
  if i>Max5 then
  begin
    p:=1000;
    Timer1.Enabled:=false;
    CloseFile(f);
  end else
  begin
    s:=0;
    if i<>Max5 then Form1.Gauge2.Progress:=round(100*(j-i)/(Max5-i));
    for k:=0 to j do
      if C5(k,j) then s:=s+NFL5[FFF5[FL4[D5[i,0],D5[k,0]],FL4[D5[i,1],D5[k,1]]]];
    write(f,s);
    ct:=ct+s;
    cn:=cn+1;
    Form1.Label1.Caption:=FloatToStr(ct);
    Form1.Gauge1.Progress:=round(100*cn/7828354);
    inc(j);
    inc(p);
    while (j<=Max5) and (not C5(i,j)) do inc(j);
  end;
 end;
 Timer2Timer(Self);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var Time2: TTime;
begin
  Label5.Caption:=TimeToStr(Time);
  if cn>1 then Time2:=(Now-StartingTime)/cn*7828354
  else Time2:=0;
  Time2:=StartingTime+Time2;
  Label7.Caption:=DateToStr(Time2)+'   '+TimeToStr(Time2);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  StartingTime:=Now;
  Label3.Caption:=TimeToStr(StartingTime);
  MakeFileNFL6;
  beep;
  Button4.Enabled:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Button3.Enabled:=false;
  Button2.Enabled:=false;
  StartingTime:=Now;
  Label3.Caption:=TimeToStr(StartingTime);
  MakeFileNFH6;
  beep;
  Button5.Enabled:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
var f1: textfile;
    pos: integer;
begin
  Button4.Enabled:=false;
  Timer1.Enabled:=false;
  assignfile(f1,'c:\mbf\nfl.txt');
  rewrite(f1);
  pos:=filepos(f);
  write(f1,i,' ',j,' ',pos,' ',ct);
  closefile(f1);
  closefile(f);
  Button2.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
var f1: textfile;
    pos: integer;
begin
  Button5.Enabled:=false;
  Timer1.Enabled:=false;
  assignfile(f1,'c:\mbf\nfh.txt');
  rewrite(f1);
  pos:=filepos(f);
  write(f1,i,' ',j,' ',pos,' ',ct);
  closefile(f1);
  closefile(f);
  Button3.Enabled:=true;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 MakeD6;
end;

end.
