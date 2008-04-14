unit InfoFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, jpeg;

type
  TInfoForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  InfoForm: TInfoForm;

implementation

{$R *.dfm}


procedure TInfoForm.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
