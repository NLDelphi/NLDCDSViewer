unit DataFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGrids;

type
  TFrame1 = class(TFrame)
    DBGrid1: TDBGrid;
  private
    FFilename: string;
  public
    property Filename: string read FFilename write FFilename;
  end;

implementation

{$R *.dfm}

end.
