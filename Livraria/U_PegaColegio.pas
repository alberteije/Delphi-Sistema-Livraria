unit U_PegaColegio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Db, DBTables, biblioteca;

type
  TF_PegaColegio = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label9: TLabel;
    SpeedButton3: TSpeedButton;
    EditProcura: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    opc: integer;
    { Public declarations }
  end;

var
  F_PegaColegio: TF_PegaColegio;

implementation

uses U_Orcamento, U_Dados;
{$R *.DFM}

procedure TF_PegaColegio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_PegaColegio.BitBtn1Click(Sender: TObject);
begin
  if opc = 1 then begin
    F_Orcamento.Edit1.Text := F_Dados.cds_ParticularId.AsString;
    F_Orcamento.Edit2.Text := F_Dados.cds_ParticularNome.AsString;
    F_Orcamento.label10.Caption := F_Dados.cds_ParticularEndereco.AsString;
    F_Orcamento.Label11.Caption := F_Dados.cds_ParticularCidade.AsString;
    F_Orcamento.datainicio.SetFocus;
  end;
  Close;
end;

procedure TF_PegaColegio.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TF_PegaColegio.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    SpeedButton3Click(Sender);
  if Key = 13 then
    DBGrid1.SetFocus;
end;

procedure TF_PegaColegio.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    BitBtn1Click(Sender);
  if Key = 9 then
    EditProcura.SetFocus;
end;

procedure TF_PegaColegio.SpeedButton3Click(Sender: TObject);
begin
  MyConsulta(F_Dados.Q_Particular, 'select * from escola where nome like' + chr(39) + '%' + EditProcura.Text + '%' + chr(39));
  F_Dados.cds_Particular.Close;
  F_Dados.cds_Particular.open;
end;

end.
