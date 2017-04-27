unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin, Unit2, Gauges, Buttons, ToolWin, ComCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Int96 =record
     ready: integer;
     s1,s2,s3: integer;
  end;

  TYamada = record
    f: word;
    Ratio: array [0..7580] of word;
  end;

  TTaskArray = array [0..209] of Int96;
  TYamadaAll = array [0..209] of TYamada;
var
  Form1: TForm1;
  ftm1,ftm2,ftm3: file of TTaskArray;
  TT1,TT2,TT3: TTaskArray;
  YamadaAll: TYamadaAll;
  fya: file of TYamadaAll;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var i: integer;
    s: string;
begin
  assignfile(fya,'c:\mbf\yamada.dat');
  reset(fya);
  read(fya,YamadaAll);
  closefile(fya);
  OpenDialog1.Execute;
  assignfile(ftm1,OpenDialog1.FileName);
  reset(ftm1);
  Read(ftm1,TT1);
  OpenDialog2.Execute;
  assignfile(ftm2,OpenDialog2.FileName);
  reset(ftm2);
  Read(ftm2,TT2);
  closefile(ftm1);
  closefile(ftm2);
  for i:=0 to 209 do if TT1[i].Ready=1 then TT3[i]:=TT1[i]
    else TT3[i]:=TT2[i];
  SaveDialog1.Execute;
  assignfile(ftm3,SaveDialog1.FileName);
  Rewrite(ftm3);
  Write(ftm3,TT3);
  closefile(ftm3);
  for i:=0 to 209 do if TT3[i].Ready=1 then
  begin
    s:=IntToStr(i)+' '+IntToStr(YamadaAll[i].f)+' '+IntToStr(TT3[i].s1)+' '+IntToStr(TT3[i].s2)+' '+IntToStr(TT3[i].s3);
    Memo1.Lines.Add(s);
  end;
end;

end.
