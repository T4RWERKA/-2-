unit MathLib;

interface

function Log(const Num, Base: Real): Real;
function IsInteger(const A: Real): Boolean;
function BinPow(A: Real; const N: Real): Real;
function ExpPow(A: Real; N: Real): Real;

implementation

function Log(Const Num, Base: Real): Real;
begin
  Result := Ln(Num) / Ln(Base);
end;

function IsInteger(const A: Real): Boolean;
begin
  if Abs(A- Trunc(A)) < 1e-10 then
    Result := True
  else
    Result := False;
end;

function BinPow(A: Real; const N: Real): Real;
var
  IntN: Integer;
begin
  IntN := Round(N);
  Result := 1;
  while IntN  <> 0 do
  begin
    if (IntN and 1 = 1) then
      Result := Result * A;
    A := A * A;
    IntN := IntN shr 1;
  end;
end;

function ExpPow(A: Real; N: Real): Real;
begin
  Result := Exp(N * Ln(A));
end;

end.
