object F_Dados: TF_Dados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 323
  Top = 172
  Height = 528
  Width = 1041
  object CDS_Fornecedor: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'razao'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'fantasia'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'endereco'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'estado'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'fone'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'fax'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'celular'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'contato'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cnpj'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'inscricao_estadual'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Fornecedor'
    StoreDefs = True
    Left = 216
    Top = 160
    object CDS_Fornecedorid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Fornecedorrazao: TStringField
      FieldName = 'razao'
      Size = 100
    end
    object CDS_Fornecedorfantasia: TStringField
      FieldName = 'fantasia'
      Size = 100
    end
    object CDS_Fornecedorendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object CDS_Fornecedorbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object CDS_Fornecedorcep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object CDS_Fornecedorcidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object CDS_Fornecedorestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object CDS_Fornecedorfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object CDS_Fornecedorfax: TStringField
      FieldName = 'fax'
      Size = 13
    end
    object CDS_Fornecedorcelular: TStringField
      FieldName = 'celular'
      Size = 13
    end
    object CDS_Fornecedorcontato: TStringField
      FieldName = 'contato'
      Size = 50
    end
    object CDS_Fornecedorcnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object CDS_Fornecedorinscricao_estadual: TStringField
      FieldName = 'inscricao_estadual'
      Size = 50
    end
    object CDS_Fornecedorauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DS_Fornecedor: TDataSource
    DataSet = CDS_Fornecedor
    Left = 216
    Top = 208
  end
  object SaveDialog: TSaveDialog
    Left = 328
    Top = 8
  end
  object OpenDialog: TOpenDialog
    Left = 256
    Top = 8
  end
  object Conexao: TSQLConnection
    ConnectionName = 'MYSQLCONNECTION'
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'dbxmys.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MySQL'
      'HostName=localhost'
      'Database=livraria'
      'User_Name=root'
      'Password=root'
      'ConnectTimeout=60')
    VendorLib = 'libmysql.dll'
    Connected = True
    Left = 16
    Top = 8
  end
  object Q_Fornecedor: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from fornecedor limit 0')
    SQLConnection = Conexao
    Left = 216
    Top = 64
    object Q_Fornecedorid: TIntegerField
      FieldName = 'id'
    end
    object Q_Fornecedorrazao: TStringField
      FieldName = 'razao'
      Size = 100
    end
    object Q_Fornecedorfantasia: TStringField
      FieldName = 'fantasia'
      Size = 100
    end
    object Q_Fornecedorendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object Q_Fornecedorbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object Q_Fornecedorcep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object Q_Fornecedorcidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object Q_Fornecedorestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object Q_Fornecedorfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object Q_Fornecedorfax: TStringField
      FieldName = 'fax'
      Size = 13
    end
    object Q_Fornecedorcelular: TStringField
      FieldName = 'celular'
      Size = 13
    end
    object Q_Fornecedorcontato: TStringField
      FieldName = 'contato'
      Size = 50
    end
    object Q_Fornecedorcnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object Q_Fornecedorinscricao_estadual: TStringField
      FieldName = 'inscricao_estadual'
      Size = 50
    end
    object Q_Fornecedorauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_Fornecedor: TDataSetProvider
    DataSet = Q_Fornecedor
    Left = 216
    Top = 112
  end
  object CDS_Nivel: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'modulo'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'nick'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Nivel'
    StoreDefs = True
    Left = 968
    Top = 368
    object CDS_Nivelmodulo: TStringField
      FieldName = 'modulo'
      Size = 255
    end
    object CDS_Nivelnick: TStringField
      FieldName = 'nick'
      Size = 10
    end
  end
  object DS_Nivel: TDataSource
    DataSet = CDS_Nivel
    Left = 968
    Top = 416
  end
  object Q_Nivel: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from nivelacesso limit 0')
    SQLConnection = Conexao
    Left = 968
    Top = 272
    object Q_Nivelmodulo: TStringField
      FieldName = 'modulo'
      Size = 255
    end
    object Q_Nivelnick: TStringField
      FieldName = 'nick'
      Size = 10
    end
  end
  object DSP_Nivel: TDataSetProvider
    DataSet = Q_Nivel
    Left = 968
    Top = 320
  end
  object CDS_Funcionarios: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'id_departamento'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cpf'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'comissao'
        DataType = ftFloat
      end
      item
        Name = 'endereco'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'fone'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'celular'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'estado'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'tipo'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'nick'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'senha'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'acesso'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Funcionarios'
    StoreDefs = True
    Left = 120
    Top = 160
    object CDS_Funcionariosid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Funcionariosid_departamento: TIntegerField
      FieldName = 'id_departamento'
      Required = True
    end
    object CDS_Funcionariosnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object CDS_Funcionarioscpf: TStringField
      FieldName = 'cpf'
      Size = 11
    end
    object CDS_Funcionarioscomissao: TFloatField
      FieldName = 'comissao'
    end
    object CDS_Funcionariosendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object CDS_Funcionariosbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object CDS_Funcionarioscep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object CDS_Funcionariosfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object CDS_Funcionarioscelular: TStringField
      FieldName = 'celular'
      Size = 13
    end
    object CDS_Funcionarioscidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object CDS_Funcionariosestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object CDS_Funcionariostipo: TStringField
      FieldName = 'tipo'
      FixedChar = True
      Size = 1
    end
    object CDS_Funcionariosnick: TStringField
      FieldName = 'nick'
      Size = 10
    end
    object CDS_Funcionariossenha: TStringField
      FieldName = 'senha'
      Size = 10
    end
    object CDS_Funcionariosacesso: TStringField
      FieldName = 'acesso'
      FixedChar = True
      Size = 1
    end
    object CDS_Funcionariosauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DS_Funcionarios: TDataSource
    DataSet = CDS_Funcionarios
    Left = 120
    Top = 208
  end
  object Q_Funcionarios: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from funcionario limit 0')
    SQLConnection = Conexao
    Left = 120
    Top = 64
    object Q_Funcionariosid: TIntegerField
      FieldName = 'id'
    end
    object Q_Funcionariosid_departamento: TIntegerField
      FieldName = 'id_departamento'
      Required = True
    end
    object Q_Funcionariosnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object Q_Funcionarioscpf: TStringField
      FieldName = 'cpf'
      Size = 11
    end
    object Q_Funcionarioscomissao: TFloatField
      FieldName = 'comissao'
    end
    object Q_Funcionariosendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object Q_Funcionariosbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object Q_Funcionarioscep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object Q_Funcionariosfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object Q_Funcionarioscelular: TStringField
      FieldName = 'celular'
      Size = 13
    end
    object Q_Funcionarioscidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object Q_Funcionariosestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object Q_Funcionariostipo: TStringField
      FieldName = 'tipo'
      FixedChar = True
      Size = 1
    end
    object Q_Funcionariosnick: TStringField
      FieldName = 'nick'
      Size = 10
    end
    object Q_Funcionariossenha: TStringField
      FieldName = 'senha'
      Size = 10
    end
    object Q_Funcionariosacesso: TStringField
      FieldName = 'acesso'
      FixedChar = True
      Size = 1
    end
    object Q_Funcionariosauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_Funcionarios: TDataSetProvider
    DataSet = Q_Funcionarios
    Left = 120
    Top = 112
  end
  object CDS_Bancos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'cc'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'banco'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'agencia'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'endereco'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'estado'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'fone'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'fax'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'gerente'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Bancos'
    StoreDefs = True
    Left = 608
    Top = 160
    object CDS_Bancosid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Bancoscc: TStringField
      FieldName = 'cc'
      Size = 15
    end
    object CDS_Bancosbanco: TStringField
      FieldName = 'banco'
      Size = 30
    end
    object CDS_Bancosagencia: TStringField
      FieldName = 'agencia'
      Size = 15
    end
    object CDS_Bancosendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object CDS_Bancoscidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object CDS_Bancosestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object CDS_Bancoscep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object CDS_Bancosfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object CDS_Bancosfax: TStringField
      FieldName = 'fax'
      Size = 13
    end
    object CDS_Bancosgerente: TStringField
      FieldName = 'gerente'
      Size = 50
    end
    object CDS_Bancosbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object CDS_Bancosauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DS_Bancos: TDataSource
    DataSet = CDS_Bancos
    Left = 608
    Top = 208
  end
  object Q_Bancos: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from banco limit 0')
    SQLConnection = Conexao
    Left = 608
    Top = 64
    object Q_Bancosid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_Bancoscc: TStringField
      FieldName = 'cc'
      Size = 15
    end
    object Q_Bancosbanco: TStringField
      FieldName = 'banco'
      Size = 30
    end
    object Q_Bancosagencia: TStringField
      FieldName = 'agencia'
      Size = 15
    end
    object Q_Bancosendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object Q_Bancoscidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object Q_Bancosestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object Q_Bancoscep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object Q_Bancosfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object Q_Bancosfax: TStringField
      FieldName = 'fax'
      Size = 13
    end
    object Q_Bancosgerente: TStringField
      FieldName = 'gerente'
      Size = 50
    end
    object Q_Bancosbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object Q_Bancosauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_Bancos: TDataSetProvider
    DataSet = Q_Bancos
    Left = 608
    Top = 112
  end
  object CDS_Unidade: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Unidade'
    StoreDefs = True
    AfterPost = CDS_UnidadeAfterPost
    Left = 304
    Top = 160
    object CDS_Unidadeid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Unidadedescricao: TStringField
      FieldName = 'descricao'
      Size = 10
    end
  end
  object DS_Unidade: TDataSource
    DataSet = CDS_Unidade
    Left = 304
    Top = 208
  end
  object Q_Unidade: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from unidade'
      'order by id')
    SQLConnection = Conexao
    Left = 304
    Top = 64
    object Q_Unidadeid: TIntegerField
      FieldName = 'id'
    end
    object Q_Unidadedescricao: TStringField
      FieldName = 'descricao'
      Size = 10
    end
  end
  object DSP_Unidade: TDataSetProvider
    DataSet = Q_Unidade
    Left = 304
    Top = 112
  end
  object CDS_Clientes: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'endereco'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'estado'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'fone'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'fax'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'celular'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'cpf'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'obs'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'mae'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'rg'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'orgao'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'nascimento'
        DataType = ftDate
      end
      item
        Name = 'desde'
        DataType = ftDate
      end
      item
        Name = 'cnpj'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'sexo'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'profissao'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'empresa'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'fone_empresa'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'renda'
        DataType = ftFloat
      end
      item
        Name = 'ref1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ref2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'fone_ref1'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'fone_ref2'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'data_cadastro'
        DataType = ftDate
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Clientes'
    StoreDefs = True
    Left = 32
    Top = 160
    object CDS_Clientesid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Clientesnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object CDS_Clientesendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object CDS_Clientesbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object CDS_Clientescep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object CDS_Clientescidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object CDS_Clientesestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object CDS_Clientesfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object CDS_Clientesfax: TStringField
      FieldName = 'fax'
      Size = 13
    end
    object CDS_Clientescelular: TStringField
      FieldName = 'celular'
      Size = 13
    end
    object CDS_Clientescpf: TStringField
      FieldName = 'cpf'
      Size = 11
    end
    object CDS_Clientesobs: TStringField
      FieldName = 'obs'
      Size = 255
    end
    object CDS_Clientesmae: TStringField
      FieldName = 'mae'
      Size = 100
    end
    object CDS_Clientesrg: TStringField
      FieldName = 'rg'
      Size = 50
    end
    object CDS_Clientesorgao: TStringField
      FieldName = 'orgao'
      Size = 10
    end
    object CDS_Clientesnascimento: TDateField
      FieldName = 'nascimento'
    end
    object CDS_Clientesdesde: TDateField
      FieldName = 'desde'
    end
    object CDS_Clientescnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object CDS_Clientessexo: TStringField
      FieldName = 'sexo'
      FixedChar = True
      Size = 1
    end
    object CDS_Clientesprofissao: TStringField
      FieldName = 'profissao'
      Size = 50
    end
    object CDS_Clientesempresa: TStringField
      FieldName = 'empresa'
      Size = 50
    end
    object CDS_Clientesfone_empresa: TStringField
      FieldName = 'fone_empresa'
      Size = 13
    end
    object CDS_Clientesrenda: TFloatField
      FieldName = 'renda'
    end
    object CDS_Clientesref1: TStringField
      FieldName = 'ref1'
      Size = 50
    end
    object CDS_Clientesref2: TStringField
      FieldName = 'ref2'
      Size = 50
    end
    object CDS_Clientesfone_ref1: TStringField
      FieldName = 'fone_ref1'
      Size = 13
    end
    object CDS_Clientesfone_ref2: TStringField
      FieldName = 'fone_ref2'
      Size = 13
    end
    object CDS_Clientesdata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object CDS_Clientesauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DS_Clientes: TDataSource
    DataSet = CDS_Clientes
    Left = 32
    Top = 208
  end
  object Q_Clientes: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from cliente limit 0')
    SQLConnection = Conexao
    Left = 32
    Top = 64
    object Q_Clientesid: TIntegerField
      FieldName = 'id'
    end
    object Q_Clientesnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object Q_Clientesendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object Q_Clientesbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object Q_Clientescep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object Q_Clientescidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object Q_Clientesestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object Q_Clientesfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object Q_Clientesfax: TStringField
      FieldName = 'fax'
      Size = 13
    end
    object Q_Clientescelular: TStringField
      FieldName = 'celular'
      Size = 13
    end
    object Q_Clientescpf: TStringField
      FieldName = 'cpf'
      Size = 11
    end
    object Q_Clientesobs: TStringField
      FieldName = 'obs'
      Size = 255
    end
    object Q_Clientesmae: TStringField
      FieldName = 'mae'
      Size = 100
    end
    object Q_Clientesrg: TStringField
      FieldName = 'rg'
      Size = 50
    end
    object Q_Clientesorgao: TStringField
      FieldName = 'orgao'
      Size = 10
    end
    object Q_Clientesnascimento: TDateField
      FieldName = 'nascimento'
    end
    object Q_Clientesdesde: TDateField
      FieldName = 'desde'
    end
    object Q_Clientescnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object Q_Clientessexo: TStringField
      FieldName = 'sexo'
      FixedChar = True
      Size = 1
    end
    object Q_Clientesprofissao: TStringField
      FieldName = 'profissao'
      Size = 50
    end
    object Q_Clientesempresa: TStringField
      FieldName = 'empresa'
      Size = 50
    end
    object Q_Clientesfone_empresa: TStringField
      FieldName = 'fone_empresa'
      Size = 13
    end
    object Q_Clientesrenda: TFloatField
      FieldName = 'renda'
    end
    object Q_Clientesref1: TStringField
      FieldName = 'ref1'
      Size = 50
    end
    object Q_Clientesref2: TStringField
      FieldName = 'ref2'
      Size = 50
    end
    object Q_Clientesfone_ref1: TStringField
      FieldName = 'fone_ref1'
      Size = 13
    end
    object Q_Clientesfone_ref2: TStringField
      FieldName = 'fone_ref2'
      Size = 13
    end
    object Q_Clientesdata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object Q_Clientesauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_Clientes: TDataSetProvider
    DataSet = Q_Clientes
    Left = 32
    Top = 112
  end
  object Q_Rap: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Conexao
    Left = 88
    Top = 8
  end
  object CDS_Livros: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_unidade'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'referencia'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'autor_marca'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'preco'
        DataType = ftFloat
      end
      item
        Name = 'estoque'
        DataType = ftInteger
      end
      item
        Name = 'livro_material'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'isbn'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'codigo_anterior'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'codigo_interno'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'descricao_pdv'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'totalizador_parcial'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'iat'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ippt'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ncm'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'tipo_item_sped'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'taxa_issqn'
        DataType = ftFloat
      end
      item
        Name = 'taxa_icms'
        DataType = ftFloat
      end
      item
        Name = 'cst'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'csosn'
        Attributes = [faFixed]
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ecf_icms_st'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'codigo_balanca'
        DataType = ftInteger
      end
      item
        Name = 'data_cadastro'
        DataType = ftDate
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Livros'
    StoreDefs = True
    AfterPost = CDS_LivrosAfterPost
    Left = 377
    Top = 160
    object CDS_Livrosid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Livrosid_unidade: TIntegerField
      FieldName = 'id_unidade'
      Required = True
    end
    object CDS_Livroscodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object CDS_Livrosdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CDS_Livrosreferencia: TStringField
      FieldName = 'referencia'
      Size = 8
    end
    object CDS_Livrosautor_marca: TStringField
      FieldName = 'autor_marca'
      Size = 15
    end
    object CDS_Livrospreco: TFloatField
      FieldName = 'preco'
    end
    object CDS_Livrosestoque: TIntegerField
      FieldName = 'estoque'
    end
    object CDS_Livroslivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object CDS_Livrosisbn: TStringField
      FieldName = 'isbn'
      Size = 15
    end
    object CDS_Livroscodigo_anterior: TStringField
      FieldName = 'codigo_anterior'
      Size = 13
    end
    object CDS_Livroscodigo_interno: TStringField
      FieldName = 'codigo_interno'
    end
    object CDS_Livrosnome: TStringField
      FieldName = 'nome'
      Size = 150
    end
    object CDS_Livrosdescricao_pdv: TStringField
      FieldName = 'descricao_pdv'
      Size = 30
    end
    object CDS_Livrostotalizador_parcial: TStringField
      FieldName = 'totalizador_parcial'
      Size = 10
    end
    object CDS_Livrosiat: TStringField
      FieldName = 'iat'
      FixedChar = True
      Size = 1
    end
    object CDS_Livrosippt: TStringField
      FieldName = 'ippt'
      FixedChar = True
      Size = 1
    end
    object CDS_Livrosncm: TStringField
      FieldName = 'ncm'
      Size = 8
    end
    object CDS_Livrostipo_item_sped: TStringField
      FieldName = 'tipo_item_sped'
      FixedChar = True
      Size = 2
    end
    object CDS_Livrostaxa_issqn: TFloatField
      FieldName = 'taxa_issqn'
    end
    object CDS_Livrostaxa_icms: TFloatField
      FieldName = 'taxa_icms'
    end
    object CDS_Livroscst: TStringField
      FieldName = 'cst'
      FixedChar = True
      Size = 3
    end
    object CDS_Livroscsosn: TStringField
      FieldName = 'csosn'
      FixedChar = True
      Size = 4
    end
    object CDS_Livrosecf_icms_st: TStringField
      FieldName = 'ecf_icms_st'
      Size = 4
    end
    object CDS_Livroscodigo_balanca: TIntegerField
      FieldName = 'codigo_balanca'
    end
    object CDS_Livrosdata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object CDS_Livrosauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DS_Livros: TDataSource
    DataSet = CDS_Livros
    Left = 377
    Top = 208
  end
  object Q_Livros: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from produto'
      'where livro_material='#39'L'#39
      'order by id,descricao')
    SQLConnection = Conexao
    Left = 377
    Top = 64
    object Q_Livrosid: TIntegerField
      FieldName = 'id'
    end
    object Q_Livrosid_unidade: TIntegerField
      FieldName = 'id_unidade'
      Required = True
    end
    object Q_Livroscodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object Q_Livrosdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object Q_Livrosreferencia: TStringField
      FieldName = 'referencia'
      Size = 8
    end
    object Q_Livrosautor_marca: TStringField
      FieldName = 'autor_marca'
      Size = 15
    end
    object Q_Livrospreco: TFloatField
      FieldName = 'preco'
    end
    object Q_Livrosestoque: TIntegerField
      FieldName = 'estoque'
    end
    object Q_Livroslivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object Q_Livrosisbn: TStringField
      FieldName = 'isbn'
      Size = 15
    end
    object Q_Livroscodigo_anterior: TStringField
      FieldName = 'codigo_anterior'
      Size = 13
    end
    object Q_Livroscodigo_interno: TStringField
      FieldName = 'codigo_interno'
    end
    object Q_Livrosnome: TStringField
      FieldName = 'nome'
      Size = 150
    end
    object Q_Livrosdescricao_pdv: TStringField
      FieldName = 'descricao_pdv'
      Size = 30
    end
    object Q_Livrostotalizador_parcial: TStringField
      FieldName = 'totalizador_parcial'
      Size = 10
    end
    object Q_Livrosiat: TStringField
      FieldName = 'iat'
      FixedChar = True
      Size = 1
    end
    object Q_Livrosippt: TStringField
      FieldName = 'ippt'
      FixedChar = True
      Size = 1
    end
    object Q_Livrosncm: TStringField
      FieldName = 'ncm'
      Size = 8
    end
    object Q_Livrostipo_item_sped: TStringField
      FieldName = 'tipo_item_sped'
      FixedChar = True
      Size = 2
    end
    object Q_Livrostaxa_issqn: TFloatField
      FieldName = 'taxa_issqn'
    end
    object Q_Livrostaxa_icms: TFloatField
      FieldName = 'taxa_icms'
    end
    object Q_Livroscst: TStringField
      FieldName = 'cst'
      FixedChar = True
      Size = 3
    end
    object Q_Livroscsosn: TStringField
      FieldName = 'csosn'
      FixedChar = True
      Size = 4
    end
    object Q_Livrosecf_icms_st: TStringField
      FieldName = 'ecf_icms_st'
      Size = 4
    end
    object Q_Livroscodigo_balanca: TIntegerField
      FieldName = 'codigo_balanca'
    end
    object Q_Livrosdata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object Q_Livrosauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_Livros: TDataSetProvider
    DataSet = Q_Livros
    Left = 377
    Top = 112
  end
  object CDS_Particular: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cnpj'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'inscricao_estadual'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'endereco'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'estado'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'fone'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'fax'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'contato'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'celular'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'diretor'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'aniversario'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Particular'
    StoreDefs = True
    Left = 529
    Top = 160
    object CDS_Particularid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Particularnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object CDS_Particularcnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object CDS_Particularinscricao_estadual: TStringField
      FieldName = 'inscricao_estadual'
    end
    object CDS_Particularendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object CDS_Particularbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object CDS_Particularcidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object CDS_Particularestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object CDS_Particularcep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object CDS_Particularfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object CDS_Particularfax: TStringField
      FieldName = 'fax'
      Size = 13
    end
    object CDS_Particularcontato: TStringField
      FieldName = 'contato'
      Size = 50
    end
    object CDS_Particularcelular: TStringField
      FieldName = 'celular'
      Size = 13
    end
    object CDS_Particulardiretor: TStringField
      FieldName = 'diretor'
      Size = 30
    end
    object CDS_Particularaniversario: TStringField
      FieldName = 'aniversario'
      Size = 5
    end
    object CDS_Particularauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DS_Particular: TDataSource
    DataSet = CDS_Particular
    Left = 529
    Top = 208
  end
  object Q_Particular: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from escola limit 0')
    SQLConnection = Conexao
    Left = 529
    Top = 64
    object Q_Particularid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_Particularnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object Q_Particularcnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object Q_Particularinscricao_estadual: TStringField
      FieldName = 'inscricao_estadual'
    end
    object Q_Particularendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object Q_Particularbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object Q_Particularcidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object Q_Particularestado: TStringField
      FieldName = 'estado'
      FixedChar = True
      Size = 2
    end
    object Q_Particularcep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object Q_Particularfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object Q_Particularfax: TStringField
      FieldName = 'fax'
      Size = 13
    end
    object Q_Particularcontato: TStringField
      FieldName = 'contato'
      Size = 50
    end
    object Q_Particularcelular: TStringField
      FieldName = 'celular'
      Size = 13
    end
    object Q_Particulardiretor: TStringField
      FieldName = 'diretor'
      Size = 30
    end
    object Q_Particularaniversario: TStringField
      FieldName = 'aniversario'
      Size = 5
    end
    object Q_Particularauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_Particular: TDataSetProvider
    DataSet = Q_Particular
    Left = 529
    Top = 112
  end
  object CDS_Produtos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_unidade'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'referencia'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'autor_marca'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'preco'
        DataType = ftFloat
      end
      item
        Name = 'estoque'
        DataType = ftInteger
      end
      item
        Name = 'livro_material'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'isbn'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'codigo_anterior'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'codigo_interno'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'descricao_pdv'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'totalizador_parcial'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'iat'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ippt'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ncm'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'tipo_item_sped'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'taxa_issqn'
        DataType = ftFloat
      end
      item
        Name = 'taxa_icms'
        DataType = ftFloat
      end
      item
        Name = 'cst'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'csosn'
        Attributes = [faFixed]
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ecf_icms_st'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'codigo_balanca'
        DataType = ftInteger
      end
      item
        Name = 'data_cadastro'
        DataType = ftDate
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Produtos'
    StoreDefs = True
    AfterPost = CDS_ProdutosAfterPost
    Left = 449
    Top = 160
    object CDS_Produtosid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Produtosid_unidade: TIntegerField
      FieldName = 'id_unidade'
      Required = True
    end
    object CDS_Produtoscodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object CDS_Produtosdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CDS_Produtosreferencia: TStringField
      FieldName = 'referencia'
      Size = 8
    end
    object CDS_Produtosautor_marca: TStringField
      FieldName = 'autor_marca'
      Size = 15
    end
    object CDS_Produtospreco: TFloatField
      FieldName = 'preco'
    end
    object CDS_Produtosestoque: TIntegerField
      FieldName = 'estoque'
    end
    object CDS_Produtoslivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object CDS_Produtosisbn: TStringField
      FieldName = 'isbn'
      Size = 15
    end
    object CDS_Produtoscodigo_anterior: TStringField
      FieldName = 'codigo_anterior'
      Size = 13
    end
    object CDS_Produtoscodigo_interno: TStringField
      FieldName = 'codigo_interno'
    end
    object CDS_Produtosnome: TStringField
      FieldName = 'nome'
      Size = 150
    end
    object CDS_Produtosdescricao_pdv: TStringField
      FieldName = 'descricao_pdv'
      Size = 30
    end
    object CDS_Produtostotalizador_parcial: TStringField
      FieldName = 'totalizador_parcial'
      Size = 10
    end
    object CDS_Produtosiat: TStringField
      FieldName = 'iat'
      FixedChar = True
      Size = 1
    end
    object CDS_Produtosippt: TStringField
      FieldName = 'ippt'
      FixedChar = True
      Size = 1
    end
    object CDS_Produtosncm: TStringField
      FieldName = 'ncm'
      Size = 8
    end
    object CDS_Produtostipo_item_sped: TStringField
      FieldName = 'tipo_item_sped'
      FixedChar = True
      Size = 2
    end
    object CDS_Produtostaxa_issqn: TFloatField
      FieldName = 'taxa_issqn'
    end
    object CDS_Produtostaxa_icms: TFloatField
      FieldName = 'taxa_icms'
    end
    object CDS_Produtoscst: TStringField
      FieldName = 'cst'
      FixedChar = True
      Size = 3
    end
    object CDS_Produtoscsosn: TStringField
      FieldName = 'csosn'
      FixedChar = True
      Size = 4
    end
    object CDS_Produtosecf_icms_st: TStringField
      FieldName = 'ecf_icms_st'
      Size = 4
    end
    object CDS_Produtoscodigo_balanca: TIntegerField
      FieldName = 'codigo_balanca'
    end
    object CDS_Produtosdata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object CDS_Produtosauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object CDS_Produtosunidade: TStringField
      FieldKind = fkLookup
      FieldName = 'unidade'
      LookupDataSet = CDS_Unidade
      LookupKeyFields = 'id'
      LookupResultField = 'descricao'
      KeyFields = 'id_unidade'
      Size = 10
      Lookup = True
    end
  end
  object DS_Produtos: TDataSource
    DataSet = CDS_Produtos
    Left = 449
    Top = 208
  end
  object Q_Produtos: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from produto'
      'where livro_material='#39'M'#39
      'order by id,descricao')
    SQLConnection = Conexao
    Left = 449
    Top = 64
    object Q_Produtosid: TIntegerField
      FieldName = 'id'
    end
    object Q_Produtosid_unidade: TIntegerField
      FieldName = 'id_unidade'
      Required = True
    end
    object Q_Produtoscodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object Q_Produtosdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object Q_Produtosreferencia: TStringField
      FieldName = 'referencia'
      Size = 8
    end
    object Q_Produtosautor_marca: TStringField
      FieldName = 'autor_marca'
      Size = 15
    end
    object Q_Produtospreco: TFloatField
      FieldName = 'preco'
    end
    object Q_Produtosestoque: TIntegerField
      FieldName = 'estoque'
    end
    object Q_Produtoslivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object Q_Produtosisbn: TStringField
      FieldName = 'isbn'
      Size = 15
    end
    object Q_Produtoscodigo_anterior: TStringField
      FieldName = 'codigo_anterior'
      Size = 13
    end
    object Q_Produtoscodigo_interno: TStringField
      FieldName = 'codigo_interno'
    end
    object Q_Produtosnome: TStringField
      FieldName = 'nome'
      Size = 150
    end
    object Q_Produtosdescricao_pdv: TStringField
      FieldName = 'descricao_pdv'
      Size = 30
    end
    object Q_Produtostotalizador_parcial: TStringField
      FieldName = 'totalizador_parcial'
      Size = 10
    end
    object Q_Produtosiat: TStringField
      FieldName = 'iat'
      FixedChar = True
      Size = 1
    end
    object Q_Produtosippt: TStringField
      FieldName = 'ippt'
      FixedChar = True
      Size = 1
    end
    object Q_Produtosncm: TStringField
      FieldName = 'ncm'
      Size = 8
    end
    object Q_Produtostipo_item_sped: TStringField
      FieldName = 'tipo_item_sped'
      FixedChar = True
      Size = 2
    end
    object Q_Produtostaxa_issqn: TFloatField
      FieldName = 'taxa_issqn'
    end
    object Q_Produtostaxa_icms: TFloatField
      FieldName = 'taxa_icms'
    end
    object Q_Produtoscst: TStringField
      FieldName = 'cst'
      FixedChar = True
      Size = 3
    end
    object Q_Produtoscsosn: TStringField
      FieldName = 'csosn'
      FixedChar = True
      Size = 4
    end
    object Q_Produtosecf_icms_st: TStringField
      FieldName = 'ecf_icms_st'
      Size = 4
    end
    object Q_Produtoscodigo_balanca: TIntegerField
      FieldName = 'codigo_balanca'
    end
    object Q_Produtosdata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object Q_Produtosauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_Produtos: TDataSetProvider
    DataSet = Q_Produtos
    Left = 449
    Top = 112
  end
  object CDS_Departamento: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'gerente'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Departamento'
    StoreDefs = True
    AfterPost = CDS_DepartamentoAfterPost
    Left = 696
    Top = 160
    object CDS_Departamentoid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Departamentonome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object CDS_Departamentogerente: TStringField
      FieldName = 'gerente'
      Size = 50
    end
  end
  object DS_Departamento: TDataSource
    DataSet = CDS_Departamento
    Left = 696
    Top = 208
  end
  object Q_Departamento: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from departamento'
      'order by id')
    SQLConnection = Conexao
    Left = 696
    Top = 64
    object Q_Departamentoid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_Departamentonome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object Q_Departamentogerente: TStringField
      FieldName = 'gerente'
      Size = 50
    end
  end
  object DSP_Departamento: TDataSetProvider
    DataSet = Q_Departamento
    Left = 696
    Top = 112
  end
  object CDS_Dorc: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_produto'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'id_orcamento_cabecalho'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'codigobarra'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'valor_total'
        DataType = ftFloat
      end
      item
        Name = 'unidade'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'valor_unitario'
        DataType = ftFloat
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'livro_material'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Dorc'
    StoreDefs = True
    BeforePost = CDS_DorcBeforePost
    AfterPost = CDS_DorcAfterPost
    Left = 33
    Top = 368
    object CDS_Dorcid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Dorcid_produto: TIntegerField
      FieldName = 'id_produto'
    end
    object CDS_Dorcid_orcamento_cabecalho: TIntegerField
      FieldName = 'id_orcamento_cabecalho'
    end
    object CDS_Dorccodigobarra: TStringField
      FieldName = 'codigobarra'
      OnChange = CDS_DorccodigobarraChange
      Size = 13
    end
    object CDS_Dorcdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CDS_Dorcquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object CDS_Dorcvalor_total: TFloatField
      FieldName = 'valor_total'
      DisplayFormat = '###,##0.00'
    end
    object CDS_Dorcunidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
    object CDS_Dorcvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
      DisplayFormat = '###,##0.00'
    end
    object CDS_Dorcauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object CDS_Dorcreferencia: TStringField
      FieldKind = fkLookup
      FieldName = 'referencia'
      LookupDataSet = CDS_Produtos
      LookupKeyFields = 'id'
      LookupResultField = 'referencia'
      KeyFields = 'id_produto'
      Size = 8
      Lookup = True
    end
    object CDS_Dorcautor_marca: TStringField
      FieldKind = fkLookup
      FieldName = 'autor_marca'
      LookupDataSet = CDS_Produtos
      LookupKeyFields = 'id'
      LookupResultField = 'autor_marca'
      KeyFields = 'id_produto'
      Size = 15
      Lookup = True
    end
    object CDS_Dorclivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
  end
  object DS_Dorc: TDataSource
    DataSet = CDS_Dorc
    Left = 33
    Top = 416
  end
  object Q_Dorc: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from orcamento_detalhe limit 0')
    SQLConnection = Conexao
    Left = 33
    Top = 272
    object Q_Dorcid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_Dorcid_produto: TIntegerField
      FieldName = 'id_produto'
      Visible = False
    end
    object Q_Dorcid_orcamento_cabecalho: TIntegerField
      FieldName = 'id_orcamento_cabecalho'
    end
    object Q_Dorccodigobarra: TStringField
      FieldName = 'codigobarra'
      Size = 13
    end
    object Q_Dorcdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object Q_Dorcquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object Q_Dorcvalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object Q_Dorcunidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
    object Q_Dorcvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object Q_Dorcauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object Q_Dorclivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
  end
  object DSP_Dorc: TDataSetProvider
    DataSet = Q_Dorc
    Left = 33
    Top = 320
  end
  object CDS_Corc: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_escola'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'codigo_orcamento'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'serie'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'ano'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'valor_total'
        DataType = ftFloat
      end
      item
        Name = 'aluno'
        DataType = ftInteger
      end
      item
        Name = 'pedido'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Corc'
    StoreDefs = True
    Left = 112
    Top = 368
    object CDS_Corcid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Corcid_escola: TIntegerField
      FieldName = 'id_escola'
      Required = True
    end
    object CDS_Corccodigo_orcamento: TStringField
      FieldName = 'codigo_orcamento'
      Size = 12
    end
    object CDS_Corcserie: TStringField
      FieldName = 'serie'
      FixedChar = True
      Size = 3
    end
    object CDS_Corcano: TStringField
      FieldName = 'ano'
      Size = 4
    end
    object CDS_Corcvalor_total: TFloatField
      FieldName = 'valor_total'
      DisplayFormat = '###,##0.00'
    end
    object CDS_Corcaluno: TIntegerField
      FieldName = 'aluno'
    end
    object CDS_Corcpedido: TStringField
      FieldName = 'pedido'
      FixedChar = True
      Size = 1
    end
    object CDS_Corcauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DS_Corc: TDataSource
    DataSet = CDS_Corc
    Left = 112
    Top = 416
  end
  object Q_Corc: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from orcamento_cabecalho limit 0')
    SQLConnection = Conexao
    Left = 112
    Top = 272
    object Q_Corcid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_Corcid_escola: TIntegerField
      FieldName = 'id_escola'
      Required = True
    end
    object Q_Corccodigo_orcamento: TStringField
      FieldName = 'codigo_orcamento'
      Size = 12
    end
    object Q_Corcserie: TStringField
      FieldName = 'serie'
      FixedChar = True
      Size = 3
    end
    object Q_Corcano: TStringField
      FieldName = 'ano'
      Size = 4
    end
    object Q_Corcvalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object Q_Corcaluno: TIntegerField
      FieldName = 'aluno'
    end
    object Q_Corcpedido: TStringField
      FieldName = 'pedido'
      FixedChar = True
      Size = 1
    end
    object Q_Corcauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_Corc: TDataSetProvider
    DataSet = Q_Corc
    Left = 112
    Top = 320
  end
  object CDS_ProcuraProd: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'id_unidade'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'referencia'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'autor_marca'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'preco'
        DataType = ftFloat
      end
      item
        Name = 'estoque'
        DataType = ftInteger
      end
      item
        Name = 'livro_material'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'isbn'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'codigo_anterior'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'codigo_interno'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'descricao_pdv'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'totalizador_parcial'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'iat'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ippt'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ncm'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'tipo_item_sped'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'taxa_issqn'
        DataType = ftFloat
      end
      item
        Name = 'taxa_icms'
        DataType = ftFloat
      end
      item
        Name = 'cst'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'csosn'
        Attributes = [faFixed]
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ecf_icms_st'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'codigo_balanca'
        DataType = ftInteger
      end
      item
        Name = 'data_cadastro'
        DataType = ftDate
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_ProcuraProd'
    StoreDefs = True
    Left = 801
    Top = 160
    object CDS_ProcuraProdid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object CDS_ProcuraProdid_unidade: TIntegerField
      FieldName = 'id_unidade'
      Required = True
    end
    object CDS_ProcuraProdcodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object CDS_ProcuraProddescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CDS_ProcuraProdreferencia: TStringField
      FieldName = 'referencia'
      Size = 8
    end
    object CDS_ProcuraProdautor_marca: TStringField
      FieldName = 'autor_marca'
      Size = 15
    end
    object CDS_ProcuraProdpreco: TFloatField
      FieldName = 'preco'
    end
    object CDS_ProcuraProdestoque: TIntegerField
      FieldName = 'estoque'
    end
    object CDS_ProcuraProdlivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object CDS_ProcuraProdisbn: TStringField
      FieldName = 'isbn'
      Size = 15
    end
    object CDS_ProcuraProdcodigo_anterior: TStringField
      FieldName = 'codigo_anterior'
      Size = 13
    end
    object CDS_ProcuraProdcodigo_interno: TStringField
      FieldName = 'codigo_interno'
    end
    object CDS_ProcuraProdnome: TStringField
      FieldName = 'nome'
      Size = 150
    end
    object CDS_ProcuraProddescricao_pdv: TStringField
      FieldName = 'descricao_pdv'
      Size = 30
    end
    object CDS_ProcuraProdtotalizador_parcial: TStringField
      FieldName = 'totalizador_parcial'
      Size = 10
    end
    object CDS_ProcuraProdiat: TStringField
      FieldName = 'iat'
      FixedChar = True
      Size = 1
    end
    object CDS_ProcuraProdippt: TStringField
      FieldName = 'ippt'
      FixedChar = True
      Size = 1
    end
    object CDS_ProcuraProdncm: TStringField
      FieldName = 'ncm'
      Size = 8
    end
    object CDS_ProcuraProdtipo_item_sped: TStringField
      FieldName = 'tipo_item_sped'
      FixedChar = True
      Size = 2
    end
    object CDS_ProcuraProdtaxa_issqn: TFloatField
      FieldName = 'taxa_issqn'
    end
    object CDS_ProcuraProdtaxa_icms: TFloatField
      FieldName = 'taxa_icms'
    end
    object CDS_ProcuraProdcst: TStringField
      FieldName = 'cst'
      FixedChar = True
      Size = 3
    end
    object CDS_ProcuraProdcsosn: TStringField
      FieldName = 'csosn'
      FixedChar = True
      Size = 4
    end
    object CDS_ProcuraProdecf_icms_st: TStringField
      FieldName = 'ecf_icms_st'
      Size = 4
    end
    object CDS_ProcuraProdcodigo_balanca: TIntegerField
      FieldName = 'codigo_balanca'
    end
    object CDS_ProcuraProddata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object CDS_ProcuraProdauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object CDS_ProcuraProdunidade: TStringField
      FieldKind = fkLookup
      FieldName = 'unidade'
      LookupDataSet = CDS_Unidade
      LookupKeyFields = 'id'
      LookupResultField = 'descricao'
      KeyFields = 'id_unidade'
      Size = 10
      Lookup = True
    end
  end
  object DS_ProcuraProd: TDataSource
    DataSet = CDS_ProcuraProd
    Left = 801
    Top = 208
  end
  object Q_ProcuraProd: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from produto')
    SQLConnection = Conexao
    Left = 801
    Top = 64
    object Q_ProcuraProdid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object Q_ProcuraProdid_unidade: TIntegerField
      FieldName = 'id_unidade'
      Required = True
    end
    object Q_ProcuraProdcodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object Q_ProcuraProddescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object Q_ProcuraProdreferencia: TStringField
      FieldName = 'referencia'
      Size = 8
    end
    object Q_ProcuraProdautor_marca: TStringField
      FieldName = 'autor_marca'
      Size = 15
    end
    object Q_ProcuraProdpreco: TFloatField
      FieldName = 'preco'
    end
    object Q_ProcuraProdestoque: TIntegerField
      FieldName = 'estoque'
    end
    object Q_ProcuraProdlivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object Q_ProcuraProdisbn: TStringField
      FieldName = 'isbn'
      Size = 15
    end
    object Q_ProcuraProdcodigo_anterior: TStringField
      FieldName = 'codigo_anterior'
      Size = 13
    end
    object Q_ProcuraProdcodigo_interno: TStringField
      FieldName = 'codigo_interno'
    end
    object Q_ProcuraProdnome: TStringField
      FieldName = 'nome'
      Size = 150
    end
    object Q_ProcuraProddescricao_pdv: TStringField
      FieldName = 'descricao_pdv'
      Size = 30
    end
    object Q_ProcuraProdtotalizador_parcial: TStringField
      FieldName = 'totalizador_parcial'
      Size = 10
    end
    object Q_ProcuraProdiat: TStringField
      FieldName = 'iat'
      FixedChar = True
      Size = 1
    end
    object Q_ProcuraProdippt: TStringField
      FieldName = 'ippt'
      FixedChar = True
      Size = 1
    end
    object Q_ProcuraProdncm: TStringField
      FieldName = 'ncm'
      Size = 8
    end
    object Q_ProcuraProdtipo_item_sped: TStringField
      FieldName = 'tipo_item_sped'
      FixedChar = True
      Size = 2
    end
    object Q_ProcuraProdtaxa_issqn: TFloatField
      FieldName = 'taxa_issqn'
    end
    object Q_ProcuraProdtaxa_icms: TFloatField
      FieldName = 'taxa_icms'
    end
    object Q_ProcuraProdcst: TStringField
      FieldName = 'cst'
      FixedChar = True
      Size = 3
    end
    object Q_ProcuraProdcsosn: TStringField
      FieldName = 'csosn'
      FixedChar = True
      Size = 4
    end
    object Q_ProcuraProdecf_icms_st: TStringField
      FieldName = 'ecf_icms_st'
      Size = 4
    end
    object Q_ProcuraProdcodigo_balanca: TIntegerField
      FieldName = 'codigo_balanca'
    end
    object Q_ProcuraProddata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object Q_ProcuraProdauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_ProcuraProd: TDataSetProvider
    DataSet = Q_ProcuraProd
    Left = 801
    Top = 112
  end
  object CDS_CSoma: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'minuta'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'vendedor'
        DataType = ftInteger
      end
      item
        Name = 'somador'
        DataType = ftInteger
      end
      item
        Name = 'hora'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'total'
        DataType = ftFloat
      end
      item
        Name = 'ecf'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'nome_cliente'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cpf_cnpj'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'data_soma'
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_CSoma'
    StoreDefs = True
    Left = 192
    Top = 368
    object CDS_CSomaid: TIntegerField
      FieldName = 'id'
    end
    object CDS_CSomaminuta: TIntegerField
      FieldName = 'minuta'
      Required = True
    end
    object CDS_CSomavendedor: TIntegerField
      FieldName = 'vendedor'
    end
    object CDS_CSomasomador: TIntegerField
      FieldName = 'somador'
    end
    object CDS_CSomahora: TStringField
      FieldName = 'hora'
      Size = 8
    end
    object CDS_CSomatotal: TFloatField
      FieldName = 'total'
    end
    object CDS_CSomaecf: TStringField
      FieldName = 'ecf'
      FixedChar = True
      Size = 1
    end
    object CDS_CSomanome_cliente: TStringField
      FieldName = 'nome_cliente'
      Size = 100
    end
    object CDS_CSomacpf_cnpj: TStringField
      FieldName = 'cpf_cnpj'
      Size = 14
    end
    object CDS_CSomaauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object CDS_CSomadata_soma: TDateField
      FieldName = 'data_soma'
    end
  end
  object DS_CSoma: TDataSource
    DataSet = CDS_CSoma
    Left = 192
    Top = 416
  end
  object Q_CSoma: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from soma_cabecalho limit 0')
    SQLConnection = Conexao
    Left = 192
    Top = 272
    object Q_CSomaid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_CSomaminuta: TIntegerField
      FieldName = 'minuta'
      Required = True
    end
    object Q_CSomavendedor: TIntegerField
      FieldName = 'vendedor'
    end
    object Q_CSomasomador: TIntegerField
      FieldName = 'somador'
    end
    object Q_CSomahora: TStringField
      FieldName = 'hora'
      Size = 8
    end
    object Q_CSomatotal: TFloatField
      FieldName = 'total'
    end
    object Q_CSomaecf: TStringField
      FieldName = 'ecf'
      FixedChar = True
      Size = 1
    end
    object Q_CSomanome_cliente: TStringField
      FieldName = 'nome_cliente'
      Size = 100
    end
    object Q_CSomacpf_cnpj: TStringField
      FieldName = 'cpf_cnpj'
      Size = 14
    end
    object Q_CSomaauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object Q_CSomadata_soma: TDateField
      FieldName = 'data_soma'
    end
  end
  object DSP_CSoma: TDataSetProvider
    DataSet = Q_CSoma
    Left = 192
    Top = 320
  end
  object CDS_DSoma: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_produto'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'id_soma_cabecalho'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'minuta'
        DataType = ftInteger
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'valor_total'
        DataType = ftFloat
      end
      item
        Name = 'unidade'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'valor_unitario'
        DataType = ftFloat
      end
      item
        Name = 'livro_material'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'nota_credito'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'data'
        DataType = ftDate
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_DSoma'
    StoreDefs = True
    BeforePost = CDS_DSomaBeforePost
    Left = 273
    Top = 368
    object CDS_DSomaid: TIntegerField
      FieldName = 'id'
    end
    object CDS_DSomaid_produto: TIntegerField
      FieldName = 'id_produto'
      Required = True
    end
    object CDS_DSomaid_soma_cabecalho: TIntegerField
      FieldName = 'id_soma_cabecalho'
      Required = True
    end
    object CDS_DSomaminuta: TIntegerField
      FieldName = 'minuta'
    end
    object CDS_DSomadescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CDS_DSomacodigo: TStringField
      FieldName = 'codigo'
      OnChange = CDS_DSomacodigoChange
      Size = 13
    end
    object CDS_DSomaquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object CDS_DSomavalor_total: TFloatField
      FieldName = 'valor_total'
      DisplayFormat = '###,##0.00'
    end
    object CDS_DSomaunidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
    object CDS_DSomavalor_unitario: TFloatField
      FieldName = 'valor_unitario'
      DisplayFormat = '###,##0.00'
    end
    object CDS_DSomalivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object CDS_DSomanota_credito: TStringField
      FieldName = 'nota_credito'
      FixedChar = True
      Size = 1
    end
    object CDS_DSomaauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object CDS_DSomareferencia: TStringField
      FieldKind = fkLookup
      FieldName = 'referencia'
      LookupDataSet = CDS_Produtos
      LookupKeyFields = 'id'
      LookupResultField = 'referencia'
      KeyFields = 'id_produto'
      Size = 50
      Lookup = True
    end
    object CDS_DSomaautor_marca: TStringField
      FieldKind = fkLookup
      FieldName = 'autor_marca'
      LookupDataSet = CDS_Produtos
      LookupKeyFields = 'id'
      LookupResultField = 'autor_marca'
      KeyFields = 'id_produto'
      Size = 50
      Lookup = True
    end
  end
  object DS_DSoma: TDataSource
    DataSet = CDS_DSoma
    Left = 273
    Top = 416
  end
  object Q_DSoma: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from soma_detalhe limit 0')
    SQLConnection = Conexao
    Left = 273
    Top = 272
    object Q_DSomaid: TIntegerField
      FieldName = 'id'
    end
    object Q_DSomaid_produto: TIntegerField
      FieldName = 'id_produto'
      Required = True
    end
    object Q_DSomaid_soma_cabecalho: TIntegerField
      FieldName = 'id_soma_cabecalho'
      Required = True
    end
    object Q_DSomaminuta: TIntegerField
      FieldName = 'minuta'
    end
    object Q_DSomadescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object Q_DSomacodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object Q_DSomaquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object Q_DSomavalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object Q_DSomaunidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
    object Q_DSomavalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object Q_DSomalivro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object Q_DSomanota_credito: TStringField
      FieldName = 'nota_credito'
      FixedChar = True
      Size = 1
    end
    object Q_DSomaauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_DSoma: TDataSetProvider
    DataSet = Q_DSoma
    Left = 273
    Top = 320
  end
  object CDS_CNC: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'minuta'
        DataType = ftInteger
      end
      item
        Name = 'somador'
        DataType = ftInteger
      end
      item
        Name = 'vendedor'
        DataType = ftInteger
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'endereco'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'fone'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ecf'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'baixa'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'obs'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'data_nc'
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_CNC'
    StoreDefs = True
    Left = 353
    Top = 368
    object CDS_CNCid: TIntegerField
      FieldName = 'id'
    end
    object CDS_CNCminuta: TIntegerField
      FieldName = 'minuta'
    end
    object CDS_CNCsomador: TIntegerField
      FieldName = 'somador'
    end
    object CDS_CNCvendedor: TIntegerField
      FieldName = 'vendedor'
    end
    object CDS_CNCnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object CDS_CNCendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object CDS_CNCfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object CDS_CNCbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object CDS_CNCcep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object CDS_CNCcidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object CDS_CNCecf: TStringField
      FieldName = 'ecf'
      FixedChar = True
      Size = 1
    end
    object CDS_CNCbaixa: TStringField
      FieldName = 'baixa'
      FixedChar = True
      Size = 1
    end
    object CDS_CNCobs: TStringField
      FieldName = 'obs'
      Size = 255
    end
    object CDS_CNCdata_nc: TDateField
      FieldName = 'data_nc'
    end
  end
  object DS_CNC: TDataSource
    DataSet = CDS_CNC
    Left = 353
    Top = 416
  end
  object Q_CNC: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from nota_credito_cabecalho limit 0')
    SQLConnection = Conexao
    Left = 353
    Top = 272
    object Q_CNCid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_CNCminuta: TIntegerField
      FieldName = 'minuta'
    end
    object Q_CNCsomador: TIntegerField
      FieldName = 'somador'
    end
    object Q_CNCvendedor: TIntegerField
      FieldName = 'vendedor'
    end
    object Q_CNCnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object Q_CNCendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object Q_CNCfone: TStringField
      FieldName = 'fone'
      Size = 13
    end
    object Q_CNCbairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object Q_CNCcep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object Q_CNCcidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object Q_CNCecf: TStringField
      FieldName = 'ecf'
      FixedChar = True
      Size = 1
    end
    object Q_CNCbaixa: TStringField
      FieldName = 'baixa'
      FixedChar = True
      Size = 1
    end
    object Q_CNCobs: TStringField
      FieldName = 'obs'
      Size = 255
    end
    object Q_CNCdata_nc: TDateField
      FieldName = 'data_nc'
    end
  end
  object DSP_CNC: TDataSetProvider
    DataSet = Q_CNC
    Left = 353
    Top = 320
  end
  object CDS_DNC: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_produto'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'id_nota_credito_cabecalho'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'minuta'
        DataType = ftInteger
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'valor_unitario'
        DataType = ftFloat
      end
      item
        Name = 'valor_total'
        DataType = ftFloat
      end
      item
        Name = 'data'
        DataType = ftDate
      end
      item
        Name = 'baixa'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_DNC'
    StoreDefs = True
    AfterPost = CDS_DNCAfterPost
    Left = 433
    Top = 368
    object CDS_DNCid: TIntegerField
      FieldName = 'id'
    end
    object CDS_DNCid_produto: TIntegerField
      FieldName = 'id_produto'
      Required = True
    end
    object CDS_DNCid_nota_credito_cabecalho: TIntegerField
      FieldName = 'id_nota_credito_cabecalho'
      Required = True
    end
    object CDS_DNCminuta: TIntegerField
      FieldName = 'minuta'
    end
    object CDS_DNCcodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object CDS_DNCdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CDS_DNCquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object CDS_DNCvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object CDS_DNCvalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object CDS_DNCbaixa: TStringField
      FieldName = 'baixa'
      FixedChar = True
      Size = 1
    end
    object CDS_DNCautor: TStringField
      FieldKind = fkLookup
      FieldName = 'autor'
      LookupDataSet = CDS_Produtos
      LookupKeyFields = 'id'
      LookupResultField = 'autor_marca'
      KeyFields = 'id_produto'
      Size = 50
      Lookup = True
    end
  end
  object DS_DNC: TDataSource
    DataSet = CDS_DNC
    Left = 433
    Top = 416
  end
  object Q_DNC: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from nota_credito_detalhe limit 0')
    SQLConnection = Conexao
    Left = 433
    Top = 272
    object Q_DNCid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_DNCid_produto: TIntegerField
      FieldName = 'id_produto'
      Required = True
    end
    object Q_DNCid_nota_credito_cabecalho: TIntegerField
      FieldName = 'id_nota_credito_cabecalho'
      Required = True
    end
    object Q_DNCminuta: TIntegerField
      FieldName = 'minuta'
    end
    object Q_DNCcodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object Q_DNCdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object Q_DNCquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object Q_DNCvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object Q_DNCvalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object Q_DNCbaixa: TStringField
      FieldName = 'baixa'
      FixedChar = True
      Size = 1
    end
  end
  object DSP_DNC: TDataSetProvider
    DataSet = Q_DNC
    Left = 433
    Top = 320
  end
  object CDS_Minuta: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'minuta'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Minuta'
    StoreDefs = True
    Left = 889
    Top = 160
    object CDS_Minutaminuta: TIntegerField
      FieldName = 'minuta'
    end
  end
  object DS_Minuta: TDataSource
    DataSet = CDS_Minuta
    Left = 889
    Top = 208
  end
  object Q_Minuta: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from minutas limit 0')
    SQLConnection = Conexao
    Left = 889
    Top = 64
    object Q_Minutaminuta: TIntegerField
      FieldName = 'minuta'
    end
  end
  object DSP_Minuta: TDataSetProvider
    DataSet = Q_Minuta
    Left = 889
    Top = 112
  end
  object CDS_DSoma1: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_produto'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'id_soma_cabecalho'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'minuta'
        DataType = ftInteger
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'valor_total'
        DataType = ftFloat
      end
      item
        Name = 'unidade'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'valor_unitario'
        DataType = ftFloat
      end
      item
        Name = 'livro_material'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'nota_credito'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_DSoma1'
    StoreDefs = True
    Left = 961
    Top = 160
    object CDS_DSoma1id: TIntegerField
      FieldName = 'id'
    end
    object CDS_DSoma1id_produto: TIntegerField
      FieldName = 'id_produto'
      Required = True
    end
    object CDS_DSoma1id_soma_cabecalho: TIntegerField
      FieldName = 'id_soma_cabecalho'
      Required = True
    end
    object CDS_DSoma1minuta: TIntegerField
      FieldName = 'minuta'
    end
    object CDS_DSoma1descricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CDS_DSoma1codigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object CDS_DSoma1quantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object CDS_DSoma1valor_total: TFloatField
      FieldName = 'valor_total'
    end
    object CDS_DSoma1unidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
    object CDS_DSoma1valor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object CDS_DSoma1livro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object CDS_DSoma1nota_credito: TStringField
      FieldName = 'nota_credito'
      FixedChar = True
      Size = 1
    end
    object CDS_DSoma1auditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DS_DSoma1: TDataSource
    DataSet = CDS_DSoma1
    Left = 961
    Top = 208
  end
  object Q_DSoma1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from soma_detalhe limit 0')
    SQLConnection = Conexao
    Left = 961
    Top = 64
    object Q_DSoma1id: TIntegerField
      FieldName = 'id'
    end
    object Q_DSoma1id_produto: TIntegerField
      FieldName = 'id_produto'
      Required = True
    end
    object Q_DSoma1id_soma_cabecalho: TIntegerField
      FieldName = 'id_soma_cabecalho'
      Required = True
    end
    object Q_DSoma1minuta: TIntegerField
      FieldName = 'minuta'
    end
    object Q_DSoma1descricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object Q_DSoma1codigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object Q_DSoma1quantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object Q_DSoma1valor_total: TFloatField
      FieldName = 'valor_total'
    end
    object Q_DSoma1unidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
    object Q_DSoma1valor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object Q_DSoma1livro_material: TStringField
      FieldName = 'livro_material'
      FixedChar = True
      Size = 1
    end
    object Q_DSoma1nota_credito: TStringField
      FieldName = 'nota_credito'
      FixedChar = True
      Size = 1
    end
    object Q_DSoma1auditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
  end
  object DSP_DSoma1: TDataSetProvider
    DataSet = Q_DSoma1
    Left = 961
    Top = 112
  end
  object CDS_Contas: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'codigo'
        DataType = ftInteger
      end
      item
        Name = 'conta'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Contas'
    StoreDefs = True
    AfterPost = CDS_ContasAfterPost
    Left = 505
    Top = 368
    object CDS_Contasid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Contascodigo: TIntegerField
      FieldName = 'codigo'
    end
    object CDS_Contasconta: TStringField
      FieldName = 'conta'
      Size = 50
    end
  end
  object DS_Contas: TDataSource
    DataSet = CDS_Contas
    Left = 505
    Top = 416
  end
  object Q_Contas: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from centro_custo')
    SQLConnection = Conexao
    Left = 505
    Top = 272
    object Q_Contasid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_Contascodigo: TIntegerField
      FieldName = 'codigo'
    end
    object Q_Contasconta: TStringField
      FieldName = 'conta'
      Size = 50
    end
  end
  object DSP_Contas: TDataSetProvider
    DataSet = Q_Contas
    Left = 505
    Top = 320
  end
  object CDS_APagar: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_banco'
        DataType = ftInteger
      end
      item
        Name = 'id_fornecedor'
        DataType = ftInteger
      end
      item
        Name = 'numero_nf'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'total_nf'
        DataType = ftFloat
      end
      item
        Name = 'numero_pedido'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'pago'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'juro'
        DataType = ftFloat
      end
      item
        Name = 'multa'
        DataType = ftFloat
      end
      item
        Name = 'valor_pago'
        DataType = ftFloat
      end
      item
        Name = 'conta'
        DataType = ftInteger
      end
      item
        Name = 'cheque'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'duplicata'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'xx'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'nominal'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'total_produtos'
        DataType = ftFloat
      end
      item
        Name = 'emissao'
        DataType = ftDate
      end
      item
        Name = 'entrada'
        DataType = ftDate
      end
      item
        Name = 'vencimento'
        DataType = ftDate
      end
      item
        Name = 'pagamento'
        DataType = ftDate
      end
      item
        Name = 'data_cheque'
        DataType = ftDate
      end
      item
        Name = 'lancamento'
        DataType = ftDate
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'historico'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_APagar'
    StoreDefs = True
    Left = 576
    Top = 368
    object CDS_APagarid: TIntegerField
      FieldName = 'id'
    end
    object CDS_APagarid_banco: TIntegerField
      FieldName = 'id_banco'
    end
    object CDS_APagarid_fornecedor: TIntegerField
      FieldName = 'id_fornecedor'
    end
    object CDS_APagarnumero_nf: TStringField
      FieldName = 'numero_nf'
    end
    object CDS_APagartotal_nf: TFloatField
      FieldName = 'total_nf'
    end
    object CDS_APagarnumero_pedido: TStringField
      FieldName = 'numero_pedido'
      Size = 10
    end
    object CDS_APagarpago: TStringField
      FieldName = 'pago'
      FixedChar = True
      Size = 1
    end
    object CDS_APagarjuro: TFloatField
      FieldName = 'juro'
    end
    object CDS_APagarmulta: TFloatField
      FieldName = 'multa'
    end
    object CDS_APagarvalor_pago: TFloatField
      FieldName = 'valor_pago'
    end
    object CDS_APagarconta: TIntegerField
      FieldName = 'conta'
    end
    object CDS_APagarcheque: TStringField
      FieldName = 'cheque'
      Size = 6
    end
    object CDS_APagarduplicata: TStringField
      FieldName = 'duplicata'
      Size = 50
    end
    object CDS_APagarxx: TStringField
      FieldName = 'xx'
      FixedChar = True
      Size = 1
    end
    object CDS_APagarnominal: TStringField
      FieldName = 'nominal'
      Size = 100
    end
    object CDS_APagartotal_produtos: TFloatField
      FieldName = 'total_produtos'
    end
    object CDS_APagaremissao: TDateField
      FieldName = 'emissao'
    end
    object CDS_APagarentrada: TDateField
      FieldName = 'entrada'
    end
    object CDS_APagarvencimento: TDateField
      FieldName = 'vencimento'
    end
    object CDS_APagarpagamento: TDateField
      FieldName = 'pagamento'
    end
    object CDS_APagardata_cheque: TDateField
      FieldName = 'data_cheque'
    end
    object CDS_APagarlancamento: TDateField
      FieldName = 'lancamento'
    end
    object CDS_APagarauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object CDS_APagarfornecedor: TStringField
      FieldKind = fkLookup
      FieldName = 'fornecedor'
      LookupDataSet = CDS_Fornecedor
      LookupKeyFields = 'id'
      LookupResultField = 'razao'
      KeyFields = 'id_fornecedor'
      Size = 100
      Lookup = True
    end
    object CDS_APagarhistorico: TStringField
      FieldName = 'historico'
      Size = 100
    end
    object CDS_APagarbanco: TStringField
      FieldKind = fkLookup
      FieldName = 'banco'
      LookupDataSet = CDS_Bancos
      LookupKeyFields = 'id'
      LookupResultField = 'banco'
      KeyFields = 'id_banco'
      Size = 100
      Lookup = True
    end
  end
  object DS_APagar: TDataSource
    DataSet = CDS_APagar
    Left = 576
    Top = 416
  end
  object Q_APagar: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from pagar limit 0')
    SQLConnection = Conexao
    Left = 576
    Top = 272
    object Q_APagarid: TIntegerField
      FieldName = 'id'
    end
    object Q_APagarid_banco: TIntegerField
      FieldName = 'id_banco'
    end
    object Q_APagarid_fornecedor: TIntegerField
      FieldName = 'id_fornecedor'
    end
    object Q_APagarnumero_nf: TStringField
      FieldName = 'numero_nf'
    end
    object Q_APagartotal_nf: TFloatField
      FieldName = 'total_nf'
    end
    object Q_APagarnumero_pedido: TStringField
      FieldName = 'numero_pedido'
      Size = 10
    end
    object Q_APagarpago: TStringField
      FieldName = 'pago'
      FixedChar = True
      Size = 1
    end
    object Q_APagarjuro: TFloatField
      FieldName = 'juro'
    end
    object Q_APagarmulta: TFloatField
      FieldName = 'multa'
    end
    object Q_APagarvalor_pago: TFloatField
      FieldName = 'valor_pago'
    end
    object Q_APagarconta: TIntegerField
      FieldName = 'conta'
    end
    object Q_APagarcheque: TStringField
      FieldName = 'cheque'
      Size = 6
    end
    object Q_APagarduplicata: TStringField
      FieldName = 'duplicata'
      Size = 50
    end
    object Q_APagarxx: TStringField
      FieldName = 'xx'
      FixedChar = True
      Size = 1
    end
    object Q_APagarnominal: TStringField
      FieldName = 'nominal'
      Size = 100
    end
    object Q_APagartotal_produtos: TFloatField
      FieldName = 'total_produtos'
    end
    object Q_APagaremissao: TDateField
      FieldName = 'emissao'
    end
    object Q_APagarentrada: TDateField
      FieldName = 'entrada'
    end
    object Q_APagarvencimento: TDateField
      FieldName = 'vencimento'
    end
    object Q_APagarpagamento: TDateField
      FieldName = 'pagamento'
    end
    object Q_APagardata_cheque: TDateField
      FieldName = 'data_cheque'
    end
    object Q_APagarlancamento: TDateField
      FieldName = 'lancamento'
    end
    object Q_APagarauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object Q_APagarhistorico: TStringField
      FieldName = 'historico'
      Size = 100
    end
  end
  object DSP_APagar: TDataSetProvider
    DataSet = Q_APagar
    Left = 576
    Top = 320
  end
  object CDS_Rec: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_banco'
        DataType = ftInteger
      end
      item
        Name = 'id_cliente'
        DataType = ftInteger
      end
      item
        Name = 'nf_fatura'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'entrada_saida'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'emissao'
        DataType = ftDate
      end
      item
        Name = 'vencimento'
        DataType = ftDate
      end
      item
        Name = 'valor'
        DataType = ftFloat
      end
      item
        Name = 'desconto_nota'
        DataType = ftFloat
      end
      item
        Name = 'total_nota'
        DataType = ftFloat
      end
      item
        Name = 'data_recebimento'
        DataType = ftDate
      end
      item
        Name = 'taxa_juro'
        DataType = ftFloat
      end
      item
        Name = 'juro'
        DataType = ftFloat
      end
      item
        Name = 'taxa_multa'
        DataType = ftFloat
      end
      item
        Name = 'multa'
        DataType = ftFloat
      end
      item
        Name = 'taxa_desconto'
        DataType = ftFloat
      end
      item
        Name = 'desconto'
        DataType = ftFloat
      end
      item
        Name = 'valor_recebido'
        DataType = ftFloat
      end
      item
        Name = 'tipo_recebimento'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'mes'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'ano'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'tipo_cliente'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'auditoria'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'historico'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_Rec'
    StoreDefs = True
    AfterInsert = CDS_RecAfterInsert
    Left = 648
    Top = 368
    object CDS_Recid: TIntegerField
      FieldName = 'id'
    end
    object CDS_Recid_banco: TIntegerField
      FieldName = 'id_banco'
    end
    object CDS_Recid_cliente: TIntegerField
      FieldName = 'id_cliente'
    end
    object CDS_Recnf_fatura: TStringField
      FieldName = 'nf_fatura'
      Size = 10
    end
    object CDS_Recentrada_saida: TStringField
      FieldName = 'entrada_saida'
      FixedChar = True
      Size = 1
    end
    object CDS_Recemissao: TDateField
      FieldName = 'emissao'
    end
    object CDS_Recvencimento: TDateField
      FieldName = 'vencimento'
    end
    object CDS_Recvalor: TFloatField
      FieldName = 'valor'
    end
    object CDS_Recdesconto_nota: TFloatField
      FieldName = 'desconto_nota'
    end
    object CDS_Rectotal_nota: TFloatField
      FieldName = 'total_nota'
    end
    object CDS_Recdata_recebimento: TDateField
      FieldName = 'data_recebimento'
    end
    object CDS_Rectaxa_juro: TFloatField
      FieldName = 'taxa_juro'
    end
    object CDS_Recjuro: TFloatField
      FieldName = 'juro'
    end
    object CDS_Rectaxa_multa: TFloatField
      FieldName = 'taxa_multa'
    end
    object CDS_Recmulta: TFloatField
      FieldName = 'multa'
    end
    object CDS_Rectaxa_desconto: TFloatField
      FieldName = 'taxa_desconto'
    end
    object CDS_Recdesconto: TFloatField
      FieldName = 'desconto'
    end
    object CDS_Recvalor_recebido: TFloatField
      FieldName = 'valor_recebido'
    end
    object CDS_Rectipo_recebimento: TStringField
      FieldName = 'tipo_recebimento'
      Size = 40
    end
    object CDS_Recmes: TStringField
      FieldName = 'mes'
      FixedChar = True
      Size = 2
    end
    object CDS_Recano: TStringField
      FieldName = 'ano'
      Size = 4
    end
    object CDS_Rectipo_cliente: TStringField
      FieldName = 'tipo_cliente'
      FixedChar = True
      Size = 1
    end
    object CDS_Recauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object CDS_Rechistorico: TStringField
      FieldName = 'historico'
      Size = 100
    end
    object CDS_Reccliente: TStringField
      FieldKind = fkLookup
      FieldName = 'cliente'
      LookupDataSet = CDS_Clientes
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'id_cliente'
      Size = 100
      Lookup = True
    end
    object CDS_Recbanco: TStringField
      FieldKind = fkLookup
      FieldName = 'banco'
      LookupDataSet = CDS_Bancos
      LookupKeyFields = 'id'
      LookupResultField = 'banco'
      KeyFields = 'id_banco'
      Size = 100
      Lookup = True
    end
  end
  object DS_Rec: TDataSource
    DataSet = CDS_Rec
    Left = 648
    Top = 416
  end
  object Q_Rec: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from receber limit 0')
    SQLConnection = Conexao
    Left = 648
    Top = 272
    object Q_Recid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object Q_Recid_banco: TIntegerField
      FieldName = 'id_banco'
    end
    object Q_Recid_cliente: TIntegerField
      FieldName = 'id_cliente'
    end
    object Q_Recnf_fatura: TStringField
      FieldName = 'nf_fatura'
      Size = 10
    end
    object Q_Recentrada_saida: TStringField
      FieldName = 'entrada_saida'
      FixedChar = True
      Size = 1
    end
    object Q_Recemissao: TDateField
      FieldName = 'emissao'
    end
    object Q_Recvencimento: TDateField
      FieldName = 'vencimento'
    end
    object Q_Recvalor: TFloatField
      FieldName = 'valor'
    end
    object Q_Recdesconto_nota: TFloatField
      FieldName = 'desconto_nota'
    end
    object Q_Rectotal_nota: TFloatField
      FieldName = 'total_nota'
    end
    object Q_Recdata_recebimento: TDateField
      FieldName = 'data_recebimento'
    end
    object Q_Rectaxa_juro: TFloatField
      FieldName = 'taxa_juro'
    end
    object Q_Recjuro: TFloatField
      FieldName = 'juro'
    end
    object Q_Rectaxa_multa: TFloatField
      FieldName = 'taxa_multa'
    end
    object Q_Recmulta: TFloatField
      FieldName = 'multa'
    end
    object Q_Rectaxa_desconto: TFloatField
      FieldName = 'taxa_desconto'
    end
    object Q_Recdesconto: TFloatField
      FieldName = 'desconto'
    end
    object Q_Recvalor_recebido: TFloatField
      FieldName = 'valor_recebido'
    end
    object Q_Rectipo_recebimento: TStringField
      FieldName = 'tipo_recebimento'
      Size = 40
    end
    object Q_Recmes: TStringField
      FieldName = 'mes'
      FixedChar = True
      Size = 2
    end
    object Q_Recano: TStringField
      FieldName = 'ano'
      Size = 4
    end
    object Q_Rectipo_cliente: TStringField
      FieldName = 'tipo_cliente'
      FixedChar = True
      Size = 1
    end
    object Q_Recauditoria: TStringField
      FieldName = 'auditoria'
      Size = 100
    end
    object Q_Rechistorico: TStringField
      FieldName = 'historico'
      Size = 100
    end
  end
  object DSP_Rec: TDataSetProvider
    DataSet = Q_Rec
    Left = 648
    Top = 320
  end
  object CDS_ItensNF: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_produto'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'id_nf_entrada_cabecalho'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'valor_unitario'
        DataType = ftFloat
      end
      item
        Name = 'valor_total'
        DataType = ftFloat
      end
      item
        Name = 'unidade'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_ItensNF'
    StoreDefs = True
    BeforeInsert = CDS_ItensNFBeforeInsert
    BeforeEdit = CDS_ItensNFBeforeEdit
    BeforePost = CDS_ItensNFBeforePost
    AfterPost = CDS_ItensNFAfterPost
    Left = 809
    Top = 368
    object CDS_ItensNFid: TIntegerField
      FieldName = 'id'
    end
    object CDS_ItensNFid_produto: TIntegerField
      FieldName = 'id_produto'
      Required = True
    end
    object CDS_ItensNFid_nf_entrada_cabecalho: TIntegerField
      FieldName = 'id_nf_entrada_cabecalho'
      Required = True
    end
    object CDS_ItensNFcodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object CDS_ItensNFdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CDS_ItensNFquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object CDS_ItensNFvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object CDS_ItensNFvalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object CDS_ItensNFunidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
  end
  object DS_ItensNF: TDataSource
    DataSet = CDS_ItensNF
    Left = 809
    Top = 416
  end
  object Q_ItensNF: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from nf_entrada_detalhe limit 0')
    SQLConnection = Conexao
    Left = 809
    Top = 272
    object Q_ItensNFid: TIntegerField
      FieldName = 'id'
    end
    object Q_ItensNFid_produto: TIntegerField
      FieldName = 'id_produto'
      Required = True
    end
    object Q_ItensNFid_nf_entrada_cabecalho: TIntegerField
      FieldName = 'id_nf_entrada_cabecalho'
      Required = True
    end
    object Q_ItensNFcodigo: TStringField
      FieldName = 'codigo'
      Size = 13
    end
    object Q_ItensNFdescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object Q_ItensNFquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object Q_ItensNFvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object Q_ItensNFvalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object Q_ItensNFunidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
  end
  object DSP_ItensNF: TDataSetProvider
    DataSet = Q_ItensNF
    Left = 809
    Top = 320
  end
  object Q_NFEntrada: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from nf_entrada_cabecalho limit 0')
    SQLConnection = Conexao
    Left = 721
    Top = 272
    object Q_NFEntradaid: TIntegerField
      FieldName = 'id'
    end
    object Q_NFEntradaid_fornecedor: TIntegerField
      FieldName = 'id_fornecedor'
    end
    object Q_NFEntradanome_fornecedor: TStringField
      FieldName = 'nome_fornecedor'
      Size = 100
    end
    object Q_NFEntradacnpj_fornecedor: TStringField
      FieldName = 'cnpj_fornecedor'
      Size = 14
    end
    object Q_NFEntradanumero_nf: TStringField
      FieldName = 'numero_nf'
    end
    object Q_NFEntradadata_emissao: TDateField
      FieldName = 'data_emissao'
    end
    object Q_NFEntradadata_entrada: TDateField
      FieldName = 'data_entrada'
    end
    object Q_NFEntradatotal_nf: TFloatField
      FieldName = 'total_nf'
    end
  end
  object CDS_NFEntrada: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_fornecedor'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'nome_fornecedor'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cnpj_fornecedor'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'numero_nf'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'data_emissao'
        DataType = ftDate
      end
      item
        Name = 'data_entrada'
        DataType = ftDate
      end
      item
        Name = 'total_nf'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DSP_NFEntrada'
    StoreDefs = True
    Left = 721
    Top = 368
    object CDS_NFEntradaid: TIntegerField
      FieldName = 'id'
    end
    object CDS_NFEntradaid_fornecedor: TIntegerField
      FieldName = 'id_fornecedor'
    end
    object CDS_NFEntradanome_fornecedor: TStringField
      FieldName = 'nome_fornecedor'
      Size = 100
    end
    object CDS_NFEntradacnpj_fornecedor: TStringField
      FieldName = 'cnpj_fornecedor'
      Size = 14
    end
    object CDS_NFEntradanumero_nf: TStringField
      FieldName = 'numero_nf'
    end
    object CDS_NFEntradadata_emissao: TDateField
      FieldName = 'data_emissao'
    end
    object CDS_NFEntradadata_entrada: TDateField
      FieldName = 'data_entrada'
    end
    object CDS_NFEntradatotal_nf: TFloatField
      FieldName = 'total_nf'
    end
  end
  object DS_NFEntrada: TDataSource
    DataSet = CDS_NFEntrada
    Left = 721
    Top = 416
  end
  object DSP_NFEntrada: TDataSetProvider
    DataSet = Q_NFEntrada
    Left = 721
    Top = 320
  end
end
