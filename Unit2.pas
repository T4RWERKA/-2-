unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FilesLib;

type
  TfrmResult = class(TForm)
//    FResult, FEpr: Real;
    lblResult: TLabel;
    lblPrecision: TLabel;
    btnOK: TButton;
    lblFunction: TLabel;
    btnSave: TButton;
    SaveDialog1: TSaveDialog;
    procedure btnOKClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
//    procedure SetResult(const Value: Real);
//    procedure SetEps(const Value: Real);
//    SetMethodNum, SetN: Integer;
  public
//    property Result: Real write SetResult;
//    property Eps: Real write SetEps;
//    property MethodNum: Integer write SetMethodNum;
//    property N: Integer write SetN;
  end;

var
  frmResult: TfrmResult;

implementation

{$R *.dfm}

procedure TfrmResult.btnOKClick(Sender: TObject);
begin
  frmResult.Close;
end;

procedure TfrmResult.btnSaveClick(Sender: TObject);
begin
  SaveDialog1.Execute();
  CreateTextFile(0, 100, SaveDialog1.FileName, FloatToStr(10), FloatToStr(0.001));
end;

end.
