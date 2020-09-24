unit U_PegaForn;

interface

uses
  Forms, Controls, Classes, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls;

type
  TF_PegaForn = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label9: TLabel;
    EditProcura: TEdit;
    SpeedButton3: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PegaForn: TF_PegaForn;

implementation

uses U_Dados, U_Cheques;
{$R *.DFM}

procedure TF_PegaForn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_PegaForn.BitBtn1Click(Sender: TObject);
begin
  F_Dados.cds_APagar.Edit;
  F_Dados.CDS_APagarid_fornecedor.AsString := StringOfChar('0', 4 - Length(F_Dados.CDS_Fornecedorid.AsString)) + F_Dados.CDS_Fornecedorid.AsString;
  F_Dados.cds_APagarFornecedor.AsString := F_Dados.cds_FornecedorRazao.Value;
  F_Cheques.Edit1.Text := F_Dados.cds_FornecedorRazao.Value;
  Close;
end;

procedure TF_PegaForn.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TF_PegaForn.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    SpeedButton3Click(Sender);
  if Key = 13 then
    DBGrid1.SetFocus;
end;

procedure TF_PegaForn.SpeedButton3Click(Sender: TObject);
begin
  F_Dados.Q_Fornecedor.Active := false;
  F_Dados.Q_Fornecedor.Sql.clear;
  F_Dados.Q_Fornecedor.Sql.add('select * from fornecedor ');
  F_Dados.Q_Fornecedor.Sql.add('where razao like' + chr(39) + '%' + EditProcura.Text + '%' + chr(39));
  F_Dados.Q_Fornecedor.Active := true;
  F_Dados.CDS_Fornecedor.Close;
  F_Dados.CDS_Fornecedor.Open;
end;

procedure TF_PegaForn.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    BitBtn1Click(Sender);
  if Key = 9 then
    EditProcura.SetFocus;
end;

end.
