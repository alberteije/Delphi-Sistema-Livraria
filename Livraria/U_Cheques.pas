unit U_Cheques;

interface

uses

  Windows, SysUtils, Classes, Graphics, Forms, Db, ValorPor, Controls, StdCtrls,
  Buttons, EditNum, Mask, ExtCtrls, Menus, MenBtn, Grids, DBGrids, Biblioteca,
  RDprint, Math;

type
  TF_Cheques = class(TForm)
    ScrollBox1: TScrollBox;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    opcoes2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Label4: TLabel;
    EditProcura: TEdit;
    MaskEdit4: TMaskEdit;
    MaskEdit1: TMaskEdit;
    BitBtn14: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn10: TBitBtn;
    Panel1: TPanel;
    data: TMaskEdit;
    Label1: TLabel;
    Edit7: TEdit;
    EditNum1: TEditNum;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    MaskEdit3: TMaskEdit;
    MaskEdit5: TMaskEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    EditNum4: TEditNum;
    Label14: TLabel;
    EditNum5: TEditNum;
    Label15: TLabel;
    EditNum6: TEditNum;
    Label16: TLabel;
    EditNum7: TEditNum;
    Label17: TLabel;
    EditNum8: TEditNum;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Extenso: TValorPorExtenso;
    Label19: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label11: TLabel;
    Edit2: TEdit;
    Label12: TLabel;
    MaskEdit2: TMaskEdit;
    Label18: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label20: TLabel;
    MaskEdit6: TMaskEdit;
    BitBtn1: TMenuButton;
    Panel2: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    EditNum12: TEditNum;
    GroupBox3: TGroupBox;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Edit12: TEdit;
    MaskEdit10: TMaskEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    MaskEdit11: TMaskEdit;
    LimpaosMarcador1: TMenuItem;
    MenuButton1: TBitBtn;
    Label21: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Edit10: TEdit;
    RDprint: TRDprint;
    procedure ID1;
    procedure ID2;
    procedure ID3;
    procedure ID4;
    procedure ID5;
    procedure ID6;
    procedure ID12;
    procedure ID13;
    procedure aguarde;
    procedure pronto;
    procedure BitBtn10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn14Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EditNum4Exit(Sender: TObject);
    procedure EditNum6Exit(Sender: TObject);
    procedure EditNum8Enter(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3DblClick(Sender: TObject);
    procedure Edit5DblClick(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure MaskEdit6Enter(Sender: TObject);
    procedure MaskEdit11Enter(Sender: TObject);
    procedure Edit13DblClick(Sender: TObject);
    procedure Edit13Exit(Sender: TObject);
    procedure MenuButton1Click(Sender: TObject);
    procedure LimpaosMarcador1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1DblClick(Sender: TObject);
    procedure RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure NovaPagina;
  private
    { Private declarations }
  public
    Inclui: Integer;
    { Public declarations }
  end;

var
  F_Cheques: TF_Cheques;
  linha, procure: Integer;
  relatorio, data1, data2: string;

implementation

uses U_Dados, U_PegaConta, U_PegaBanco, U_PegaBanco2,
  U_PegaForn, U_PegaForn1;
{$R *.DFM}

// Exercício: analise bem o código dessa página para que seja melhorado

procedure TF_Cheques.ID1;
Begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  F_Cheques.DBGrid1.Columns.Items[1].Color := clInfoBk;
  F_Dados.Q_APagar.Active := False;
  F_Dados.Q_APagar.SQL.clear;
  F_Dados.Q_APagar.SQL.add('select * from pagar');
  F_Dados.Q_APagar.SQL.add(' where vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
  F_Dados.Q_APagar.SQL.add(' order by numero_nf,id_fornecedor,vencimento,pagamento');
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
end;

procedure TF_Cheques.ID2;
Begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  F_Cheques.DBGrid1.Columns.Items[2].Color := clInfoBk;
  F_Dados.Q_APagar.Active := False;
  F_Dados.Q_APagar.SQL.clear;
  F_Dados.Q_APagar.SQL.add('select * from pagar');
  F_Dados.Q_APagar.SQL.add(' where vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
  F_Dados.Q_APagar.SQL.add(' order by id_fornecedor,vencimento,pagamento');
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
end;

procedure TF_Cheques.ID3;
Begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  F_Cheques.DBGrid1.Columns.Items[3].Color := clInfoBk;
  F_Dados.Q_APagar.Active := False;
  F_Dados.Q_APagar.SQL.clear;
  F_Dados.Q_APagar.SQL.add('select * from pagar');
  F_Dados.Q_APagar.SQL.add(' where vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
  F_Dados.Q_APagar.SQL.add(' order by conta,id_fornecedor,vencimento,pagamento');
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
end;

procedure TF_Cheques.ID4;
Begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  F_Cheques.DBGrid1.Columns.Items[4].Color := clInfoBk;
  F_Dados.Q_APagar.Active := False;
  F_Dados.Q_APagar.SQL.clear;
  F_Dados.Q_APagar.SQL.add('select * from pagar');
  F_Dados.Q_APagar.SQL.add(' where vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
  F_Dados.Q_APagar.SQL.add(' order by emissao,id_fornecedor,vencimento,pagamento');
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
end;

procedure TF_Cheques.ID5;
Begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  F_Cheques.DBGrid1.Columns.Items[5].Color := clInfoBk;
  F_Dados.Q_APagar.Active := False;
  F_Dados.Q_APagar.SQL.clear;
  F_Dados.Q_APagar.SQL.add('select * from pagar');
  F_Dados.Q_APagar.SQL.add(' where vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
  F_Dados.Q_APagar.SQL.add(' order by vencimento,id_fornecedor,pagamento');
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
end;

procedure TF_Cheques.ID6;
Begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  F_Cheques.DBGrid1.Columns.Items[6].Color := clInfoBk;
  F_Dados.Q_APagar.Active := False;
  F_Dados.Q_APagar.SQL.clear;
  F_Dados.Q_APagar.SQL.add('select * from pagar');
  F_Dados.Q_APagar.SQL.add(' where vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
  F_Dados.Q_APagar.SQL.add(' order by pagamento,id_fornecedor,vencimento');
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
end;

procedure TF_Cheques.ID12;
Begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  F_Cheques.DBGrid1.Columns.Items[12].Color := clInfoBk;
  F_Dados.Q_APagar.Active := False;
  F_Dados.Q_APagar.SQL.clear;
  F_Dados.Q_APagar.SQL.add('select * from pagar');
  F_Dados.Q_APagar.SQL.add(' where vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
  F_Dados.Q_APagar.SQL.add(' order by id_banco,id_fornecedor,vencimento,pagamento');
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
end;

procedure TF_Cheques.ID13;
Begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  F_Cheques.DBGrid1.Columns.Items[13].Color := clInfoBk;
  F_Dados.Q_APagar.Active := False;
  F_Dados.Q_APagar.SQL.clear;
  F_Dados.Q_APagar.SQL.add('select * from pagar');
  F_Dados.Q_APagar.SQL.add(' where vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
  F_Dados.Q_APagar.SQL.add(' order by cheque,id_fornecedor,vencimento,pagamento');
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
end;

Procedure TF_Cheques.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

Procedure TF_Cheques.pronto;
begin
  Panel3.Visible := False;
  Panel3.SendToBack;
  Panel3.Repaint;
end;

procedure TF_Cheques.BitBtn10Click(Sender: TObject);
begin
  Close;
end;

procedure TF_Cheques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If F_Dados.CDS_APagar.State in [dsEdit, dsInsert] then
  begin
    F_Dados.CDS_APagar.Post;
    F_Dados.CDS_APagar.ApplyUpdates(0);
  end;
  F_Dados.Q_APagar.Close;
  F_Dados.CDS_APagar.Close;
  Release;
end;

procedure TF_Cheques.BitBtn14Click(Sender: TObject);
var
  opc: Integer;
begin
  opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then
  begin
    F_Dados.CDS_APagar.Delete;
    F_Dados.CDS_APagar.ApplyUpdates(0);
  end;
end;

procedure TF_Cheques.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = Vk_Return then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Cheques.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := UPCASE(Key);
end;

procedure TF_Cheques.FormCreate(Sender: TObject);
begin
  MaskEdit4.text := datetostr(Date);
  MaskEdit1.text := datetostr(Date);
  F_Dados.Q_APagar.Open;
  F_Dados.CDS_APagar.Open;
  ID1;
  F_Cheques.DBGrid1.Columns.Items[1].Color := clInfoBk;
  procure := 1;
end;

procedure TF_Cheques.DBGrid1TitleClick(Column: TColumn);
var
  i: Integer;
begin
  If Column.ID = 1 then begin
    For i := 0 to F_Cheques.DBGrid1.Columns.Count - 1 do begin
      F_Cheques.DBGrid1.Columns.Items[i].Color := clWindow;
    end;
    ID1;
    procure := 1;
  end
  else If Column.ID = 2 then begin
    For i := 0 to F_Cheques.DBGrid1.Columns.Count - 1 do begin
      F_Cheques.DBGrid1.Columns.Items[i].Color := clWindow;
    end;
    ID2;
    procure := 2;
  end
  Else If Column.ID = 3 then begin
    For i := 0 to F_Cheques.DBGrid1.Columns.Count - 1 do begin
      F_Cheques.DBGrid1.Columns.Items[i].Color := clWindow;
    end;
    ID3;
    procure := 3;
  end
  Else If Column.ID = 4 then begin
    For i := 0 to F_Cheques.DBGrid1.Columns.Count - 1 do begin
      F_Cheques.DBGrid1.Columns.Items[i].Color := clWindow;
    end;
    ID4;
    procure := 4;
  end
  Else If Column.ID = 5 then begin
    For i := 0 to F_Cheques.DBGrid1.Columns.Count - 1 do begin
      F_Cheques.DBGrid1.Columns.Items[i].Color := clWindow;
    end;
    ID5;
    procure := 5;
  end
  Else If Column.ID = 6 then begin
    For i := 0 to F_Cheques.DBGrid1.Columns.Count - 1 do begin
      F_Cheques.DBGrid1.Columns.Items[i].Color := clWindow;
    end;
    ID6;
    procure := 6;
  end
  Else If Column.ID = 12 then begin
    For i := 0 to F_Cheques.DBGrid1.Columns.Count - 1 do begin
      F_Cheques.DBGrid1.Columns.Items[i].Color := clWindow;
    end;
    ID12;
    procure := 12;
  end
  Else If Column.ID = 13 then begin
    For i := 0 to F_Cheques.DBGrid1.Columns.Count - 1 do begin
      F_Cheques.DBGrid1.Columns.Items[i].Color := clWindow;
    end;
    ID13;
    procure := 13;
  end
end;

procedure TF_Cheques.SpeedButton1Click(Sender: TObject);
begin
  aguarde;
  If procure = 1 then
    ID1
  Else if procure = 2 then
    ID2
  Else if procure = 3 then
    ID3
  Else if procure = 4 then
    ID4
  Else if procure = 5 then
    ID5
  Else if procure = 6 then
    ID6
  Else if procure = 12 then
    ID12
  Else if procure = 13 then
    ID13;
  pronto;
end;

procedure TF_Cheques.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    SpeedButton2Click(Sender);
end;

procedure TF_Cheques.SpeedButton2Click(Sender: TObject);
begin
  data1 := MaskEdit4.text; // Copy(MaskEdit4.text,4,3)+Copy(MaskEdit4.text,1,3)+Copy(MaskEdit4.text,7,4);
  data2 := MaskEdit1.text; // Copy(MaskEdit1.text,4,3)+Copy(MaskEdit1.text,1,3)+Copy(MaskEdit1.text,7,4);
  //
  aguarde;
  //
  If procure = 1 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.SQL.clear;
    F_Dados.Q_APagar.SQL.add('select * from pagar where numero_nf like' + chr(39) + EditProcura.text + '%' + chr(39));
    F_Dados.Q_APagar.SQL.add('and vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
    F_Dados.Q_APagar.SQL.add('order by numero_nf,id_fornecedor,vencimento,pagamento');
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
  end
  Else If procure = 2 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.SQL.clear;
    F_Dados.Q_APagar.SQL.add('select * from pagar where id_fornecedor like' + chr(39) + EditProcura.text + '%' + chr(39));
    F_Dados.Q_APagar.SQL.add('and vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
    F_Dados.Q_APagar.SQL.add('order by id_fornecedor,vencimento,pagamento');
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
  end
  Else If procure = 3 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.SQL.clear;
    F_Dados.Q_APagar.SQL.add('select * from pagar where conta like' + chr(39) + EditProcura.text + '%' + chr(39));
    F_Dados.Q_APagar.SQL.add('and vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
    F_Dados.Q_APagar.SQL.add('order by conta,id_fornecedor,vencimento,pagamento');
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
  end
  Else If procure = 4 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.SQL.clear;
    F_Dados.Q_APagar.SQL.add('select * from pagar where emissao like' + chr(39) + EditProcura.text + '%' + chr(39));
    F_Dados.Q_APagar.SQL.add('and vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
    F_Dados.Q_APagar.SQL.add('order by emissao,id_fornecedor,vencimento,pagamento');
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
  end
  Else If procure = 5 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.SQL.clear;
    F_Dados.Q_APagar.SQL.add('select * from pagar where vencimento like' + chr(39) + EditProcura.text + '%' + chr(39));
    F_Dados.Q_APagar.SQL.add('and vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
    F_Dados.Q_APagar.SQL.add('order by vencimento,id_fornecedor,pagamento');
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
  end
  Else If procure = 6 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.SQL.clear;
    F_Dados.Q_APagar.SQL.add('select * from pagar where pagamento like' + chr(39) + EditProcura.text + '%' + chr(39));
    F_Dados.Q_APagar.SQL.add('and vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
    F_Dados.Q_APagar.SQL.add('order by pagamento,id_fornecedor,vencimento');
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
  end
  Else If procure = 12 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.SQL.clear;
    F_Dados.Q_APagar.SQL.add('select * from pagar where id_banco like' + chr(39) + EditProcura.text + '%' + chr(39));
    F_Dados.Q_APagar.SQL.add('and vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
    F_Dados.Q_APagar.SQL.add('order by id_banco,id_fornecedor,vencimento,pagamento');
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
  end
  Else If procure = 13 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.SQL.clear;
    F_Dados.Q_APagar.SQL.add('select * from pagar where cheque like' + chr(39) + EditProcura.text + '%' + chr(39));
    F_Dados.Q_APagar.SQL.add('and vencimento between ' + chr(39) + DataToSql(data1) + chr(39) + ' and ' + chr(39) + DataToSql(data2) + chr(39));
    F_Dados.Q_APagar.SQL.add('order by cheque,id_fornecedor,vencimento,pagamento');
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
  end;
  //
  pronto;
end;

procedure TF_Cheques.BitBtn2Click(Sender: TObject);
var
  conta, igual: string;
  total, juro, multa, recebido, pagar: double;
begin
  relatorio := 'tesouraria';
  RDprint.MostrarProgresso := True;
  RDprint.TitulodoRelatorio := 'Tesouraria e Banco';
  RDprint.TamanhoQteColunas := 140;
  RDprint.TamanhoQteLinhas := 66;

  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 09;

  aguarde;

  total := 0;
  juro := 0;
  multa := 0;
  recebido := 0;
  pagar := 0;

  F_Dados.CDS_APagar.DisableControls;
  F_Dados.CDS_APagar.First;
  conta := F_Dados.CDS_APagarConta.AsString;
  while not F_Dados.CDS_APagar.eof do begin
    NovaPagina;

    RDprint.Imp(linha, 01, F_Dados.CDS_APagarnumero_nf.AsString);
    RDprint.Imp(linha, 21, Copy(F_Dados.CDS_APagarFornecedor.AsString, 1, 30));
    RDprint.Imp(linha, 52, F_Dados.CDS_APagarConta.AsString);
    RDprint.Imp(linha, 68, F_Dados.CDS_APagarEmissao.AsString);
    RDprint.Imp(linha, 79, F_Dados.CDS_APagarVencimento.AsString);
    RDprint.Imp(linha, 90, F_Dados.CDS_APagarpagamento.AsString);
    RDprint.ImpVal(linha, 101, '##,##0.00', F_Dados.CDS_APagartotal_nf.Value, []);
    RDprint.ImpVal(linha, 110, '##,##0.00', F_Dados.CDS_APagarJuro.Value, []);
    RDprint.ImpVal(linha, 119, '##,##0.00', F_Dados.CDS_APagarMulta.Value, []);
    RDprint.ImpVal(linha, 131, '##,##0.00', F_Dados.CDS_APagarvalor_pago.Value, []);

    total := ArredondaTruncaValor('A', total, 2) + ArredondaTruncaValor('A', F_Dados.CDS_APagartotal_nf.Value, 2);
    juro := ArredondaTruncaValor('A', juro, 2) + ArredondaTruncaValor('A', F_Dados.CDS_APagarJuro.Value, 2);
    multa := ArredondaTruncaValor('A', multa, 2) + ArredondaTruncaValor('A', F_Dados.CDS_APagarMulta.Value, 2);
    recebido := ArredondaTruncaValor('A', recebido, 2) + ArredondaTruncaValor('A', F_Dados.CDS_APagarvalor_pago.Value, 2);
    if F_Dados.CDS_APagarpagamento.AsString = '' then
      pagar := ArredondaTruncaValor('A', pagar, 2) + ArredondaTruncaValor('A', F_Dados.CDS_APagartotal_nf.Value, 2);
    F_Dados.CDS_APagar.Next;
    If F_Dados.CDS_APagarConta.AsString <> conta then
      igual := 'NAO';
    inc(linha)
  end;
  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 140));

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, 'TOTAIS EM (R$): ');
  RDprint.ImpVal(linha, 101, '##,##0.00', total, []);
  RDprint.ImpVal(linha, 109, '##,##0.00', juro, []);
  RDprint.ImpVal(linha, 119, '##,##0.00', multa, []);
  RDprint.ImpVal(linha, 131, '##,##0.00', recebido, []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, 'SALDO A PAGAR EM (R$): ');
  RDprint.ImpVal(linha, 131, '##,##0.00', pagar, []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 140));

  If igual <> 'NAO' then begin
    F_Dados.Q_Contas.Active := False;
    F_Dados.Q_Contas.SQL.clear;
    F_Dados.Q_Contas.SQL.add('Select * from centro_custo where codigo=' + chr(39) + F_Dados.CDS_APagarConta.AsString + chr(39));
    F_Dados.Q_Contas.Active := True;

    inc(linha);
    NovaPagina;
    RDprint.Imp(linha, 01, 'Conta....: ' + F_Dados.Q_ContasConta.Value);
    inc(linha);
    NovaPagina;
    RDprint.Imp(linha, 01, StringOfChar('=', 140));
  end;
  F_Dados.CDS_APagar.EnableControls;
  F_Dados.CDS_APagar.First;

  RDprint.Fechar;
  pronto;
end;

procedure TF_Cheques.EditNum4Exit(Sender: TObject);
begin
  EditNum5.text := FloatTostr(StrToFloat(EditNum1.text) * StrToFloat(EditNum4.text) / 100);
end;

procedure TF_Cheques.EditNum6Exit(Sender: TObject);
begin
  EditNum7.text := FloatTostr(StrToFloat(EditNum1.text) * StrToFloat(EditNum6.text) / 100);
end;

procedure TF_Cheques.EditNum8Enter(Sender: TObject);
begin
  EditNum8.text := FloatTostr(StrToFloat(EditNum1.text) + StrToFloat(EditNum5.text) + StrToFloat(EditNum7.text));
end;

procedure TF_Cheques.BitBtn4Click(Sender: TObject);
begin
  F_Dados.CDS_APagar.Edit;
  F_Dados.CDS_APagarnumero_nf.AsString := Edit7.text;
  F_Dados.CDS_APagarFornecedor.AsString := Edit1.text;
  F_Dados.CDS_APagarConta.AsString := Edit3.text;
  if MaskEdit3.text <> '  /  /    ' then
    F_Dados.CDS_APagarEmissao.AsString := MaskEdit3.text;
  if MaskEdit5.text <> '  /  /    ' then
    F_Dados.CDS_APagarVencimento.AsString := MaskEdit5.text;
  F_Dados.CDS_APagartotal_nf.AsString := EditNum1.text;
  F_Dados.CDS_APagarJuro.AsString := EditNum5.text;
  F_Dados.CDS_APagarMulta.AsString := EditNum7.text;
  F_Dados.CDS_APagarvalor_pago.AsString := EditNum8.text;
  if data.text <> '  /  /    ' then begin
    F_Dados.CDS_APagarpagamento.AsString := data.text;
    F_Dados.CDS_APagarPago.AsString := 'S';
  end;
  F_Dados.CDS_APagarBanco.AsString := Edit5.text;
  F_Dados.CDS_APagarDuplicata.AsString := Edit8.text;
  F_Dados.CDS_APagarNominal.AsString := Edit9.text;
  F_Dados.CDS_APagarCheque.AsString := Edit2.text;
  if MaskEdit2.text <> '  /  /    ' then
    F_Dados.CDS_APagardata_cheque.AsString := MaskEdit2.text;
  if MaskEdit6.text <> '  /  /    ' then
    F_Dados.CDS_APagarLancamento.AsString := MaskEdit6.text;
  F_Dados.CDS_APagar.Post;
  F_Dados.CDS_APagar.ApplyUpdates(0);
  Panel1.Visible := False;
end;

procedure TF_Cheques.BitBtn3Click(Sender: TObject);
begin
  Panel1.Visible := False;
end;

procedure TF_Cheques.DBGrid1DblClick(Sender: TObject);
var
  vlrcheque: double;
  vcheque: string;
begin
  If F_Dados.CDS_APagarXX.AsString <> '' then begin
    // calcula o valor do cheque de acordo com as despesas selecionadas
    F_Dados.CDS_APagar.DisableControls;
    F_Dados.CDS_APagar.First;
    vlrcheque := 0;
    While not F_Dados.CDS_APagar.eof do begin
      If F_Dados.CDS_APagarXX.AsString <> '' then begin
        vlrcheque := vlrcheque + F_Dados.CDS_APagarvalor_pago.Value;
        F_Dados.CDS_APagar.Next;
      end
      else begin
        F_Dados.CDS_APagar.Next;
        Continue;
      end;
    end;
    vcheque := FloatTostr(vlrcheque);
    F_Dados.CDS_APagar.EnableControls;
    F_Dados.CDS_APagar.First;
    EditNum12.text := vcheque;
    Panel2.Left := Floor((DBGrid1.Width - Panel2.Width) / 2);
    Panel2.Top := Floor((DBGrid1.Height - Panel2.Height) / 2);
    Panel2.Visible := True;
    Edit12.SetFocus;
  end
  else begin
    Edit7.text := F_Dados.CDS_APagarnumero_nf.AsString;
    Edit8.text := F_Dados.CDS_APagarDuplicata.AsString;
    if F_Dados.CDS_APagarNominal.AsString <> '' then
      Edit9.text := F_Dados.CDS_APagarNominal.AsString
    else
      Edit9.text := F_Dados.CDS_APagarFornecedor.AsString;
    Edit1.text := F_Dados.CDS_APagarFornecedor.AsString;
    Edit3.text := F_Dados.CDS_APagarConta.AsString;
    //
    F_Dados.Q_Contas.Active := False;
    F_Dados.Q_Contas.SQL.clear;
    F_Dados.Q_Contas.SQL.add('Select * from centro_custo where codigo=' + chr(39) + F_Dados.CDS_APagarConta.AsString + chr(39));
    F_Dados.Q_Contas.Active := True;
    Edit4.text := F_Dados.Q_ContasConta.AsString;
    //
    MaskEdit3.text := F_Dados.CDS_APagarEmissao.AsString;
    MaskEdit5.text := F_Dados.CDS_APagarVencimento.AsString;
    EditNum1.text := F_Dados.CDS_APagartotal_nf.AsString;
    EditNum5.text := F_Dados.CDS_APagarJuro.AsString;
    EditNum7.text := F_Dados.CDS_APagarMulta.AsString;
    EditNum8.text := F_Dados.CDS_APagarvalor_pago.AsString;
    data.text := F_Dados.CDS_APagarpagamento.AsString;
    Edit5.text := F_Dados.CDS_APagarBanco.AsString;
    //
    F_Dados.Q_Bancos.Active := False;
    F_Dados.Q_Bancos.SQL.clear;
    F_Dados.Q_Bancos.SQL.add('Select * from banco where id=' + chr(39) + F_Dados.CDS_APagarBanco.AsString + chr(39));
    F_Dados.Q_Bancos.Active := True;
    Edit6.text := F_Dados.Q_BancosBanco.AsString;
    //
    Edit2.text := F_Dados.CDS_APagarCheque.AsString;
    MaskEdit2.text := F_Dados.CDS_APagarData_Cheque.AsString;
    MaskEdit6.text := F_Dados.CDS_APagarLancamento.AsString;
    Panel1.Left := Floor((DBGrid1.Width - Panel1.Width) / 2);
    Panel1.Top := Floor((DBGrid1.Height - Panel1.Height) / 2);
    Panel1.Visible := True;
    Edit7.SetFocus;
    //
    F_Dados.Q_Contas.Active := False;
    F_Dados.Q_Contas.SQL.clear;
    F_Dados.Q_Contas.SQL.add('Select * from centro_custo order by codigo');
    F_Dados.Q_Contas.Active := True;
    F_Dados.CDS_Contas.Close;
    F_Dados.CDS_Contas.Open;
    F_Dados.Q_Bancos.Active := False;
    F_Dados.Q_Bancos.SQL.clear;
    F_Dados.Q_Bancos.SQL.add('Select * from banco order by id');
    F_Dados.Q_Bancos.Active := True;
    F_Dados.CDS_Bancos.Close;
    F_Dados.CDS_Bancos.Open;
  end;
end;

procedure TF_Cheques.MenuItem1Click(Sender: TObject);
begin
  F_Dados.CDS_APagar.Edit;
  F_Dados.CDS_APagarEmissao.AsString := '';
  F_Dados.CDS_APagar.Post;
  F_Dados.CDS_APagar.ApplyUpdates(0);
end;

procedure TF_Cheques.MenuItem2Click(Sender: TObject);
begin
  F_Dados.CDS_APagar.Edit;
  F_Dados.CDS_APagarpagamento.AsString := '';
  F_Dados.CDS_APagar.Post;
  F_Dados.CDS_APagar.ApplyUpdates(0);
end;

procedure TF_Cheques.Edit3Exit(Sender: TObject);
begin
  If Edit3.text <> '' then begin
    F_Dados.Q_Contas.Active := False;
    F_Dados.Q_Contas.SQL.clear;
    F_Dados.Q_Contas.SQL.add('select * from centro_custo where codigo=' + chr(39) + Edit3.text + chr(39));
    F_Dados.Q_Contas.Active := True;
    If F_Dados.Q_ContasCodigo.AsString = '' then begin
      Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
      Edit3.SetFocus;
    end
    else begin
      Edit4.text := F_Dados.Q_ContasConta.Value;
    end;
  end;
  F_Dados.Q_Contas.Active := False;
  F_Dados.Q_Contas.SQL.clear;
  F_Dados.Q_Contas.SQL.add('select * from centro_custo ');
  F_Dados.Q_Contas.SQL.add('order by codigo');
  F_Dados.Q_Contas.Active := True;
  F_Dados.CDS_Contas.Close;
  F_Dados.CDS_Contas.Open;
end;

procedure TF_Cheques.Edit3DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_PegaConta, F_PegaConta);
  F_PegaConta.ShowModal;
end;

procedure TF_Cheques.Edit5DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_PegaBanco, F_Pegabanco);
  F_Pegabanco.ShowModal;
end;

procedure TF_Cheques.Edit5Exit(Sender: TObject);
begin
  If Edit5.text <> '' then begin
    if Length(Edit5.text) = 1 then
      Edit5.text := '0' + Edit5.text;
    F_Dados.Q_Bancos.Active := False;
    F_Dados.Q_Bancos.SQL.clear;
    F_Dados.Q_Bancos.SQL.add('select * from banco where id=' + chr(39) + Edit5.text + chr(39));
    F_Dados.Q_Bancos.Active := True;
    If F_Dados.Q_BancosId.AsString = '' then begin
      Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
      Edit5.SetFocus;
    end
    else begin
      Edit6.text := F_Dados.Q_BancosBanco.Value;
    end;
  end;
  F_Dados.Q_Bancos.Active := False;
  F_Dados.Q_Bancos.SQL.clear;
  F_Dados.Q_Bancos.SQL.add('select * from banco ');
  F_Dados.Q_Bancos.SQL.add('order by id');
  F_Dados.Q_Bancos.Active := True;
  F_Dados.CDS_Bancos.Close;
  F_Dados.CDS_Bancos.Open;
end;

procedure TF_Cheques.BitBtn1Click(Sender: TObject);
var
  dia, mes, ano, dmes: string;
  opc: Integer;
begin
  aguarde;

  RDprint.MostrarProgresso := True;
  RDprint.TitulodoRelatorio := 'Cheque';
  RDprint.TamanhoQteColunas := 100;
  RDprint.TamanhoQteLinhas := 66;

  dia := Copy(MaskEdit2.text, 1, 2);
  mes := Copy(MaskEdit2.text, 4, 2);
  ano := Copy(MaskEdit2.text, 7, 4);
  //
  if mes = '01' then
    dmes := 'JANEIRO'
  else if mes = '02' then
    dmes := 'FEVEREIRO'
  else if mes = '03' then
    dmes := 'MARCO'
  else if mes = '04' then
    dmes := 'ABRIL'
  else if mes = '05' then
    dmes := 'MAIO'
  else if mes = '06' then
    dmes := 'JUNHO'
  else if mes = '07' then
    dmes := 'JULHO'
  else if mes = '08' then
    dmes := 'AGOSTO'
  else if mes = '09' then
    dmes := 'SETEMBRO'
  else if mes = '10' then
    dmes := 'OUTUBRO'
  else if mes = '11' then
    dmes := 'NOVEMBRO'
  else if mes = '12' then
    dmes := 'DEZEMBRO';
  //
  relatorio := 'cheque';
  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 02;
  RDprint.ImpVal(linha, 89, '##,##0.00', StrToFloat(EditNum8.text), []);
  inc(linha);
  RDprint.Imp(linha, 01, '');
  inc(linha);
  Extenso.Valor := StrToFloat(EditNum8.text);
  RDprint.Imp(linha, 15, Label19.Caption);
  inc(linha);
  RDprint.Imp(linha, 01, '');
  inc(linha);
  RDprint.Imp(linha, 01, '');
  inc(linha);
  RDprint.Imp(linha, 04, Edit9.text);
  inc(linha);
  RDprint.Imp(linha, 52, 'Cidade,' + dia + '               ' + dmes + '           ' + ano);
  inc(linha);
  RDprint.Fechar;
  //
  opc := Application.MessageBox('Deseja Imprimir a Cópia de Cheque?', 'Imprime Cópia de Cheque', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then begin
    relatorio := 'copia_cheque';
    RDprint.abrir; // Inicia a montagem do relatório...

    RDprint.ImpVal(linha, 85, '##,##0.00', StrToFloat(EditNum8.text), []);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    Extenso.Valor := StrToFloat(EditNum8.text);
    RDprint.Imp(linha, 15, Label19.Caption);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 04, Edit9.text);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 52, 'Cidade,' + dia + '               ' + dmes + '           ' + ano);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, StringOfChar('=', 100));
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, 'CHEQUE No....: ' + Edit2.text + '        BANCO: ' + Edit5.text + ' - ' + Edit6.text);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, 'DUPLICATA No.: ' + Edit8.text + '        PAGO A: ' + Edit1.text);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, StringOfChar('=', 100));
    RDprint.Fechar;
  end;
  //
  pronto;
end;

procedure TF_Cheques.MaskEdit6Enter(Sender: TObject);
begin
  MaskEdit6.text := datetostr(Date);
end;

procedure TF_Cheques.MaskEdit11Enter(Sender: TObject);
begin
  MaskEdit11.text := datetostr(Date);
end;

procedure TF_Cheques.Edit13DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_PegaBanco2, F_Pegabanco2);
  F_Pegabanco2.ShowModal;
end;

procedure TF_Cheques.Edit13Exit(Sender: TObject);
begin
  If Edit13.text <> '' then begin
    if Length(Edit13.text) = 1 then
      Edit13.text := '0' + Edit13.text;
    F_Dados.Q_Bancos.Active := False;
    F_Dados.Q_Bancos.SQL.clear;
    F_Dados.Q_Bancos.SQL.add('select * from banco where id=' + chr(39) + Edit13.text + chr(39));
    F_Dados.Q_Bancos.Active := True;
    If F_Dados.Q_Bancosid.AsString = '' then begin
      Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
      Edit13.SetFocus;
    end
    else begin
      Edit14.text := F_Dados.Q_BancosBanco.Value;
      Edit10.text := F_Dados.Q_BancosBanco.Value;
    end;
  end;
  F_Dados.Q_Bancos.Active := False;
  F_Dados.Q_Bancos.SQL.clear;
  F_Dados.Q_Bancos.SQL.add('select * from banco ');
  F_Dados.Q_Bancos.SQL.add('order by id');
  F_Dados.Q_Bancos.Active := True;
  F_Dados.CDS_Bancos.Close;
  F_Dados.CDS_Bancos.Open;
end;

procedure TF_Cheques.MenuButton1Click(Sender: TObject);
var
  dia, mes, ano, dmes: string;
  opc: Integer;
begin
  aguarde;

  RDprint.MostrarProgresso := True;
  RDprint.TitulodoRelatorio := 'Cheque';
  RDprint.TamanhoQteColunas := 100;
  RDprint.TamanhoQteLinhas := 66;

  dia := Copy(MaskEdit10.text, 1, 2);
  mes := Copy(MaskEdit10.text, 4, 2);
  ano := Copy(MaskEdit10.text, 7, 4);
  //
  if mes = '01' then
    dmes := 'JANEIRO'
  else if mes = '02' then
    dmes := 'FEVEREIRO'
  else if mes = '03' then
    dmes := 'MARCO'
  else if mes = '04' then
    dmes := 'ABRIL'
  else if mes = '05' then
    dmes := 'MAIO'
  else if mes = '06' then
    dmes := 'JUNHO'
  else if mes = '07' then
    dmes := 'JULHO'
  else if mes = '08' then
    dmes := 'AGOSTO'
  else if mes = '09' then
    dmes := 'SETEMBRO'
  else if mes = '10' then
    dmes := 'OUTUBRO'
  else if mes = '11' then
    dmes := 'NOVEMBRO'
  else if mes = '12' then
    dmes := 'DEZEMBRO';
  //

  relatorio := 'cheque';
  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 02;
  RDprint.ImpVal(linha, 89, '##,##0.00', StrToFloat(EditNum12.text), []);
  inc(linha);
  RDprint.Imp(linha, 01, '');
  inc(linha);
  Extenso.Valor := StrToFloat(EditNum12.text);
  RDprint.Imp(linha, 15, Label19.Caption);
  inc(linha);
  RDprint.Imp(linha, 01, '');
  inc(linha);
  RDprint.Imp(linha, 01, '');
  inc(linha);
  RDprint.Imp(linha, 04, Edit10.text);
  inc(linha);
  RDprint.Imp(linha, 52, 'Cidade,' + dia + '               ' + dmes + '           ' + ano);
  inc(linha);
  RDprint.Fechar;
  //
  opc := Application.MessageBox('Deseja Imprimir a Cópia de Cheque?', 'Imprime Cópia de Cheque', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then begin

    relatorio := 'copia_cheque';
    RDprint.abrir; // Inicia a montagem do relatório...

    RDprint.ImpVal(linha, 85, '##,##0.00', StrToFloat(EditNum12.text), []);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    Extenso.Valor := StrToFloat(EditNum12.text);
    RDprint.Imp(linha, 15, Label19.Caption);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 04, Edit10.text);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 52, 'Cidade,' + dia + '               ' + dmes + '           ' + ano);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, StringOfChar('=', 100));
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, 'CHEQUE No....: ' + Edit12.text + '        BANCO: ' + Edit13.text + ' - ' + Edit14.text);
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, 'DUPLICATA No.: VARIAS        PAGO A: CHEQUE PARA VARIAS DESPESAS');
    inc(linha);
    RDprint.Imp(linha, 01, '');
    inc(linha);
    RDprint.Imp(linha, 01, StringOfChar('=', 100));
    inc(linha);
    RDprint.Imp(linha, 01, 'DOCUMENTO');
    RDprint.Imp(linha, 07, 'DUPLICATA');
    RDprint.Imp(linha, 34, 'DESCRICAO');
    RDprint.Imp(linha, 80, 'VALOR');
    inc(linha);
    RDprint.Imp(linha, 01, StringOfChar('=', 100));

    F_Dados.CDS_APagar.DisableControls;
    F_Dados.CDS_APagar.First;
    While not F_Dados.CDS_APagar.eof do begin
      if F_Dados.CDS_APagarXX.AsString = 'X' then begin
        inc(linha);
        RDprint.Imp(linha, 01, Copy(F_Dados.CDS_APagarnumero_nf.AsString, 1, 15));
        RDprint.Imp(linha, 17, Copy(F_Dados.CDS_APagarDuplicata.AsString, 1, 15));
        RDprint.Imp(linha, 34, F_Dados.CDS_APagarFornecedor.AsString);
        RDprint.ImpVal(linha, 80, '##,##0.00', F_Dados.CDS_APagarvalor_pago.Value, []);
        F_Dados.CDS_APagar.Next;
      end
      else begin
        F_Dados.CDS_APagar.Next;
        Continue;
      end;
    end;
    F_Dados.CDS_APagar.EnableControls;
    F_Dados.CDS_APagar.First;

    inc(linha);
    RDprint.Imp(linha, 01, StringOfChar('=', 100));

    RDprint.Fechar;
  end;
  //
  pronto;
end;

procedure TF_Cheques.LimpaosMarcador1Click(Sender: TObject);
begin
  aguarde;
  F_Dados.CDS_APagar.First;
  While not F_Dados.CDS_APagar.eof do begin
    F_Dados.CDS_APagar.Edit;
    F_Dados.CDS_APagarXX.AsString := '';
    F_Dados.CDS_APagar.Post;
    F_Dados.CDS_APagar.ApplyUpdates(0);
    F_Dados.CDS_APagar.Next;
  end;
  F_Dados.CDS_APagar.First;
  pronto;
end;

procedure TF_Cheques.BitBtn6Click(Sender: TObject);
begin
  Edit12.clear;
  Edit13.clear;
  Edit14.clear;
  MaskEdit10.clear;
  MaskEdit11.clear;
  EditNum12.text := '0.00';
  Panel2.Visible := False;
end;

procedure TF_Cheques.BitBtn5Click(Sender: TObject);
begin
  Edit12.clear;
  Edit13.clear;
  Edit14.clear;
  MaskEdit10.clear;
  MaskEdit11.clear;
  EditNum12.text := '0.00';
  Panel2.Visible := False;
end;

procedure TF_Cheques.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = 115 then begin
    Application.CreateForm(TF_PegaForn, F_PegaForn);
    F_PegaForn.ShowModal;
  end;
end;

procedure TF_Cheques.Edit1DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_PegaForn1, F_PegaForn1);
  F_PegaForn1.ShowModal;
