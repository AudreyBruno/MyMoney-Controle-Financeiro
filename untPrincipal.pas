unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  untLancamentos, untCategorias, FMX.Ani, uListViewLoader, classLancamento,
  DataModule.Principal, FireDAC.Comp.Client, Data.DB, untLancamentosCad,
  classLogin;

type
  TfrmPrincipal = class(TForm)
    Layout1: TLayout;
    imgMenu: TImage;
    circleAvatar: TCircle;
    imgNotification: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Image1: TImage;
    Image2: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    rectPrincipal: TRectangle;
    Layout7: TLayout;
    imgAddLanc: TImage;
    Layout8: TLayout;
    Label8: TLabel;
    lblTodosLancamentos: TLabel;
    lvLancamentos: TListView;
    imgCategoria: TImage;
    StyleBook: TStyleBook;
    rectMenu: TRectangle;
    imgFecharMenu: TImage;
    lyMenuCat: TLayout;
    Label9: TLabel;
    lyMenuLogoff: TLayout;
    Label10: TLabel;
    lyPrincipal: TLayout;
    AnimationMenu: TFloatAnimation;
    procedure FormShow(Sender: TObject);
    procedure lvLancamentosUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lblTodosLancamentosClick(Sender: TObject);
    procedure AnimationMenuFinish(Sender: TObject);
    procedure imgFecharMenuClick(Sender: TObject);
    procedure lyMenuCatClick(Sender: TObject);
    procedure lyMenuLogoffClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgMenuClick(Sender: TObject);
    procedure imgAddLancClick(Sender: TObject);
    procedure lvLancamentosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    procedure OpenMenu(ind: Boolean);
    procedure ListarLancamentos;
    procedure AbrirLançamentos(id: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses untLogin;

{$R *.fmx}

procedure TfrmPrincipal.OpenMenu(ind: Boolean);
begin
  if rectMenu.Tag = 0 then
    rectMenu.Visible := True;

  AnimationMenu.StartValue := frmPrincipal.Width + 50;
  AnimationMenu.Start;
end;

procedure TfrmPrincipal.AbrirLançamentos(id: integer);
begin
  if NOT Assigned(frmLancamentosCad) then
    Application.CreateForm(TfrmLancamentosCad, frmLancamentosCad);

  if id <> 0 then
    frmLancamentosCad.modo := 'A'
  else
    frmLancamentosCad.modo := 'I';

  frmLancamentosCad.id_lanc := id;
  frmLancamentosCad.ShowModal(procedure(ModalResult: TModalResult)
    begin
      ListarLancamentos;
    end);
end;

procedure TfrmPrincipal.ListarLancamentos;
var
  lanc: TLancamento;
  qry: TFDQuery;
  erro: string;
  i: Integer;
  foto: TStream;
begin
  try
    lvLancamentos.Items.Clear;

    lanc := TLancamento.Create(DMPrincipal.FDConn);
    qry := lanc.ListarLancamento(10, erro);

    if erro <> '' then
      begin
        ShowMessage(erro);
        exit;
      end;

    qry.First;
    for i := 0 to qry.RecordCount - 1 do
      begin
        if qry.FieldByName('ICONE').AsString <> '' then
          foto := qry.CreateBlobStream(qry.FieldByName('ICONE'), TBlobStreamMode.bmRead)
        else
          foto := nil;

        TListViewLoader.AddLancamentosLv(lvLancamentos,
                                         qry.FieldByName('ID_LANCAMENTO').AsInteger,
                                         qry.FieldByName('DESCRICAO').AsString,
                                         qry.FieldByName('DESCRICAO_CATEGORIA').AsString,
                                         qry.FieldByName('VALOR').AsFloat,
                                         foto,
                                         qry.FieldByName('DATA').AsDateTime);

        qry.Next;

        foto.DisposeOf;
      end;

  finally
    lanc.DisposeOf;
  end;
end;

procedure TfrmPrincipal.AnimationMenuFinish(Sender: TObject);
begin
  AnimationMenu.Inverse := not AnimationMenu.Inverse;

  if rectMenu.Tag = 1 then
    begin
      rectMenu.Tag := 0;
      rectMenu.Visible := False;
    end
  else
    rectMenu.Tag := 1;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmPrincipal := nil;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  ListarLancamentos;
end;

procedure TfrmPrincipal.imgAddLancClick(Sender: TObject);
begin
  AbrirLançamentos(0);
end;

procedure TfrmPrincipal.imgFecharMenuClick(Sender: TObject);
begin
  OpenMenu(false);
end;

procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
begin
  OpenMenu(True);
end;

procedure TfrmPrincipal.lblTodosLancamentosClick(Sender: TObject);
begin
  if NOT Assigned(frmLancamentos) then
    Application.CreateForm(TfrmLancamentos, frmLancamentos);

  frmLancamentos.Show;
end;

procedure TfrmPrincipal.lvLancamentosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  AbrirLançamentos(AItem.Tag);
end;

procedure TfrmPrincipal.lvLancamentosUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  txt: TListItemText;
begin
  txt := TListItemText(AItem.Objects.FindDrawable('txtDescricao'));
  txt.Width := lvLancamentos.Width - txt.PlaceOffset.X - 110;
end;

procedure TfrmPrincipal.lyMenuCatClick(Sender: TObject);
begin
  if NOT Assigned(frmCategorias) then
    Application.CreateForm(TfrmCategorias, frmCategorias);

  OpenMenu(false);
  frmCategorias.Show;
end;

procedure TfrmPrincipal.lyMenuLogoffClick(Sender: TObject);
var
  login: TLogin;
  erro: string;
begin
  try
    login := TLogin.Create(DMPrincipal.FDConn);

    if NOT login.Logout(erro) then
      begin
        ShowMessage(erro);
        Exit;
      end;
  finally
    login.DisposeOf;
  end;

  if NOT Assigned(frmLogin) then
      Application.CreateForm(TfrmLogin, frmLogin);

  Application.MainForm := FrmLogin;
  frmLogin.Show;
  frmPrincipal.Close;
end;

end.
