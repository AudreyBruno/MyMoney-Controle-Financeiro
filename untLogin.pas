unit untLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.TabControl,
  System.Actions, FMX.ActnList, u99Permissions, FMX.MediaLibrary.Actions,

  {$IFDEF ANDROID}
    FMX.VirtualKeyboard, FMX.Platform,
  {$ENDIF}

  FMX.StdActns, untPrincipal, classLogin, DataModule.Principal,
  FireDAC.Comp.Client;

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
    ActLibrary: TTakePhotoFromLibraryAction;
    ActCamera: TTakePhotoFromCameraAction;
    TimerLogin: TTimer;
    procedure lblBtnLoginCriarContaClick(Sender: TObject);
    procedure lblBtnCreateAccountLoginClick(Sender: TObject);
    procedure roundRectAccountBtnNextClick(Sender: TObject);
    procedure imgBackCreateAccountClick(Sender: TObject);
    procedure imgBackFotoClick(Sender: TObject);
    procedure circleSelectFotoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgFotoClick(Sender: TObject);
    procedure imgLibraryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActLibraryDidFinishTaking(Image: TBitmap);
    procedure ActCameraDidFinishTaking(Image: TBitmap);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure roundRectBtnLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure roundRectBtnCreateAccountClick(Sender: TObject);
    procedure TimerLoginTimer(Sender: TObject);
  private
    { Private declarations }
    permission: T99Permissions;
    procedure permissionError(Sender: TObject);
    procedure OpenForm;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.OpenForm;
begin
  if NOT Assigned(frmPrincipal) then
    Application.CreateForm(TfrmPrincipal, frmPrincipal);

  Application.MainForm := frmPrincipal;
  frmPrincipal.Show;
  Close;
end;

procedure TfrmLogin.permissionError(Sender: TObject);
begin
  ShowMessage('Você não possui permissão de acesso para esse recurso');
end;

procedure TfrmLogin.ActCameraDidFinishTaking(Image: TBitmap);
begin
  circleSelectFoto.Fill.Bitmap.Bitmap := Image;
  ActFoto.Execute;
end;

procedure TfrmLogin.ActLibraryDidFinishTaking(Image: TBitmap);
begin
  circleSelectFoto.Fill.Bitmap.Bitmap := Image;
  ActFoto.Execute;
end;

procedure TfrmLogin.circleSelectFotoClick(Sender: TObject);
begin
  ActSelectFoto.Execute;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmLogin := nil;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  permission := T99Permissions.Create;
end;

procedure TfrmLogin.FormDestroy(Sender: TObject);
begin
  permission.DisposeOf;
end;

procedure TfrmLogin.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService : IFMXVirtualKeyboardService;
{$ENDIF}
begin
  {$IFDEF ANDROID}
    if (Key = vkHardwareBack) then
      begin
        TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
                                                          IInterface(FService));

        if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
          begin
            // Botao back pressionado e teclado visivel...
            // (apenas fecha o teclado)
          end
        else
          begin
            if tabCtrlLogin.ActiveTab = tabCreateAccount then
              begin
                Key := 0;
                ActLogin.Execute
              end
            else if tabCtrlLogin.ActiveTab = TabFoto then
              begin
                Key := 0;
                ActCreateAccount.Execute
              end
            else if tabCtrlLogin.ActiveTab = tabSelectFoto then
              begin
                Key := 0;
                ActFoto.Execute;
              end;
          end;
      end;
  {$ENDIF}
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  tabCtrlLogin.ActiveTab := tabLogin;
  TimerLogin.Enabled := True;
end;

procedure TfrmLogin.imgBackCreateAccountClick(Sender: TObject);
begin
  ActCreateAccount.Execute;
end;

procedure TfrmLogin.imgBackFotoClick(Sender: TObject);
begin
  ActFoto.Execute;
end;

procedure TfrmLogin.imgFotoClick(Sender: TObject);
begin
  permission.Camera(ActCamera, permissionError);
end;

procedure TfrmLogin.imgLibraryClick(Sender: TObject);
begin
  permission.PhotoLibrary(ActLibrary, permissionError);
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

procedure TfrmLogin.roundRectBtnCreateAccountClick(Sender: TObject);
var
  login: TLogin;
  erro: string;
begin
  try
    login := TLogin.Create(DMPrincipal.FDConn);
    login.NOME := edtAccountName.Text;
    login.EMAIL := edtAccountEmail.Text;
    login.SENHA := edtAccountPassword.Text;
    login.IND_LOGIN := 'S';
    login.FOTO := circleSelectFoto.Fill.Bitmap.Bitmap;

    if NOT login.Excluir(erro) then
      begin
        ShowMessage(erro);
        Exit;
      end;

    if NOT login.Inserir(erro) then
      begin
        ShowMessage(erro);
        Exit;
      end;
  finally
    login.DisposeOf;
  end;

  OpenForm;
end;

procedure TfrmLogin.roundRectBtnLoginClick(Sender: TObject);
var
  login: TLogin;
  erro: string;
begin
  try
    login := TLogin.Create(DMPrincipal.FDConn);
    login.EMAIL := edtLoginEmail.Text;
    login.SENHA := edtLoginPassword.Text;

    if NOT login.Login(erro) then
      begin
        ShowMessage(erro);
        Exit;
      end;
  finally
    login.DisposeOf;
  end;

  OpenForm;
end;

procedure TfrmLogin.TimerLoginTimer(Sender: TObject);
var
  login: TLogin;
  erro: string;

  qry : TFDQuery;
begin
  TimerLogin.Enabled := False;

  tabCtrlLogin.ActiveTab := tabLogin;

  try
    login := TLogin.Create(DMPrincipal.FDConn);
    qry := TFDQuery.Create(nil);

    qry := login.ListarUsuario(erro);

    if qry.FieldByName('IND_LOGIN').AsString <> 'S' then
      Exit;

  finally
    qry.DisposeOf;
    login.DisposeOf;
  end;

  OpenForm;
end;

end.
