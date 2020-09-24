unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls, ImgList, XPMan,
  JvExControls, JvComponent, JvPageList, JvTabBar, RibbonLunaStyleActnCtrls,
  Ribbon, ToolWin, ActnMan, ActnCtrls, ActnList, RibbonSilverStyleActnCtrls,
  JvExComCtrls, JvStatusBar, ActnMenus, RibbonActnMenus, JvOutlookBar, JvLookOut,
  ScreenTips, WideStrings, DB, UBase, JvComponentBase, Enter,
  rpgraphicex, jpeg;

type
  TFMenu = class(TFBase)
    Image16: TImageList;
    PopupMenu: TPopupMenu;
    menuFechar: TMenuItem;
    menuFecharTodasExcetoEssa: TMenuItem;
    menuSepararAba: TMenuItem;
    N2: TMenuItem;
    JvTabBar: TJvTabBar;
    JvModernTabBarPainter: TJvModernTabBarPainter;
    JvPageList: TJvPageList;
    Ribbon: TRibbon;
    RibbonPageCadastros: TRibbonPage;
    RibbonGrupoGeral: TRibbonGroup;
    ActionManager: TActionManager;
    LinhaStatus: TJvStatusBar;
    Image48: TImageList;
    ActionCliente: TAction;
    ActionFornecedor: TAction;
    ActionColaborador: TAction;
    Image32: TImageList;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    ActionCargo: TAction;
    ActionTipoColaborador: TAction;
    ActionNivelFormacaoColaborador: TAction;
    ActionProduto: TAction;
    ActionMarca: TAction;
    ActionNCM: TAction;
    ActionUnidade: TAction;
    ActionBanco: TAction;
    ActionOrcamento: TAction;
    ActionSetor: TAction;
    ScreenTipsManager1: TScreenTipsManager;
    ActionSair: TAction;
    ActionTrocarUsuario: TAction;
    ActionNivelAcesso: TAction;
    User: TLabel;
    Senha: TLabel;
    TipoAcesso: TLabel;
    MREnter1: TMREnter;
    ActionLivro: TAction;
    Image1: TImage;
    ActionEscolaParticular: TAction;
    ActionMaterial: TAction;
    RibbonPage1: TRibbonPage;
    RibbonGroup1: TRibbonGroup;
    ActionOutrosPagamentos: TAction;
    ActionAjustePrecos: TAction;
    ActionCentroCusto: TAction;
    ActionConfirmaPagamentos: TAction;
    ActionEntradaNotaFiscal: TAction;
    ActionNotaCredito: TAction;
    ActionConsultaPreco: TAction;
    ActionLancamentoPagar: TAction;
    ActionReceber: TAction;
    RibbonGroup3: TRibbonGroup;
    Codigo: TLabel;
    ActionSoma: TAction;
    RibbonGroup4: TRibbonGroup;
    RibbonGroup5: TRibbonGroup;
    RibbonGroup6: TRibbonGroup;
    procedure menuFecharClick(Sender: TObject);
    procedure menuFecharTodasExcetoEssaClick(Sender: TObject);
    procedure menuSepararAbaClick(Sender: TObject);
    procedure JvPageListChange(Sender: TObject);
    procedure JvTabBarTabClosing(Sender: TObject; Item: TJvTabBarItem; var AllowClose: Boolean);
    procedure ActionClienteExecute(Sender: TObject);
    procedure ActionFornecedorExecute(Sender: TObject);
    procedure ActionColaboradorExecute(Sender: TObject);
    procedure ActionUnidadeExecute(Sender: TObject);
    procedure ActionBancoExecute(Sender: TObject);
    procedure ActionOrcamentoExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ActionTrocarUsuarioExecute(Sender: TObject);
    procedure JvTabBarTabMoved(Sender: TObject; Item: TJvTabBarItem);
    procedure JvTabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure FormPaint(Sender: TObject);
    procedure ActionLivroExecute(Sender: TObject);
    procedure ActionEscolaParticularExecute(Sender: TObject);
    procedure ActionMaterialExecute(Sender: TObject);
    procedure ActionOutrosPagamentosExecute(Sender: TObject);
    procedure ActionAjustePrecosExecute(Sender: TObject);
    procedure ActionProdutoExecute(Sender: TObject);
    procedure ActionCentroCustoExecute(Sender: TObject);
    procedure ActionConfirmaPagamentosExecute(Sender: TObject);
    procedure ActionEntradaNotaFiscalExecute(Sender: TObject);
    procedure ActionLancamentoPagarExecute(Sender: TObject);
    procedure ActionReceberExecute(Sender: TObject);
    procedure ActionSetorExecute(Sender: TObject);
    procedure ActionSomaExecute(Sender: TObject);
    procedure ActionConsultaPrecoExecute(Sender: TObject);
    procedure ActionNotaCreditoExecute(Sender: TObject);
    procedure ActionNivelAcessoExecute(Sender: TObject);
  private
    function doLogin: Boolean;

    function PodeAbrirFormulario(ClasseForm: TFormClass; var Pagina: TJvCustomPage): Boolean;
    function TotalFormsAbertos(ClasseForm: TFormClass): Integer;
    procedure AjustarCaptionAbas(ClasseForm: TFormClass);
    function ObterAba(Pagina: TJvCustomPage): TJvTabBarItem;
    function ObterPagina(Aba: TJvTabBarItem): TJvCustomPage;

    procedure ShowHint(Sender: TObject);
  public
    procedure NovaPagina(ClasseForm: TFormClass; IndiceImagem: Integer);
    function FecharPagina(Pagina: TJvCustomPage): Boolean; overload;
    function FecharPagina(Pagina: TJvCustomPage; TodasExcetoEssa: Boolean): Boolean; overload;
    function FecharPaginas: Boolean;
    procedure SepararAba(Pagina: TJvCustomPage);

  end;

