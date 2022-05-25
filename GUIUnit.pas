unit GUIUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.Actions, Vcl.ActnList,
  Unit2,
  Math,
  MathParser,
  NumIntegrationLib,
  MathLib,
  DynamicStructLib;


type
  TTrackBar = class(VCL.ComCtrls.TTrackBar)
  private
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  end;
  TMethod = function (Func: String; const A, B, Eps: Real; var N: Integer): Real;
  TMyTrackBar = class(TTrackBar)
  end;
  TMainForm = class(TForm)
    Panel1: TPanel;
    lblMethod: TLabel;
    lblFunction: TLabel;
    cmbbxMethods: TComboBox;
    edtFunc: TEdit;
    edtLowLimit: TEdit;
    lblLowLimit: TLabel;
    edtUpperLimit: TEdit;
    lblUpperLimit: TLabel;
    btnCalc: TButton;
    ActionList1: TActionList;
    Action1: TAction;
    trckAccuracy: TTrackBar;
    lblAccuracy: TLabel;
    lblSign: TLabel;
    lblNum: TLabel;
    Button1: TButton;
    procedure btnCalcClick(Sender: TObject);
    procedure cmbbxMethodsChange(Sender: TObject);
    procedure trckAccuracyChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function Eps: Real;
    procedure SetEps(const Value: Real);
    function Res: Real;
    procedure SetRes(const Value: Real);
    function N: Integer;
    procedure SetN(const Value: Integer);
    { Private declarations }
  public
    property PEps: Real read Eps write SetEps;
    property PRes: Real read Res write SetRes;
    property AN: Integer read N write SetN;
  end;

var
  MainForm: TMainForm;
  Method: TMethod;
  LowLimit, UpperLimit: Real;
  Func: String;

implementation

{$R *.dfm}

var
  CorrectFlag, ComboFlag: Boolean;
  Eps, Res: Real;
  N: Integer;

procedure TTrackBar.WMLButtonDown(var Message: TWMLButtonDown);
begin
  Position := Round((Max - Min) / Width * ScreenToClient(Mouse.CursorPos).X) + Min;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
  FNAme: String;
  FFile: TextFile;
begin
//  SaveDialog1.Execute();
//  FName := SaveDialog1.FileName;
//  AssignFile(FFile, FName);
//  ReSet(FFile);
//  Write('valodya_bashlykov');
//  Close();
//  ShowMessage(FName);
end;

procedure SetCursor(edtControl: TEdit; const CursPos: Integer);
begin
  edtControl.SetFocus;
  edtControl.SelStart := CursPos;
end;

procedure TMainForm.btnCalcClick(Sender: TObject);
begin
  CorrectFlag := True;
  if ComboFlag then
  begin
    Method := SelectMethod(cmbbxMethods.ItemIndex);
    if edtFunc.Text <> '' then
    begin
      Func := edtFunc.Text;
      if edtLowLimit.Text <> '' then
      begin
        LowLimit := StrToFloat(edtLowLimit.Text);
        if edtUpperLimit.Text <> '' then
          UpperLimit := StrToFloat(edtUpperLimit.Text)
        else
        begin
          SetCursor(edtUpperLimit, 0);
          ShowMessage('Введите верхний предел');
          CorrectFlag := False;
        end;
      end
      else
      begin
        SetCursor(edtLowLimit, 0);
        ShowMessage('Введите нижний предел');
        CorrectFlag := False;
      end;
    end
    else
    begin
      SetCursor(edtFunc, 0);
      ShowMessage('Введите функцию');
      CorrectFlag := False;
    end
  end
  else
  begin
    cmbbxMethods.DroppedDown := True;
    ShowMessage('Выберите метод интегрирования');
    CorrectFlag := False;
  end;
  Eps := SelectAccuracy(trckAccuracy.Position);
  if CorrectFlag then
  begin
    Res := Int(Method(Func, LowLimit, UpperLimit, Eps,
      N) / Eps) * Eps;
    Application.CreateForm(TfrmResult, frmResult);
    frmResult.Show;
    frmResult.lblFunction.Caption := 'Функция: ' + Func;
    frmResult.lblResult.Caption := 'Результат: ' + FloatToStr(Res);
    frmResult.lblPrecision.Caption := 'Точность ' + FloatToStr(Eps) + ' была ' +
      'достигнута при числе отрезков разбиения N = ' + IntToStr(N);
  end;
end;

procedure TMainForm.cmbbxMethodsChange(Sender: TObject);
begin
  ComboFlag := True;
end;

function TMainForm.Eps: Real;
begin
  Result := Eps;
end;

function TMainForm.N: Integer;
begin
  Result := N;
end;

function TMainForm.Res: Real;
begin
  Result := Res;
end;

procedure TMainForm.SetEps(const Value: Real);
begin
  PEps := Value;
end;

procedure TMainForm.SetN(const Value: Integer);
begin
  AN := Value;
end;

procedure TMainForm.SetRes(const Value: Real);
begin
  PRes := Value;
end;

procedure TMainForm.trckAccuracyChange(Sender: TObject);
begin
  lblNum.Caption := IntToStr(trckAccuracy.Position);
end;

initialization

ComboFlag := False;

end.
