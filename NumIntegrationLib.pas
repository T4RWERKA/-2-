unit NumIntegrationLib;

interface

uses
  System.SysUtils,
  Math,
  MathParser;

function LeftRect(Func: String; const A, B, Eps: Real; var N: Integer): Real;
function RightRect(Func: String; const A, B, Eps: Real; var N: Integer): Real;
function MediumRect(Func: String; const A, B, Eps: Real; var N: Integer): Real;
function Trapezoid(Func: String; const A, B, Eps: Real; var N: Integer): Real;
function Simpson(Func: String; const A, B, Eps: Real; var N: Integer): Real;

implementation

type
  TElem = record
    X: Real;
    Y: Real;
  end;

procedure CreateTextFile(var F: TObject; const Method: TMethod; const Eps: Real;
   Res: Real);
const
  StrRect1 = '����� ��������������� � ����� ���������� �������������� ������� ����� ����������, ������������� � ������ ��������������� ������� ';
  StrRect2 = '�� ��������� ������� �������, �� ���� ���������, �� ������ ������������ �������. ���� ����������� ������ ��������������� �������,';
  StrRect3 = '�� ����� ����� ����������� � ����������� ���������� ������� ��� �������� ������������� �������� ��������� ����� ���������������,';
  StrRect4 = '������ ������� ����� ������������ ����������� ����� ���������������� ��������� ������ ��������������, � ������ � ��������� ';
  StrRect5 = '��������������� ������� � ���� �����.';
  StrRect6 = '���� ������� [a, b] �������� ������������ � �� ������������ ����������� ���������, �������� ��������� ����� ����� �� �������';
  StrLeftRect1 = '����� ���������������:';
  StrRightRect1 = '������ ���������������:';
  StrMediumRect1 = '������� ���������������';
  FormulaLeft1 = 'I = f(a)(b-a)';
  FormulaMedium1 = 'I = f((a+b)/2)(b-a)';
  FormulaRight1 = 'I = f(b)(b-a)';
  StrSegm1 = '� ������ ��������� ������� �������������� �� n ������������ �������� ���������� ���� ������ ����������� �� ������ �� ���� ������������';
  StrSegm2 = '�������� ����� ����� ��������� ������. � ���������� ���������� �������:';
  FormulaLeft2 = 'I = Sum(i=0,n-1) f(x[i])(x[i+1]�x[i])';
  FormulaMedium2 = 'I = Sum(i=0,n-1) f((x[i+1]+x[i])/2)(x[i+1]�x[i])';
  FormulaRight2 = 'I = Sum(i=1,n) f(x[i])(x[i]�x[i-1])';
  StrSameSegm = '���� ��� ������������ ������� ��������� ����� �����, �� ������� ����� �������� � ��������� ����:';
  FormulaLeft3 = 'I = h*Sum(i=0,n-1) f[i] = h(f[0]+f[1]+...+f[n-1])';
  FormulaMedium3 = 'I = h(f[0]/2+f[1]+...+f[n-1]+f[n]/2)';
  FormulaRight3 = 'I = h*Sum(i=1,n)f[i] = h(f[1]+f[2]+...+f[n])';
  StrStep = '��� �������������� ��������� �� ������� h = (b-a)/n';
  StrEps = '��� �������� Eps = ';
  StrRes = ' ��������� �����:';
begin

end;

function LeftRect(Func: String; const A, B, Eps: Real; var N: Integer): Real;
var
  i: Integer;
  X, Y, Res1, Res2, Step: Real;
  ErrorFlag: Boolean;
  XY: TElem;
  Table: File of TElem;
  ResFile: TextFile;