var
  FMenu: TFMenu;
  FormAtivo: String;
  Logado: Boolean;

implementation

uses ULogin, U_Dados, U_Clientes, U_Fornecedores, U_Funcionarios, U_Unidades,
  U_Livros, U_Produtos, U_Particulares, U_Bancos, U_Departamentos, U_NivelAcesso,
  //
  U_Orcamento, U_Precos, U_Soma, U_NC,
  //
  U_Contas, U_DadosNF, U_Outros, U_Cheques, U_aReceber,
  //
  U_NFEntrada, U_Ajusta;
{$R *.dfm}

var
  IdxTabSelected: Integer = -1;
  { TFMenu }

{$REGION 'Infra'}
procedure TFMenu.NovaPagina(ClasseForm: TFormClass; IndiceImagem: Integer);
var
  Aba: TJvTabBarItem;
  Pagina: TJvCustomPage;
  Form: TForm;
begin

  // verifica se pode abrir o form
  if not PodeAbrirFormulario(ClasseForm, Pagina) then
  begin
    JvPageList.ActivePage := Pagina;
    Exit;
  end;

  // cria uma nova aba
  Aba := JvTabBar.AddTab('');

  // instancia uma página padrão
  Pagina := TJvStandardPage.Create(Self);

  // seta a PageList da nova página para aquela que já está no form principal
  Pagina.PageList := JvPageList;

  // cria um form passando a página para o seu construtor, que recebe um TComponent
  Form := ClasseForm.Create(Pagina);

  // Propriedades do Form
  with Form do
  begin
    Align := alClient;
    BorderStyle := bsNone;
    Parent := Pagina;
  end;

  // Propriedades da Aba
  with Aba do
  begin
    Caption := Form.Caption;
    ImageIndex := IndiceImagem;
    PopupMenu := Self.PopupMenu;
  end;

  // ajusta o título (caption) das abas
  AjustarCaptionAbas(ClasseForm);

  // ativa a página
  JvPageList.ActivePage := Pagina;

  FormAtivo := Form.Name;

  // exibe o formulário
  Form.Show;
end;

function TFMenu.PodeAbrirFormulario(ClasseForm: TFormClass; var Pagina: TJvCustomPage): Boolean;
var
  I: Integer;
