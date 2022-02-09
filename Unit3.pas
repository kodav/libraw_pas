unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, libraw_types, FMX.Objects,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TForm3 = class(TForm)
    getversion: TButton;
    open: TButton;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Memo1: TMemo;
    procedure getversionClick(Sender: TObject);
    procedure openClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

//{$LINK 'Obj/utils_libraw_st.obj'}
{$R *.fmx}
{
function strchr(const S: PChar; C: Integer): PChar; cdecl;
begin
  Result := StrScan(S, Chr(C));
end;

function __imp_malloc(Size: Cardinal): Pointer; cdecl;
begin
  GetMem(Result, Size);
end;
}
procedure TForm3.getversionClick(Sender: TObject);
begin
  Memo1.Lines.Add(libraw_version());
end;

procedure TForm3.openClick(Sender: TObject);
var
  libraw_data : plibraw_data_t;
  res, s : integer;
  thumb : TMemoryStream;
  fname : PAnsiChar;
begin
  if (OpenDialog1.Execute) then begin
    s := sizeof(libraw_data^.idata);
    libraw_data := libraw_init(0);
    if (libraw_data <> nil) then begin
      GetMem(fname, Length(OpenDialog1.FileName));
      StrPCopy(fname, OpenDialog1.FileName);
      res := libraw_open_file(libraw_data, fname);
      if res = LIBRAW_SUCCESS then begin
        Memo1.Lines.Add(libraw_data^.idata.make + ' ' + libraw_data^.idata.model + ' ' + libraw_data^.idata.software);
        res := libraw_unpack(libraw_data);
        if res = LIBRAW_SUCCESS then begin
          res := libraw_unpack_thumb(libraw_data);
          if (res = LIBRAW_SUCCESS) and (libraw_data^.thumbnail.tlength > 0)
            and (libraw_data^.thumbnail.thumb <> nil) then begin
            thumb := TMemoryStream.Create();
            try
              thumb.Write(libraw_data^.thumbnail.thumb^, libraw_data^.thumbnail.tlength);
              thumb.Seek(0, soFromBeginning);
              Image1.Bitmap.LoadFromStream(thumb);
            finally
              thumb.Free;
            end;
//            Image1.Bitmap.LoadFromFile(ChangeFileExt(OpenDialog1.FileName, '.JPG'));
          end;
        end;
      end;
      Freemem(fname);

      libraw_close(libraw_data);
    end;
  end;
end;

end.
