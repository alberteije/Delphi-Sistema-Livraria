unit U_PegaProd1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Db, DBTables,
  biblioteca, JvExControls, JvgLabel;

type
  TF_PegaProd1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBGrid1: TDBGrid;
    Label9: TLabel;
    SpeedButton3: TSpeedButton;
    EditProcura: TEdit;
    Panel3: TJvgLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditProcuraExit(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PegaProd1: TF_PegaProd1;

implementation

uses U_Dados, U_Orcamento;
{$R *.DFM}

procedure TF_PegaProd1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_PegaProd1.BitBtn1Click(Sender: TObject);
begin
  F_Dados.cds_DSoma.Append;
  F_Dados.cds_DSomaCodigo.AsString := F_Dados.cds_ProcuraProdCodigo.AsString;
  Close;
end;

procedure TF_PegaProd1.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TF_PegaProd1.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    SpeedButton3Click(Sender);
  if Key = 113 then begin
    Panel3.Visible := True;
    Panel3.Repaint;
    MyConsulta(F_Dados.Q_ProcuraProd, 'select * from produto where descricao like' + chr(39) + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
    F_Dados.cds_ProcuraProd.Close;
    F_Dados.cds_ProcuraProd.open;
    Panel3.Visible := False;
    Panel3.Repaint;
  end;
  if Key = 115 then begin
    Panel3.Visible := True;
    Panel3.Repaint;
    MyConsulta(F_Dados.Q_ProcuraProd, 'select * from produto where autor_marca like' + chr(39) + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
    F_Dados.cds_ProcuraProd.Close;
    F_Dados.cds_ProcuraProd.open;
    Panel3.Visible := False;
    Panel3.Repaint;
  end;
  if Key = 13 then
    DBGrid1.SetFocus;
end;

procedure TF_PegaProd1.EditProcuraExit(Sender: TObject);
begin
  DBGrid1.SetFocus;
end;

procedure TF_PegaProd1.SpeedButton3Click(Sender: TObject);
begin
  Panel3.Visible := True;
  Panel3.Repaint;
  MyConsulta(F_Dados.Q_ProcuraProd, 'select * from produto where descricao like' + chr(39) + '%' + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
  F_Dados.cds_ProcuraProd.Close;
  F_Dados.cds_ProcuraProd.open;
  Panel3.Visible := False;
  Panel3.Repaint;
end;

procedure TF_PegaProd1.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    EditProcura.SetFocus;
  if Key = 13 then
    BitBtn1Click(Sender);
end;

end.