begin
  Result := True;
  // varre a JvPageList para saber se já existe um Form aberto
  for I := 0 to JvPageList.PageCount - 1 do
    // se achou um form
    if JvPageList.Pages[I].Components[0].ClassType = ClasseForm then
    begin
      Pagina := JvPageList.Pages[I];
      // permite abrir o form novamente caso a Tag tenha o valor zero
      Result := (Pagina.Components[0] as TForm).Tag = 0;
      Break;
    end;
end;

// verifica o total de formulários abertos
function TFMenu.TotalFormsAbertos(ClasseForm: TFormClass): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to JvPageList.PageCount - 1 do
  begin
    if JvPageList.Pages[I].Components[0].ClassType = ClasseForm then
      Inc(Result);
  end;
end;

// ajusta o título (caption) das abas
procedure TFMenu.AjustarCaptionAbas(ClasseForm: TFormClass);
var
  I, Indice, TotalForms: Integer;
  NovoCaption: string;
begin
  TotalForms := TotalFormsAbertos(ClasseForm);

  if TotalForms > 1 then
  begin
    Indice := 1;
    for I := 0 to JvPageList.PageCount - 1 do
    begin
      with JvPageList do
      begin
        if Pages[I].Components[0].ClassType = ClasseForm then
        begin
          NovoCaption := (Pages[I].Components[0] as TForm).Caption + ' (' + IntToStr(Indice) + ')'; (Pages[I] as TJvStandardPage)
          .Caption := NovoCaption;
          ObterAba(Pages[I]).Caption := NovoCaption;
          Inc(Indice);
        end;
      end;
    end;
  end;
end;

function TFMenu.doLogin: Boolean;
var
  FormLogin: TFLogin;
begin
  if not Logado then
  begin
    FormLogin := TFLogin.Create(Self);
    try
      FormLogin.ShowModal;
      Result := True;
    finally
      FormLogin.Free;
    end;
  end;
end;

// controla o fechamento da página
function TFMenu.FecharPagina(Pagina: TJvCustomPage): Boolean;
var
  Form: TForm;
  PaginaEsquerda: TJvCustomPage;
begin
  PaginaEsquerda := nil;
  Form := Pagina.Components[0] as TForm;

  Result := Form.CloseQuery;

  if Result then
  begin
    if Pagina.PageIndex > 0 then
    begin
      PaginaEsquerda := JvPageList.Pages[Pagina.PageIndex - 1];
    end;

    Form.Close;
    ObterAba(Pagina).Free;
    Pagina.Free;

    JvPageList.ActivePage := PaginaEsquerda;
  end;
end;

// controla o fechamento da página - todas exceto a selecionada
function TFMenu.FecharPagina(Pagina: TJvCustomPage; TodasExcetoEssa: Boolean): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := JvPageList.PageCount - 1 downto 0 do
    if JvPageList.Pages[I] <> Pagina then
    begin
      Result := FecharPagina(JvPageList.Pages[I]);
      if not Result then
        Exit;
    end;
end;

function TFMenu.FecharPaginas: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := JvPageList.PageCount - 1 downto 0 do
  begin
    Result := FecharPagina(JvPageList.Pages[I]);
    if not Result then
      Exit;
  end;
end;

procedure TFMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Sair?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Application.Run;
  FecharPaginas;
end;

procedure TFMenu.FormCreate(Sender: TObject);
begin
  Self.WindowState := wsMaximized;
  Application.OnHint := ShowHint;
  Logado := False;
end;

procedure TFMenu.FormPaint(Sender: TObject);
begin
  if not doLogin then
    Application.Terminate;
  Logado := True;
end;

procedure TFMenu.ShowHint(Sender: TObject);
begin
  LinhaStatus.Panels.Items[1].Text := Application.hint;
end;

// separa a aba (formulário)
procedure TFMenu.SepararAba(Pagina: TJvCustomPage);
begin
  with Pagina.Components[0] as TForm do
  begin
    Align := alNone;
    BorderStyle := bsSizeable;
    Parent := nil;
  end;
  ObterAba(Pagina).Visible := False;
