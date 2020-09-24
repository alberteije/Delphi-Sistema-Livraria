unit U_PegaBanco;

interface

uses

  Forms, Classes, Controls, Grids, DBGrids;

type
  TF_PegaBanco = class(TForm)
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
  F_PegaBanco: TF_PegaBanco;

implementation

uses U_Dados, U_Cheques;
{$R *.DFM}

procedure TF_PegaBanco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_Dados.Q_Bancos.Close;
  Release;
end;

procedure TF_PegaBanco.FormCreate(Sender: TObject);
begin
  F_Dados.Q_Bancos.Open;
  F_Dados.CDS_Bancos.Close;
  F_Dados.CDS_Bancos.Open;
end;

procedure TF_PegaBanco.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    F_Cheques.Edit5.Text := F_Dados.CDS_BancosId.AsString;
    F_Cheques.Edit6.Text := F_Dados.CDS_BancosBanco.Value;
    Close;
  end;
end;

procedure TF_PegaBanco.DBGrid1DblClick(Sender: TObject);
begin
  F_Cheques.Edit5.Text := F_Dados.CDS_BancosId.AsString;
  F_Cheques.Edit6.Text := F_Dados.CDS_BancosBanco.Value;
  Close;
end;

end.
