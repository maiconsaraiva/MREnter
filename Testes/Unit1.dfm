object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 477
  ClientWidth = 1027
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 312
    Top = 23
    Width = 75
    Height = 22
    OnClick = SpeedButton1Click
  end
  object Edit1: TEdit
    Left = 56
    Top = 112
    Width = 168
    Height = 21
    Hint = 'Teste de Hint'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = 'Edit1'
  end
  object JvCalcEdit1: TJvCalcEdit
    Left = 56
    Top = 139
    Width = 168
    Height = 21
    TabOrder = 1
    DecimalPlacesAlwaysShown = False
  end
  object wwDBEdit1: TwwDBEdit
    Left = 56
    Top = 166
    Width = 168
    Height = 21
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cxTextEdit1: TcxTextEdit
    Left = 272
    Top = 112
    TabOrder = 3
    Text = 'cxTextEdit1'
    OnKeyDown = cxTextEdit1KeyDown
    Width = 168
  end
  object cxButtonEdit1: TcxButtonEdit
    Left = 272
    Top = 139
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 4
    Text = 'cxButtonEdit1'
    Width = 168
  end
  object wwDBComboBox1: TwwDBComboBox
    Left = 56
    Top = 254
    Width = 168
    Height = 21
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 5
    UnboundDataType = wwDefault
  end
  object MREnter1: TMREnter
    AutoSkip = False
    EnterEnabled = True
    ClassList.Strings = (
      'TMaskEdit'
      'TEdit'
      'TDBEdit'
      'TDBCheckBox'
      'TTabbedNoteBook'
      'TDBCheckDocEdit'
      'TMRDBExtEdit'
      'TDBDateEdit'
      'TwwDBEdit'
      'TwwDBComboBox'
      'TwwDBSpinEdit'
      'TwwDBComboDlg'
      'TwwDBLookupCombo'
      'TwwDBLookupComboDlg'
      'TwwIncrementalSearch'
      'TwwDBRitchEdit'
      'TwwKeyCombo'
      'TRxDBLookupList'
      'TRxDBGrid'
      'TRxDBLookupCombo'
      'TRxDBCalcEdit'
      'TRxDBComboBox'
      'TRxDBComboEdit'
      'TDBDateEdit'
      '====================='
      'TRxCalcEdit'
      'TCurrencyEdit'
      'TRxLookupEdit'
      '====================='
      'TJvEdit'
      'TJvCalcEdit'
      'TJvValidateEdit'
      'TJvMaskEdit'
      'TJvComboEdit'
      'TJvFileNameEdit'
      'TJvDirectoryEdit'
      'TJvSpinEdit'
      'TJvDatePickerEdit'
      'TJvDateEdit'
      'TJvDBEdit'
      'TJvDBCalcEdit'
      'TJvDBDatePickerEdit'
      'TJvDBSpinEdit'
      'TJvDBLookupEdit'
      'TJvDBComboEdit'
      'TJvDBDateEdit'
      'TJvDBMaskEdit'
      'TJvDBLookupComboEdit'
      'TJvDBSearchEdit'
      'TJvDBFindEdit'
      '====================='
      'TRzDBEdit'
      'TRzDBButtonEdit'
      'TRzDBDateTimeEdit'
      'TRzDBNumericEdit'
      'TRzDBSpinEdit'
      'TRzDBSpandEdit'
      'TRzDBSpinner'
      'TRzTBTrackBar'
      'TRzDBDateTimePicker'
      'TRzDBComboBox'
      'TRzDBLookupComboBox'
      'TRzDBCheckBox'
      'TRzDBLookupDialog'
      'TRzDBRadioGroup'
      'TRzDBCheckBoxGroup')
    KeyBoardArrows = False
    FocusColor = clYellow
    FocusEnabled = True
    HintColor = clInfoBk
    HintEnabled = True
    Left = 80
    Top = 24
  end
end
