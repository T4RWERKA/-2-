object frmResult: TfrmResult
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
  ClientHeight = 184
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblResult: TLabel
    Left = 24
    Top = 48
    Width = 60
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090': '
    WordWrap = True
  end
  object lblPrecision: TLabel
    Left = 24
    Top = 87
    Width = 47
    Height = 13
    Caption = #1058#1086#1095#1085#1086#1089#1090#1100
  end
  object lblFunction: TLabel
    Left = 24
    Top = 8
    Width = 48
    Height = 13
    Caption = #1060#1091#1085#1082#1094#1080#1103':'
  end
  object btnOK: TButton
    Left = 160
    Top = 132
    Width = 73
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnSave: TButton
    Left = 296
    Top = 132
    Width = 121
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1077#1096#1077#1085#1080#1077
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object SaveDialog1: TSaveDialog
    Filter = 'TextFile|*.txt|File|*.*'
    Left = 464
    Top = 8
  end
end
