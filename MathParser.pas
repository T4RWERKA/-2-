unit MathParser;

interface

uses
  System.SysUtils,
  Math,
  MathLib,
  DynamicStructLib;

procedure SinToS(var Str: String);
function IsOperator(const Sign: Char): Boolean;
function IsFunction(const Sign: Char): Boolean;
procedure PrepChange(var Str: String);
function OpPreced(const Op: Char): Integer;
function OpLeftAssoc(const Op: Char): Boolean;
function MarshYard(const Str: String; var ErrorFlag: Boolean): String;
function PostCalc(const Str: String; Arg: Real; var ErrorFlag: Boolean): Real;

implementation

procedure SinToS(var Str: String);
const
  N = 9;
  Func: array [1..N] of String = ('ArcSin', 'ArcCos', 'ArcTan', 'ArcCtg', 'Sin',
    'Cos', 'Arc', 'Ctg', 'Ln');
  FuncA: array [1..N] of Char = ('a', 'c', 't', 'a', 'S', 'C', 'T', 'A',
    'L');
var
  i: Integer;
begin
  for i := 1 to N do
    while Pos(Func[i], Str) > 0 do
    begin
      Insert(FuncA[i], Str, Pos(Func[i], Str));
      Delete(Str, Pos(Func[i], Str), Length(Func[i]));
    end;
end;

// U - unary minus
function IsOperator(const Sign: Char): Boolean;
begin
  if Sign in ['+', '-', '*', '/', 'U', '^'] then
    Result := True
  else
    Result := False;
end;

function IsFunction(const Sign: Char): Boolean;
begin
  if Sign in ['S', 'C', 'T', 'A', 's', 'c', 't', 'a', 'L'] then
    Result := True
  else
    Result := False;
end;

procedure PrepChange(var Str: String);
var
  i, Br: Integer;
  Flag: Boolean;
  SteckPt: PtOp;
  C: Char;
begin
  SinToS(Str);
  i := 1;
  while i <= Length(Str) do
  begin
    if (Str[i] = '+') and ((i = 1) or (Str[i - 1] = '(')) then
    begin
      Delete(Str, i, 1);
      Dec(i);
    end;
    Inc(i);
  end;
  for i := 1 to Length(Str) do
    if (Str[i] = '-') and ((i = 1) or (Str[i - 1] = '(')) then
      Str[i] := 'U';
  Flag := True;
  i := 1;
  Br := 0;
  SteckPt := Nil;
  while i <= Length(Str) do
  begin
    if IsFunction(Str[i]) and (Str[i + 1] <> '(') then
    begin
      Insert('(', Str, i + 1);
      Inc(i);
      Inc(Br);
    end
    else
    begin
      case Str[i] of
        '(': Push(SteckPt, Str[i]);
        ')': Pop(SteckPt, C);
      end;
      if Br > 0 then
        if i = Length(Str) then
        begin
          Str := Str + ')';
          Inc(i);
        end
        else if IsOperator(Str[i]) and IsEmpty(SteckPt) then
        begin
          Insert(')', Str, i);
          Inc(i);
          Dec(Br);
        end
    end;
    Inc(i);
  end;
end;

function OpPreced(const Op: Char): Integer;
begin
  case Op of
    '-', '+': Result := 1;
    '*', '/': Result := 2;
    'U': Result := 3;
    '^': Result := 4;
  end;
end;

function OpLeftAssoc(const Op: Char): Boolean;
begin
  case Op of
    '-', '+', '*', '/', 'U': Result := True;
    '^': Result := False;
  end;
end;

function MarshYard(const Str: String; var ErrorFlag: Boolean): String;
var
  i: Integer;
  SteckPt: PtOp;
  C: Char;
  Flag, NumFlag: Boolean;
  Str1: String;
begin
  ErrorFlag := False;
  Str1 := Str;
  PrepChange(Str1);
