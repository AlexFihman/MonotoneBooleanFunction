unit Unit2;

interface


const D1: array[0..2,0..1] of integer =((0,0),(0,1),(1,1));
      C0: array[0..1,0..1] of boolean =((True,True),(False,True));
      FH1: array[0..2,0..2] of integer=((0,1,2),(1,1,2),(2,2,2));
      FL1: array[0..2,0..2] of integer=((0,0,0),(0,1,1),(0,1,2));
      Max0: integer = 1;
      Max1: integer = 2;
      Max2: integer = 5;
      Max3: integer = 19;
      Max4: integer = 167;
      Max5: integer = 7580;
      Max6: integer = 7828353;

var
  C1: array [0..2,0..2] of boolean;
  C2: array [0..5,0..5] of boolean;
  C3: array [0..19,0..19] of boolean;
  C4: array [0..167,0..167] of boolean;
  D2: array [0..5,0..1] of integer;
  D3: array [0..19,0..1] of integer;
  D4: array [0..167,0..1] of integer;
  D5: array [0..7580,0..1] of integer;
  FFF1: array [0..1,0..1] of integer;
  FFF2: array [0..2,0..2] of integer;
  FFF3: array [0..5,0..5] of integer;
  FFF4: array [0..19,0..19] of integer;
  FFF5: array [0..167,0..167] of integer;
  FH2,FL2: array [0..5,0..5] of integer;
  FH3,FL3: array [0..19,0..19] of integer;
  FH4,FL4: array [0..167,0..167] of integer;
  Position6: array [0..7580] of integer;
  NFH4,NFL4: array [0..167] of integer;
  NFH5,NFL5: array [0..7580] of integer;

procedure InitArrays;
function C5(i,j: integer): boolean;

implementation

procedure MakeC1;
var i,j: integer;
begin
  for i:=0 to Max1 do
  for j:=0 to Max1 do
  C1[i,j]:=C0[D1[i,0],D1[j,0]] and C0[D1[i,1],D1[j,1]];
end;

procedure MakeC2;
var i,j: integer;
begin
  for i:=0 to Max2 do
  for j:=0 to Max2 do
  C2[i,j]:=C1[D2[i,0],D2[j,0]] and C1[D2[i,1],D2[j,1]];
end;

procedure MakeC3;
var i,j: integer;
begin
  for i:=0 to Max3 do
  for j:=0 to Max3 do
  C3[i,j]:=C2[D3[i,0],D3[j,0]] and C2[D3[i,1],D3[j,1]];
end;

procedure MakeC4;
var i,j: integer;
begin
  for i:=0 to Max4 do
  for j:=0 to Max4 do
  C4[i,j]:=C3[D4[i,0],D4[j,0]] and C3[D4[i,1],D4[j,1]];
end;

function C5(i,j: integer): boolean;
begin
  C5:=C4[D5[i,0],D5[j,0]] and C4[D5[i,1],D5[j,1]];
end;

procedure MakeD2;
var i,j,cn: integer;
begin
  cn:=0;
  for i:=0 to Max1 do
  for j:=i to Max1 do
  if C1[i,j] then
  begin
    D2[cn,0]:=i;
    D2[cn,1]:=j;
    FFF2[i,j]:=cn;
    inc(cn);
  end;
end;

procedure MakeD3;
var i,j,cn: integer;
begin
  cn:=0;
  for i:=0 to Max2 do
  for j:=i to Max2 do
  if C2[i,j] then
  begin
    D3[cn,0]:=i;
    D3[cn,1]:=j;
    FFF3[i,j]:=cn;
    inc(cn);
  end;
end;

procedure MakeD4;
var i,j,cn: integer;
begin
  cn:=0;
  for i:=0 to Max3 do
  for j:=i to Max3 do
  if C3[i,j] then
  begin
    D4[cn,0]:=i;
    D4[cn,1]:=j;
    FFF4[i,j]:=cn;
    inc(cn);
  end;
end;

procedure MakeD5;
var i,j,cn: integer;
begin
  cn:=0;
  for i:=0 to Max4 do
  for j:=i to Max4 do
  if C4[i,j] then
  begin
    D5[cn,0]:=i;
    D5[cn,1]:=j;
    FFF5[i,j]:=cn;
    inc(cn);
  end;
end;

procedure MakeFHL2;
var i,j: integer;
begin
  for i:=0 to Max2 do
  for j:=0 to Max2 do
    FH2[i,j]:=FFF2[FH1[D2[i,0],D2[j,0]],FH1[D2[i,1],D2[j,1]]];
  for i:=0 to Max2 do
  for j:=0 to Max2 do
    FL2[i,j]:=FFF2[FL1[D2[i,0],D2[j,0]],FL1[D2[i,1],D2[j,1]]];
end;

procedure MakeFHL3;
var i,j: integer;
begin
  for i:=0 to Max3 do
  for j:=0 to Max3 do
    FH3[i,j]:=FFF3[FH2[D3[i,0],D3[j,0]],FH2[D3[i,1],D3[j,1]]];
  for i:=0 to Max3 do
  for j:=0 to Max3 do
    FL3[i,j]:=FFF3[FL2[D3[i,0],D3[j,0]],FL2[D3[i,1],D3[j,1]]];
end;

procedure MakeFHL4;
var i,j: integer;
begin
  for i:=0 to Max4 do
  for j:=0 to Max4 do
    FH4[i,j]:=FFF4[FH3[D4[i,0],D4[j,0]],FH3[D4[i,1],D4[j,1]]];
  for i:=0 to Max4 do
  for j:=0 to Max4 do
    FL4[i,j]:=FFF4[FL3[D4[i,0],D4[j,0]],FL3[D4[i,1],D4[j,1]]];
end;
procedure MakeNFHL4;
var i,j: integer;
begin
  for i:=0 to Max4 do
  begin
    NFH4[i]:=0;
    NFL4[i]:=0
  end;

  for i:=0 to Max4 do
  for j:=0 to i do
    if C4[j,i] then
    begin
      inc(NFH4[j]);
      inc(NFL4[i])
    end;
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
  for j:=0 to i do
    if C5(j,i) then
    begin
      inc(NFH5[j]);
      inc(NFL5[i])
    end;
end;

procedure MakePosition6;
var i: integer;
begin
  Position6[0]:=0;
  for i:=1 to Max5 do
    Position6[i]:=Position6[i-1]+NFH5[i-1];
end;

procedure InitArrays;
begin
  MakeC1;
  MakeD2;
  MakeC2;
  MakeD3;
  MakeC3;
  MakeD4;
  MakeC4;
  MakeD5;
  MakeFHL2;
  MakeFHL3;
  MakeFHL4;
  MakeNFHL4;
  MakeNFHL5;
  MakePosition6;
end;

end.
