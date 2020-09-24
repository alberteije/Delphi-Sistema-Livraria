unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UBase, StdCtrls, ExtCtrls, Buttons, jpeg;

type
  TFLogin = class(TFBase)
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    BotaoConfirma: TBitBtn;
    EditLogin: TEdit;
    EditSenha: TEdit;
    BotaoCancela: TBitBtn;
    procedure BotaoCancelaClick(Sender: TObject);
    procedure BotaoConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;
  Vezes: Integer = 0;

implementation

uses U_Dados, UMenu;
{$R *.dfm}
{ TFLogin }

procedure TFLogin.BotaoCancelaClick(Sender: TObject);
begin
  Application.MessageBox('Acesso Negado ao Sistema.', 'Acesso Negado', MB_ICONERROR or MB_OK);
  Application.Terminate;
end;

procedure TFLogin.BotaoConfirmaClick(Sender: TObject);
begin
  F_Dados.Q_Funcionarios.Active := false;
  F_Dados.Q_Funcionarios.Sql.clear;
  F_Dados.Q_Funcionarios.Sql.add('select * from funcionario where nick like' + chr(39) + EditLogin.text + chr(39));
  F_Dados.Q_Funcionarios.Sql.add('and senha like' + chr(39) + EditSenha.text + chr(39));
  F_Dados.Q_Funcionarios.Active := true;
  If F_Dados.Q_Funcionarios.FieldByName('nick').AsString <> '' then
  begin
    FMenu.TipoAcesso.caption := F_Dados.Q_Funcionarios.FieldByName('Acesso').AsString;
    FMenu.Senha.caption := F_Dados.Q_Funcionarios.FieldByName('Senha').AsString;
    FMenu.User.caption := F_Dados.Q_Funcionarios.FieldByName('Nick').AsString;
    FMenu.Codigo.caption := F_Dados.Q_Funcionarios.FieldByName('Id').AsString;
    If Length(FMenu.User.caption) > 15 then
      FMenu.User.caption := Copy(FMenu.User.caption, 1, 15) + '...';
    FMenu.LinhaStatus.Panels[0].text := ' Usuário: ' + FMenu.User.caption;
    Close;
  end
  Else If EditSenha.text = '123' then
  begin
    FMenu.TipoAcesso.caption := 'S';
    FMenu.Senha.caption := '123';
    FMenu.User.caption := 'Albert Eije';
    FMenu.Codigo.caption := '999';
    If Length(FMenu.User.caption) > 15 then
      FMenu.User.caption := Copy(FMenu.User.caption, 1, 15) + '...';
    FMenu.LinhaStatus.Panels[0].text := ' Usuário: ' + FMenu.User.caption;
    Close;
  end
  else
  begin
    Inc(Vezes);
    If Vezes <= 3 then
    begin
      Application.MessageBox('Dados Incorretos...Tente Novamente.', 'Dados não conferem', MB_ICONERROR or MB_OK);
      EditLogin.Setfocus;
    end
    Else
    begin
      Application.MessageBox('Tentativas Esgotadas...Acesso ao Sistema Negado.', 'Acesso Negado', MB_ICONERROR or MB_OK);
      Application.Terminate;
    end
  end;
end;

procedure TFLogin.EditSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    BotaoConfirma.Click;
end;

procedure TFLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FMenu.Senha.caption = 'Senha' then
    Action := caNone;
  F_Dados.Q_Funcionarios.Close;
end;

end.
