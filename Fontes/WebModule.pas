unit WebModule;

interface

uses
  System.Classes, Web.HTTPApp, Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP;

type
  TWebModuleServer = class(TWebModule)
    DSHTTPWebDispatcher: TDSHTTPWebDispatcher;
    DSServer: TDSServer;
    DSServerClass: TDSServerClass;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure WebModuleServerDefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModuleServer;
  ContentType :string = 'application/json';

implementation

{$R *.dfm}

uses
  ServerMethods, Web.WebReq;

procedure TWebModuleServer.WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType := AnsiString(ContentType);
end;

procedure TWebModuleServer.WebModuleServerDefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  ContentType := 'text/html';
  Response.Content :=
    '<!DOCTYPE html>' +
    '<html>' +
      '<head>' +
        '<meta charset="UTF-8" />' +
        '<title>DataSnap</title>' +
      '</head>' +
      '<body>' +
        '<h1>DataSnap</h1>' +
        '<h2>Server Status - Online</h2>' +
      '</body>' +
    '</html>';
end;

procedure TWebModuleServer.DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethods.TServerMethods;
end;

initialization

finalization
  Web.WebReq.FreeWebModules;

end.
