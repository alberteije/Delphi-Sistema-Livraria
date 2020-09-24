unit U_PegaConta;

interface

uses

  Forms, Classes, Controls, Grids, DBGrids;

type
  TF_PegaConta = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PegaConta: TF_PegaConta;

implementation

uses U_Dados, U_Cheques;
{$R *.DFM}

procedure TF_PegaConta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_Dados.Q_Contas.Close;
  Release;
end;

procedure TF_PegaConta.FormCreate(Sender: TObject);
begin
  F_Dados.Q_Contas.Open;
end;

procedure TF_PegaConta.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    F_Cheques.Edit3.Text := F_Dados.Q_ContasCodigo.AsString;
    F_Cheques.Edit4.Text := F_Dados.Q_ContasConta.Value;
    Close;
  end;
end;

procedure TF_PegaConta.DBGrid1DblClick(Sender: TObject);
begin
  F_Cheques.Edit3.Text := F_Dados.Q_ContasCodigo.AsString;
  F_Cheques.Edit4.Text := F_Dados.Q_ContasConta.Value;
  Close;
end;

end.
