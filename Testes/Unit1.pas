unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, vcl.Wwdotdot, vcl.Wwdbcomb, cxMaskEdit, cxButtonEdit,
  cxTextEdit, vcl.Wwdbedit, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits, Vcl.StdCtrls, System.Typinfo,
  Vcl.Buttons, MREnterLib;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    JvCalcEdit1: TJvCalcEdit;
    wwDBEdit1: TwwDBEdit;
    cxTextEdit1: TcxTextEdit;
    cxButtonEdit1: TcxButtonEdit;
    wwDBComboBox1: TwwDBComboBox;
    SpeedButton1: TSpeedButton;
    MREnter1: TMREnter;
    procedure cxTextEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cxTextEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=VK_RETURN then
   ShowMessage('Teste');
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var pOnKeyDownPropInfo : PPropInfo;
begin

  pOnKeyDownPropInfo := GetPropInfo( Screen.ActiveControl.Parent.ClassInfo, 'KeyDown' );

end;

end.
