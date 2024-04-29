unit untCategoriasCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, untPrincipal, FMX.Edit,
  FMX.ListBox, classCategoria, FireDAC.Comp.Client, DataModule.Principal,
  untCategorias, FMX.DialogService;

type
  TfrmCategoriaCad = class(TForm)
    Layout1: TLayout;
    lblTitle: TLabel;
    imgBack: TImage;
    imgSave: TImage;
    rectDelete: TRectangle;
    imgDelete: TImage;
    Layout4: TLayout;
    Label4: TLabel;
    edtDescricao: TEdit;
    Line3: TLine;
    Label1: TLabel;
    lbIcone: TListBox;
    ListBoxItem1: TListBoxItem;
    imgSelect: TImage;
    Image2: TImage;
    ListBoxItem2: TListBoxItem;
    Image3: TImage;
    ListBoxItem3: TListBoxItem;
    Image4: TImage;
    ListBoxItem4: TListBoxItem;
    Image5: TImage;
    ListBoxItem5: TListBoxItem;
    Image6: TImage;
    ListBoxItem6: TListBoxItem;
    Image7: TImage;
    ListBoxItem7: TListBoxItem;
    Image8: TImage;
    ListBoxItem8: TListBoxItem;
    Image9: TImage;
    ListBoxItem9: TListBoxItem;
    Image10: TImage;
    ListBoxItem10: TListBoxItem;
    Image11: TImage;
    ListBoxItem11: TListBoxItem;
    Image12: TImage;
    ListBoxItem12: TListBoxItem;
    Image13: TImage;
    ListBoxItem13: TListBoxItem;
    Image14: TImage;
    ListBoxItem14: TListBoxItem;
    Image15: TImage;
    ListBoxItem15: TListBoxItem;
    Image16: TImage;
    ListBoxItem16: TListBoxItem;
    Image17: TImage;
    procedure imgBackClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgSaveClick(Sender: TObject);
    procedure imgDeleteClick(Sender: TObject);
  private
    selectedIcon: TBitmap;
    selectedIndiceIcon: Integer;
    procedure SelectIcon(img: TImage);
    { Private declarations }
  public
    { Public declarations }
    modo: string;
    id_cat: Integer;
  end;

var
  frmCategoriaCad: TfrmCategoriaCad;

implementation

{$R *.fmx}

procedure TfrmCategoriaCad.SelectIcon(img: TImage);
begin
  selectedIcon := img.Bitmap;
  selectedIndiceIcon := TListBoxItem(img.Parent).Index;

  imgSelect.Parent := img.Parent;
end;

procedure TfrmCategoriaCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmCategoriaCad := nil;
end;

procedure TfrmCategoriaCad.FormResize(Sender: TObject);
begin
  lbIcone.Columns := Trunc(lbIcone.Width / 80);
end;

procedure TfrmCategoriaCad.FormShow(Sender: TObject);
var
  cat : TCategoria;
  qry: TFDQuery;
  erro: string;
  item : TListBoxItem;
  img : TImage;
begin
  if modo = 'I' then
    begin
      rectDelete.Visible := False;
      edtDescricao.Text := '';
      SelectIcon(Image2);
    end
  else
    begin
      try
        rectDelete.Visible := True;

        cat := TCategoria.Create(DMPrincipal.FDConn);
        cat.ID_CATEGORIA := id_cat;

        qry := cat.ListarCategoria(erro);

        edtDescricao.Text := qry.FieldByName('DESCRICAO').AsString;

        item := lbIcone.ItemByIndex(qry.FieldByName('INDICE_ICONE').AsInteger);
        imgSelect.Parent := item;

        img := frmCategoriaCad.FindComponent('Image' + (item.Index + 2).tostring) as TImage;
        SelectIcon(img);
      finally
        qry.DisposeOf;
        cat.DisposeOf;
      end;
    end;
end;

procedure TfrmCategoriaCad.Image2Click(Sender: TObject);
begin
  SelectIcon(TImage(Sender));
end;

procedure TfrmCategoriaCad.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCategoriaCad.imgDeleteClick(Sender: TObject);
var
  cat: TCategoria;
  erro: string;
begin
  TDialogService.MessageDialog('Confirma exclusão da categoria?',
                               TMsgDlgType.mtConfirmation,
                               [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
                               TMsgDlgBtn.mbNo,
                               0,
  procedure(const AResult: TModalResult)
  var
    erro: string;
  begin
    if AResult = mrYes then
      begin
        try
          cat := TCategoria.Create(DMPrincipal.FDConn);
          cat.ID_CATEGORIA := id_cat;

          if not cat.Excluir(erro) then
            begin
              ShowMessage(erro);
              Exit;
            end;

          frmCategorias.ListarCategorias;
          Close;
        finally
          cat.DisposeOf;
        end;
      end;
  end);
end;

procedure TfrmCategoriaCad.imgSaveClick(Sender: TObject);
var
  cat : TCategoria;
  erro: string;
  icone: TStream;
begin
  try
    cat := TCategoria.Create(DMPrincipal.FDConn);
    cat.DESCRICAO := edtDescricao.Text;
    cat.ICONE := selectedIcon;
    cat.INDICE_ICONE := selectedIndiceIcon;

    if modo = 'I' then
      begin
        cat.Inserir(erro);
      end
    else
      begin
        cat.ID_CATEGORIA := id_cat;
        cat.Alterar(erro);
      end;

    if erro <> '' then
      begin
        ShowMessage(erro);
        Exit;
      end;

    frmCategorias.ListarCategorias;
    close;
  finally
    cat.DisposeOf;
  end;
end;

end.
