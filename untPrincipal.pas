unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  untLancamentos, untCategorias, FMX.Ani;

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
    Image3: TImage;
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
    procedure lvLancamentosPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure lblTodosLancamentosClick(Sender: TObject);
    procedure AnimationMenuFinish(Sender: TObject);
    procedure imgFecharMenuClick(Sender: TObject);
    procedure lyMenuCatClick(Sender: TObject);
    procedure lyMenuLogoffClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgMenuClick(Sender: TObject);
  private
    procedure OpenMenu(ind: Boolean);
    { Private declarations }
  public
    procedure AddLancamentosLv(listview: TListView;
                                         id_lancamento: Integer;
                                         descricao, categoria: string;
                                         valor: double; foto: TStream;
                                         dt: TDateTime);
    procedure AddCategoriaLv(listview: TListView;
                                       id_categoria: Integer;
                                       descricao: string;
                                       foto: TStream);
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

procedure TfrmPrincipal.AddLancamentosLv(listview: TListView;
                                         id_lancamento: Integer;
                                         descricao, categoria: string;
                                         valor: double; foto: TStream;
                                         dt: TDateTime);
var
  txt: TListItemText;
  img: TListItemImage;
  bmp : TBitmap;
begin
  with listview.Items.Add do
    begin
      Height := 55;
      Tag := id_lancamento;

      txt := TListItemText(Objects.FindDrawable('txtDescricao'));
      txt.Text := descricao;

      txt := TListItemText(Objects.FindDrawable('txtCategoria'));
      txt.Text := categoria;

      txt := TListItemText(Objects.FindDrawable('txtData'));
      txt.Text := FormatDateTime('dd/mm', dt);

      txt := TListItemText(Objects.FindDrawable('txtValor'));
      txt.Text := FormatFloat('#,##0.00', valor);

      img := TListItemImage(Objects.FindDrawable('imgIcon'));

      if foto <> nil then
        begin
          bmp := TBitmap.Create;
          bmp.LoadFromStream(foto);

          img.OwnsBitmap := true;
          img.Bitmap := bmp;
        end;
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

procedure TfrmPrincipal.AddCategoriaLv(listview: TListView;
                                       id_categoria: Integer;
                                       descricao: string;
                                       foto: TStream);
var
  txt: TListItemText;
  img: TListItemImage;
  bmp : TBitmap;
begin
  with listview.Items.Add do
    begin
      Height := 55;
      Tag := id_categoria;

      txt := TListItemText(Objects.FindDrawable('txtDescricao'));
      txt.Text := descricao;

      img := TListItemImage(Objects.FindDrawable('imgIcon'));

      if foto <> nil then
        begin
          bmp := TBitmap.Create;
          bmp.LoadFromStream(foto);

          img.OwnsBitmap := true;
          img.Bitmap := bmp;
        end;
    end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmPrincipal := nil;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  foto: TStream;
  i: Integer;
begin
  foto := TMemoryStream.Create;
  imgCategoria.Bitmap.SaveToStream(foto);
  foto.Position := 0;

  for i := 1 to 10 do
    AddLancamentosLv(frmPrincipal.lvLancamentos, 1, 'Compra de Passagem', 'Transporte', -50, foto, Date);

  foto.DisposeOf;
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

procedure TfrmPrincipal.lvLancamentosPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  foto: TStream;
  i: Integer;
begin
  {if lvLancamentos.Items.Count > 0 then
    if lvLancamentos.GetItemRect(lvLancamentos.Items.Count - 4).Bottom <= lvLancamentos.Height then
      for i := 1 to 10 do
        AddLancamentosLv(frmPrincipal.lvLancamentos, 1, 'Compra' + IntToStr(i), 'Transporte', -50000.59, foto, Date); }
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
begin
  if NOT Assigned(frmLogin) then
      Application.CreateForm(TfrmLogin, frmLogin);

  Application.MainForm := FrmLogin;
  frmLogin.Show;
  frmPrincipal.Close;
end;

end.
