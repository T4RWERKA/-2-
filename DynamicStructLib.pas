unit DynamicStructLib;

interface

type
  PtOp = ^ElemOp;
  ElemOp = record
    Oper: Char;
    Next: PtOp;
  end;
  PtNum = ^ElemNum;
  ElemNum = record
    Num:  Real;
    Next: PtNum;
  end;

procedure Push(var Top: PtOp; const Element: Char); overload;
procedure Push(var Top: PtNum; const Element: Real); overload;
procedure Pop(var Top: PtOp; var Variable: Char); overload;
procedure Pop(var Top: PtNum; var Variable: Real); overload;
function IsEmpty(const Top: Pointer): Boolean;

implementation

// ���������� �������� � ����

{ Top - ��������� �� ������� �����
  Element - ����� ������� ����� }

// ���� �� ��������
procedure Push(var Top: PtOp; const Element: Char); overload;
var
  X: PtOp;
begin
  New(X);
  X^.Oper := Element;
  X^.Next := Top;
  Top := X;
end;

// ���� �� �����
procedure Push(var Top: PtNum; const Element: Real); overload;
var
  X: PtNum;
begin
  New(X);
  X^.Num := Element;
  X^.Next := Top;
  Top := X;
end;


// ���������� ������� �� �����

{ Top - ��������� �� ������� �����
  Variable - ����������, � ������� ����������� ������� �� ����� }

// ���� �� ��������
procedure Pop(var Top: PtOp; var Variable: Char); overload;
var
  X: PtOp;
begin
  Variable := Top^.Oper;
  X := Top;
  Top := Top^.Next;
  Dispose(X);
end;

// ���� �� �����
procedure Pop(var Top: PtNum; var Variable: Real); overload;
var
  X: PtNum;
begin
  Variable := Top^.Num;
  X := Top;
  Top := Top^.Next;
  Dispose(X);
end;

// �������� ����� �� �������

function IsEmpty(const Top: Pointer): Boolean;
begin
  if Top = Nil then
    IsEmpty := True
  else
    IsEmpty := False;
end;

end.
