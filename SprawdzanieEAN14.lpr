program SprawdzanieEAN14;
uses
SysUtils;

var
ciagEAN13, ciagEAN14: String;
wariant, i: Integer;

function sprawdzenieSumyKontrolnejEAN13(EAN: String): String;
var
suma : Integer;
begin
suma := 1 * StrToInt(EAN[1]) +
3 * StrToInt(EAN[2]) +
1 * StrToInt(EAN[3]) +
3 * StrToInt(EAN[4]) +
1 * StrToInt(EAN[5]) +
3 * StrToInt(EAN[6]) +
1 * StrToInt(EAN[7]) +
3 * StrToInt(EAN[8]) +
1 * StrToInt(EAN[9]) +
3 * StrToInt(EAN[10]) +
1 * StrToInt(EAN[11]) +
3 * StrToInt(EAN[12]);

suma := suma mod 10;
suma := 10 - suma;
suma := suma mod 10;

Result := IntToStr(suma);
end;

function sprawdzenieSumyKontrolnejEAN14(EAN: String): String;
var
suma : Integer;
begin
suma := 3 * StrToInt(EAN[1]) +
1 * StrToInt(EAN[2]) +
3 * StrToInt(EAN[3]) +
1 * StrToInt(EAN[4]) +
3 * StrToInt(EAN[5]) +
1 * StrToInt(EAN[6]) +
3 * StrToInt(EAN[7]) +
1 * StrToInt(EAN[8]) +
3 * StrToInt(EAN[9]) +
1 * StrToInt(EAN[10]) +
3 * StrToInt(EAN[11]) +
1 * StrToInt(EAN[12]) +
3 * StrToInt(EAN[13]);

suma := suma mod 10;
suma := 10 - suma;
suma := suma mod 10;

Result := IntToStr(suma);
end;

function convertToEAN14(ean13: String; wariant: Integer): String;
var
i: Integer;
begin
Result := '00000000000000';

if (length(ean13) <> 13) then
begin
Result := 'Nieprawidlowa dlugosc kodu EAN-13 (powinno byc 13 znakow)';
exit;
end;

if ((wariant < 0) or (wariant >9)) then
begin
Result := 'Wartosc wariantu nie miesci sie w zakresie 0-9!';
exit;
end;

if (sprawdzenieSumyKontrolnejEAN13(ean13)[1] <> ean13[13]) then
begin
Result := 'Nieprawidlowa cyfra kontrolna w kodzie EAN-13';
exit;
end;

for i:=12 downto 1 do
Result[i+1] := ean13[i];

Result[1] := IntToStr(wariant)[1];
Result[14] := sprawdzenieSumyKontrolnejEAN14(Result)[1];
end;

function convertToEAN13(ean14: String): String;
var
i: Integer;
begin
Result := '0000000000000';

if (length(ean14) <> 14) then
begin
Result := 'Dlugosc kodu EAN-14 nie sklada sie z 14 znakow!';
exit;
end;

if (sprawdzenieSumyKontrolnejEAN14(ean14)[1] <> ean14[14]) then
begin
Result := 'Suma kontrolna kodu EAN-14 nie zgadza sie!';
exit;
end;

for i:=1 to 12 do
Result[i] := ean14[i+1];

Result[13] := sprawdzenieSumyKontrolnejEAN13(Result)[1];
end;

begin

writeln('Wybierz opcje:');
writeln('1. EAN-13 => EAN-14');
writeln('2. EAN-14 => EAN-13');
readln(i);

if (i=1) then
begin
write('Wprowadz EAN-13: ');
readln(ciagEAN13);
write('Wybierz wariant: ');
readln(wariant);
ciagEAN14 := convertToEAN14(ciagEAN13, wariant);
write('EAN-14: ');
writeln(ciagEAN14);
end
else
begin
write('Wprowadz EAN-14: ');
readln(ciagEAN14);
ciagEAN13 := convertToEAN13(ciagEAN14);
write('EAN-13: ');
writeln(ciagEAN13);
end;
readln;
end.
