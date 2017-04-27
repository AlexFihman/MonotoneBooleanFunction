Program Mix;
  {$APPTYPE CONSOLE}
uses SysUtils,Unit2;

type TList=Object
       Elements: array [0..4] of byte;
       size: integer;
       function Extract(n: integer): byte;
     end;

     TYList= object
       Elements: array [0..119,0..1] of word;
       Mark: array [0..119] of boolean;
       Size: integer;
       function ClearResult: integer;
     end;

     TYamada=record
       f: word;
       Ratio: array [0..7580] of word;
     end;

var i,j,k,cn: integer;
    ar1: array [0..119,0..4] of integer;
    List1,List2: TList;
    YList: TYList;
    YamadaAll: array [0..209] of TYamada;
    Buf,Buf2: array [0..31] of byte;
    f2,f3: file of byte;
    Oi,Vi: array [0..7580] of word;
    Kraftwerk: array [0..7580,0..119] of word;
    Checked: array [0..7580] of boolean;

function TList.Extract(n: integer): byte;
var i: integer;
begin
  Extract:=Elements[n];
  for i:=n to size-2 do Elements[i]:=Elements[i+1];
end;

function TYList.ClearResult: integer;
var i,j,cn: integer;
begin
  for i:=0 to 119 do Mark[i]:=false;

  for i:=0 to size-2 do
  for j:=i+1 to size-1 do
  if (Elements[i,0]=Elements[j,0]) and (Elements[i,1]=Elements[j,1])
     then Mark[j]:=true;

  cn:=0;
  for i:=0 to size-1 do
  if not Mark[i] then
  begin
    Elements[cn]:=Elements[i];
    inc(cn);
  end;
  size:=cn;
  ClearResult:=cn;
end;

function Apply(i,model: integer): integer;
var i1,i2: integer;
begin
  i2:=0;
  for i1:=0 to 4 do
  if odd(i shr i1) then i2:=i2+(1 shl ar1[model,i1]);
  Apply:=i2;
end;

function bit(i,r: integer): integer;
begin
  bit:=(i shr r) and 1;
end;

procedure f2buf(f: word);
var i: integer;
begin
  for i:=0 to 31 do buf[i]:=D1[D2[D3[D4[D5[f,bit(i,4)],bit(i,3)],bit(i,2)],bit(i,1)],bit(i,0)]
end;

function buf2f: word;
var lev1: array [0..15] of word;
    lev2: array [0..7] of word;
    lev3: array [0..3] of word;
    lev4: array [0..1] of word;
    i: integer;
begin
  for i:=0 to 15 do lev1[i]:=FFF1[buf[2*i],buf[2*i+1]];
  for i:=0 to 7 do lev2[i]:=FFF2[lev1[2*i],lev1[2*i+1]];
  for i:=0 to 3 do lev3[i]:=FFF3[lev2[2*i],lev2[2*i+1]];
  for i:=0 to 1 do lev4[i]:=FFF4[lev3[2*i],lev3[2*i+1]];
  buf2f:=FFF5[lev4[0],lev4[1]];
end;

function shuttle(f,n: word): word;
var i: integer;
    tsh: word;
begin
  tsh:=0;
  for i:=0 to 4 do if odd(f shr i) then tsh:=tsh + 1 shl ar1[n,i];
  shuttle:=tsh;
end;

function boeing(f,n: word): word;
var j: integer;
begin
  f2buf(f);
  buf2:=buf;
  for j:=0 to 31 do buf[j]:=buf2[shuttle(j,n)];
  boeing:=buf2f;
end;

begin
  Initarrays;
  for i:=0 to 4 do List1.Elements[i]:=i;
  List1.Size:=5;

  for i:=0 to 119 do
  begin
    k:=i;
    List2:=List1;
    for j:=5 downto 1 do
    begin
      ar1[i,5-j]:=List2.Extract(k mod j);
      k:=k div j;
    end;
  end;

  for i:=0 to Max5 do Oi[i]:=0;
  for i:=0 to Max5 do Vi[i]:=0;
  
  for i:=1 to Max5 do if Oi[i]=0 then
     for j:=0 to 119 do Oi[boeing(i,j)]:=i;

  for i:=0 to Max5 do if Oi[i]=i then 
  for j:=0 to Max5 do if Oi[j]=i then
    inc(Vi[i]);
    
  assignfile(f3,'kraftwerk.dat');
  rewrite(f3);
  for i:=0 to Max5 do
  begin
    writeln(i);
    for j:=0 to 119 do
    Kraftwerk[i,j]:=boeing(i,j);
  end;
  BlockWrite(f3,Kraftwerk,sizeof(Kraftwerk));
  {reset(f3);
  BlockRead(f3,Kraftwerk,sizeof(Kraftwerk));}
  closefile(f3);

  cn:=0;
  for i:=0 to 209 do
  for j:=0 to Max5 do YamadaAll[i].Ratio[j]:=0;

  for i:=0 to Max5 do if Vi[i]<>0 then
  begin
    writeln(i);
    YamadaAll[cn].f:=i;
    for j:=0 to Max5 do Checked[j]:=false;
    for j:=0 to Max5 do if (Oi[j]>=i) and not (Checked[j]) then
    begin
      for k:=0 to 119 do
      begin
         Ylist.Elements[k,0]:=Kraftwerk[i,k];
         Ylist.Elements[k,1]:=Kraftwerk[j,k];
      end;

    Ylist.Size:=120;

    if i=Oi[j] then YamadaAll[cn].Ratio[j]:=Ylist.ClearResult else
                    YamadaAll[cn].Ratio[j]:=Ylist.ClearResult*2;
    for k:=0 to Ylist.Size-1 do if Ylist.Elements[k,0]=i then
                    Checked[Ylist.Elements[k,1]]:=true;
    end;
  inc(cn);
  end;

  writeln(cn);
  cn:=0;
  for i:=0 to 209 do
  for j:=0 to Max5 do
    cn:=cn+YamadaAll[i].Ratio[j];

  writeln(cn);
  assignfile(f2,'yamada.dat');
  rewrite(f2);
  BlockWrite(f2,YamadaAll,sizeof(YamadaAll));
  closefile(f2);
end.