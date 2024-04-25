unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

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
    Rectangle1: TRectangle;
    Layout7: TLayout;
    Image3: TImage;
    Layout8: TLayout;
    Label8: TLabel;
    Label9: TLabel;
    lvLancamentos: TListView;
    imgCategoria: TImage;
    procedure FormShow(Sender: TObject);
  private
    procedure AddLancamentosLv(id_lancamento: Integer;
                                         descricao, categoria: string;
                                         valor: double; foto: TStream;
                                         dt: TDateTime);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.AddLancamentosLv(id_lancamento: Integer;
                                         descricao, categoria: string;
                                         valor: double; foto: TStream;
                                         dt: TDateTime);
var
  txt: TListItemText;
  img: TListItemImage;
  bmp : TBitmap;
begin
  with lvLancamentos.Items.Add do
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

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  foto: TStream;
  i: Integer;
begin
  foto := TMemoryStream.Create;
  imgCategoria.Bitmap.SaveToStream(foto);
  foto.Position := 0;

  for i := 1 to 10 do
    AddLancamentosLv(1, 'Compra de Passagem', 'Transporte', -50, foto, Date);

  foto.DisposeOf;
end;

end.
