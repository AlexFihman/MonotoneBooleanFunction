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
    procedure Timer2Timer(Sender: TObject);
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

  TNFL6Thread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

  TNFH6Thread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  Form1: TForm1;
  f: file of integer;
  i,j,cn,StartCn: integer;
  ct: extended;
  TimeMark,StartingTime: TTime;
  progress,prev: extended;
  NFL6Thread: TNFL6Thread;
  NFH6Thread: TNFH6Thread;  
  NFL6paused: boolean=false;
  NFH6Paused: boolean=false;

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
  if FileExists('c:\mbf\NFL6.dat') then
    reset(f) else rewrite(f);
  assignfile(f1,'c:\mbf\nfl.txt');
  if FileExists('c:\mbf\nfl.txt') then
  begin
    reset(f1);
    read(f1,i,j,pos,ct,cn);
    StartCn:=cn;
    close(f1);
  end
  else begin
    i:=0;j:=0;pos:=0;ct:=0;cn:=0;StartCn:=0;
  end;
  seek(f,pos);
  NFL6Thread:=TNFL6Thread.Create(false);
  NFL6Thread.Priority:=tpIdle;
end;

procedure MakeFileNFH6;
var f1: textfile;
    buf: array[0..1023] of integer;
    RRead,pos: integer;
    dummyi: integer;
begin
  assignfile(f,'c:\mbf\NFH6.dat');
  if not FileExists('c:\mbf\NFH6.dat') then rewrite(f) else reset(f);
  assignfile(f1,'c:\mbf\nfh.txt');
  if FileExists('c:\mbf\nfh.txt') then
  begin
    reset(f1);
    read(f1,i,j,pos,ct,cn);
    StartCn:=cn;
    close(f1);
  end
  else begin
    i:=0;j:=0;pos:=0;ct:=0;cn:=0;
    StartCn:=0;
  end;
  seek(f,pos);
  NFH6Thread:=TNFH6Thread.Create(false);
  NFH6Thread.Priority:=tpIdle;
end;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  InitArrays;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var Time2: TTime;
begin
  Form1.Label1.Caption:=FloatToStr(ct);
  Form1.Gauge1.Progress:=round(100*cn/7828354);
  if i<>Max5 then Form1.Gauge2.Progress:=round(100*(j-i)/(Max5-i));

  Label5.Caption:=TimeToStr(Time);
  if (cn>StartCn) and (StartCn<7828354) then Time2:=(Now-StartingTime)/(cn-StartCn)*(7828354-StartCn) else Time2:=0;
  Time2:=StartingTime+Time2;
  Label7.Caption:=DateToStr(Time2)+'   '+TimeToStr(Time2);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  NFL6Paused:=false;
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  StartingTime:=Now;
  Label3.Caption:=TimeToStr(StartingTime);
  MakeFileNFL6;
  Button4.Enabled:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  NFH6Paused:=false;
  Button3.Enabled:=false;
  Button2.Enabled:=false;
  StartingTime:=Now;
  Label3.Caption:=TimeToStr(StartingTime);
  MakeFileNFH6;
  Button5.Enabled:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Button4.Enabled:=false;
  NFL6Paused:=true;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Button5.Enabled:=false;
  NFH6Paused:=true;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 MakeD6;
end;

procedure TNFL6Thread.Execute;
var s,k: integer;
    f1: textfile;
begin
  repeat
    if j>max5 then
    begin
      inc(i);
      j:=i;
    end;
    if i>Max5 then NFL6Paused:=true
    else
    begin
      s:=0;
      for k:=0 to j do
        if C5(k,j) then s:=s+NFL5[FFF5[FL4[D5[i,0],D5[k,0]],FL4[D5[i,1],D5[k,1]]]];
      write(f,s);
      ct:=ct+s;
      cn:=cn+1;
      inc(j);
      while (j<=Max5) and (not C5(i,j)) do inc(j);
    end;
  until NFL6paused;
  assignfile(f1,'c:\mbf\nfl.txt');
  rewrite(f1);
  write(f1,i,' ',j,' ',filepos(f),' ',ct,' ',cn);
  closefile(f1);
  closefile(f);
end;

procedure TNFH6Thread.Execute;
var s,k: integer;
    f1: textfile;
begin
  repeat
    if j>Max5 then
    begin
      inc(i);
      j:=i;
    end;
    if i>Max5 then NFH6Paused:=true
    else
    begin
      s:=0;
      for k:=i to Max5 do
        if C5(i,k) then s:=s+NFH5[FFF5[FH4[D5[j,0],D5[k,0]],FH4[D5[j,1],D5[k,1]]]];
      write(f,s);
      ct:=ct+s;
      cn:=cn+1;
      inc(j);
      while (j<=Max5) and (not C5(i,j)) do inc(j);
    end;
  until NFH6Paused;
  assignfile(f1,'c:\mbf\nfh.txt');
  rewrite(f1);
  write(f1,i,' ',j,' ',filepos(f),' ',ct,' ',cn);
  closefile(f1);
  closefile(f);
end;

end.
