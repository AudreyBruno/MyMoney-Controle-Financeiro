unit classLancamento;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.Graphics;

type
  TLancamento = class
  private
    FConn: TFDConnection;
    FVALOR: double;
    FDATA_ATE: string;
    FDESCRICAO: string;
    FDATA_DE: string;
    FID_CATEGORIA: Integer;
    FDATA: TDateTime;
    FID_LANCAMENTO: Integer;
  public
    constructor Create(conn: TFDConnection);

    property ID_LANCAMENTO: Integer read FID_LANCAMENTO write FID_LANCAMENTO;
    property ID_CATEGORIA: Integer read FID_CATEGORIA write FID_CATEGORIA;
    property VALOR: double read FVALOR write FVALOR;
    property DATA: TDateTime read FDATA write FDATA;
    property DATA_DE: string read FDATA_DE write FDATA_DE;
    property DATA_ATE: string read FDATA_ATE write FDATA_ATE;
    property DESCRICAO: string read FDESCRICAO write FDESCRICAO;

    function ListarLancamento(qtdResult: integer; out erro: string): TFDQuery;
    function ListarResumo(out erro: string): TFDQuery;
    function Inserir(out erro: string): Boolean;
    function Alterar(out erro: string): Boolean;
    function Excluir(out erro: string): Boolean;
end;

implementation

{ TLancamento }

constructor TLancamento.Create(conn: TFDConnection);
begin
  FConn := conn;
end;

function TLancamento.Inserir(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
    if ID_CATEGORIA <= 0 then
    begin
      erro := 'Informe a categoria do lançamento';
      Result := false;
      exit;
    end;

  if DESCRICAO = '' then
    begin
      erro := 'Informe a descrição do lançamento';
      Result := false;
      exit;
    end;

  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('INSERT INTO TAB_LANCAMENTO(ID_CATEGORIA, VALOR, DATA, DESCRICAO)');
      qry.SQL.Add('VALUES(:ID_CATEGORIA, :VALOR, :DATA, :DESCRICAO)');
      qry.ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
      qry.ParamByName('VALOR').Value := VALOR;
      qry.ParamByName('DATA').Value := FDATA;
      qry.ParamByName('DESCRICAO').Value := DESCRICAO;
      qry.ExecSQL;

      Result := true;
      erro := '';
    except on ex:exception do
      begin
          Result := False;
          erro := 'Erro ao inserir lançamento: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TLancamento.Alterar(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  if ID_LANCAMENTO <= 0 then
    begin
      erro := 'Informe o lançamento';
      Result := false;
      exit;
    end;

  if ID_CATEGORIA <= 0 then
    begin
      erro := 'Informe a categoria do lançamento';
      Result := false;
      exit;
    end;

  if DESCRICAO = '' then
    begin
      erro := 'Informe a descrição do lançamento';
      Result := false;
      exit;
    end;

  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE TAB_LANCAMENTO SET ID_CATEGORIA = :ID_CATEGORIA, VALOR = :VALOR, DATA = :DATA, DESCRICAO = :DESCRICAO');
      qry.SQL.Add('WHERE ID_LANCAMENTO = :ID_LANCAMENTO');
      qry.ParamByName('ID_LANCAMENTO').Value := ID_LANCAMENTO;
      qry.ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
      qry.ParamByName('VALOR').Value := VALOR;
      qry.ParamByName('DATA').Value := FDATA;
      qry.ParamByName('DESCRICAO').Value := DESCRICAO;
      qry.ExecSQL;

      Result := true;
      erro := '';
    except on ex:exception do
      begin
        Result := False;
        erro := 'Erro ao alterar lançamento: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TLancamento.Excluir(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  if ID_LANCAMENTO <= 0 then
    begin
      erro := 'Informe o lançamento';
      Result := false;
      exit;
    end;

  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM TAB_LANCAMENTO');
      qry.SQL.Add('WHERE ID_LANCAMENTO = :ID_LANCAMENTO');
      qry.ParamByName('ID_LANCAMENTO').Value := ID_LANCAMENTO;
      qry.ExecSQL;

      Result := true;
      erro := '';
    except on ex:exception do
      begin
        Result := False;
        erro := 'Erro ao excluir lançamento: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TLancamento.ListarLancamento(qtdResult: integer; out erro: string): TFDQuery;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Fconn;

    qry.Active := false;
    qry.sql.Clear;
    qry.sql.Add('SELECT L.*, C.DESCRICAO AS DESCRICAO_CATEGORIA, C.ICONE');
    qry.sql.Add('FROM TAB_LANCAMENTO L');
    qry.sql.Add('JOIN TAB_CATEGORIA C ON (C.ID_CATEGORIA = L.ID_CATEGORIA)');
    qry.sql.Add('WHERE 1 = 1');

    if ID_LANCAMENTO > 0 then
      begin
        qry.SQL.Add('AND L.ID_LANCAMENTO = :ID_LANCAMENTO');
        qry.ParamByName('ID_LANCAMENTO').Value := ID_LANCAMENTO;
      end;

    if ID_CATEGORIA > 0 then
      begin
        qry.SQL.Add('AND L.ID_CATEGORIA = :ID_CATEGORIA');
        qry.ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
      end;

    if (DATA_DE <> '') AND (DATA_ATE <> '') then
      begin
        qry.SQL.Add('AND L.DATA BETWEEN :DATA_DE AND :DATA_ATE');
        qry.ParamByName('DATA_DE').Value := DATA_DE;
        qry.ParamByName('DATA_ATE').Value := DATA_ATE;
      end;

    qry.sql.Add('ORDER BY L.DATA DESC');

    if qtdResult > 0 then
      qry.sql.Add('LIMIT ' + qtdResult.ToString);

    qry.Active := true;

    Result := qry;
    erro := '';

  except on ex:exception do
    begin
        Result := nil;
        erro := 'Erro ao consultar lançamentos: ' + ex.Message;
    end;
  end;
end;

function TLancamento.ListarResumo(out erro: string): TFDQuery;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Fconn;

    qry.Active := false;
    qry.sql.Clear;
    qry.sql.Add('SELECT C.ICONE, C.DESCRICAO, CAST(SUM(L.VALOR) AS REAL) AS VALOR');
    qry.sql.Add('FROM    TAB_LANCAMENTO L');
    qry.sql.Add('JOIN TAB_CATEGORIA C ON (C.ID_CATEGORIA = L.ID_CATEGORIA)');
    qry.SQL.Add('WHERE L.DATA BETWEEN :DATA_DE AND :DATA_ATE');
    qry.sql.Add('GROUP BY C.ICONE, C.DESCRICAO');
    qry.sql.Add('ORDER BY 3');
    qry.ParamByName('DATA_DE').Value := DATA_DE;
    qry.ParamByName('DATA_ATE').Value := DATA_ATE;
    qry.Active := true;

    Result := qry;
    erro := '';
  except on ex:exception do
    begin
      Result := nil;
      erro := 'Erro ao consultar lançamentos: ' + ex.Message;
    end;
  end;
end;

end.
