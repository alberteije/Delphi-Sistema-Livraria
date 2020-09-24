unit U_NivelAcesso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList, Grids, DBGrids, Biblioteca,
  Menus;

type
  TF_NivelAcesso = class(TForm)
    ImageList1: TImageList;
    Edit2: TEdit;
    Panel1: TPanel;
    TreeView1: TTreeView;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid2: TDBGrid;
    ImageList: TImageList;
    PopupMenu1: TPopupMenu;
    Retiraacessoaomdulo1: TMenuItem;
    procedure RetiraAcesso;
    procedure modulos;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Retiraacessoaomdulo1Click(Sender: TObject);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_NivelAcesso: TF_NivelAcesso;

implementation

uses U_Dados, UMenu;
{$R *.DFM}

procedure TF_NivelAcesso.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  TreeView1Click(Sender);
end;

procedure TF_NivelAcesso.TreeView1Click(Sender: TObject);
Var
  Vb: integer;
  Lev1: integer;
begin
  If TreeView1.Selected <> Nil then begin
    Lev1 := TreeView1.Selected.Level;
    Edit2.text := TreeView1.Selected.text;
    For Vb := TreeView1.Selected.AbsoluteIndex downto 0 do begin
      If TreeView1.Items[Vb].Level < Lev1 then begin
        Edit2.text := TreeView1.Items[Vb].text + Edit2.text; ;
        Lev1 := TreeView1.Items[Vb].Level;
      end;
    end;
  end;
end;

procedure TF_NivelAcesso.BitBtn2Click(Sender: TObject);
begin
  F_Dados.Q_Rap.Active := false;
  F_Dados.Q_Rap.Sql.clear;
  F_Dados.Q_Rap.Sql.add('select * from nivel_acesso where modulo=' + chr(39) + Edit2.text + chr(39));
  F_Dados.Q_Rap.Sql.add('and nick=' + chr(39) + F_Dados.CDS_FuncionariosNick.AsString + chr(39));
  F_Dados.Q_Rap.Active := true;
  If F_Dados.Q_Rap.FieldByName('Modulo').AsString <> '' then begin
    Application.MessageBox('O usuário já tem acesso ao módulo selecionado', 'Sistema de Segurança', mb_Ok + mb_IconInformation);
  end
  else begin
    F_Dados.CDS_Nivel.Append;
    F_Dados.CDS_Nivel.FieldByName('Modulo').AsString := Edit2.text;
    F_Dados.CDS_Nivel.FieldByName('Nick').AsString := F_Dados.CDS_FuncionariosNick.AsString;
    F_Dados.CDS_Nivel.Post;
    F_Dados.CDS_Nivel.ApplyUpdates(0);
  end;
  modulos;
end;

procedure TF_NivelAcesso.FormCreate(Sender: TObject);
begin
  MyConsulta(F_Dados.Q_Funcionarios, 'select * from funcionario order by nome');
  F_Dados.CDS_Funcionarios.Close;
  F_Dados.CDS_Funcionarios.Open;
  modulos;
end;

procedure TF_NivelAcesso.modulos;
begin
  F_Dados.Q_Nivel.Active := false;
  F_Dados.Q_Nivel.Sql.clear;
  F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where nick=' + chr(39) + F_Dados.CDS_FuncionariosNick.AsString + chr(39));
  F_Dados.Q_Nivel.Active := true;
  F_Dados.CDS_Nivel.Close;
  F_Dados.CDS_Nivel.Open;
end;

procedure TF_NivelAcesso.Retiraacessoaomdulo1Click(Sender: TObject);
begin
  RetiraAcesso;
end;

procedure TF_NivelAcesso.DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    RetiraAcesso;
  end;
  if Key = VK_RETURN then
    DBGrid1.SetFocus;
end;

procedure TF_NivelAcesso.RetiraAcesso;
begin
  if Application.MessageBox('Deseja excluir o acesso selecionado?', 'Sistema de Segurança', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if F_Dados.CDS_Nivelmodulo.AsString <> '' then
    begin
      F_Dados.CDS_Nivel.Delete;
      F_Dados.CDS_Nivel.ApplyUpdates(0);
      modulos;
    end;
  end;
end;

procedure TF_NivelAcesso.DBGrid1CellClick(Column: TColumn);
begin
  modulos;
end;

procedure TF_NivelAcesso.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  modulos;
  if Key = VK_RETURN then
    DBGrid2.SetFocus;
end;

procedure TF_NivelAcesso.DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  modulos;
end;

procedure TF_NivelAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_NivelAcesso.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

end.
