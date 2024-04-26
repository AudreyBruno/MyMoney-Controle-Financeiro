unit untCategoriasCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, untPrincipal, FMX.Edit,
  FMX.ListBox;

type
  TfrmCategoriaCad = class(TForm)
    Layout1: TLayout;
    lblTitle: TLabel;
    imgBack: TImage;
    imgSave: TImage;
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout4: TLayout;
    Label4: TLabel;
    Edit3: TEdit;
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
  private
    selectedIcon: TBitmap;
    procedure SelectIcon(img: TImage);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCategoriaCad: TfrmCategoriaCad;

implementation

{$R *.fmx}

procedure TfrmCategoriaCad.SelectIcon(img: TImage);
begin
  selectedIcon := img.Bitmap;

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

procedure TfrmCategoriaCad.Image2Click(Sender: TObject);
begin
  SelectIcon(TImage(Sender));
end;

procedure TfrmCategoriaCad.imgBackClick(Sender: TObject);
begin
  Close;
end;

end.
