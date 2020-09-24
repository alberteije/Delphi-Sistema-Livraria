unit U_Soma;

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, EditNum, DBCGrids, Mask, DBCtrls,
  Grids, DBGrids, MenBtn, Menus, ComCtrls, Db, DBTables, Biblioteca, RDprint;

type
  TF_Soma = class(TForm)
    ScrollBox1: TScrollBox;
    BitBtn10: TBitBtn;
    ScrollBox2: TScrollBox;
    Label4: TLabel;
    Label1: TLabel;
    EditNum2: TEditNum;
    Edit1: TEdit;
    BitBtn14: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    DATA: TLabel;
    HORA: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Edit5: TEdit;
    Label3: TLabel;
    opcoes2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    BitBtn1: TMenuButton;
    MenuButton3: TMenuButton;
    opcoes3: TPopupMenu;
    MenuItem3: TMenuItem;
    Panel2: TPanel;
    Label15: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Relatrios1: TMenuItem;
    Vdeo2: TMenuItem;
    Impressora1: TMenuItem;
    Panel3: TPanel;
    Panel4: TPanel;
    Label20: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Edit15: TEdit;
    Edit16: TEdit;
    MaskEdit7: TMaskEdit;
    GroupBox1: TGroupBox;
    BitBtn7: TBitBtn;
    Edit17: TEdit;
    Edit18: TEdit;
    Label27: TLabel;
    MaskEdit8: TMaskEdit;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    RDprint: TRDprint;
    procedure terminaminuta;
    procedure iniciaminuta;
    procedure aguarde;
    procedure pronto;
    procedure pegadorc;
    procedure habilita;
    procedure desabilita;
    procedure GravaDadosCanc;
    procedure saiorc;
    procedure limpa;
    procedure impminuta;
    procedure pegaminuta;
    procedure grava;
    procedure grava_cabecalho;
    procedure soma;
    procedure BitBtn10Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure EditNum2Exit(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure Vdeo2Click(Sender: TObject);
    procedure Impressora1Click(Sender: TObject);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn7Click(Sender: TObject);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure NovaPagina;
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    Inclui: Integer;
    { Public declarations }
  end;

var
  F_Soma: TF_Soma;
  linha: Integer;
  relatorio: string;

implementation

uses U_Dados, U_PegaProd1;
{$R *.DFM}

Procedure TF_Soma.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

Procedure TF_Soma.pronto;
begin
  Panel3.Visible := False;
  Panel3.SendToBack;
  Panel3.Repaint;
end;

Procedure TF_Soma.impminuta;
begin
  aguarde;
  F_Dados.cds_DSoma.ApplyUpdates(0);
  soma;
  // PegaMinuta;
  MyConsulta(F_Dados.Q_DSoma, 'select * from soma_detalhe where minuta=' + chr(39) + Edit1.text + chr(39) + 'order by nota_credito, descricao');
  F_Dados.cds_DSoma.Close;
  F_Dados.cds_DSoma.Open;
  //
  MyConsulta(F_Dados.Q_Rap, 'select * from soma_detalhe where minuta=' + chr(39) + Edit1.text + chr(39) + ' and nota_credito="X"');
  if F_Dados.Q_Rap.RecordCount <= 0 then begin
    iniciaminuta;
    terminaminuta;
  end
  else if F_Dados.Q_Rap.RecordCount > 0 then begin
    pronto;
    Panel4.Visible := True;
    Edit15.SetFocus;
  end;
end;

procedure TF_Soma.BitBtn10Click(Sender: TObject);
begin
  Close;
end;

procedure TF_Soma.limpa;
begin
  Label9.caption := '';
  Label5.caption := '';
  Label10.caption := '';
  Edit1.Clear;
  Edit2.Clear;
  Edit5.Clear;
  EditNum2.text := '0,00';
end;

procedure TF_Soma.pegadorc;
begin
  MyConsulta(F_Dados.Q_Corc, 'select * from orcamento_cabecalho where codigo_orcamento=' + chr(39) + MaskEdit1.text + chr(39));

  if F_Dados.Q_Corc.RecordCount > 0 then
  begin
    MyConsulta(F_Dados.Q_Dorc, 'select * from orcamento_detalhe where id_orcamento_cabecalho=' + chr(39) + F_Dados.Q_Corcid.AsString + chr(39));
    F_Dados.cds_Dorc.Close;
    F_Dados.cds_Dorc.Open;
  end;
end;

procedure TF_Soma.pegaminuta;
begin
  MyConsulta(F_Dados.Q_DSoma, 'select * from soma_detalhe where minuta=' + chr(39) + Edit1.text + chr(39));
  F_Dados.cds_DSoma.Close;
  F_Dados.cds_DSoma.Open;
end;

procedure TF_Soma.grava;
begin
  F_Dados.cds_DSoma.ApplyUpdates(0);
  soma;
  grava_cabecalho;
end;

procedure TF_Soma.grava_cabecalho;
begin
  F_Dados.cds_CSomaMinuta.AsString := Edit1.text;
  F_Dados.cds_CSomasomador.AsString := Edit2.text;
  F_Dados.cds_CSomavendedor.AsString := Edit5.text;
  F_Dados.CDS_CSomadata_soma.AsString := DATA.caption;
  F_Dados.cds_CSomaHora.AsString := HORA.caption;
  F_Dados.cds_CSomaTotal.AsString := EditNum2.text;
  F_Dados.cds_CSomaAuditoria.AsString := DateTimeToStr(Now);
  F_Dados.cds_CSoma.Post;
  F_Dados.cds_CSoma.ApplyUpdates(0);
end;

procedure TF_Soma.habilita;
begin
  Edit1.Enabled := True;
  Edit2.Enabled := True;
  Edit5.Enabled := True;
  EditNum2.Enabled := True;
  BitBtn1.Enabled := False;
  BitBtn10.Enabled := False;
  BitBtn3.Enabled := True;
  BitBtn4.Enabled := True;
  BitBtn14.Enabled := True;
  MenuButton3.Enabled := True;
end;

procedure TF_Soma.desabilita;
begin
  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Edit5.Enabled := False;
  EditNum2.Enabled := False;
  BitBtn1.Enabled := True;
  BitBtn10.Enabled := True;
  BitBtn3.Enabled := False;
  BitBtn4.Enabled := False;
  BitBtn14.Enabled := False;
  MenuButton3.Enabled := False;
end;

Procedure TF_Soma.soma;
Begin
  if F_Dados.cds_DSomaCodigo.AsString = '' then begin
    If F_Dados.cds_DSoma.State in [dsEdit, dsInsert] then
      F_Dados.cds_DSoma.Cancel
    else
      F_Dados.cds_DSoma.Delete;
    F_Dados.cds_DSoma.ApplyUpdates(0);
  end;
  //
  F_Dados.Q_Rap.Active := False;
  F_Dados.Q_Rap.Sql.Clear;
  F_Dados.Q_Rap.Sql.add('delete from soma_detalhe where codigo is null');
  F_Dados.Q_Rap.ExecSql;
  //
  MyConsulta(F_Dados.Q_Rap, 'select sum(valor_total) as soma from soma_detalhe where minuta=' + chr(39) + Edit1.text + chr(39));
  EditNum2.text := F_Dados.Q_Rap.FieldByName('soma').AsString;
end;

procedure TF_Soma.FormActivate(Sender: TObject);
begin
  Inclui := 0;
  F_Dados.Q_CSoma.Active := True;
  F_Dados.cds_CSoma.Close;
  F_Dados.cds_CSoma.Open;
  limpa;
  desabilita;
  pegaminuta;
end;

procedure TF_Soma.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If (Inclui = 1) or (Inclui = 2) or (Inclui = 3) then begin
    Application.MessageBox('Antes de Sair, Confirme ou Cancele a Soma', 'Atenção!!!', Mb_IconError);
    Action := caNone;
  end
  else begin
    F_Dados.Q_CSoma.Close;
    Release;
  end;
end;

procedure TF_Soma.BitBtn4Click(Sender: TObject);
var
  opc: Integer;
begin
  If Edit1.text = '' then begin
    Application.MessageBox('Não Existe uma Soma em Andamento para Ser Confirmada', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    aguarde;
    If (F_Dados.cds_DSoma.State in [dsEdit, dsInsert]) and (F_Dados.cds_DSomaCodigo.AsString <> '') then
      F_Dados.cds_DSoma.Post
    Else If (F_Dados.cds_DSoma.State in [dsEdit, dsInsert]) and (F_Dados.cds_DSomaCodigo.AsString = '') then
      F_Dados.cds_DSoma.Cancel;
    F_Dados.cds_DSoma.ApplyUpdates(0);

    If Inclui = 1 then begin
      F_Dados.cds_CSoma.Edit;
      grava;
    end
    else if Inclui = 2 then begin
      F_Dados.cds_CSoma.Edit;
      grava;
    end
    else if Inclui = 3 then begin
      F_Dados.cds_CSoma.Edit;
      grava;
    end;
    limpa;
    desabilita;
    pegaminuta;
    Inclui := 0;
    Application.MessageBox('Soma Confirmada Com Sucesso', 'Informação do Sistema', Mb_IconInformation);
    pronto;
  end;
end;

procedure TF_Soma.BitBtn14Click(Sender: TObject);
var
  opc: Integer;
begin
  if F_Dados.cds_DSomaCodigo.AsString <> '' then begin
    opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then
    begin
      F_Dados.cds_DSoma.Delete;
      F_Dados.cds_DSoma.ApplyUpdates(0);
    end;
  end
  else begin
    Application.MessageBox('Não Existem Ítens para Serem Excluídos', 'Informação do Sistema', Mb_IconInformation);
  end;
end;

procedure TF_Soma.BitBtn3Click(Sender: TObject);
var
  opc: Integer;
begin
  If Edit1.text = '' then begin
    Application.MessageBox('Não Existe uma Soma em Andamento para Ser Cancelada', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    opc := Application.MessageBox('Se Cancelar a Minuta Acima Todos os Dados Serão Perdidos - Continua?', 'Cancela a Minuta', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then begin
      aguarde;
      If Inclui = 1 then begin
        F_Dados.cds_CSoma.Edit;
        GravaDadosCanc;
      end
      else if Inclui = 2 then begin
        F_Dados.cds_CSoma.Edit;
        GravaDadosCanc;
      end
      else if Inclui = 3 then begin
        F_Dados.cds_CSoma.Edit;
        GravaDadosCanc;
      end;
      limpa;
      desabilita;
      pegaminuta;
      Inclui := 0;
      pronto;
    end;
  end;
end;

procedure TF_Soma.GravaDadosCanc;
begin
  F_Dados.Q_Rap.Active := False;
  F_Dados.Q_Rap.Sql.Clear;
  F_Dados.Q_Rap.Sql.add('delete from soma_detalhe where minuta=' + chr(39) + Edit1.text + chr(39));
  F_Dados.Q_Rap.ExecSql;
  //
  F_Dados.cds_CSomaMinuta.AsString := Edit1.text;
  F_Dados.cds_CSomasomador.AsString := '999';
  F_Dados.cds_CSomavendedor.AsString := '999';
  F_Dados.CDS_CSomadata_soma.AsString := DATA.caption;
  F_Dados.cds_CSomaHora.AsString := HORA.caption;
  F_Dados.cds_CSomaTotal.AsString := EditNum2.text;
  F_Dados.cds_CSomaAuditoria.AsString := DateTimeToStr(Now);
  F_Dados.cds_CSoma.Post;
  F_Dados.cds_CSoma.ApplyUpdates(0);
end;

procedure TF_Soma.DBGrid1DblClick(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 3) then begin
    Application.CreateForm(TF_PegaProd1, F_PegaProd1);
    F_PegaProd1.ShowModal
  end
  else
    Application.MessageBox('Não Existe uma Soma em Andamento', 'Informação do Sistema', Mb_IconInformation);
end;

procedure TF_Soma.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = 112 then begin
    aguarde;
    F_Dados.cds_DSoma.ApplyUpdates(0);
    soma;
    pronto;
  end;
  //
  If Key = 115 then begin // ok
    If (Inclui = 1) or (Inclui = 2) or (Inclui = 3) then begin
      Application.CreateForm(TF_PegaProd1, F_PegaProd1);
      F_PegaProd1.ShowModal;
    end
    else
      Application.MessageBox('Não Existe uma Soma em Andamento', 'Informação do Sistema', Mb_IconInformation);
  end;
  //
  If Key = 116 then begin // ok
    MenuItem1Click(Sender);
  end;
  //
  If Key = 117 then begin // ok
    MenuItem2Click(Sender);
  end;
  //
  If Key = 118 then begin // ok
    MenuItem3Click(Sender);
  end;
  //
  If Key = 120 then begin
    Vdeo2Click(Sender);
  end;
  //
  If Key = 122 then begin
    BitBtn3Click(Sender);
  end;
  //
  If Key = 123 then begin
    BitBtn4Click(Sender);
  end;
  //
  If Key = 121 then begin
    Impressora1Click(Sender);
  end;
end;

procedure TF_Soma.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := Upcase(Key);
  // If Key = '.' then
  // Key := #44;
end;

procedure TF_Soma.Edit2Exit(Sender: TObject);
begin
  If Edit2.text <> '' then begin
    Edit2.text := StringOfChar('0', 3 - Length(Edit2.text)) + Edit2.text;
    If Edit2.text <> '' then begin
      MyConsulta(F_Dados.Q_Rap, 'select id from funcionario where id=' + chr(39) + Edit2.text + chr(39));
      If F_Dados.Q_Rap.FieldByName('id').AsString = '' then begin
        Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
        Edit2.SetFocus;
      end;
    end;
  end
  else begin
    If Edit1.text <> '' then begin
      Application.MessageBox('É Necessário Inserir o Código do Somador', 'Informação do Sistema', Mb_IconInformation);
      Edit2.SetFocus;
    end;
  end;
end;

procedure TF_Soma.Edit5Exit(Sender: TObject);
begin
  If Edit5.text <> '' then begin
    Edit5.text := StringOfChar('0', 3 - Length(Edit5.text)) + Edit5.text;
    If Edit5.text <> '' then begin
      MyConsulta(F_Dados.Q_Rap, 'select id from funcionario where id=' + chr(39) + Edit5.text + chr(39));
      If F_Dados.Q_Rap.FieldByName('id').AsString = '' then begin
        Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
        Edit5.SetFocus;
      end;
    end;
  end
  else begin
    If Edit1.text <> '' then begin
      Application.MessageBox('É Necessário Inserir o Código do Vendedor', 'Informação do Sistema', Mb_IconInformation);
      Edit5.SetFocus;
    end;
  end;
end;

procedure TF_Soma.MenuItem1Click(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) or (Inclui = 3) then begin
    Application.MessageBox('Você já Iniciou ou está Acessando uma ' + #13 + 'Minuta. Clique em CONFIRMAR ou CANCELAR', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    Inclui := 1;
    limpa;

    //Exercício: para realizar o controle de numeração das minutas em rede, estamos
    //inserindo um registro numa tabela que controla apenas isso. Pense numa melhor
    //maneira de realizar tal controle.
    F_Dados.Conexao.AutoClone := False;
    F_Dados.Q_Rap.Active := False;
    F_Dados.Q_Rap.Sql.Clear;
    F_Dados.Q_Rap.Sql.add('insert into minutas() values ()');
    F_Dados.Q_Rap.ExecSql();

    F_Dados.Q_Rap.Active := False;
    F_Dados.Q_Rap.Sql.Clear;
    F_Dados.Q_Rap.Sql.add('select LAST_INSERT_ID() as id');
    F_Dados.Q_Rap.Open();
    F_Dados.Conexao.AutoClone := True;

    Edit1.text := StringOfChar('0', 10 - Length(F_Dados.Q_Rap.FieldByName('id').AsString)) + F_Dados.Q_Rap.FieldByName('id').AsString;
    DATA.caption := DateToStr(date);
    HORA.caption := TimeToStr(Time);
    F_Dados.cds_CSoma.Append;
    grava_cabecalho;
    //
    MyConsulta(F_Dados.Q_CSoma, 'select * from soma_cabecalho where minuta=' + chr(39) + Edit1.text + chr(39));
    F_Dados.cds_CSoma.Close;
    F_Dados.cds_CSoma.Open;
    //
    pegaminuta;
    habilita;
    Edit1.Enabled := False;
    Edit2.SetFocus;
    DBGrid1.ReadOnly := False;
  end;
end;

procedure TF_Soma.MenuItem2Click(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) or (Inclui = 3) then begin
    Application.MessageBox('Você já Iniciou ou está Acessando uma ' + #13 + 'Minuta. Clique em CONFIRMAR ou CANCELAR', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    limpa;
    pegaminuta;
    habilita;
    Edit1.Enabled := True;
    Edit1.SetFocus;
    BitBtn14.Enabled := False;
    BitBtn3.Enabled := False;
    BitBtn4.Enabled := False;
    MenuButton3.Enabled := False;
  end;
end;

procedure TF_Soma.Edit1Exit(Sender: TObject);
var
  total: string;
begin
  Edit1.text := StringOfChar('0', 10 - Length(Edit1.text)) + Edit1.text;
  MyConsulta(F_Dados.Q_CSoma, 'select * from soma_cabecalho where minuta=' + chr(39) + Edit1.text + chr(39));
  F_Dados.cds_CSoma.Close;
  F_Dados.cds_CSoma.Open;
  If F_Dados.Q_CSomaMinuta.AsString <> '' then begin
    if F_Dados.Q_CSomasomador.AsString = '999' then begin
      Application.MessageBox('A Minuta Acima foi Cancelada', 'Informação do Sistema', Mb_IconInformation);
      limpa;
      desabilita;
      Edit1.Enabled := False;
    end
    else begin
      Inclui := 2;
      Edit2.text := F_Dados.Q_CSomasomador.AsString;
      Edit5.text := F_Dados.Q_CSomavendedor.AsString;
      DATA.caption := DateToStr(date);
      HORA.caption := F_Dados.Q_CSomaHora.AsString;
      //
      pegaminuta;
      soma;
      Edit1.Enabled := False;
      DBGrid1.ReadOnly := True;
    end;
  end
  else begin
    If Edit1.text <> '' then begin
      Application.MessageBox('A Minuta Acima Não Existe', 'Informação do Sistema', Mb_IconInformation);
      limpa;
      desabilita;
      Edit1.Enabled := False;
    end
    else begin
      desabilita;
    end;
  end;
end;

procedure TF_Soma.EditNum2Exit(Sender: TObject);
begin
  DBGrid1.SetFocus;
end;

procedure TF_Soma.MenuItem3Click(Sender: TObject);
begin
  If Inclui = 0 then begin
    Application.MessageBox('É Necessário Iniciar ou Acessar uma Soma para Importar um Orçamento', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    ScrollBox1.Enabled := False;
    ScrollBox2.Enabled := False;
    DBGrid1.Enabled := False;
    Panel2.Visible := True;
    MaskEdit1.SetFocus;
  end;
end;

procedure TF_Soma.MaskEdit1Exit(Sender: TObject);
var
  opc: Integer;
  opc1: pchar;
  opc2: string;
begin
  Label5.caption := copy(MaskEdit1.text, 5, 3);
  Label9.caption := MaskEdit1.text;
  MyConsulta(F_Dados.Q_Corc, 'select * from orcamento_cabecalho where codigo_orcamento=' + chr(39) + MaskEdit1.text + chr(39));
  MyConsulta(F_Dados.Q_Particular, 'select * from escola where id=' + chr(39) + F_Dados.Q_Corcid_escola.AsString + chr(39));
  If F_Dados.Q_Corccodigo_orcamento.AsString <> '' then begin
    Label10.caption := F_Dados.Q_ParticularNome.AsString;
    opc2 := 'O Orçamento Solicitado Pertence ao Colégio:' + #13 + #13 + F_Dados.Q_ParticularNome.AsString + ' - ' + copy(F_Dados.Q_CorcSerie.AsString, 1, 1) + 'a Série.' + #13 + #13 + '      Importa o Orçamento Solicitado?      ';
    opc1 := pchar(opc2);
    opc := Application.MessageBox(opc1, 'Aviso do Sistema', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then begin
      aguarde;
      //
      F_Dados.cds_DSoma1.Open;
      pegadorc;
      F_Dados.Q_Dorc.First;
      While not F_Dados.Q_Dorc.EOF do begin
        F_Dados.cds_DSoma1.Append;
        F_Dados.CDS_DSoma1id_soma_cabecalho.AsInteger := F_Dados.CDS_CSomaid.AsInteger;
        F_Dados.CDS_DSoma1id_produto.AsString := F_Dados.Q_Dorcid_produto.AsString;
        F_Dados.CDS_DSoma1minuta.AsInteger := F_Dados.CDS_CSomaminuta.AsInteger;
        F_Dados.cds_DSoma1Codigo.AsString := F_Dados.Q_DorcCodigoBarra.AsString;
        F_Dados.cds_DSoma1Descricao.AsString := F_Dados.Q_DorcDescricao.AsString;
        F_Dados.cds_DSoma1Quantidade.AsString := F_Dados.Q_DorcQuantidade.AsString;
        F_Dados.cds_DSoma1Unidade.AsString := F_Dados.Q_DorcUnidade.AsString;
        F_Dados.cds_DSoma1valor_unitario.AsString := F_Dados.Q_Dorcvalor_unitario.AsString;
        F_Dados.cds_DSoma1valor_total.AsString := F_Dados.Q_Dorcvalor_total.AsString;
        F_Dados.cds_DSoma1livro_material.AsString := F_Dados.Q_Dorclivro_material.AsString;
        F_Dados.cds_DSoma1Auditoria.AsString := F_Dados.Q_DorcAuditoria.AsString;
        F_Dados.cds_DSoma1.Post;
        F_Dados.Q_Dorc.Next;
      end;
      saiorc;
      F_Dados.cds_DSoma1.ApplyUpdates(0);
      pegaminuta;
    end
    else begin
      saiorc;
    end;
  end
  else begin
    Application.MessageBox('O Orçamento Solicitado não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
    saiorc;
  end;
  //
  DBGrid1.SetFocus;
  pronto;
end;

procedure TF_Soma.saiorc;
begin
  MaskEdit1.Clear;
  ScrollBox1.Enabled := True;
  ScrollBox2.Enabled := True;
  DBGrid1.Enabled := True;
  Panel2.Visible := False;
end;

procedure TF_Soma.Vdeo2Click(Sender: TObject);
begin
  If Inclui = 0 then begin
    Application.MessageBox('É Necessário Iniciar ou Acessar uma Soma para Imprimir uma Minuta', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    RDprint.OpcoesPreview.Preview := True;
    impminuta;
  end;
end;

procedure TF_Soma.Impressora1Click(Sender: TObject);
begin
  If Inclui = 0 then begin
    Application.MessageBox('É Necessário Iniciar ou Acessar uma Soma para Imprimir uma Minuta', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    RDprint.OpcoesPreview.Preview := False;
    impminuta;
  end;
end;

procedure TF_Soma.MaskEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then
    saiorc;
end;

procedure TF_Soma.MaskEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TF_Soma.BitBtn7Click(Sender: TObject);
var
  item: Integer;
begin
  aguarde;
  if Edit15.text <> '' then begin
    iniciaminuta;
    MyConsulta(F_Dados.Q_Rap, 'select * from nota_credito_cabecalho where minuta=' + chr(39) + Edit1.text + chr(39));
    if F_Dados.Q_Rap.FieldByName('minuta').AsString = '' then begin
      F_Dados.cds_CNC.Close;
      F_Dados.cds_CNC.Open;
      F_Dados.cds_DNC.Close;
      F_Dados.cds_DNC.Open;
      // grava dados na CNC
      F_Dados.cds_CNC.Append;
      F_Dados.cds_CncMinuta.AsString := Edit1.text;
      F_Dados.cds_CncSomador.AsString := Edit2.text;
      F_Dados.cds_CncVendedor.AsString := Edit5.text;
      F_Dados.CDS_CNCdata_nc.AsString := DateToStr(date);
      F_Dados.cds_CncNome.AsString := Edit15.text;
      F_Dados.cds_CncEndereco.AsString := Edit16.text;
      F_Dados.cds_CncFone.AsString := MaskEdit7.text;
      F_Dados.cds_CncBairro.AsString := Edit17.text;
      F_Dados.cds_CncCep.AsString := MaskEdit8.text;
      F_Dados.cds_CncCidade.AsString := Edit18.text;
      F_Dados.cds_CNC.Post;
      F_Dados.cds_CNC.ApplyUpdates(0);
      // grava dados na DNC
      MyConsulta(F_Dados.Q_Rap, 'select * from nota_credito_cabecalho where minuta=' + chr(39) + Edit1.text + chr(39));
      //
      F_Dados.cds_DSoma.DisableControls;
      F_Dados.cds_DSoma.First;
      While not F_Dados.cds_DSoma.EOF do begin
        if F_Dados.CDS_DSomanota_credito.AsString = 'X' then begin
          F_Dados.cds_DNC.Append;
          F_Dados.cds_DNCminuta.AsString := Edit1.text;
          F_Dados.CDS_DNCid_nota_credito_cabecalho.AsString := F_Dados.Q_Rap.FieldByName('id').AsString;
          F_Dados.CDS_DNCid_produto.AsString := F_Dados.CDS_DSomaid_produto.AsString;
          F_Dados.cds_DNCCodigo.AsString := F_Dados.cds_DSomaCodigo.AsString;
          F_Dados.cds_DNCDescricao.AsString := F_Dados.cds_DSomaDescricao.AsString;
          F_Dados.cds_DNCQuantidade.AsString := F_Dados.cds_DSomaQuantidade.AsString;
          F_Dados.cds_DNCvalor_unitario.AsString := F_Dados.cds_DSomavalor_unitario.AsString;
          F_Dados.cds_DNCvalor_total.AsString := F_Dados.cds_DSomavalor_total.AsString;
          F_Dados.cds_DNC.Post;
          F_Dados.cds_DSoma.Next;
        end
        else
          F_Dados.cds_DSoma.Next;
      end;
      F_Dados.cds_DNC.ApplyUpdates(0);
      F_Dados.cds_DSoma.First;
      F_Dados.cds_DSoma.EnableControls;
    end;
    //

    relatorio := 'nc';

    item := 0;

    RDprint.Imp(linha + 01, 01, '****************************************************');
    RDprint.Imp(linha + 02, 01, F_Dados.NomeEmpresa);
    RDprint.Imp(linha + 03, 01, '              Telefone: (88) 3241.5555              ');
    RDprint.Imp(linha + 04, 01, '                   NOTA DE CREDITO                  ');
    RDprint.Imp(linha + 05, 01, '           MINUTA DE VENDA No  ' + Edit1.text);
    RDprint.Imp(linha + 06, 01, 'DATA: ' + DATA.caption);
    RDprint.Imp(linha + 06, 38, 'HORA: ' + HORA.caption);
    RDprint.Imp(linha + 07, 01, '****************************************************');
    //
    MyConsulta(F_Dados.Q_Rap, 'select nome from funcionario where id=' + chr(39) + Edit2.text + chr(39));
    RDprint.Imp(linha + 08, 01, 'SOMADOR...: ' + Edit2.text + ' / ' + F_Dados.Q_Rap.FieldByName('Nome').AsString);
    //
    MyConsulta(F_Dados.Q_Rap, 'select nome from funcionario where id=' + chr(39) + Edit5.text + chr(39));
    RDprint.Imp(linha + 09, 01, 'VENDEDOR..: ' + Edit5.text + ' / ' + F_Dados.Q_Rap.FieldByName('Nome').AsString);
    RDprint.Imp(linha + 10, 01, '****************************************************');
    RDprint.Imp(linha + 11, 01, '**********        DADOS DO CLIENTE        **********');
    RDprint.Imp(linha + 12, 01, '****************************************************');
    RDprint.Imp(linha + 13, 01, 'Nome: ' + copy(Edit15.text, 1, 46));
    RDprint.Imp(linha + 14, 01, 'Endereco: ' + copy(Edit16.text, 1, 42));
    RDprint.Imp(linha + 15, 01, 'Fone: ' + MaskEdit7.text + ' - Bairro: ' + copy(Edit17.text, 1, 21));
    RDprint.Imp(linha + 16, 01, 'CEP: ' + MaskEdit8.text + ' - Cidade: ' + copy(Edit18.text, 1, 26));
    RDprint.Imp(linha + 17, 01, '****************************************************');
    RDprint.Imp(linha + 18, 01, '----------------------------------------------------');
    RDprint.Imp(linha + 19, 01, 'ITEM   DESCRICAO');
    RDprint.Imp(linha + 20, 01, 'UNIDADE   QUANTIDADE    UNITARIO (R$)     TOTAL (R$)');
    RDprint.Imp(linha + 21, 01, '----------------------------------------------------');
    //
    MyConsulta(F_Dados.Q_DNC, 'select * from nota_credito_detalhe where minuta=' + chr(39) + Edit1.text + chr(39));
    F_Dados.Q_DNC.First;
    linha := linha + 22;
    while not F_Dados.Q_DNC.EOF do begin
      item := item + 1;
      RDprint.ImpVal(linha, 01, '###0', item, []);
      RDprint.Imp(linha, 06, F_Dados.Q_DNCDescricao.AsString);
      inc(linha);
      RDprint.Imp(linha, 01, F_Dados.Q_DNCCodigo.AsString);
      RDprint.ImpVal(linha, 15, '###0', F_Dados.Q_DNCQuantidade.Value, []);
      inc(linha);
      RDprint.Imp(linha, 01, '*');
      F_Dados.Q_DNC.Next;
      inc(linha);
      continue;
    end;
    RDprint.Imp(linha + 00, 01, '');
    RDprint.Imp(linha + 01, 01, '====================================================');
    RDprint.Imp(linha + 02, 01, 'Vale a presente Nota de Credito ao portador para ser');
    RDprint.Imp(linha + 03, 01, 'retirado em nossa loja em qualquer tempo, os livros');
    RDprint.Imp(linha + 04, 01, 'acima relacionados.');
    RDprint.Imp(linha + 05, 01, '====================================================');
    RDprint.Imp(linha + 08, 01, '               Cidade, ' + DateToStr(date));
    RDprint.Imp(linha + 12, 01, F_Dados.NomeEmpresa);
    RDprint.Imp(linha + 13, 01, '----------------------------------------------------');
    terminaminuta;
  end
  else begin
    Application.MessageBox('É Necessário Inserir o Nome do Cliente!!!', 'Atenção!!!', Mb_IconError);
    Edit15.SetFocus;
    pronto;
  end;
end;

Procedure TF_Soma.iniciaminuta;
var
  item, nc: Integer;
begin
  relatorio := 'bobina';
  aguarde;
  item := 0;
  nc := 0;

  RDprint.TamanhoQteLinhas := 1; // Linhas (deve ser 1 quando for CUPOM)
  RDprint.TamanhoQteColunas := 55; // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
  RDprint.FonteTamanhoPadrao := s20cpp; // Fonte Comprimido em 20 cpp
  // RDPrint.OpcoesPreview.Preview := false;

  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 01;

  RDprint.Imp(linha + 01, 01, '****************************************************');
  RDprint.Imp(linha + 02, 01, F_Dados.NomeEmpresa);
  RDprint.Imp(linha + 03, 01, '****************************************************');
  RDprint.Imp(linha + 05, 01, '*********  MINUTA DE VENDA No  ' + Edit1.text + '  *********');
  RDprint.Imp(linha + 07, 01, '****************************************************');
  RDprint.Imp(linha + 08, 01, '********  NAO VALE COMO COMPROVANTE FISCAL  ********');
  RDprint.Imp(linha + 09, 01, '****************************************************');
  RDprint.Imp(linha + 10, 01, 'DATA: ' + DATA.caption);
  RDprint.Imp(linha + 10, 38, 'HORA: ' + HORA.caption);
  RDprint.Imp(linha + 11, 01, '----------------------------------------------------');
  //
  MyConsulta(F_Dados.Q_Rap, 'select nome from funcionario where id=' + chr(39) + Edit2.text + chr(39));
  RDprint.Imp(linha + 12, 01, 'SOMADOR...: ' + Edit2.text + ' / ' + F_Dados.Q_Rap.FieldByName('Nome').AsString);
  //
  MyConsulta(F_Dados.Q_Rap, 'select nome from funcionario where id=' + chr(39) + Edit5.text + chr(39));
  RDprint.Imp(linha + 13, 01, 'VENDEDOR..: ' + Edit5.text + ' / ' + F_Dados.Q_Rap.FieldByName('Nome').AsString);
  //
  RDprint.Imp(linha + 14, 01, '----------------------------------------------------');
  RDprint.Imp(linha + 15, 01, 'ITEM   DESCRICAO');
  RDprint.Imp(linha + 16, 01, 'UNIDADE   QUANTIDADE    UNITARIO (R$)     TOTAL (R$)');
  RDprint.Imp(linha + 17, 01, '----------------------------------------------------');
  //
  F_Dados.cds_DSoma.DisableControls;
  F_Dados.cds_DSoma.First;
  linha := linha + 18;
  while not F_Dados.cds_DSoma.EOF do begin
    item := item + 1;

    RDprint.ImpVal(linha, 01, '###0', item, []);
    RDprint.Imp(linha, 07, F_Dados.cds_DSomaDescricao.AsString);
    inc(linha);
    RDprint.Imp(linha, 01, F_Dados.CDS_DSomaUnidade.AsString);
    RDprint.ImpVal(linha, 14, '##,##0', F_Dados.cds_DSomaQuantidade.Value, []);
    RDprint.ImpVal(linha, 28, '##,##0.00', F_Dados.cds_DSomavalor_unitario.Value, []);
    RDprint.ImpVal(linha, 43, '##,##0.00', F_Dados.cds_DSomavalor_total.Value, []);

    inc(linha);
    if F_Dados.CDS_DSomanota_credito.AsString = 'X' then begin
      nc := 1;
      RDprint.Imp(linha, 01, '* NC *');
    end
    else
      RDprint.Imp(linha, 01, '*');
    F_Dados.cds_DSoma.Next;
    inc(linha);
    continue;
  end;

  RDprint.Imp(linha + 00, 01, '----------------------------------------------------');
  RDprint.Imp(linha + 01, 01, 'TOTAL DA VENDA (R$):');
  RDprint.ImpVal(linha + 01, 43, '##,##0.00', StrToFloat(EditNum2.text), []);
  RDprint.Imp(linha + 02, 01, '====================================================');
  RDprint.Imp(linha + 03, 01, 'POR FAVOR, CONFIRA OS ITENS ANTES DE IR PARA O CAIXA');
  RDprint.Imp(linha + 04, 01, '====================================================');

  if nc = 1 then
  begin
    RDprint.Imp(linha + 06, 01, '----------------------------------------------------');
    nc := 0;
  end;

  linha := linha + 07;
end;

Procedure TF_Soma.terminaminuta;
begin
  RDprint.Imp(linha + 01, 01, '');
  linha := linha + 15;
  RDprint.Imp(linha, 01, '');

  if RDprint.OpcoesPreview.Preview then
    RDprint.TamanhoQteLinhas := linha;

  RDprint.Fechar;
  F_Dados.cds_DSoma.EnableControls;
  //
  Edit15.Clear;
  Edit16.Clear;
  Edit17.Clear;
  MaskEdit7.Clear;
  MaskEdit8.Clear;
  F_Dados.Q_CNC.Close;
  F_Dados.Q_DNC.Close;
  Panel4.Visible := False;
  pronto;
  BitBtn4.Click;
end;

procedure TF_Soma.NovaPagina;
begin
  if linha > 63 then
    RDprint.NovaPagina;
end;

procedure TF_Soma.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

end.
