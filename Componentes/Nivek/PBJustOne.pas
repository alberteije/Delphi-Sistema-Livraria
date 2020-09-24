 { -------------------------------------------------------------------------------------}
 { A "JustOne" component for CodeGear Delphi.                                           }
 { Copyright 1997-2007, Patrick Brisacier and Jean-Fabien Connault. All Rights Reserved.}
 { This component can be freely used and distributed in commercial and private          }
 { environments, provided this notice is not modified in any way.                       }
 { -------------------------------------------------------------------------------------}
 { Feel free to contact us if you have any questions, comments or suggestions at:       }
 {   cycocrew@wanadoo.fr (Jean-Fabien Connault)                                         }
 { You can always find the latest version of this component at:                         }
 {   http://perso.wanadoo.fr/cycocrew/delphi/components.html                            }
 { -------------------------------------------------------------------------------------}
 { Date last modified:  2007.05.26                                                      }
 { -------------------------------------------------------------------------------------}

 { -------------------------------------------------------------------------------------}
 { TPBJustOne v1.05                                                                     }
 { -------------------------------------------------------------------------------------}
 { Description:                                                                         }
 {   A component that enables only one unique instance of an application at each time.  }
 { -------------------------------------------------------------------------------------}
 { See example contained in example.zip file for more details.                          }
 { -------------------------------------------------------------------------------------}
 { Revision History:                                                                    }
 { 1.00:  + Initial release                                                             }
 { 1.01:  + Cleaned source code (1997.04.06)                                            }
 { 1.02:  + Changed Register page to "System" (2001.06.16)                              }
 { 1.03:  + Cosmetic changes (2001.09.09)                                               }
 { 1.04:  + Fixed potential access violation (2001.12.09)                               }
 { 1.05:  + Added CodeGear Delphi 2007 support (2007.05.26)                             }
 { -------------------------------------------------------------------------------------}
 { Note:                                                                                }
 { There is a limitation under Windows NT 4.0 : when the application is called again,   }
 { it doesn't come to the front. It's not the case under Windows 95/98/ME/2000/XP/Vista.}
 { -------------------------------------------------------------------------------------}

unit PBJustOne;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TPBJustOne = class(TComponent)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;

const
  MAX_BUFFER_SIZE = 260; // MAX_PATH = 260

var
  MyAppName, MyClassName: array[0..MAX_BUFFER_SIZE] of char;
  MyPopup, LastFound: HWND;
  NumFound: integer;

procedure Register;

implementation

 {***************************************************************************}
 { FUNCTION LookAtAllWindows                                                 }
 {***************************************************************************}

function LookAtAllWindows(Handle: HWND; Temp: longint): BOOL; stdcall;
var
  WindowName, ClassName: array[0..MAX_BUFFER_SIZE] of char;
begin
  Result := True;
  if (GetClassName(Handle, ClassName, SizeOf(ClassName)) > 0) then
  begin
    if (StrComp(ClassName, MyClassName) = 0) then
    begin
      if (GetWindowText(Handle, WindowName, SizeOf(WindowName)) > 0) then
      begin
        if (StrComp(WindowName, MyAppName) = 0) then
        begin
          Inc(NumFound);
          if (Handle <> Application.Handle) then
            LastFound := Handle;
        end;
      end;
    end;
  end;
end;

 {***************************************************************************}
 { CONSTRUCTOR Create                                                        }
 {***************************************************************************}

constructor TPBJustOne.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NumFound  := 0;
  LastFound := 0;
  GetWindowText(Application.Handle, MyAppName, SizeOf(MyAppName));
  GetClassName(Application.Handle, MyClassName, SizeOf(MyClassName));
  EnumWindows(@LookAtAllWindows, 0);
  if (NumFound > 1) then
  begin
    MyPopup := GetLastActivePopup(LastFound);
    BringWindowToTop(LastFound);
    if IsIconic(MyPopup) then
      ShowWindow(MyPopup, SW_RESTORE)
    else
      SetForegroundWindow(MyPopup);
    Application.Terminate;
  end;
end;

 {***************************************************************************}
 { PROCEDURE Register                                                        }
 {***************************************************************************}

procedure Register;
begin
  RegisterComponents('System', [TPBJustOne]);
end;

end.

