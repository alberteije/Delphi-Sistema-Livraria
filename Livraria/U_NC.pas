unit U_NC;

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, DBCGrids, Mask, DBCtrls, Grids, DBGrids, MenBtn,
  Menus, ComCtrls, Db, DBTables, Biblioteca, RDprint;

type
  TF_NC = class(TForm)
    ScrollBox1: TScrollBox;
    BitBtn10: TBitBtn;
    ScrollBox2: TScrollBox;
    Label4: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn14: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    Edit2: TEdit;
    Edit5: TEdit;
    Label3: TLabel;
    BitBtn1: TMenuButton;
    MenuButton3: TMenuButton;
    Panel3: TPanel;
    MaskEdit1: TMaskEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Edit7: TEdit;
    Edit3: TEdit;
    MaskEdit4: TMaskEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label5: TLabel;
    MaskEdit2: TMaskEdit;
    opcoes3: TPopupMenu;
    Relatrios1: TMenuItem;
    Vdeo2: TMenuItem;
    RadioButton1: TCheckBox;
    Memo1: TMemo;
    Label9: TLabel;
    RDprint: TRDprint;
    procedure aguarde;
    procedure pronto;
    procedure habilita;
    procedure desabilita;
    procedure limpa;
    procedure pegaminuta;
    procedure grava;
    procedure BitBtn10Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1Exit(Sender: TObject);
    procedure Vdeo2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure NovaPagina;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_NC: TF_NC;
  linha: Integer;

implementation

uses U_Dados;
{$R *.DFM}

Procedure TF_NC.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

Procedure TF_NC.pronto;
begin
  Panel3.Visible := False;
  Panel3.SendToBack;
  Panel3.Repaint;
end;

procedure TF_NC.BitBtn10Click(Sender: TObject);
begin
  Close;
end;

procedure TF_NC.limpa;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit5.Clear;
  MaskEdit1.Clear;
  Edit7.Clear;
  MaskEdit4.Clear;
  Edit3.Clear;
  MaskEdit2.Clear;
  Edit8.Clear;
  RadioButton1.Checked := False;
  Memo1.Clear;
end;

procedure TF_NC.pegaminuta;
begin
  MyConsulta(F_Dados.Q_DNC, 'select * from nota_credito_detalhe where minuta=' + chr(39) + Edit1.text + chr(39) + 'order by descricao');
  F_Dados.cds_DNC.Close;
  F_Dados.cds_DNC.open;
end;

procedure TF_NC.grava;
begin
  if RadioButton1.Checked = True then
    F_Dados.cds_CncBaixa.AsString := 'S';
  F_Dados.cds_CncNome.AsString := Edit7.text;
  F_Dados.cds_CncEndereco.AsString := Edit3.text;
  F_Dados.cds_CncFone.AsString := MaskEdit4.text;
  F_Dados.cds_CncBairro.AsString := Edit8.text;
  F_Dados.cds_CncCep.AsString := MaskEdit2.text;
  F_Dados.cds_CncCidade.AsString := Edit9.text;
  F_Dados.cds_CncObs.AsString := Memo1.text;
  F_Dados.cds_Cnc.Post;
  F_Dados.cds_Cnc.ApplyUpdates(0);
end;

procedure TF_NC.habilita;
begin
  Edit1.Enabled := True;
  BitBtn1.Enabled := False;
  BitBtn10.Enabled := False;
  BitBtn3.Enabled := True;
  BitBtn4.Enabled := True;
  BitBtn14.Enabled := True;
  MenuButton3.Enabled := True;
end;

procedure TF_NC.desabilita;
begin
  Edit1.Enabled := False;
  BitBtn1.Enabled := True;
  BitBtn10.Enabled := True;
  BitBtn3.Enabled := False;
  BitBtn4.Enabled := False;
  BitBtn14.Enabled := False;
  MenuButton3.Enabled := False;
end;

procedure TF_NC.FormActivate(Sender: TObject);
begin
  F_Dados.Q_Cnc.Active := True;
  F_Dados.cds_Cnc.Close;
  F_Dados.cds_Cnc.open;
  limpa;
  desabilita;
  pegaminuta;
end;

procedure TF_NC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_Dados.Q_Cnc.Close;
  Release;
end;

procedure TF_NC.BitBtn4Click(Sender: TObject);
begin
  if Edit1.text <> '' then
  begin
    aguarde;
    F_Dados.cds_Cnc.Edit;
    grava;
    limpa;
    desabilita;
    pegaminuta;
    pronto;
  end;
end;

procedure TF_NC.BitBtn14Click(Sender: TObject);
var
  opc: Integer;
begin
  if F_Dados.cds_DSomaCodigo.AsString <> '' then begin
    opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then
    begin
      F_Dados.cds_DNC.Delete;
      F_Dados.cds_DNC.ApplyUpdates(0);
    end;
  end
  else begin
    Application.MessageBox('Não Existem Ítens para Serem Excluídos', 'Informação do Sistema', Mb_IconInformation);
  end;
end;

procedure TF_NC.BitBtn3Click(Sender: TObject);
var
  opc: Integer;
begin
  aguarde;
  limpa;
  desabilita;
  pegaminuta;
  pronto;
end;

procedure TF_NC.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = vk_f5 then begin // ok
    BitBtn1Click(Sender);
  end;
  //
  If Key = vk_f9 then begin
    Vdeo2.Click;
  end;
  //
  If Key = vk_f11 then begin
    BitBtn3Click(Sender);
  end;
  //
  If Key = vk_f12 then begin
    BitBtn4Click(Sender);
  end;
end;

