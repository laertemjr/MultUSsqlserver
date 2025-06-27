unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, System.IniFiles;

type
  TfrmLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EdtUser: TEdit;
    btnLogin: TButton;
    edtSenha: TEdit;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iniconf : TIniFile;
    inicat : string;
    function conectar():Boolean;
    procedure leituraINI();
  public
    { Public declarations }
    user:string;
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
   uSQLServerConf, uMainMenu, uDM, uGlobal;

{$R *.dfm}
// Copyright © 2025 Mancuso Software (laertemjr@outlook.com.br)


procedure TfrmLogin.FormCreate(Sender: TObject);
begin
   KeyPreview := True;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
   if dm.ADOConnection1.Connected then dm.ADOConnection1.Connected := False;

   leituraINI();

   while inicat = EmptyStr do
   begin
      ShowMessage('Selecione o nome do banco de dados na configuração.');
      frmSQLServerConf.ShowModal;
      if bAbortar then
      begin
         Application.Terminate;
         Abort;
      end
      else leituraINI();
   end;

   while not conectar() do;
   dm.TbUsers.Close;
   dm.TbUsers.SQL.Clear;
   dm.TbUsers.SQL.Add('SELECT * FROM TB_USERS');
   dm.TbUsers.Open;
   dm.TbUsers.Last;
   EdtUser.SetFocus;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      SelectNext(ActiveControl as TWinControl, True, True);
      Key := #0;
   end;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
   if dm.TbUsers.Locate('USER_NAME;USER_PASSWORD', VarArrayOf([EdtUser.Text, edtSenha.Text]),[]) then
   begin
      user := EdtUser.Text;
      dm.TbUsers.Close;
      //Self.WindowState := wsMinimized;
      Self.Visible := False;
      frmMainMenu.ShowModal;
      EdtUser.Text := EmptyStr;
      edtSenha.Text := EmptyStr;
      Self.Visible := True;
      //Self.WindowState := wsNormal;
   end
   else
   begin
      ShowMessage('Usuário e/ou Senha incorretos.');
      edtSenha.Text := EmptyStr;
      EdtUser.SetFocus;
      EdtUser.SelLength := 0;
   end;
end;

function TfrmLogin.conectar():Boolean;
begin
   if FileExists(ExtractFilePath(Application.ExeName) + 'config.ini') then
   begin
      leituraINI();
   end
   else
   begin
      ShowMessage('Arquivo config.ini não localizado.');
      frmSQLServerConf.ShowModal;
      leituraINI();
   end;

   try
      dm.ADOConnection1.Connected := True;
      Result := True;
   except
      ShowMessage('Não foi possível a conexão com o banco de dados.');
      if MsgPergunta('Revisar a configuração do banco de dados ?', True) then
      begin
         frmSQLServerConf.ShowModal;
         if bAbortar then
         begin
            Application.Terminate;
            Abort;
         end
         else Result := False;
      end
      else
      begin
         Application.Terminate;
         Abort;
      end;
   end;
end;

procedure TfrmLogin.leituraINI;
var pw, uid, ds : string;
begin
   iniconf := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
   pw := iniconf.ReadString('MSSQLServer', 'Password', '');
   uid := iniconf.ReadString('MSSQLServer', 'User ID', '');
   inicat := iniconf.ReadString('MSSQLServer', 'Initial Catalog', '');
   ds := iniconf.ReadString('MSSQLServer', 'Data Source', '');
   iniconf.Free;
   dm.ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Password=' + pw + ';Persist Security Info=True;User ID=' + uid +
               ';Initial Catalog=' + inicat + ';Data Source=' + ds;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if dm.ADOConnection1.Connected then
      dm.ADOConnection1.Connected := False;;
end;

end.