//  WriteLn(Str1);
  Result := '';
  SteckPt := Nil;
  NumFlag := False;
  for i := 1 to Length(Str1) do
  begin
    if (Str1[i] >= '0') and (Str1[i] <= '9') or (Str1[i] = 'x') then
    begin
      Result := Result + Str1[i];
      if not NumFlag then
        NumFlag := True;
    end
    else
    begin
      if NumFlag then
      begin
        Result := Result + ' ';
        NumFlag := False;
      end;
      if IsFunction(Str1[i])  then
        Push(SteckPt, Str1[i])
      else if IsOperator(Str1[i]) then
      begin
        while (not IsEmpty(SteckPt)) and ((IsOperator(SteckPt.Oper) and
          ((OpLeftAssoc(Str1[i]) and (OpPreced(Str1[i]) <= OpPreced(SteckPt.Oper)))
          or (not OpLeftAssoc(Str1[i]) and (OpPreced(Str1[i]) <
          OpPreced(SteckPt.Oper)))))) do
          begin
            Pop(SteckPt, C);
            Result := Result + C;
          end;
        Push(SteckPt, Str1[i]);
      end
      else if Str1[i] = '(' then
        Push(SteckPt, Str1[i])
      else if Str1[i] = ')' then
      begin
        Flag := True;
        while (not IsEmpty(SteckPt)) and Flag do
          if SteckPt.Oper = '(' then
            Flag := False
          else
          begin
            Pop(SteckPt, C);
            Result := Result + C;
          end;
        if Flag then
        begin
          (* ERROR *)
          ErrorFlag := True;
          WriteLn('Ошибка! В выражении пропущена скобка.');
        end
        else
        begin
          Pop(SteckPt, C);
          if (not IsEmpty(SteckPt)) and (IsFunction(SteckPt.Oper)) then
          begin
            Pop(SteckPt, C);
            Result := Result + C;
          end;
        end;
      end;
    end;
  end;
  Result := Result + ' ';
  while not IsEmpty(SteckPt) do
  begin
    if SteckPt.Oper = '(' then
    begin
      (* ERROR *)
      ErrorFlag := True;
      WriteLn('Ошибка! В выражении пропущена скобка.');
    end;
    Pop(SteckPt, C);
    Result := Result + C;
  end;
end;

function PostCalc(const Str: String; Arg: Real; var ErrorFlag: Boolean): Real;
var
  i: Integer;
  Num1, Num2: Real;
  SteckPt: PtNum;
  NumFlag: Boolean;
begin
  ErrorFlag := False;
  NumFlag := False;
  i := 1;
  while i <= Length(Str) do
  begin
    if (Str[i] >= '0') and (Str[i] <= '9') then
    begin
      if not NumFlag then
      begin
        Num1 := Ord(Str[i]) - 48;
        NumFlag := True;
      end
      else
        Num1 := Num1 * 10 + Ord(Str[i]) - 48;
    end
    else
    begin
      if NumFlag then
      begin
        NumFlag := False;
        Push(SteckPt, Num1);
      end
      else if Str[i] = 'x' then
      begin
        Push(SteckPt, Arg);
        Inc(i);
      end
      else if IsOperator(Str[i]) then
      begin
        if Str[i] in ['+', '-', '*', '/', '^'] then
        begin
          Pop(SteckPt, Num1);
          Pop(SteckPt, Num2);
        end
        else
          Pop(SteckPt, Num1);
        case Str[i] of
          '+': Push(SteckPt, Num2 + Num1);
          '-': Push(SteckPt, Num2 - Num1);
          '*': Push(SteckPt, Num2 * Num1);
          '/': Push(SteckPt, Num2 / Num1);
          'U': Push(SteckPt, -Num1);
          '^':
          begin
            if (Num1 = 0) and (Num2 = 0) then
            begin
              (* ERROR *)
              ErrorFlag := True;
              Writeln('Значение не определено');
            end
            else if IsInteger(Num1) then
              Push(SteckPt, BinPow(Num2, Num1))
            else if Num2 >= 0 then
              Push(SteckPt, ExpPow(Num2, Num1))
            else
            begin
              (* ERROR *)
              ErrorFlag := True;
              Writeln('Значение не определено');
            end;
          end;
        end;
      end
      else
      begin
        Pop(SteckPt, Num1);
        case Str[i] of
          'S': Push(SteckPt, Sin(Num1));
          'C': Push(SteckPt, Cos(Num1));
          'T': Push(SteckPt, Tan(Num1));
          'A': Push(SteckPt, 1 / Tan(Num1));
          's':
          begin
            if Abs(Num1) > 1 then
            begin
              (* ERROR *)
              ErrorFlag := True;
              Writeln('Значение арксинуса не определено');
            end
            else
              Push(SteckPt, ArcSin(Num1));
          end;
          'c':
          begin
            if Abs(Num1) > 1 then
            begin
              (* ERROR *)
              ErrorFlag := True;
              Writeln('Значение арккосинуса не определено');
            end
            else
              Push(SteckPt, ArcCos(Num1));
          end;
          't': Push(SteckPt, ArcTan(Num1));
          'a': Push(SteckPt, Pi/2 - ArcTan(Num1));
          'L':
          begin
            if Num1 <= 0 then
            begin
              (* ERROR *)
              ErrorFlag := True;
              Writeln('Значение логарифма не определено');
            end
            else
              Push(SteckPt, Ln(Num1));
          end;
        end;
      end;
    end;
    Inc(i);
  end;
  if not ErrorFlag then
    Pop(SteckPt, Result);
end;

end.
