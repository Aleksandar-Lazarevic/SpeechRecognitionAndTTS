unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    EditWavPath: TEdit;
    BtnBrowse: TButton;
    procedure BtnBrowseClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
const CPP_LIB1 = 'pocketsphinx.dll';
function ps_test(modelpath: PAnsiChar; path: PAnsiChar): PAnsiChar;
  stdcall; external CPP_LIB1 name 'ps_test' delayed;
function ps_livetest(modelpath: PAnsiChar): PAnsiChar;
  stdcall; external CPP_LIB1 name 'ps_livetest' delayed;
function ps_freebuffer(pBuffer: PAnsiChar): Boolean;
  stdcall; external CPP_LIB1 name 'ps_freebuffer' delayed;

const CPP_LIB2 = 'libespeak-ng.dll';
function test_tts(text: PAnsiChar; output: PAnsiChar; data_path: PAnsiChar): Boolean;
  stdcall; external CPP_LIB2 name 'test_tts' delayed;

function StringToPAnsiChar(stringVar : string) : PAnsiChar;
Var
  AnsString : AnsiString;
  InternalError : Boolean;
begin
  InternalError := false;
  Result := '';
  try
    if stringVar <> '' Then
    begin
       AnsString := AnsiString(StringVar);
       Result := PAnsiChar(PAnsiString(AnsString));
    end;
  Except
    InternalError := true;
  end;
  if InternalError or (String(Result) <> stringVar) then
  begin
    Raise Exception.Create('Conversion from string to PAnsiChar failed!');
  end;
end;

procedure TForm1.BtnBrowseClick(Sender: TObject);
var
  selectedFile: string;
  dlg: TOpenDialog;
  result : PAnsiChar;
  modelPath : PAnsiChar;
  filePath : PAnsiChar;
  Start, Elapsed: DWORD;
begin
  BtnBrowse.Enabled := False;
  result := ps_livetest(StringToPAnsiChar(GetCurrentDir + '\model'));
  //ShowMessage('File : '+GetCurrentDir);
  EditWavPath.Text := string(result);
  ps_freebuffer(result);

  // sleep for 5 seconds without freezing
  Start := GetTickCount;
  Elapsed := 0;
  repeat
  // (WAIT_OBJECT_0+nCount) is returned when a message is in the queue.
  // WAIT_TIMEOUT is returned when the timeout elapses.
    if MsgWaitForMultipleObjects(0, Pointer(nil)^, FALSE, 5000-Elapsed, QS_ALLINPUT) <> WAIT_OBJECT_0 then Break;
    Application.ProcessMessages;
    Elapsed := GetTickCount - Start;
  until Elapsed >= 5000;

  test_tts(PAnsiChar(AnsiString(EditWavPath.Text)),
        PAnsiChar(AnsiString('')),
        StringToPAnsiChar(GetCurrentDir + '\data'));

  BtnBrowse.Enabled := True;
      ShowMessage('OK');

  (*
  selectedFile := '';
  dlg := TOpenDialog.Create(nil);
  try
//    dlg.InitialDir := 'C:\';
    dlg.Filter := 'All files (*.wav)|*.wav';
    if dlg.Execute(Handle) then
      selectedFile := dlg.FileName;
  finally
    dlg.Free;
  end;

  if selectedFile <> '' then
    begin
    filePath := StringToPAnsiChar(selectedFile);
    result := ps_test(StringToPAnsiChar(GetCurrentDir + '\model'), filePath);
    //PAnsiChar(AnsiString(result))
    EditWavPath.Text := string(result);
    end;*/
    *)
end;

procedure TForm1.BtnSaveClick(Sender: TObject);
var
  saveDialog : TSaveDialog;
begin
(*
  saveDialog := TSaveDialog.Create(self);
  saveDialog.Title := 'Save your wav file';
  //saveDialog.InitialDir := GetCurrentDir;
  saveDialog.Filter := 'wav file|*.wav';
  saveDialog.DefaultExt := 'wav';
  if saveDialog.Execute
  then
    begin
      //ShowMessage('File : '+saveDialog.FileName)
      test_tts(PAnsiChar(AnsiString(EditTTSText.Text)),
        PAnsiChar(AnsiString(saveDialog.FileName)),
        StringToPAnsiChar(GetCurrentDir + '\data'));
      ShowMessage('OK');
    end;
  //else
  //  ShowMessage('Save file was cancelled');

  saveDialog.Free;  *)
end;

end.
