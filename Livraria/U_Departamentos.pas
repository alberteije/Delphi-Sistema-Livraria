unit U_Departamentos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, Db, Grids, DBGrids, DBTables,
  DBIProcs, Menus, UBase;

type
  TF_Departamentos = class(TFBase)
    PanTitulo: TPanel;
    PanGrid: TPanel;
    DBGrid1: TDBGrid;
    PanProcura: TPanel;
    BitBtn15: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn10: TBitBtn;
    procedure incluir(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure alterar(Sender: TObject);
    procedure Retorna(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure gridalt;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  F_Departamentos: TF_Departamentos;
  conf,Procure:integer;

implementation

uses U_Dados;

{$R *.DFM}

procedure TF_Departamentos.incluir(Sender: TObject);
var
   codigo:string;
begin
   F_Dados.CDS_Departamento.Append;
   PanTitulo.Caption:='Cadastro de Departamentos - Inserindo...';
   gridalt;
end;

procedure TF_Departamentos.alterar(Sender: TObject);
begin
   F_Dados.CDS_Departamento.Edit;
   PanTitulo.Caption:='Cadastro de Departamentos - Alterando...';
   gridalt;
end;

procedure TF_Departamentos.gridalt;
begin
   DBGrid1.ReadOnly := False;
   DBGrid1.SetFocus;
   DBGrid1.SelectedIndex:=1;
end;

procedure TF_Departamentos.Excluir(Sender: TObject);
var
   opc:Integer;
begin
     opc:=Application.MessageBox('Confirma Exclusão?','Exclusão de Registros',Mb_YesNo + Mb_IconQuestion);
     If opc=IdYes then
     begin
        F_Dados.CDS_Departamento.Delete;
        F_Dados.CDS_Departamento.ApplyUpdates(0);
     end;
end;

procedure TF_Departamentos.Retorna(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TF_Departamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_Departamentos.FormCreate(Sender: TObject);
begin
   F_Dados.CDS_Departamento.Close;
   F_Dados.CDS_Departamento.Open;
end;

procedure TF_Departamentos.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   If Key = Vk_Return then
      DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Departamentos.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
   KEY := UPCASE(KEY);
   If Key = #27 then
      DBGrid1.ReadOnly := True;
end;

end.
