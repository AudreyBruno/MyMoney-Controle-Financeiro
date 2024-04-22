unit untLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.TabControl;

type
  TfrmLogin = class(TForm)
    lyLoginPrincipal: TLayout;
    imgLoginLogo: TImage;
    lyLoginEmail: TLayout;
    roundRectLoginEmail: TRoundRect;
    edtLoginEmail: TEdit;
    StyleBook: TStyleBook;
    lyLoginPassword: TLayout;
    roundRectLoginPassword: TRoundRect;
    edtLoginPassword: TEdit;
    lyBtnLogin: TLayout;
    roundRectBtnLogin: TRoundRect;
    lblLogin: TLabel;
    tabCtrlLogin: TTabControl;
    tabLogin: TTabItem;
    tabCreateAccount: TTabItem;
    lyCreateAccount: TLayout;
    Image1: TImage;
    lyAccountEmail: TLayout;
    roundRectAccountEmail: TRoundRect;
    edtAccountEmail: TEdit;
    lyAccountPassword: TLayout;
    roundRectAccountPassword: TRoundRect;
    edtAccountPassword: TEdit;
    lyAccountBtnNext: TLayout;
    roundRectAccountBtnNext: TRoundRect;
    Label1: TLabel;
    lyAccountName: TLayout;
    roundRectAccountName: TRoundRect;
    edtAccountName: TEdit;
    tabFoto: TTabItem;
    lyFoto: TLayout;
    imgFotoEdit: TImage;
    lyBtnCreateAccount: TLayout;
    roundRectBtnCreateAccount: TRoundRect;
    Label2: TLabel;
    tabSelectFoto: TTabItem;
    lySelectFoto: TLayout;
    Label4: TLabel;
    imgFoto: TImage;
    imgLibrary: TImage;
    Layout1: TLayout;
    Layout2: TLayout;
    Image2: TImage;
    Layout3: TLayout;
    Image3: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

end.
