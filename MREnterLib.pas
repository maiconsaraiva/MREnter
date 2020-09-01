unit MREnterLib;

interface

uses
  Messages, WinTypes, WinProcs, SysUtils, Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.stdCtrls, Vcl.DBGRIDS;

{$R MREnterLib.res}

function ObjectInheritsFrom(AObj: TObject; AClassName: String): Boolean;

type

  TMREnter = class(TComponent)
  private
    { Private declarations }
    FAutor            : string;

    FEnterEnabled     : Boolean;

    FFocusColor       : TColor;
    FFocusEnabled     : Boolean;

    FHintEnabled      : Boolean;
    FHintColor        : TColor;

    FAutoSkip         : Boolean;
    FKeyBoardArrows   : Boolean;
    FOnMessage        : TMessageEvent;
    FOnMessageRescue  : TMessageEvent;

    FOnIdle           : TIdleEvent;
    FOnIdleRescue     : TIdleEvent;

    FOnHint           : TNotifyEvent;
    FOnHintRescue     : TNotifyEvent;

    FOnHelp           : THelpEvent;
    FOnHelpRescue     : THelpEvent;

    FClassList        : TStringList;
    procedure SetClassList( AClassList: TStringList );
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoShowHint( Control: TWinControl );
    procedure LocalOnMessage(var Msg: TMsg; var Handled: Boolean);
    procedure LocalOnIdle(Sender: TObject; var Done: Boolean);
    procedure LocalOnHint(Sender: TObject);
    function  LocalOnHelp(Command: word; Data: Nativeint; var CallHelp: Boolean):Boolean;

    function CheckClassList( AClassName: string ): Boolean;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
  published
    { Published declarations }
    property Autor : string           read FAutor          write FAutor stored False;
    property AutoSkip: Boolean        read FAutoSkip        write FAutoSkip;
    property EnterEnabled: Boolean    read FEnterEnabled    write FEnterEnabled;
    property ClassList: TStringList   read FClassList       write SetClassList;
    property KeyBoardArrows : Boolean read FKeyBoardArrows  write FKeyBoardArrows;
    property FocusColor : TColor      read FFocusColor      write FFocusColor;
    property FocusEnabled : Boolean   read FFocusEnabled    write FFocusEnabled;
    property HintColor : TColor       read FHintColor       write FHintColor;
    property HintEnabled : Boolean    read FHintEnabled     write FHintEnabled;

    property OnMessage: TMessageEvent read FOnMessage       write FOnMessage;
    property OnIdle:    TIdleEvent    read FOnIdle          write FOnIdle;
    property OnHint:    TNotifyEvent  read FOnHint          write FOnHint;
    property OnHelp:    THelpEvent    read FOnHelp          write FOnHelp;
  end;

implementation

uses
  ShellAPI,
  Vcl.dbctrls,
  TypInfo,
  MRENTERREG,
  Vcl.Grids;

Var
  FHintWindow       : THintWindow;
  FFocusControl     : TWinControl;
  FActiveControl    : TWinControl;
  FFocusColorReturn : TColor;

{ GetHintWindow}

function HintWindow: THintWindow;
begin

  if FHintWindow = nil then
  begin
    FHintWindow := THintWindow.Create(Application);
    FHintWindow.Visible := False;
  end;

  Result := FHintWindow;

end;