begin
  Func := MarshYard(Func, ErrorFlag);
  N := 2;
  Res2 := 0;
  repeat
    Res1 := Res2;
    Res2 := 0;
    Step := (B - A) / N;
    X := A;
    for i := 1 to N do
    begin
      Res2 := Res2 + PostCalc(Func, X, ErrorFlag);
      X := X + Step;
    end;
    Res2 := Res2 * Step;
    N := N * 2;
  until Abs(Res2 - Res1) < Eps;

  // ������ X � Y � �������������� ����
  Assign(Table, 'D:\Libraries\Table.txt');
  Rewrite(Table);
  X := A;
  for i := 1 to N do
  begin
    Y := PostCalc(Func, X, ErrorFlag);
    XY.X := X;
    XY.Y := Y;
    X := X + Step;
    Write(Table, XY);
  end;
  Close(Table);

  Result := Res2;
end;

function RightRect(Func: String; const A, B, Eps: Real; var N: Integer): Real;
var
  i: Integer;
  X, Res1, Res2, Step: Real;
  ErrorFlag: Boolean;
begin
  Func := MarshYard(Func, ErrorFlag);
  N := 1;
  Res2 := 0;
  repeat
    Res1 := Res2;
    Res2 := 0;
    Step := (B - A) / N;
    X := A + Step;
    for i := 1 to N do
    begin
      Res2 := Res2 + PostCalc(Func, X, ErrorFlag);
      X := X + Step;
    end;
    Res2 := Res2 * Step;
    Inc(N);
  until Abs(Res2 - Res1) < Eps;
  Result := Res2;
end;

function MediumRect(Func: String; const A, B, Eps: Real; var N: Integer): Real;
var
  i: Integer;
  X, Res1, Res2, Step: Real;
  ErrorFlag: Boolean;
begin
  Func := MarshYard(Func, ErrorFlag);
  N := 1;
  Res2 := 0;
  repeat
    Res1 := Res2;
    Res2 := 0;
    Step := (B - A) / N;
    X := A;
    for i := 1 to N do
    begin
      Res2 := Res2 + PostCalc(Func, X + Step / 2, ErrorFlag);
      X := X + Step;
    end;
    Res2 := Res2 * Step;
    Inc(N);
  until Abs(Res2 - Res1) < Eps;
  Result := Res2;
end;

function Trapezoid(Func: String; const A, B, Eps: Real; var N: Integer): Real;
var
  i: Integer;
  X, Res1, Res2, Step: Real;
  ErrorFlag: Boolean;
begin
  Func := MarshYard(Func, ErrorFlag);
  N := 1;
  Res2 := 0;
  repeat
    Res1 := Res2;
    Res2 := 0;
    Step := (B - A) / N;
    Res2 := Res2 + PostCalc(Func, A, ErrorFlag) / 2;
    Res2 := Res2 + PostCalc(Func, B, ErrorFlag) / 2;
    X := A + Step;
    for i := 1 to N - 1 do
    begin
      Res2 := Res2 + PostCalc(Func, X, ErrorFlag);
      X := X + Step;
    end;
    Res2 := Res2 * Step;
    Inc(N);
  until Abs(Res2 - Res1) < Eps;
  Result := Res2;
end;

function Simpson(Func: String; const A, B, Eps: Real; var N: Integer): Real;
var
  i: Integer;
  X, Res1, Res2, Step: Real;
  ErrorFlag: Boolean;
begin
  Func := MarshYard(Func, ErrorFlag);
  N := 1;
  Res2 := 0;
  repeat
    Res1 := Res2;
    Res2 := 0;
    Step := (B - A) / (2*N);
    Res2 := Res2 + PostCalc(Func, A, ErrorFlag);
    Res2 := Res2 + PostCalc(Func, B, ErrorFlag);
    X := A + Step;
    for i := 1 to N do
    begin
      Res2 := Res2 + 4 * PostCalc(Func, X, ErrorFlag);
      X := X + Step * 2;
    end;
    X := A + Step * 2;
    for i := 1 to N - 1 do
    begin
      Res2 := Res2 + 2 * PostCalc(Func, X, ErrorFlag);
      X := X + Step * 2;
    end;
    Res2 := Res2 * Step / 3;
    Inc(N);
  until Abs(Res2 - Res1) < Eps;
  Result := Res2;
end;

end.
