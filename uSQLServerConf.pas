unit uSQLServerConf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, Vcl.StdCtrls;

type
  TfrmSQLServerConf = class(TForm)
    Label4: TLabel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    OpenDialog1: TOpenDialog;
    edtUser: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtPassw: TEdit;
    btnDefault: TButton;
    Label1: TLabel;
    edtServerName: TEdit;
    ComboBox1: TComboBox;
    btnConectar: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iniconf : TIniFile;
    bpodeSalvar:Boolean;
    procedure leituraINI();
  public
    { Public declarations }

  end;

var
  frmSQLServerConf: TfrmSQLServerConf;

implementation

uses
   uGlobal, uDM;

{$R *.dfm}


procedure TfrmSQLServerConf.FormShow(Sender: TObject);
begin
   bAbortar := False;
   bpodeSalvar := False;
   edtServerName.Clear;
   edtUser.Clear;
   edtPassw.Clear;
   ComboBox1.Clear;

   if FileExists(ExtractFilePath(Application.ExeName) + 'config.ini') then leituraINI()
   else btnConectar.SetFocus;
end;

procedure TfrmSQLServerConf.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if bpodeSalvar then
   begin
    CanClose := True;
    dm.ADOConnection1.Connected := False;
    Exit;
   end;

   if MsgPergunta('Fechar o formulário ? As alterações que não estiverem salvas serão descartadas.', False) then
   begin
      CanClose := True;
      bAbortar := True;
      dm.ADOConnection1.Connected := False;
   end
   else CanClose := False;
end;

procedure TfrmSQLServerConf.leituraINI;
begin
   ComboBox1.Clear;
   iniconf := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
   edtServerName.Text := iniconf.ReadString('MSSQLServer', 'Data Source', '');
   edtUser.Text       := iniconf.ReadString('MSSQLServer', 'User ID', '');
   edtPassw.Text      := iniconf.ReadString('MSSQLServer', 'Password', '');
   ComboBox1.Items.Add(iniconf.ReadString('MSSQLServer', 'Initial Catalog', ''));
   iniconf.Free;
   ComboBox1.ItemIndex := 0;
end;

procedure TfrmSQLServerConf.btnSalvarClick(Sender: TObject);
begin
   if MsgPergunta('Salvar as alterações ?') then
   begin
      iniconf := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
      iniconf.WriteString('MSSQLServer', 'Data Source', edtServerName.Text);
      iniconf.WriteString('MSSQLServer', 'User ID', edtUser.Text);
      iniconf.WriteString('MSSQLServer', 'Password', edtPassw.Text);
      iniconf.WriteString('MSSQLServer', 'Initial Catalog', ComboBox1.Text);
      iniconf.Free;
      bpodeSalvar := True;
      Self.Close;
   end
   else Exit;
end;

procedure TfrmSQLServerConf.btnCancelarClick(Sender: TObject);
begin
   if MsgPergunta('Descartar as alterações ?', False) then leituraINI()
   else Exit;
end;

procedure TfrmSQLServerConf.btnConectarClick(Sender: TObject);
var strSQL:string;
begin
   strSQL := 'Provider=SQLOLEDB.1;Password=' + edtPassw.Text + ';Persist Security Info=True;User ID=' + edtUser.Text +
               ';Initial Catalog=;Data Source=' + GetComputerNameFunc;

   dm.ADOConnection1.ConnectionString := strSQL;
   try
      dm.ADOConnection1.Connected := True;
      ShowMessage('Selecione o banco de dados.');
      dm.ADOQuery1.SQL.Text := 'SELECT name FROM sys.databases WHERE name NOT IN (' + QuotedStr('master') + ', ' +
                             QuotedStr('model') + ', ' + QuotedStr('msdb') + ', '+ QuotedStr('tempdb') + ') ORDER BY name';
      dm.ADOQuery1.Open;
      dm.ADOQuery1.First;
      ComboBox1.Items.Clear;
      while not dm.ADOQuery1.EOF do
      begin
         ComboBox1.Items.Add(dm.ADOQuery1.FieldByName('name').AsString);
         dm.ADOQuery1.Next;
      end;
      dm.ADOQuery1.Close;
   except
      ShowMessage('Não foi possível conectar o banco de dados.');
   end;
end;

procedure TfrmSQLServerConf.btnDefaultClick(Sender: TObject);
begin
   edtServerName.Text := GetComputerNameFunc;
   edtUser.Text       := 'sa';
   edtPassw.Text      := EmptyStr;
end;

end.
