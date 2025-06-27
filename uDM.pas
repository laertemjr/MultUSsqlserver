unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.Win.ADODB, Data.DB;

type
  Tdm = class(TDataModule)
    ADOConnection1: TADOConnection;
    tbUsers: TADOQuery;
    ADOQuery1: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
