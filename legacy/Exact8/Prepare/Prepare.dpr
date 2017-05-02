program Prepare;

uses
  Forms,
  Unit2 in 'Unit2.pas',
  Unit1 in 'Unit1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  InitArrays;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
