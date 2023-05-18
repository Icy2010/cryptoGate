# cryptoGate
#### 为 Delphi 提供 RSA 和 AES加解密使用的
#### 以后如果在Delphi工程中有使用期待的在增加
# 下面为实例代码
```pascal
    TcryptoGate.RSAGenerate(2048,'private.txt','public.txt'); // 生成


    Write('RSA加密后的: ');
    var Res:= TcryptoGate.RSAEncrypt('看看RSA加密后的内容是什么',CPublicKey);
    Writeln(Res);

    Write(#13#10 + 'RSA解密后的: ');
    Res:= TcryptoGate.RSADecrypt(Res,CPrivateKey);
    Writeln(Res);

    if TCryptoGate.AESEncrypt(CAESKey,'看看AES加密后的内容是什么',Res) then
    begin
      Write('AES加密后的: ');
      Writeln(Res);
    end;

    if TCryptoGate.AESDecrypt(CAESKey,Res,Res) then
    begin
      Write(#13#10 + 'AES解密后的: ');
      Writeln(Res);
    end;

```
