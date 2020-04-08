unit HackDBGrid;

interface

uses
  Vcl.DBGrids
  , Messages
  , WinAPI.Windows
  ;

type
  // Hack to redeclare your TDBGrid here whitout the the form designer going mad
  THackDBGrid = class(Vcl.DBGrids.TDBGrid)
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
  end;

implementation

procedure THackDBGrid.WMHScroll(var Msg: TWMHScroll);
begin
  case Msg.ScrollCode of
    SB_ENDSCROLL:
      OutputDebugString('SB_ENDSCROLL');
    SB_LEFT:
      OutputDebugString('SB_LEFT');
    SB_RIGHT:
      OutputDebugString('SB_RIGHT');
    SB_LINELEFT:
      OutputDebugString('SB_LINELEFT');
    SB_LINERIGHT:
      OutputDebugString('SB_LINERIGHT');
    SB_PAGELEFT:
      OutputDebugString('SB_PAGELEFT');
    SB_PAGERIGHT:
      OutputDebugString('SB_PAGERIGHT');
    SB_THUMBPOSITION:
      OutputDebugString('SB_THUMBPOSITION');
  end;
  inherited; // to keep the expected behavior
end;

end.