{ Create }
constructor TMREnter.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  FAutor          := 'martins@mrsoftware.com.br';
  {Se FAutoSkip = True, irá pular automáticamente para o próximo campo ao 
  completar a quantidade de caracteres definida em MaxLength (se este estiver definido)}
  FAutoSkip       := False; 
  FFocusEnabled   := True;
  FKeyBoardArrows := False;
  FClassList      := TStringList.create;
  FEnterEnabled   := True;
  FFocusColor     := clYellow;
  FHintColor      := Application.HintColor;
  FHintEnabled    := True;
  with FClassList do
  begin
    Add('TMaskEdit');
    Add('TEdit');
    Add('TDBEdit');
    Add('TDBCheckBox');
    Add('TTabbedNoteBook');
    Add('TComboBox');
    Add('TDBComboBox');
    //Add('TStringGrid');            { Suporte ao tratamento de Grids       }
    //Add('TDrawGrid');
    //Add('TDBGrid');

    Add('TDBCheckDocEdit');  { Componente p/ edição de CGC do Roger       }
    Add('TMRDBExtEdit');     { Edit com busca incremental MR              }
    Add('TDBDateEdit');      { Componente p/ edição de datas do Sebastião }
    Add('============================');
    //Add('TwwDBGrid');              { Suporte aos componentes do InfoPower }
    Add('TwwDBEdit');              { Já que tem um monte de gente que usa }
    Add('TwwDBComboBox');          { achei por bem deixar todos disponí-  }
    Add('TwwDBSpinEdit');          { veis durante a criação do componen-  }
    Add('TwwDBComboDlg');          { te, assim como os outros ....        }
    Add('TwwDBLookupCombo');       {                                      }
    Add('TwwDBLookupComboDlg');    { ideia do Dennis ...                  }
    Add('TwwIncrementalSearch');   { valeu ...                            }
    Add('TwwDBRitchEdit');         { 02/03/1999                           }
    Add('TwwKeyCombo');            {                                      }
    Add('============================');
    Add('TRxDBLookupList');        { Suporte aos componentes do RxLib     }
    Add('TRxDBGrid');              {                                      }
    Add('TRxDBLookupCombo');       { Paulo H. Trentin                     }
    Add('TRxDBCalcEdit');          { www.rantac.com.br/users/phtrentin    }
    Add('TRxDBComboBox');
    Add('TRxDBComboEdit');
    Add('TDBDateEdit');
    Add('TRxCalcEdit');
    Add('TCurrencyEdit');
    Add('TRxLookupEdit');


    //Adicionados os componentes da paleta Jedi
    Add('============================');
    Add('TJvEdit');
    Add('TJvCalcEdit');
    Add('TJvValidateEdit');
    Add('TJvMaskEdit');
    Add('TJvComboEdit');
    Add('TJvFileNameEdit');
    Add('TJvDirectoryEdit');
    Add('TJvSpinEdit');
    Add('TJvDatePickerEdit');
    Add('TJvDateEdit');
    Add('TJvDBEdit');
    Add('TJvDBCalcEdit');
    Add('TJvDBDatePickerEdit');
    Add('TJvDBSpinEdit');
    Add('TJvDBLookupEdit');
    Add('TJvDBComboEdit');
    Add('TJvDBDateEdit');
    Add('TJvDBMaskEdit');
    Add('TJvDBLookupComboEdit');
    Add('TJvDBSearchEdit');
    Add('TJvDBFindEdit');

    //Suporte aos componentes Raize
    Add('============================');
    Add('TRzDBEdit');
    Add('TRzDBButtonEdit');
    Add('TRzDBDateTimeEdit');
    Add('TRzDBNumericEdit');
    Add('TRzDBSpinEdit');
    Add('TRzDBSpandEdit');
    Add('TRzDBSpinner');
    Add('TRzTBTrackBar');
    Add('TRzDBDateTimePicker');
    Add('TRzDBComboBox');
    Add('TRzDBLookupComboBox');
    Add('TRzDBCheckBox');
    Add('TRzDBLookupDialog');
    Add('TRzDBRadioGroup');
    Add('TRzDBCheckBoxGroup');

    //31/08/2020 - Suporte aos Componentes da DevExpress
    Add('============================');
    Add('TcxTextEdit');
    Add('TcxComboBox');
    Add('TcxLookupComboBox');
    Add('TcxCheckBox');
    Add('TcxDateEdit');
    Add('TcxCalcEdit');
    Add('TcxCurrencyEdit');
    Add('TcxCheckComboBox');
    Add('TcxSpinEdit');
    Add('TcxTimeEdit');
    Add('TcxButtonEdit');
    Add('TcxMaskEdit');
    Add('TcxHyperLinkEdit');
    Add('TcxFontNameComboBox');
    Add('TcxColorComboBox');
    Add('TcxShellComboBox');
    Add('TcxImageComboBox');
    Add('TcxMRUEdit');
    Add('TcxPopupEdit');
    Add('');
    Add('TcxDBTextEdit');
    Add('TcxDBComboBox');
    Add('TcxDBLookupComboBox');
    Add('TcxDBCheckBox');
    Add('TcxDBDateEdit');
    Add('TcxDBCalcEdit');
    Add('TcxDBCurrencyEdit');
    Add('TcxDBCheckComboBox');
    Add('TcxDBSpinEdit');
    Add('TcxDBTimeEdit');
    Add('TcxDBButtonEdit');
    Add('TcxDBMaskEdit');
    Add('TcxDBHyperLinkEdit');
    Add('TcxDBFontNameComboBox');
    Add('TcxDBColorComboBox');
    Add('TcxDBShellComboBox');
    Add('TcxDBImageComboBox');
    Add('TcxDBMRUEdit');
    Add('TcxDBPopupEdit');



  end;

  if not( csDesigning in ComponentState ) then
  begin
    FOnMessageRescue      := Application.OnMessage;
    Application.OnMessage := LocalOnMessage;

    FOnIdleRescue         := Application.OnIdle;
    Application.OnIdle    := LocalOnIdle;

    FOnHintRescue         := Application.OnHint;
    Application.OnHint    := LocalOnHint;

    FOnHelpRescue         := Application.OnHelp;
    Application.OnHelp    := LocalOnHelp;

  end;

