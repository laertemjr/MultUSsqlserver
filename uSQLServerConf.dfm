object frmSQLServerConf: TfrmSQLServerConf
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o do Servidor MS-SQL Server'
  ClientHeight = 441
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  TextHeight = 15
  object Label4: TLabel
    Left = 19
    Top = 219
    Width = 161
    Height = 15
    Caption = 'Selecione o Banco de Dados :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 19
    Top = 83
    Width = 63
    Height = 15
    Caption = 'Username :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 19
    Top = 123
    Width = 58
    Height = 15
    Caption = 'Password :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 19
    Top = 19
    Width = 197
    Height = 15
    Caption = 'Nome do Servidor MS-SQL Server :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnSalvar: TButton
    Left = 11
    Top = 320
    Width = 75
    Height = 25
    Caption = '&Salvar'
    TabOrder = 5
    OnClick = btnSalvarClick
  end
  object btnCancelar: TButton
    Left = 97
    Top = 320
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    TabOrder = 6
    OnClick = btnCancelarClick
  end
  object edtUser: TEdit
    Left = 88
    Top = 80
    Width = 92
    Height = 23
    Hint = 'Default: SYSDBA'
    Alignment = taCenter
    MaxLength = 4
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object edtPassw: TEdit
    Left = 88
    Top = 120
    Width = 92
    Height = 23
    Hint = 'Default: masterkey'
    Alignment = taCenter
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 2
  end
  object btnDefault: TButton
    Left = 185
    Top = 320
    Width = 75
    Height = 25
    Caption = '&Default'
    TabOrder = 7
    OnClick = btnDefaultClick
  end
  object edtServerName: TEdit
    Left = 19
    Top = 40
    Width = 161
    Height = 23
    Hint = 'Default: 3050'
    Alignment = taCenter
    MaxLength = 4
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 19
    Top = 240
    Width = 161
    Height = 23
    Style = csDropDownList
    TabOrder = 4
  end
  object btnConectar: TButton
    Left = 19
    Top = 160
    Width = 75
    Height = 25
    Caption = '&Conectar'
    TabOrder = 3
    OnClick = btnConectarClick
  end
  object OpenDialog1: TOpenDialog
    Left = 32
    Top = 368
  end
end
