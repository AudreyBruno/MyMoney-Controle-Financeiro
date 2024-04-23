unit untLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.TabControl,
  System.Actions, FMX.ActnList;

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
    imgBackCreateAccount: TImage;
    Layout3: TLayout;
    imgBackFoto: TImage;
    lyLoginFooter: TLayout;
    lyLoginFooterCenter: TLayout;
    lblBtnLogin: TLabel;
    lblBtnLoginCriarConta: TLabel;
    ActionList: TActionList;
    ActLogin: TChangeTabAction;
    ActCreateAccount: TChangeTabAction;
    ActFoto: TChangeTabAction;
    ActSelectFoto: TChangeTabAction;
    lyCreateAccountFooter: TLayout;
    lyCreateAccountFooterCenter: TLayout;
    lblBtnCreateAccountLogin: TLabel;
    lblBtnCreateAccount: TLabel;
    rectPageSelectCreateAccount: TRectangle;
    rectPageSelectLogin: TRectangle;
    circleSelectFoto: TCircle;
    procedure lblBtnLoginCriarContaClick(Sender: TObject);
    procedure lblBtnCreateAccountLoginClick(Sender: TObject);
    procedure roundRectAccountBtnNextClick(Sender: TObject);
    procedure imgBackCreateAccountClick(Sender: TObject);
    procedure imgBackFotoClick(Sender: TObject);
    procedure circleSelectFotoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.circleSelectFotoClick(Sender: TObject);
begin
  ActSelectFoto.Execute;
end;

procedure TfrmLogin.imgBackCreateAccountClick(Sender: TObject);
begin
  ActCreateAccount.Execute;
end;

procedure TfrmLogin.imgBackFotoClick(Sender: TObject);
begin
  ActFoto.Execute;
end;

procedure TfrmLogin.lblBtnCreateAccountLoginClick(Sender: TObject);
begin
  ActLogin.Execute;
end;

procedure TfrmLogin.lblBtnLoginCriarContaClick(Sender: TObject);
begin
  ActCreateAccount.Execute;
end;

procedure TfrmLogin.roundRectAccountBtnNextClick(Sender: TObject);
begin
  ActFoto.Execute;
end;

end.
