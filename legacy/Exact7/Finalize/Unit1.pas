unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  end;
  Int96 =record
     ready: boolean;
     s1,s2,s3: integer;
  end;
  TTaskArray = array [0..29] of Int96;

var
  Form1: TForm1;
  ftm: file of TTaskArray;
  fdg: file of integer;
  TaskArray: TTaskArray;
  ss1,ss2,ss3,sum1,sum2,sum3,posct: integer;
  ss: Int96;

implementation

{$R *.DFM}
function Int96ToStr: string;
var a: array[0..11] of byte;
    s: string;
    i1,j,k: integer;
    rest: byte;
    tmp: word;
begin
  move(sum1,a[0],4);
  move(sum2,a[4],4);
  move(sum3,a[8],4);
  s:='';
  for i1:=0 to 22 do
  begin
    rest:=0;
    for k:=11 downto 0 do
    begin
      tmp:=(a[k]+256*rest);
      a[k]:=tmp div 10;
      rest:=tmp mod 10;
    end;
    s:=IntToStr(rest)+s;
  end;
  Int96ToStr:=s;
end;

procedure TForm1.Button1Click(Sender: TObject);
var dummyi: integer;
    res: comp;
    s1: string;
begin
    assignfile(ftm,'c:\mbf\tm.dat');
    reset(ftm);
    read(ftm,TaskArray);
    closefile(ftm);

    sum1:=0;sum2:=0;sum3:=0;
    for dummyi:=0 to 29 do
    begin
      ss1:=TaskArray[dummyi].s1;
      ss2:=TaskArray[dummyi].s2;
      ss3:=TaskArray[dummyi].s3;
      asm
        push eax
        push ebx
        push ecx
        mov eax,sum1
        mov ebx,sum2
        mov ecx,sum3

        add eax,ss1
        adc ebx,ss2
        adc ecx,ss3

        mov sum1,eax
        mov sum2,ebx
        mov sum3,ecx
        pop ecx
        pop ebx
        pop eax
      end;
    end;
    Memo1.Lines.Insert(0,Int96ToStr);
end;

end.