end;

function TFMenu.ObterAba(Pagina: TJvCustomPage): TJvTabBarItem;
var
  Form: TForm;
begin
  Result := nil;

  Form := Pagina.Components[0] as TForm;

  FormAtivo := Form.Name;

  if Assigned(Pagina) then
    Result := JvTabBar.Tabs[Pagina.PageIndex];
end;

procedure TFMenu.JvPageListChange(Sender: TObject);
begin
  ObterAba(JvPageList.ActivePage).Selected := True;
end;

procedure TFMenu.JvTabBarTabClosing(Sender: TObject; Item: TJvTabBarItem; var AllowClose: Boolean);
begin
  AllowClose := FecharPagina(ObterPagina(Item));
end;

procedure TFMenu.JvTabBarTabMoved(Sender: TObject; Item: TJvTabBarItem);
begin
  if IdxTabSelected >= 0 then
  begin
    JvPageList.Pages[IdxTabSelected].PageIndex := Item.Index;
  end;
end;

procedure TFMenu.JvTabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
begin
  if Assigned(Item) then
    IdxTabSelected := Item.Index
  else
    IdxTabSelected := -1;
end;

function TFMenu.ObterPagina(Aba: TJvTabBarItem): TJvCustomPage;
begin
  Result := JvPageList.Pages[Aba.Index];
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFMenu.ActionClienteExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSClientes"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Clientes, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Clientes, (Sender as TAction).ImageIndex);
  end;
end;

procedure TFMenu.ActionFornecedorExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSFornecedores"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Fornecedores, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Fornecedores, (Sender as TAction).ImageIndex);
  end;
end;

procedure TFMenu.ActionBancoExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSBancos"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Bancos, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Bancos, (Sender as TAction).ImageIndex);
  end;
end;

procedure TFMenu.ActionColaboradorExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSFuncionários"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Funcionarios, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Funcionarios, (Sender as TAction).ImageIndex);
  end;
end;

procedure TFMenu.ActionEscolaParticularExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSEscolas"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Particulares, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Particulares, (Sender as TAction).ImageIndex);
  end;
end;

procedure TFMenu.ActionMaterialExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSProdutosMateriais"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Produtos, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Produtos, (Sender as TAction).ImageIndex);
  end;
end;

procedure TFMenu.ActionLivroExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSProdutosLivros"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Livros, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Livros, (Sender as TAction).ImageIndex);
  end;
end;

procedure TFMenu.ActionNivelAcessoExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active:=false;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.SQL.add('select * from nivel_acesso where modulo = "CADASTROSSistema de SegurançaDefinir Nível de Acesso"');
    F_Dados.Q_Nivel.SQL.add('and nick = '+#39+User.Caption+#39);
    F_Dados.Q_Nivel.Active:=true;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then
    begin
      Application.CreateForm(TF_NivelAcesso, F_NivelAcesso);
      F_NivelAcesso.ShowModal;
    end
    else begin
       Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo','Sistema de Segurança',mb_Ok+mb_IconError);
    end;
  end
  else
  begin
    Application.CreateForm(TF_NivelAcesso, F_NivelAcesso);
    F_NivelAcesso.ShowModal;
  end;
end;

procedure TFMenu.ActionSetorExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSDepartamentos"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Departamentos, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Departamentos, (Sender as TAction).ImageIndex);
  end;
end;

procedure TFMenu.ActionUnidadeExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "CADASTROSProdutosUnidades"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      NovaPagina(TF_Unidades, (Sender as TAction).ImageIndex);
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    NovaPagina(TF_Unidades, (Sender as TAction).ImageIndex);
  end;
end;

//

procedure TFMenu.ActionNotaCreditoExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "BALCAONota de Crédito"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_NC, F_NC);
      F_NC.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_NC, F_NC);
    F_NC.ShowModal;
  end;
end;

