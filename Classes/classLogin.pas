unit classLogin;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.Graphics;

type
  TLogin = class
  private
    FConn: TFDConnection;
    FIND_LOGIN: string;
    FEMAIL: string;
    FSENHA: string;
    FNOME: string;
    FID_USUARIO: Integer;
    FFOTO: TBitmap;
  public
    constructor Create(conn: TFDConnection);
    property ID_USUARIO: Integer read FID_USUARIO write FID_USUARIO;
    property NOME: string read FNOME write FNOME;
    property EMAIL: string read FEMAIL write FEMAIL;
    property SENHA: string read FSENHA write FSENHA;
    property IND_LOGIN: string read FIND_LOGIN write FIND_LOGIN;
    property FOTO: TBitmap read FFOTO write FFOTO;

    function Inserir(out erro: string): Boolean;
    function Alterar(out erro: string): Boolean;
    function Excluir(out erro: string): Boolean;
    function ListarUsuario(out erro: string): TFDQuery;
    function Login(out erro: string): Boolean;
    function Logout(out erro: string): Boolean;
  end;

implementation

{ TLogin }

constructor TLogin.Create(conn: TFDConnection);
begin
  FConn := conn;
end;

function TLogin.Inserir(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  if NOME = '' then
    begin
      erro := 'Informe seu nome';
      Result := false;
      exit;
    end;

  if EMAIL = '' then
    begin
      erro := 'Informe seu email';
      Result := false;
      exit;
    end;

  if SENHA = '' then
    begin
      erro := 'Informe uma senha';
      Result := false;
      exit;
    end;


  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('INSERT INTO TAB_USUARIO(NOME, EMAIL, SENHA, IND_LOGIN, FOTO)');
      qry.SQL.Add('VALUES(:NOME, :EMAIL, :SENHA, :IND_LOGIN, :FOTO)');
      qry.ParamByName('NOME').Value := NOME;
      qry.ParamByName('EMAIL').Value := EMAIL;
      qry.ParamByName('SENHA').Value := SENHA;
      qry.ParamByName('IND_LOGIN').Value := IND_LOGIN;
      qry.ParamByName('FOTO').Assign(FOTO);
      qry.ExecSQL;

      Result := true;
      erro := '';

    except on ex:exception do
      begin
        Result := False;
        erro := 'Erro ao inserir usuário: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TLogin.Alterar(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  if NOME = '' then
    begin
      erro := 'Informe seu nome';
      Result := false;
      exit;
    end;

  if EMAIL = '' then
    begin
      erro := 'Informe seu email';
      Result := false;
      exit;
    end;

  if SENHA = '' then
    begin
      erro := 'Informe uma senha';
      Result := false;
      exit;
    end;

  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE TAB_USUARIO SET NOME = :NOME, EMAIL = :EMAIL,');
      qry.SQL.Add('SENHA = :SENHA, IND_LOGIN = :IND_LOGIN, FOTO = :FOTO');
      qry.SQL.Add('WHERE ID_USUARIO = :ID_USUARIO');
      qry.ParamByName('ID_USUARIO').Value := ID_USUARIO;
      qry.ParamByName('NOME').Value := NOME;
      qry.ParamByName('EMAIL').Value := EMAIL;
      qry.ParamByName('SENHA').Value := SENHA;
      qry.ParamByName('IND_LOGIN').Value := IND_LOGIN;
      qry.ParamByName('FOTO').Assign(FOTO);
      qry.ExecSQL;

      Result := true;
      erro := '';

    except on ex:exception do
      begin
        Result := False;
        erro := 'Erro ao alterar usuário: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TLogin.Excluir(out erro: string): Boolean;
var
  qry : TFDQuery;
begin
  if ID_USUARIO > 0 then
    begin
      erro := 'Informe um usuario';
      Result := false;
      exit;
    end;

  try
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM TAB_USUARIO');
      qry.SQL.Add('WHERE ID_USUARIO = :ID_USUARIO');
      qry.ParamByName('ID_USUARIO').Value := ID_USUARIO;

      qry.ExecSQL;

      Result := true;
      erro := '';

    except on ex:exception do
      begin
        Result := False;
        erro := 'Erro ao excluir usuário: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TLogin.ListarUsuario(out erro: string): TFDQuery;
var
  qry : TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Fconn;

    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM TAB_USUARIO');
    qry.SQL.Add('WHERE 1 = 1');

    if ID_USUARIO > 0 then
      begin
        qry.SQL.Add('AND ID_USUARIO = :ID_USUARIO');
        qry.ParamByName('ID_USUARIO').Value := ID_USUARIO;
      end;

    if EMAIL <> '' then
      begin
        qry.SQL.Add('AND EMAIL = :EMAIL');
        qry.ParamByName('EMAIL').Value := EMAIL;
      end;

    if SENHA <> '' then
      begin
        qry.SQL.Add('AND SENHA = :SENHA');
        qry.ParamByName('SENHA').Value := SENHA;
      end;

    qry.Active := true;

    Result := qry;
    erro := '';

  except on ex:exception do
    begin
      Result := nil;
      erro := 'Erro ao consultar usuários: ' + ex.Message;
    end;
  end;
end;

function TLogin.Login(out erro: string): Boolean;
var
  qry : TFDQuery;
begin
  if EMAIL = '' then
    begin
      erro := 'Informe o email do usuário';
      Result := false;
      exit;
    end;

  if SENHA = '' then
    begin
      erro := 'Informe a senha do usuário';
      Result := false;
      exit;
    end;

  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Fconn;

    try
      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT * FROM TAB_USUARIO');
      qry.SQL.Add('WHERE EMAIL = :EMAIL');
      qry.SQL.Add('AND SENHA = :SENHA');
      qry.ParamByName('EMAIL').Value := EMAIL;
      qry.ParamByName('SENHA').Value := SENHA;
      qry.Active := true;


      if qry.RecordCount = 0 then
        begin
          Result := false;
          erro := 'Email ou senha inválida';
          Exit;
        end;

      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE TAB_USUARIO');
      qry.SQL.Add('SET IND_LOGIN = :IND_LOGIN');
      qry.ParamByName('IND_LOGIN').Value := 'S';
      qry.ExecSQL;

      Result := true;
      erro := '';

    except on ex:exception do
      begin
        Result := false;
        erro := 'Erro ao validar login: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

function TLogin.Logout(out erro: string): Boolean;
var
  qry : TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Fconn;

    try
      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE TAB_USUARIO');
      qry.SQL.Add('SET IND_LOGIN = :IND_LOGIN');
      qry.ParamByName('IND_LOGIN').Value := 'N';
      qry.ExecSQL;

      Result := true;
      erro := '';

    except on ex:exception do
      begin
        Result := false;
        erro := 'Erro ao fazer logout: ' + ex.Message;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
end;

end.
