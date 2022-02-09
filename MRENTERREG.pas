{$A-,B-,D-,F-,G+,I-,K+,L-,N+,P+,Q-,R-,S-,T-,V+,W-,X+,Y-}

unit MRENTERREG;

interface

uses
  Messages, WinTypes, WinProcs, SysUtils, Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs;

procedure Register;

implementation

uses
  MREnterLib, ShellApi;

const
  IdVersion = '2.5';

procedure Register;
begin
  RegisterComponents('MR Tools', [TMREnter]);
end;

end.
