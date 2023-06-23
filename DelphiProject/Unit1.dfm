object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Demo'
  ClientHeight = 99
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 53
    Height = 13
    Caption = 'ASR Result'
  end
  object EditWavPath: TEdit
    Left = 24
    Top = 43
    Width = 297
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object BtnBrowse: TButton
    Left = 327
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = BtnBrowseClick
  end
end