procedure TFMenu.ActionOrcamentoExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "BALCAOOrçamento"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_Orcamento, F_Orcamento);
      F_Orcamento.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_Orcamento, F_Orcamento);
    F_Orcamento.ShowModal;
  end;
end;

procedure TFMenu.ActionConsultaPrecoExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "BALCAOVisualiza Preços"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_Precos, F_Precos);
      F_Precos.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_Precos, F_Precos);
    F_Precos.ShowModal;
  end;
end;

procedure TFMenu.ActionSomaExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "BALCAOSoma"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_Soma, F_Soma);
      F_Soma.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_Soma, F_Soma);
    F_Soma.ShowModal;
  end;
end;

//

procedure TFMenu.ActionEntradaNotaFiscalExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "ESTOQUEEntrada de Nota"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_NFEntrada, F_NFEntrada);
      F_NFEntrada.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_NFEntrada, F_NFEntrada);
    F_NFEntrada.ShowModal;
  end;
end;

procedure TFMenu.ActionAjustePrecosExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "ESTOQUEReajuste de Preços"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_Ajusta, F_Ajusta);
      F_Ajusta.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_Ajusta, F_Ajusta);
    F_Ajusta.ShowModal;
  end;
end;

//

procedure TFMenu.ActionCentroCustoExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "FINANCEIROCadastro das Contas"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_Contas, F_Contas);
      F_Contas.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_Contas, F_Contas);
    F_Contas.ShowModal;
  end;
end;

procedure TFMenu.ActionConfirmaPagamentosExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "FINANCEIROEmissão de Cheques"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_Cheques, F_Cheques);
      F_Cheques.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_Cheques, F_Cheques);
    F_Cheques.ShowModal;
  end;
end;

procedure TFMenu.ActionOutrosPagamentosExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "FINANCEIROOutros Pagamentos"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_Outros, F_Outros);
      F_Outros.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_Outros, F_Outros);
    F_Outros.ShowModal;
  end;
end;

procedure TFMenu.ActionLancamentoPagarExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "FINANCEIRODados da Nota"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_DadosNF, F_DadosNF);
      F_DadosNF.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_DadosNF, F_DadosNF);
    F_DadosNF.ShowModal;
  end;
end;

procedure TFMenu.ActionReceberExecute(Sender: TObject);
begin
  if TipoAcesso.Caption <> 'S' then begin
    F_Dados.Q_Nivel.Active := False;
    F_Dados.Q_Nivel.Sql.clear;
    F_Dados.Q_Nivel.Sql.add('select * from nivel_acesso where modulo = "FINANCEIROControle de Contas a Receber"');
    F_Dados.Q_Nivel.Sql.add('and nick = ' + #39 + User.Caption + #39);
    F_Dados.Q_Nivel.Active := True;
    If F_Dados.Q_Nivel.FieldByName('Modulo').AsString <> '' then begin
      Application.CreateForm(TF_aReceber, F_aReceber);
      F_aReceber.ShowModal;
    end
    else begin
      Application.MessageBox('Você Não Tem o Nível de Acesso Necessário Para Esse Módulo', 'Sistema de Segurança', mb_Ok + mb_IconError);
    end;
  end
  else begin
    Application.CreateForm(TF_aReceber, F_aReceber);
    F_aReceber.ShowModal;
  end;
end;

procedure TFMenu.ActionSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMenu.ActionProdutoExecute(Sender: TObject);
begin
  //
end;

procedure TFMenu.ActionTrocarUsuarioExecute(Sender: TObject);
begin
  Senha.Caption := 'Senha';
  Logado := False;
  doLogin;
end;
{$ENDREGION}

{$REGION 'PopupMenu'}
procedure TFMenu.menuFecharClick(Sender: TObject);
begin
  FecharPagina(JvPageList.ActivePage);
end;

procedure TFMenu.menuFecharTodasExcetoEssaClick(Sender: TObject);
begin
  FecharPagina(JvPageList.ActivePage, True);
end;

procedure TFMenu.menuSepararAbaClick(Sender: TObject);
begin
  SepararAba(JvPageList.ActivePage);
end;
{$ENDREGION}

end.
