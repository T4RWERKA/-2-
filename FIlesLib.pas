unit FilesLib;

interface

uses
  MathParser;

procedure CreateTextFile(const MethodNum, N: Integer; const FileName: String;
  const Result, Eps: String);

implementation

type
  TElem = record
    X, Y: Real;
  end;
  TTable = File of TElem;

procedure CreateTable(const FileName: String; Func: String; const A, B,
  MethodNum: Integer; const N: Integer);

procedure WriteInTable(var F: TTable; const X, Y: Real);
var
  Elem: TElem;
begin
  Elem.X := X;
  Elem.Y := Y;
  Write(F, Elem);
end;

var
  i: Integer;
  Step, X: Real;
  F: TTable;
begin
  Assign(F, FileName);
  Rewrite(F);

  Step := (B - A) / N;
  if MethodNum = 2 then
    X := A + Step
  else
    X := A;
    
  for i := Low to High do


  Close(F);
end;

procedure CreateTextFile(const MethodNum, N: Integer; const FileName: String;
  const Result, Eps: String);
type
  TMethodsNames = (LeftRect, RightRect, MediumRect, Trapezoid, Simpson);
const
  StrRect1: array [1..5] of String = ('����� ��������������� � ����� ���������� �������������� ������� ����� ����������, ������������� � ������ ��������������� �������',
    '�� ��������� ������� �������, �� ���� ���������, �� ������ ������������ �������. ���� ����������� ������ ��������������� �������,',
    '�� ����� ����� ����������� � ����������� ���������� ������� ��� �������� ������������� �������� ��������� ����� ���������������,',
    '������ ������� ����� ������������ ����������� ����� ���������������� ��������� ������ ��������������, � ������ � ���������',
    '��������������� ������� � ���� �����.');
  StrTrapez: array [1..3] of String = ('����� �������� � ����� ���������� �������������� ������� ����� ����������, ������������� � ������ �� ������ ������������ ������� ',
    '��������������� ������� �� ��������� ������ �������, �� ���� �������� �������. ������� ��� �������� ������� ����������������',
    '�������������� ����������.');
  StrSimps: array [1..2] of String = ('����� �������� � ����� ���������� �������������� ������� ����� ����������, ������������� � ������ �� ������ ������������ ������� ',
    '��������������� ������� �� ��������� ������ �������, �� ���� �� ������������ �������.');
  StrOtr = '���� ������� [a, b] �������� ������������ � �� ������������ ����������� ���������, �������� ��������� ����� ����� �� �������';
  StrRect2: array [LeftRect..MediumRect] of String = ('����� ���������������:', '������ ���������������:', '������� ���������������');
  Formula1: array [TMethodsNames] of String = ('I = f(a)(b-a)', 'I = f(b)(b-a)',
    'I = f((a+b)/2)(b-a)', 'I = (f(a)+f(b))/2 * (b-a)', 'I = (f(a) + 4f((a+b)/2) + f(b)) * (b-a)/6');
  StrSegm: array [1..3] of String = ('� ������ ��������� ������� �������������� �� ',
    ' ������������ �������� ���������� ���� ������ ����������� �� ������ �� ���� ������������',
    '�������� ����� ����� ��������� ������. � ���������� ���������� �������:');
  Formula2: array [TMethodsNames] of String = ('I = Sum(i=0,n-1) f(x[i])(x[i+1]�x[i])',
    'I = Sum(i=1,n) f(x[i])(x[i]�x[i-1])', 'I = Sum(i=0,n-1) f((x[i+1]+x[i])/2)(x[i+1]�x[i])',
    'I = Sum(i=0,n-1) (f(x[i])+f(x[i+1]))/2 * (x[i+1]�x[i])',
    'I = (f(x[0]) + 4*Sum(i=1,n) f(x[2i-1]) + 2 * Sum(i=1,n-1) f(x[2i]) + f(x[2n])) * h/3');
  StrSameSegm = '���� ��� ������������ ������� ��������� ����� �����, �� ������� ����� �������� � ��������� ����:';
  Formula3: array [LeftRect..Trapezoid] of String = ('I = h*Sum(i=0,n-1) f[i] = h(f[0]+f[1]+...+f[n-1])',
    'I = h*Sum(i=1,n) f[i] = h(f[1]+f[2]+...+f[n])', 'I = h(f[0]/2+f[1]+...+f[n-1]+f[n]/2)',
    'I = h(f[0]/2+f[1]+...+f[n-1]+f[n]/2)');
  StrStep = '��� �������������� ��������� �� ������� ';
  Formula4: array [1..2] of String = ('h = (b-a)/n', 'h = (b-a)/(2n)');
  StrEps = '��� �������� Eps = ';
  StrRes = ' ��������� ����� ';
  StrN = '������ �������� ���������� ��� ���������� �������� ��������� N = ';
var
  MethodName: TMethodsNames;
  i: Integer;
  F: TextFile;
begin
  Assign(F, FileName);
  Rewrite(F);

  case MethodNum of
    0: MethodName := LeftRect;
    1: MethodName := RightRect;
    2: MethodName := MediumRect;
    3: MethodName := Trapezoid;
    4: MethodName := Simpson;
  end;

  case MethodName of
    LeftRect..MediumRect:
      for i := Low(StrRect1) to High(StrRect1) do
        WriteLn(F, StrRect1[i]);
    Trapezoid:
      for i := Low(StrTrapez) to High(StrTrapez) do
        WriteLn(F, StrTrapez[i]);
    Simpson:
      for i := Low(StrSimps) to High(StrSimps) do
        WriteLn(F, StrSimps[i]);
  end;

  WriteLn(F, StrOtr);
  if MethodName in [LeftRect..MediumRect] then
    WriteLn(F, StrRect2[MethodName]);
  WriteLn(F, Formula1[MethodName]);

  Write(F, StrSegm[1]);
  if MethodName in [LeftRect..Trapezoid] then
    Write(F, 'n')
  else
    Write(F, 'N = 2n ������');
  for i := 2 to 3 do
    WriteLn(F, StrSegm[i]);
  WriteLn(F, Formula2[MethodName]);

  if MethodName <> Simpson then
  begin
    WriteLn(F, StrSameSegm);
    WriteLn(F, Formula3[MethodName]);
  end;

  WriteLn(F, StrStep);
  if MethodName <> Simpson then
    WriteLn(F, Formula4[1])
  else
    WriteLn(F, Formula4[2]);

  WriteLn(F, StrEps, Eps, StrRes, Result, '.');
  WriteLn(F, StrN, N);
  Close(F);
end;

end.
