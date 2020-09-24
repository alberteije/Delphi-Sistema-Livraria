unit U_PegaBanco2;

interface

uses

  Forms, Classes, Controls, Grids, DBGrids;

type
  TF_PegaBanco2 = class(TForm)
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
  F_PegaBanco2: TF_PegaBanco2;

implementation

uses U_Dados, U_Cheques;
{$R *.DFM}

procedure TF_PegaBanco2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_Dados.Q_Bancos.Close;
  Release;
end;

procedure TF_PegaBanco2.FormCreate(Sender: TObject);
begin
  F_Dados.Q_Bancos.Open;
  F_Dados.CDS_Bancos.Close;
  F_Dados.CDS_Bancos.Open;
end;

procedure TF_PegaBanco2.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    F_Cheques.Edit13.Text := F_Dados.CDS_BancosId.AsString;
    F_Cheques.Edit14.Text := F_Dados.CDS_BancosBanco.Value;
    F_Cheques.Edit10.Text := F_Dados.CDS_BancosBanco.Value;
    Close;
  end;
end;

procedure TF_PegaBanco2.DBGrid1DblClick(Sender: TObject);
begin
  F_Cheques.Edit13.Text := F_Dados.CDS_BancosId.AsString;
  F_Cheques.Edit14.Text := F_Dados.CDS_BancosBanco.Value;
  F_Cheques.Edit10.Text := F_Dados.CDS_BancosBanco.Value;
  Close;
end;

end.
