program SprawdzanieEAN14;
uses
SysUtils;

var
ean_13, ean_14: String;
variant, i: Integer;

//calculates EAN-13 checksum
function checkSum13(EAN: String): String;
var
sum : Integer;
begin
sum := 1 * StrToInt(EAN[1]) +
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

sum := sum mod 10;
sum := 10 - sum;
sum := sum mod 10;

Result := IntToStr(sum);
end;

//calculates EAN-14 checksum
function checkSum14(EAN: String): String;
var
sum : Integer;
begin
sum := 3 * StrToInt(EAN[1]) +
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

sum := sum mod 10;
sum := 10 - sum;
sum := sum mod 10;

Result := IntToStr(sum);
end;


//EAN-13 => EAN-14
function convertToEAN14(ean13: String; variant: Integer): String;
var
i: Integer;
begin
Result := '00000000000000';

//check length of code
if (length(ean13) <> 13) then
begin
Result := 'Nieprawidlowa dlugosc kodu EAN-13 (powinno byc 13 znakow)';
exit;
end;

//check variant
if ((variant < 0) or (variant >9)) then
begin
Result := 'Nieprawidlowa wartosc wariantu (powinno byc 0-9)';
exit;
end;

//check control digit
if (checkSum13(ean13)[1] <> ean13[13]) then
begin
Result := 'Nieprawidlowa cyfra kontrolna w kodzie EAN-13';
exit;
end;

//convert EAN-13 to EAN-14
for i:=12 downto 1 do
Result[i+1] := ean13[i];

Result[1] := IntToStr(variant)[1];
Result[14] := checkSum14(Result)[1];
end;

//EAN-14 => EAN-13
function convertToEAN13(ean14: String): String;
var
i: Integer;
begin
Result := '0000000000000';

//check code length
if (length(ean14) <> 14) then
begin
Result := 'Nieprawidlowa dlugosc kodu EAN-14 (powinno byc 14 znakow)';
exit;
end;

//control check digit
if (checkSum14(ean14)[1] <> ean14[14]) then
begin
Result := 'Nieprawidlowa suma kontrolna w kodzie EAN-14';
exit;
end;

//convert EAN-14 to EAN-13
for i:=1 to 12 do
Result[i] := ean14[i+1];

Result[13] := checkSum13(Result)[1];
end;

begin

writeln('Wybierz opcje:');
writeln('1. EAN-13 => EAN-14');
writeln('2. EAN-14 => EAN-13');
readln(i);

if (i=1) then
begin
writeln('Podaj kod EAN-13');
readln(ean_13);
writeln('Podaj wariant');
readln(variant);
ean_14 := convertToEAN14(ean_13, variant);
writeln('Kod EAN-14 to: ');
writeln(ean_14);
end
else
begin
writeln('Podaj kod EAN-14');
readln(ean_14);
ean_13 := convertToEAN13(ean_14);
writeln('Kod EAN-13 to: ');
writeln(ean_13);
end;
readln;
end.
