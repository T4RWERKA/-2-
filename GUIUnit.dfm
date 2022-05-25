object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1063#1080#1089#1083#1077#1085#1085#1086#1077' '#1080#1085#1090#1077#1075#1088#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 452
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 753
    Height = 450
    Align = alTop
    TabOrder = 0
    object lblMethod: TLabel
      Left = 24
      Top = 29
      Width = 119
      Height = 13
      Caption = #1052#1077#1090#1086#1076' '#1080#1085#1090#1077#1075#1088#1080#1088#1086#1074#1072#1085#1080#1103
    end
    object lblFunction: TLabel
      Left = 521
      Top = 29
      Width = 44
      Height = 13
      Caption = #1060#1091#1085#1082#1094#1080#1103
    end
    object lblLowLimit: TLabel
      Left = 22
      Top = 99
      Width = 83
      Height = 13
      Caption = #1053#1080#1078#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072
    end
    object lblUpperLimit: TLabel
      Left = 184
      Top = 99
      Width = 86
      Height = 13
      Caption = #1042#1077#1088#1093#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072
    end
    object lblAccuracy: TLabel
      Left = 521
      Top = 99
      Width = 47
      Height = 13
      Caption = #1058#1086#1095#1085#1086#1089#1090#1100
    end
    object lblSign: TLabel
      Left = 521
      Top = 118
      Width = 116
      Height = 13
      Caption = #1047#1085#1072#1082#1086#1074' '#1087#1086#1089#1083#1077' '#1079#1072#1087#1103#1090#1086#1081':'
    end
    object lblNum: TLabel
      Left = 643
      Top = 118
      Width = 6
      Height = 13
      Caption = '0'
    end
    object cmbbxMethods: TComboBox
      Left = 22
      Top = 48
      Width = 217
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbbxMethodsChange
      Items.Strings = (
        #1052#1077#1090#1086#1076' '#1083#1077#1074#1099#1093' '#1087#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082#1086#1074
        #1052#1077#1090#1086#1076' '#1094#1077#1085#1090#1088#1072#1083#1100#1085#1099#1093' '#1087#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082#1086#1074
        #1052#1077#1090#1086#1076' '#1087#1088#1072#1074#1099#1093' '#1087#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082#1086#1074
        #1052#1077#1090#1086#1076' '#1090#1088#1072#1087#1077#1094#1080#1081
        #1052#1077#1090#1086#1076' '#1057#1080#1084#1087#1089#1086#1085#1072' ')
    end
    object btnCalc: TButton
      Left = 336
      Top = 176
      Width = 75
      Height = 25
      Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
      TabOrder = 1
      OnClick = btnCalcClick
    end
    object edtUpperLimit: TEdit
      Left = 184
      Top = 118
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object edtLowLimit: TEdit
      Left = 22
      Top = 118
      Width = 121
      Height = 21
      TabOrder = 3
      Text = '0'
    end
    object edtFunc: TEdit
      Left = 521
      Top = 48
      Width = 152
      Height = 21
      TabOrder = 4
      Text = 'x^2'
    end
    object trckAccuracy: TTrackBar
      Left = 521
      Top = 137
      Width = 152
      Height = 45
      Max = 8
      PageSize = 1
      TabOrder = 5
      OnChange = trckAccuracyChange
    end
  end
  object Button1: TButton
    Left = 336
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ActionList1: TActionList
    Left = 704
    Top = 408
    object Action1: TAction
      Caption = 'Action1'
    end
  end
end
