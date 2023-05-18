program example;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Ice.cryptoGate in '..\Ice.cryptoGate.pas';
(*----------------------------------------------------------------------------*)
const
CPublicKey = '-----BEGIN Public Key-----' + #10 +
'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAy37D/BudjfCa1X40CDAg' + #10 +
'FqS9zN/atYlIb4+JXqdrbGjavTg3/+oWtyn237ySS+Mp57CuXBhPIXkNPhLYdiXv' + #10 +
'YW280Kd6ISfPS3ELi2ZgV588yoMCzzCbepbhLWdBpMEbk4EnOQ/aTMGyOI1uordi' + #10 +
'APdd1zwB5brIdS2jVfVKEtIay29O9UYFr+Q7MHr8Xk2fJ5y2lmwL0sRoH5/0sp8T' + #10 +
'28NYFo8ZLV/voAxph+d8/hNLNMk4Cl55Nf6GtDrKyTR5h458rdOWZz5myAjUAewp' + #10 +
'SL2S/FKSVMCSKQqy0BvD1MjWcJpjKC11k4mUi6k54f2MEHvoiq7dOLlzRn89TJm2' + #10 +
'0wIDAQAB' + #10 +
'-----END Public Key-----';

CPrivateKey = '-----BEGIN PRIVATE KEY-----' + #10 +
'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDLfsP8G52N8JrV' + #10 +
'fjQIMCAWpL3M39q1iUhvj4lep2tsaNq9ODf/6ha3KfbfvJJL4ynnsK5cGE8heQ0+' + #10 +
'Eth2Je9hbbzQp3ohJ89LcQuLZmBXnzzKgwLPMJt6luEtZ0GkwRuTgSc5D9pMwbI4' + #10 +
'jW6it2IA913XPAHlush1LaNV9UoS0hrLb071RgWv5DswevxeTZ8nnLaWbAvSxGgf' + #10 +
'n/SynxPbw1gWjxktX++gDGmH53z+E0s0yTgKXnk1/oa0OsrJNHmHjnyt05ZnPmbI' + #10 +
'CNQB7ClIvZL8UpJUwJIpCrLQG8PUyNZwmmMoLXWTiZSLqTnh/YwQe+iKrt04uXNG' + #10 +
'fz1MmbbTAgMBAAECggEANZ/EGY1VaW/7/UJyh63W5uCmu3RJ+AijM/LJKk5H+ptu' + #10 +
'+On1p9SSA9ZlHfRdQO4tvsZKTC6Du7hgivkAXbIFcNEwLnPTtST+dUzm0+c4gB6Q' + #10 +
'MHVxqhOPBTD5SbOqErZog+hG47yPtCZexpROkUZt5v9IlU1U2qrr5CUQo7gtuuN2' + #10 +
'qTyonb6qQmiWa523Ge9exSxDCi2xjUVt48FDeleDEYJzSAYWon9L9NHqIuCYEPbI' + #10 +
'CCW/xNm+VWiIBVP1211bd+F0aH7Rg3INzzULHDsaKJCcrx4D+ZjzLSwP/+Fb2T4D' + #10 +
'jSaRg00B2RrQcATXVAgfezPaQW5D2Cg2kJFOPXeBMQKBgQDn7XYIv5fvpa+z3eYf' + #10 +
'qYXPv3pPDOsa94spKE7GNcxVmCpc2BqJm39aNtvIu0iWnWzTkxFMQVU16FhB5Ch7' + #10 +
'fGn4dWcvb+mhOw3+g9EKOeFE58ia5D4KQS+S9xMlhXNi7Wi60g1i+6LHndxW4mfN' + #10 +
'1HGX2lFiZ3b7fmonQMupC6RJPQKBgQDgndQCqxeKJoFcXILbHEU8O2lnxIyYlWQR' + #10 +
'gABYnxwgtLULkoNncvTqI8JT8W5iP5TfO8QyMAG3DpP0nsyA8E4BRmCiY16HW2Sn' + #10 +
'7dgdAr1y7OhwjY9fI9QqPZH29CDWYpbpvHZt/NUTcF/89aLpD3tb5Xo4+kSzLRJV' + #10 +
'HL0sNjNhTwKBgCM8k7NOkKHrVV+Jdh4XXmoq2EVMXCfztiPhqN46bDoQ7Va/yoBf' + #10 +
'rKCjNw8vTR78+fzHGliwkGapT0drh68DPwJtq+isIx3I4B5sHoVkN9KFOJg31ykt' + #10 +
'sDGu8izAMsCz+zZvFXOVcazMUh6tNUIzZbLBi53cxFn/Yddm48piJ2qtAoGAa58T' + #10 +
'myexAq+KYd+tjyCPh9mLmn2RQ/aoWL407EFoL7+F04Ki1Wk+MgVqMeBHHGoMgZ1Y' + #10 +
'VxerarNgbt+7arg5F+FJoeTswPwoUVHjr5rFfRBIGs2o+VPob0jK7EFyjmX0mw+C' + #10 +
'yxZOXZ8FTuW+5d5WI+Ti1/QKALPCyecYONvLaH8CgYA9DElKzlD27MzMB0OoNGar' + #10 +
'IYvsNxxx20eUdmE36y7NZLitEYuY2h8UY/gjMQAxVjG6eFr9CqIeAz2tr0BIUX5q' + #10 +
'AI9gHPwx4PaaRomKOdjzMexZg124+rGopsvm4zUcDFK2dtGp5hCm/AE1M/GgoJYP' + #10 +
'bCVNyAGFyIonI0VgralwmA==' + #10 +
'-----END PRIVATE KEY-----';

CAESKey = '12345678910qwertyuiopasd';
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
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


    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
