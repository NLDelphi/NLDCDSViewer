object DataFrame: TDataFrame
  Left = 0
  Top = 0
  Width = 538
  Height = 334
  TabOrder = 0
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 538
    Height = 334
    ActivePage = TabData
    Align = alClient
    Style = tsFlatButtons
    TabIndex = 1
    TabOrder = 0
    object TabFields: TTabSheet
      Caption = 'Fields'
      object FieldGrid: TJvStringGrid
        Left = 0
        Top = 0
        Width = 530
        Height = 303
        Align = alClient
        ColCount = 1
        Ctl3D = False
        DefaultRowHeight = 18
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentCtl3D = False
        TabOrder = 0
        Alignment = taLeftJustify
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
        ColWidths = (
          206)
      end
    end
    object TabData: TTabSheet
      Caption = 'Data view'
      ImageIndex = 1
      object NLDDBGrid1: TNLDDBGrid
        Left = 0
        Top = 0
        Width = 530
        Height = 303
        Align = alClient
        DataSource = DataSource
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        AutoSort = True
        IncSearch.Active = True
        IncSearch.Interval = 2500
        MarkOrder = True
        SortOrder = soAsc
        SelectedColBold = True
      end
    end
    object TabFormView: TTabSheet
      Caption = 'Form view'
      ImageIndex = 2
      object ScrollBox: TScrollBox
        Left = 0
        Top = 0
        Width = 530
        Height = 303
        Align = alClient
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
      end
    end
  end
  object DataSource: TDataSource
    Left = 192
    Top = 1
  end
end
