unit Ice.cryptoGate;
(*
     web: zelig.cn 
     2023-05-17 暂时只有 AES ，RSA 加解密 RSA生成公私密匙  因为在Delphi的工程只用到这两个 哈
*)
interface
  uses
  System.SysUtils,
  System.Classes;
(*----------------------------------------------------------------------------*)
const COutputSize = 1024;
type
TcryptoGate = record
public
class  procedure RSAGenerate(const bits: Cardinal;const privatePath,publicPath: UTF8String );static;
class  function RSAEncrypt(const plainText,publicKey: UTF8String): UTF8String;static;
class  function RSADecrypt(const plainText,privateKey: UTF8String): UTF8String;static;
class  function AESEncrypt(const key,input: UTF8String; var Output: UTF8String):Boolean;static;
class  function AESDecrypt(const key,input: UTF8String; var Output: UTF8String):Boolean; static;
end;

implementation
{$IFDEF MSWINDOWS}
  const PDLL = 'cryptoGate-x64.dll';
{$ENDIF}

{$IFDEF LINUX64}
  const PDLL = 'libcryptoGate-x64.so';
{$ENDIF}

(*----------------------------------------------------------------------------*)

procedure GateGenerateRSAKey(bits: Int64;privatePath,publicPath: PUTF8Char); cdecl; external PDLL;
procedure GateRSAEncrypt(plainText,publicKey: PUTF8Char;Output: PUTF8Char; OutputSize: NativeInt); cdecl; external PDLL;
procedure GateRSADecrypt(plainText,privateKey: PUTF8Char;Output: PUTF8Char; OutputSize: NativeInt); cdecl; external PDLL;
function GateAESEncrypt(key,input,output: PUTF8Char;outputSize: NativeInt):Boolean; cdecl; external PDLL;
function GateAESDecrypt(key,input,output: PUTF8Char;outputSize: NativeInt):Boolean; cdecl; external PDLL;
{ TcryptoGate }

class function TcryptoGate.AESDecrypt(const key, input: UTF8String;
  var Output: UTF8String): Boolean;
var
  data:  array[0..COutputSize] of UTF8Char;
begin
  FillChar(data,COutputSize,0);
  Result:= GateAESDecrypt(PUTF8Char(key),PUTF8Char(input),data,COutputSize);
  if Result then Output:= data;
end;

class function TcryptoGate.AESEncrypt(const key, input: UTF8String;
  var Output: UTF8String): Boolean;
var
  data:  array[0..COutputSize] of UTF8Char;
begin
  FillChar(data,COutputSize,0);
  Result:= GateAESEncrypt(PUTF8Char(key),PUTF8Char(input),data,COutputSize);
  if Result then Output:= data;
end;

class function TcryptoGate.RSADecrypt(const plainText, privateKey: UTF8String):UTF8String;
  var
  data:  array[0..COutputSize] of UTF8Char;
begin
  FillChar(data,COutputSize,0);
  GateRSADecrypt(PUTF8Char(plainText),PUTF8Char(privateKey),data,COutputSize);
  Result:= data;
end;

class function TcryptoGate.RSAEncrypt(const plainText, publicKey: UTF8String):UTF8String;
  var
  data:  array[0..COutputSize] of UTF8Char;
begin
  FillChar(data,COutputSize,0);
  GateRSAEncrypt(PUTF8Char(plainText),PUTF8Char(publicKey),data,COutputSize);
  Result:= data
end;

class procedure TcryptoGate.RSAGenerate(const bits: Cardinal; const privatePath,
  publicPath: UTF8String);
begin
  GateGenerateRSAKey(bits,PUTF8Char(privatePath),PUTF8Char(publicPath));
end;

end.


