unit classCategoria;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.Graphics;

type
  TCategoria = class
  private
    FConn: TFDConnection;
    FDESCRICAO: string;
    FID_CATEGORIA: Integer;
    FINDICE_ICONE: Integer;
    FICONE: TBitmap;
  public
    constructor Create(conn: TFDConnection);
    property ID_CATEGORIA: Integer read FID_CATEGORIA write FID_CATEGORIA;
    property DESCRICAO: string read FDESCRICAO write FDESCRICAO;
    property ICONE: TBitmap read FICONE write FICONE;
    property INDICE_ICONE: Integer read FINDICE_ICONE write FINDICE_ICONE;

    function ListarCategoria(out erro: string): TFDQuery;
    function Inserir(out erro: string): Boolean;
    function Alterar(out erro: string): Boolean;
    function Excluir(out erro: string): Boolean;
end;

implementation

{ TCategoria }

function TCategoria.Alterar(out erro: string): Boolean;
var
  qry : TFDQuery;
begin
  if ID_CATEGORIA <= 0 then
    begin
      erro := 'Informe o ID da categoria';
      Result := false;
      exit;
    end;

  if DESCRICAO = '' then
    begin
      erro := 'Informe a descrição da categoria';
      Result := false;
      exit;
    end;

  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE TAB_CATEGORIA SET DESCRICAO = :DESCRICAO, ICONE = :ICONE, INDICE_ICONE = :INDICE_ICONE');
      qry.SQL.Add('WHERE ID_CATEGORIA = :ID_CATEGORIA');
      qry.ParamByName('DESCRICAO').Value := DESCRICAO;
      qry.ParamByName('ICONE').Assign(ICONE);
      qry.ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
      qry.ParamByName('INDICE_ICONE').Value := INDICE_ICONE;
      qry.ExecSQL;

      Result := true;
      erro := '';
    except on ex:exception do
      begin
        Result := False;
        erro := 'Erro ao alterar categorias: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

constructor TCategoria.Create(conn: TFDConnection);
begin
  FConn := conn;
end;

function TCategoria.Excluir(out erro: string): Boolean;
var
  qry : TFDQuery;
begin
  if ID_CATEGORIA <= 0 then
    begin
      erro := 'Informe o ID da categoria';
      Result := false;
      exit;
    end;

  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM TAB_CATEGORIA');
      qry.SQL.Add('WHERE ID_CATEGORIA = :ID_CATEGORIA');
      qry.ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
      qry.ExecSQL;

      Result := true;
      erro := '';
    except on ex:exception do
      begin
        Result := False;
        erro := 'Erro ao excluir categorias: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TCategoria.Inserir(out erro: string): Boolean;
var
  qry : TFDQuery;
begin
  if DESCRICAO = '' then
    begin
      erro := 'Informe a descrição da categoria';
      Result := false;
      exit;
    end;

  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('INSERT INTO TAB_CATEGORIA(DESCRICAO, ICONE, INDICE_ICONE)');
      qry.SQL.Add('VALUES(:DESCRICAO, :ICONE, :INDICE_ICONE)');
      qry.ParamByName('DESCRICAO').Value := DESCRICAO;
      qry.ParamByName('ICONE').Assign(ICONE);
      qry.ParamByName('INDICE_ICONE').Value := INDICE_ICONE;
      qry.ExecSQL;

      Result := true;
      erro := '';
    except on ex:exception do
      begin
          Result := False;
          erro := 'Erro ao inserir categorias: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TCategoria.ListarCategoria(out erro: string): TFDQuery;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := FConn;

    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM TAB_CATEGORIA');
    qry.SQL.Add('WHERE 1 = 1');

    if ID_CATEGORIA > 0 then
      begin
        qry.SQL.Add('AND ID_CATEGORIA = :ID_CATEGORIA');
        qry.ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
      end;

    qry.Active := True;

    Result := qry;
    erro := '';
  except on Ex:exception do
    begin
      Result := nil;
      erro := 'Erro ao consultar categorias: ' + ex.Message;
    end;
  end;
end;

end.
