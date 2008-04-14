object FilterForm: TFilterForm
  Left = 200
  Top = 310
  Width = 454
  Height = 246
  Caption = 'Filter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 142
    Height = 219
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object FilterList: TListBox
      Left = 0
      Top = 0
      Width = 142
      Height = 219
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnClick = FilterListClick
    end
  end
  object Panel2: TPanel
    Left = 142
    Top = 0
    Width = 304
    Height = 219
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 78
      Width = 21
      Height = 13
      Caption = 'Veld'
    end
    object Label2: TLabel
      Left = 16
      Top = 126
      Width = 19
      Height = 13
      Caption = 'Van'
    end
    object Label3: TLabel
      Left = 160
      Top = 126
      Width = 51
      Height = 13
      Caption = 'Tot en met'
    end
    object Label4: TLabel
      Left = 16
      Top = 8
      Width = 28
      Height = 13
      Caption = 'Naam'
    end
    object BeginValue: TEdit
      Left = 16
      Top = 143
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object EndValue: TEdit
      Left = 160
      Top = 143
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object FieldCombo: TComboBox
      Left = 16
      Top = 95
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
    end
    object NameEdit: TEdit
      Left = 16
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object ActiveCheck: TCheckBox
      Left = 15
      Top = 55
      Width = 58
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Actief'
      TabOrder = 1
    end
    object SluitenKnop: TButton
      Left = 208
      Top = 180
      Width = 75
      Height = 25
      Action = SluitenAction
      TabOrder = 7
    end
    object OkKnop: TButton
      Left = 128
      Top = 180
      Width = 75
      Height = 25
      Action = OpslaanAction
      Default = True
      TabOrder = 6
    end
    object NieuwButton: TButton
      Left = 16
      Top = 180
      Width = 33
      Height = 25
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = NieuwButtonClick
    end
    object DelButton: TButton
      Left = 56
      Top = 180
      Width = 33
      Height = 25
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpFixed
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = DelButtonClick
    end
  end
  object ActionList1: TActionList
    Left = 336
    Top = 8
    object OpslaanAction: TAction
      Caption = 'Opslaan'
      ShortCut = 16467
      OnExecute = OpslaanActionExecute
    end
    object SluitenAction: TAction
      Caption = 'Sluiten'
      ShortCut = 27
      OnExecute = SluitenActionExecute
    end
  end
end
