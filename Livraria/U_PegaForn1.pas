unit U_PegaForn1;

interface

uses
  Forms, Controls, Classes, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Windows;

type
  TF_PegaForn1 = class(TForm)
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
  F_PegaForn1: TF_PegaForn1;

implementation

uses U_DadosNF, U_Dados;
{$R *.DFM}

procedure TF_PegaForn1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_PegaForn1.BitBtn1Click(Sender: TObject);
begin
  F_DadosNF.Edit3.Text := F_Dados.Q_FornecedorId.AsString;
  F_DadosNF.Edit4.Text := F_Dados.Q_FornecedorRazao.AsString;
  F_DadosNF.datainicio.SetFocus;
  Close;
end;

procedure TF_PegaForn1.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TF_PegaForn1.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    SpeedButton3Click(Sender);
  if Key = vk_return then
    DBGrid1.SetFocus;
end;

procedure TF_PegaForn1.SpeedButton3Click(Sender: TObject);
begin
  F_Dados.Q_Fornecedor.Active := false;
  F_Dados.Q_Fornecedor.Sql.clear;
  F_Dados.Q_Fornecedor.Sql.add('select * from fornecedor ');
  F_Dados.Q_Fornecedor.Sql.add('where razao like' + chr(39) + '%' + EditProcura.Text + '%' + chr(39));
  F_Dados.Q_Fornecedor.Active := true;
  F_Dados.CDS_Fornecedor.Close;
  F_Dados.CDS_Fornecedor.Open;
end;

procedure TF_PegaForn1.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
    BitBtn1Click(Sender);
  if Key = vk_tab then
    EditProcura.SetFocus;
end;

end.
