program Project1;

uses
  Vcl.Forms,
  GUIUnit in 'GUIUnit.pas' {MainForm},
  System.SysUtils,
  Math,
  MathParser in 'D:\Libraries\MathParser.pas',
  NumIntegrationLib in 'D:\Libraries\NumIntegrationLib.pas',
  MathLib in 'D:\Libraries\MathLib.pas',
  DynamicStructLib in 'D:\Libraries\DynamicStructLib.pas',
  Unit2 in 'Unit2.pas' {frmResult},
  FIlesLib in 'FIlesLib.pas';

{$R *.res}

var
  Func, PFunc: String;
  A, B, Eps: Real;
  MethodNum, N: Integer;
  Method: TMethod;
  ErrorFlag: Boolean;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  MainForm.Button1.Hide;
  Application.Run;
end.