end;

procedure TF_Cheques.NovaPagina;
begin
  if linha > 63 then
    RDprint.NovaPagina;
end;

procedure TF_Cheques.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  if relatorio = 'tesouraria' then
  begin
    RDprint.Imp(02, 01, StringOfChar('=', 140));
    RDprint.impf(03, 01, 'Tesouraria e Banco - Período: ' + MaskEdit4.text + ' A ' + MaskEdit1.text, [expandido, NEGRITO]);
    RDprint.Imp(04, 01, F_Dados.NomeEmpresa);
    RDprint.Imp(05, 01, F_Dados.EnderecoEmpresa);
    RDprint.Imp(06, 01, StringOfChar('=', 140));

    RDprint.Imp(07, 01, 'DOCUMENTO');
    RDprint.Imp(07, 21, 'PAGO A');
    RDprint.Imp(07, 52, 'CONTA');
    RDprint.Imp(07, 68, 'EMISSAO');
    RDprint.Imp(07, 79, 'VENCIMENTO');
    RDprint.Imp(07, 90, 'PAGAMENTO');
    RDprint.Imp(07, 102, 'A PAGAR');
    RDprint.Imp(07, 113, 'JUROS');
    RDprint.Imp(07, 122, 'MULTA');
    RDprint.Imp(07, 131, 'VLR. PAGO');

    RDprint.Imp(08, 01, StringOfChar('-', 140));
    linha := 09;
  end;
  if relatorio = 'copia_cheque' then
  begin
    RDprint.Imp(02, 01, StringOfChar('=', 100));
    RDprint.impf(03, 01, 'Cópia de Cheque', [expandido, NEGRITO]);
    RDprint.Imp(04, 01, F_Dados.NomeEmpresa);
    RDprint.Imp(05, 01, F_Dados.EnderecoEmpresa);
    RDprint.Imp(06, 01, StringOfChar('=', 100));
    linha := 07;
  end;
end;

procedure TF_Cheques.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  if relatorio = 'tesouraria' then
  begin
    RDprint.Imp(64, 01, StringOfChar('=', 140));
    RDprint.Imp(65, 01, 'Página: ' + formatfloat('##', Pagina) + ' de &page&');
    RDprint.impd(65, 140, 'Impresso em ' + DateTimeToStr(Now), [italico]);
  end;
end;

procedure TF_Cheques.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

end.