end;

{ Destroy }
destructor TMREnter.Destroy;
begin
  FClassList.free;

  if Assigned( FOnMessageRescue ) then
    Application.OnMessage := FOnMessageRescue;

  if Assigned( FOnIdleRescue ) then
    Application.OnIdle := FOnIdleRescue;

  if Assigned( FOnHintRescue ) then
    Application.OnHint := FOnHintRescue;

  if Assigned( FOnHelpRescue ) then
    Application.OnHelp := FOnHelpRescue;

  inherited Destroy;
end;

procedure TMREnter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and
     (AComponent = FFocusControl) then
    FFocusControl := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TMREnter.SetClassList( AClassList: TStringList );
begin
  FClassList.Assign( AClassList );
end;

procedure TMREnter.LocalOnMessage(var Msg: TMsg; var Handled: Boolean);
var
  pMaxLengthPropInfo,
  pColorPropInfo,
  pOnKeyDownPropInfo,
  pOnKeyPressPropInfo,
  pColPropInfo,
  pColCountPropInfo : PPropInfo;
  intMaxLength,
  intSelStart,
  intCol,
  intColCount       : integer;
  bCheckClassList, Is_cxCustomEdit : Boolean;
  wActiveControl : TWinControl;
  Obj : TObject;
begin


  Is_cxCustomEdit := False;
  if Screen.ActiveControl <> nil then
  begin
    bCheckClassList := False;
    wActiveControl := Screen.ActiveControl;

    if CheckClassList( Screen.ActiveControl.ClassName ) then
    begin
      bCheckClassList := True;
      wActiveControl := Screen.ActiveControl;
    end
    else
      {Tratamento feito para comportar componentes da DevExpress

      "When a TcxDBTextEdit is focused, the Screen.ActiveControl has the type TcxCustomInnerTextEdit.
      In my opinion, the ActiveControl should be of the type TcxDBTextEdit.
      How else could I determine if ActiveControl is of the type TcxTextEdit or TcxDBTextEdit?"

      Answer:
      By design, our editors are wrappers (to support CX styles) for inner editors which implement
      the editing functionality. You may use code similar to the following to obtain the editor
      corresponding to a particular inner control.
      Fonte: https://supportcenter.devexpress.com/ticket/details/a1102
      }
      //Se Owner existir e herdar de "TcxCustomEdit" então o tratamento deverá ser feito no Screen.ActiveControl.Owner
      // e não em Screen.ActiveControl
      if (not bCheckClassList) and (Screen.ActiveControl.Owner <> nil) then
        if (Screen.ActiveControl.Owner is TWinControl) then
          if ObjectInheritsFrom(Screen.ActiveControl.Owner, 'TcxCustomEdit') then
          begin
            bCheckClassList := CheckClassList( Screen.ActiveControl.Owner.ClassName );
            if bCheckClassList then
              wActiveControl := Screen.ActiveControl.Owner as TWinControl; //ActiveControl da DevExpress
            Is_cxCustomEdit := True;
          end;
  end
  else
  begin
    bCheckClassList := False;
    wActiveControl := nil;
  end;

  if ( FFocusEnabled ) then
  begin
    if ( FActiveControl <> wActiveControl ) then
    begin

      //
      // if the control was out then turn off the hint window
      //
      if ( FHintWindow <> nil ) then
      begin
        FHintWindow.ReleaseHandle;
        FHintWindow := nil;
      end;

      //
      // Changed = ActiveControl
      //
      if FActiveControl <> wActiveControl then
      begin
        FActiveControl := wActiveControl;
        DoShowHint(FActiveControl);
      end;

      //
      // if focus control <> nil then the control was changed
      //
      if ( FFocusControl <> nil ) then
      begin
        //
        // Antes de setar de volta a cor, verifico se o component nao esta
        // sendo destruido
        //
        if not( csDestroying in FFocusControl.ComponentState ) then
        begin
          pColorPropInfo := GetPropInfo( FFocusControl.ClassInfo, 'Color' );
          if ( pColorPropInfo <> nil ) then
            SetOrdProp( FFocusControl, 'Color', FFocusColorReturn )
          else
          if Is_cxCustomEdit then
          begin
            {Tratamento para componentes da DevExpress (não possuem a propriedade "Color", e sim
            "StyleFocused (TcxStyle) e dentro dela tem a Color que define a cor quando o objeto está em foco}
            Obj := GetObjectProp(FFocusControl, 'StyleFocused');  //StyleFocused : TcxStyle
            if Obj <> nil then
              if GetPropInfo(Obj, 'Color' ) <> nil then
                SetPropValue(Obj, 'Color', FFocusColorReturn );
          end;
        end;
        FFocusControl := nil;
      end;

      //
      // The new control is geting
      //

      if bCheckClassList then
        FFocusControl := wActiveControl else FFocusControl := nil;

      //
      // Set the Focus Color to new control
      //
      if ( FFocusControl <> nil ) then
      begin
        pColorPropInfo := GetPropInfo( FFocusControl.ClassInfo, 'Color' );
        if ( pColorPropInfo <> nil ) then
        begin
          FFocusColorReturn := GetOrdProp( FFocusControl, pColorPropInfo );
          SetOrdProp( FFocusControl, 'Color', FFocusColor );
        end
        else
        if Is_cxCustomEdit then
        begin
          {Tratamento para componentes da DevExpress (não possuem a propriedade "Color", e sim
          "StyleFocused (TcxStyle) e dentro dela tem a Color que define a cor quando o objeto está em foco}
          Obj := GetObjectProp(FFocusControl, 'StyleFocused');  //StyleFocused : TcxStyle
          if Obj <> nil then
            if GetPropInfo(Obj, 'Color' ) <> nil then
              SetPropValue(Obj, 'Color', FFocusColor );
        end;
      end;

    end;
  end;

  if FEnterEnabled then
  if Screen <> nil then
  if wActiveControl <> nil then
  if ( ( Msg.message = WM_KeyDown ) and ( bCheckClassList ) ) then
  begin
    case Msg.wParam of
      VK_Return:  if ( wActiveControl is TCustomGrid ) then
                  begin
                    if ( wActiveControl is TDBGrid ) then Msg.wParam := VK_TAB
                    else Msg.wParam := VK_Right;
                  end
                  else
                  begin
                    pOnKeyDownPropInfo := GetPropInfo( wActiveControl, 'OnKeyDown' );
                    pOnKeyPressPropInfo:= GetPropInfo( wActiveControl, 'OnKeyPress' );

                    if ( wActiveControl is TCustomComboBox ) then
                    begin
                      if not ( wActiveControl as TCustomComboBox ).DroppedDown then Msg.wParam := VK_TAB;
                    end
                    else
                      if ( pOnKeyDownPropInfo <> nil ) and (pOnKeyPressPropInfo <> nil) then
                      begin
                        if ( GetOrdProp( wActiveControl, pOnKeyDownPropInfo ) = 0 )
                          and ( GetOrdProp( wActiveControl, pOnKeyPressPropInfo ) = 0 )
                        then
                          Msg.wParam := VK_TAB;
                      end;

                  end;
      VK_Down  :  if (FKeyBoardArrows) and
                     not( wActiveControl is TCustomGrid ) and
                     not( wActiveControl is TCustomComboBox ) then
                    Msg.wParam := VK_TAB;
      VK_Up    :  if (FKeyBoardArrows) and
                     not( wActiveControl is TCustomGrid )  and
                     not( wActiveControl is TCustomComboBox ) then
                  begin
                    Msg.wParam := VK_CLEAR;
                    keybd_event(VK_SHIFT,0,0,0);
                    keybd_event(VK_TAB,0,0,0);
                    Keybd_event(VK_SHIFT,0,Keyeventf_keyup,0);
                  end;
      VK_Back  :  ;
    else

//
// Mais um codigo em quarentena
//
//      if ( wActiveControl is TCustomEdit ) and
      if ( bCheckClassList ) and ( FAutoSkip ) then
      begin
        { Verifica a propriedade MaxLength }
        pMaxLengthPropInfo := GetPropInfo( wActiveControl.ClassInfo, 'MaxLength' );

        { Verifica a propriedade SelStart }
        { furada, GetPropInfo só trabalha com Published }
        { pSelStartPropInfo := GetPropInfo( wActiveControl.ClassInfo, 'SelStart' ); }

        if ( pMaxLengthPropInfo <> nil ) then
        begin

          { Pega os valores das propriedades }
          intMaxLength := GetOrdProp( wActiveControl, pMaxLengthPropInfo );

          //
          // Ainda preciso deixar esse codigo mais bonito :(((
          //
          if ( wActiveControl is TCustomComboBox ) then
            intSelStart  := ( wActiveControl as TCustomCombobox ).SelStart;

          if ( wActiveControl is TCustomEdit ) then
            intSelStart  := ( wActiveControl as TCustomEdit).SelStart;
          // =============================================

          if ( intMaxLength <> 0 ) and
             ( intMaxLength = ( intSelStart + 1 ) ) then
            keybd_event(13,0,0,0);
        end;
      end;
    end;
  end;

  if Assigned( FOnMessageRescue ) then FOnMessageRescue( Msg, Handled );
  if Assigned( FOnMessage ) then FOnMessage( Msg, Handled );
end;

procedure TMREnter.LocalOnIdle(Sender: TObject; var Done: Boolean);
begin
  if not (csDestroying in Application.ComponentState) then
  begin
    if Assigned( FOnIdleRescue ) then FOnIdleRescue( Sender, Done );
    if Assigned( FOnIdle ) then FOnIdle( Sender, Done );
  end;
end;

procedure TMREnter.LocalOnHint(Sender: TObject);
begin
  if not (csDestroying in Application.ComponentState) then
  begin
    if Assigned( FOnHintRescue ) then FOnHintRescue( Sender );
    if Assigned( FOnHint ) then FOnHint( Sender );
  end;
end;

function  TMREnter.LocalOnHelp(Command: word; Data: Nativeint; var CallHelp: Boolean):Boolean;
begin
  result := true;
  if not (csDestroying in Application.ComponentState) then
  begin
    if Assigned( FOnHelpRescue ) then result:= FOnHelpRescue( Command, Data, CallHelp );
    if Assigned( FOnHelp ) then result:= FOnHelp( Command, Data, CallHelp );
  end;
end;

function TMREnter.CheckClassList( AClassName: string ): Boolean;
var
  intX : integer;
begin
  result := false;
  for intX := 0 to FClassList.Count-1 do
  begin
    result := AnsiCompareText( AClassName, FClassList.strings[intX] ) = 0;
    if result then
      break;
  end;
end;

procedure TMREnter.DoShowHint( Control : TWinControl );
var
  lPoint : TPoint;
  lHintRect: TRect;
  lHintWindow: THintWindow;

begin

  if (Control.Hint = '') or
     not( HintEnabled ) then Exit;

  lHintWindow := HintWindow;
  lHintWindow.Color := FHintColor;

  { display hint below bottom left corner of speed button }
  lPoint.X := 0;
  lPoint.Y := Control.Height;

  { convert to scree corrdinates }
  lPoint := Control.ClientToScreen(lPoint);

  { set hint window size & position }
  lHintRect.Left   := lPoint.X;
  lHintRect.Top    := lPoint.Y ;
  lHintRect.Right  := lHintRect.Left +  lHintWindow.Canvas.TextWidth(Control.Hint)  + 6;
  lHintRect.Bottom := lHintRect.Top  +  lHintWindow.Canvas.TextHeight(Control.Hint) + 2;

  lHintWindow.Visible := True;
  lHintWindow.ActivateHint(lHintRect, Control.Hint);

end;

function ObjectInheritsFrom(AObj: TObject; AClassName: String): Boolean;
var
  ClassType: TClass;
begin
  Result := False;
  ClassType := aObj.ClassType;
  //Percorre as Classes parents (Classes Pai) verificanso se alguma delas é a passada em ClassName
  //Fonte: http://docs.embarcadero.com/products/rad_studio/delphiAndcpp2009/HelpUpdate2/EN/html/delphivclwin32/System__TObject__ClassParent.html
  repeat
    if LowerCase(ClassType.ClassName) = LowerCase(aClassName) then
    begin
      Result := True;
      Break;
    end;
    ClassType := ClassType.ClassParent;
  until ClassType = nil;
end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  FHintWindow := nil;

finalization

  FHintWindow := nil;

end.