procedure TF_NC.Edit1Exit(Sender: TObject);
begin
  Edit1.text := StringOfChar('0', 10 - Length(Edit1.text)) + Edit1.text;
  MyConsulta(F_Dados.Q_Cnc, 'select * from nota_credito_cabecalho where ecf="S" and minuta=' + chr(39) + Edit1.text + chr(39));
  F_Dados.cds_Cnc.Close;
  F_Dados.cds_Cnc.open;
  If F_Dados.Q_CncMinuta.AsString <> '' then begin
    Edit2.text := F_Dados.Q_CncSomador.AsString;
    Edit5.text := F_Dados.Q_CncVendedor.AsString;
    MaskEdit1.text := F_Dados.Q_CNCdata_nc.AsString;
    Edit7.text := F_Dados.Q_CncNome.AsString;
    Edit3.text := F_Dados.Q_CncEndereco.AsString;
    MaskEdit4.text := F_Dados.Q_CncFone.AsString;
    Edit8.text := F_Dados.Q_CncBairro.AsString;
    MaskEdit2.text := F_Dados.Q_CncCep.AsString;
    Edit9.text := F_Dados.Q_CncCidade.AsString;
    Memo1.text := F_Dados.Q_CncObs.AsString;
    if F_Dados.Q_CNCBaixa.AsString = 'S' then
      RadioButton1.Checked := True;
    //
    pegaminuta;
    Edit1.Enabled := False;
  end
  else
  begin
    If Edit1.text <> '' then
    begin
      Application.MessageBox('A Minuta Acima Não Existe ou o Cupom Fiscal não foi Impresso', 'Informação do Sistema', Mb_IconInformation);
      limpa;
      desabilita;
      Edit1.Enabled := False;
    end
    else
    begin
      desabilita;
    end;
  end;
end;

procedure TF_NC.Vdeo2Click(Sender: TObject);
begin
  aguarde;

  RDprint.MostrarProgresso := True;
  RDprint.TitulodoRelatorio := 'Nota de Credito';
  RDprint.TamanhoQteColunas := 136;
  RDprint.TamanhoQteLinhas := 66;

  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 21;

  F_Dados.cds_DNC.DisableControls;
  F_Dados.cds_DNC.First;
  while not F_Dados.cds_DNC.eof do begin
    NovaPagina;

    RDprint.Imp(linha, 01, F_Dados.CDS_DncCodigo.AsString);
    RDprint.Imp(linha, 19, F_Dados.CDS_DncQuantidade.AsString);
    RDprint.Imp(linha, 30, F_Dados.CDS_DncDescricao.AsString);
    RDprint.Imp(linha, 92, F_Dados.CDS_DncAutor.AsString);
    F_Dados.cds_DNC.next;

    inc(linha);
  end;

  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');
  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');
  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');

  inc(linha);
  NovaPagina;
  RDprint.impc(linha, 68, 'Cidade, ' + MaskEdit1.text, []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');
  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');

  inc(linha);
  NovaPagina;
  RDprint.impc(linha, 68, F_Dados.NomeEmpresa, []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');
  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');
  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 136));

  F_Dados.cds_DNC.First;
  F_Dados.cds_DNC.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_NC.BitBtn1Click(Sender: TObject);
begin
  limpa;
  pegaminuta;
  habilita;
  Edit1.Enabled := True;
  Edit1.SetFocus;
end;

procedure TF_NC.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := upcase(Key);
end;

procedure TF_NC.NovaPagina;
begin
  if linha > 63 then
    RDprint.NovaPagina;
end;

procedure TF_NC.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  RDprint.Imp(02, 01, StringOfChar('=', 136));
  RDprint.impf(03, 01, 'Nota de Credito', [expandido, NEGRITO]);
  RDprint.Imp(04, 01, F_Dados.NomeEmpresa);
  RDprint.Imp(05, 01, F_Dados.EnderecoEmpresa);
  RDprint.Imp(06, 01, StringOfChar('=', 136));
  RDprint.Imp(07, 01, 'Minuta No: ' + Edit1.text + '   -   Data da Emissao: ' + MaskEdit1.text);
  RDprint.Imp(08, 01, StringOfChar('=', 136));
  RDprint.Imp(09, 01, 'Nome do Cliente.....: ' + Edit7.text);
  RDprint.Imp(10, 01, 'Endereco............: ' + Edit3.text);
  RDprint.Imp(11, 01, 'Bairro..............: ' + Edit8.text + '  -  Fone...: ' + MaskEdit4.text);
  RDprint.Imp(12, 01, 'Cidade..............: ' + Edit9.text + '  -  CEP...: ' + MaskEdit2.text);
  RDprint.Imp(13, 01, StringOfChar('=', 136));
  RDprint.Imp(15, 01, '             Vale a presente Nota de Credito ao portador para ser retirado em nossa loja em qualquer tempo, os livros');
  RDprint.Imp(16, 01, '             abaixo relacionados.');
  RDprint.Imp(18, 01, StringOfChar('=', 136));

  RDprint.Imp(19, 01, 'CODIGO');
  RDprint.Imp(19, 15, 'QUANT');
  RDprint.Imp(19, 30, 'DESCRICAO');
  RDprint.Imp(19, 92, 'AUTOR');

  RDprint.Imp(20, 01, StringOfChar('-', 136));
  linha := 21;
end;

procedure TF_NC.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  RDprint.Imp(64, 01, StringOfChar('=', 136));
  RDprint.Imp(65, 01, 'Página: ' + formatfloat('##', Pagina) + ' de &page&');
  RDprint.impd(65, 136, 'Impresso em ' + DateTimeToStr(Now), [italico]);
end;

procedure TF_NC.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

end.
