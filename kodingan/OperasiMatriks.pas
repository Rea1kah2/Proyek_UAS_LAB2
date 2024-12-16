program Operasi_Matriks;
uses crt,sysutils;

label
    penjumlahan,pengurangan,perkalian,transpos,determinan,kofaktor,adjoint,menu_utama,isikeluar,isi_lagi;
    
type
    Tmatriks = array[1..3,1..3] of longint;

    Tpengguna = record
        nama : string[25];
        umur : integer;
        hobi : string[20];
    end;

procedure intro(pengguna : Tpengguna);
begin
    if(pengguna.umur < 17) then
    begin
        with pengguna do
        begin
            writeln('Hai ',nama,'!, senang deh bisa kenalan sama kamu!');
            writeln('Terus umurnya baru ',umur,' tahun dong!, masih kecil bangettt!');
            writeln('Terus hobinya ',hobi,' lagi. Sama kayak bocil dekat rumah aku!');
        end;
    end
    else if(pengguna.umur >= 17) then
    begin
        with pengguna do
        begin
            writeln('Hai ',nama,'!, senang deh bisa kenalan sama kamu!');
            writeln('Terus umurnya udah ',umur,' tahun ya!, udah siap dong menghadapi kenyataan hidup!');
            writeln('Terus hobinya ',hobi,' dong. Sama kayak Mahasiswa Artefak di kampusku!');
        end;
    end
    else
    begin
        with pengguna do
        begin
            writeln('Hai ',nama,'!, senang deh bisa kenalan sama kamu!');
            writeln('Umur kamu ',umur,' tahun, udah tua juga ya!');
            writeln('Terus hobinya ',hobi,' dong. Sama kayak Dosen Killer di kampus akuu!');
        end;
    end;
    writeln;
    writeln('Nah, kan kita udah kenalan nih, Yuk langsung masuk ke programnya!');
end;


procedure kayyy;
begin
        writeln('          /\_/\ ');
        writeln('       =  0 . 0  =');
        writeln('        /       \  ');
end;
procedure Tanda(pilihan : char;baris,kolom : integer);
begin
    if((baris <= 2) and (kolom <= 2)) then
    begin
        case pilihan of
            '1' : begin
                gotoxy(16,1);writeln('+');
                end;
            '2' : begin 
                gotoxy(16,1);writeln('-');
                end;
            '4' : begin
                gotoxy(1,1);writeln('A =');
                gotoxy(23,1);writeln('A^T =');
                end;
        end;
    end
    else
    case pilihan of
    '1' : begin
          gotoxy(22,2);writeln('+');
          end;
    '2' : begin
          gotoxy(22,2);writeln('-');
          end;
    '4' : begin
          gotoxy(1,2);writeln('A =');
          gotoxy(24,2);writeln('==>');
          gotoxy(29,2);writeln('A^T =');
          end;
    end;
end;

procedure Tandakali(pilihan : char;barisA,kolomB : integer);
begin
    if((barisA <= 2) and (kolomB <= 2)) then
    begin
        gotoxy(16,1);writeln('X');
    end
    else
    begin
        gotoxy(22,2);writeln('X');
    end;
end;

procedure Tandakali3(pilihan : char;barisA,kolomB,kolomA : integer);
begin
    if((barisA <= 2) and (kolomB <= 2) and (kolomA <= 2)) then
    begin
        gotoxy(16,1);writeln('X');
    end
    else
    begin
        gotoxy(22,2);writeln('X');
    end;
end;
procedure TekanEnter;
begin
    write('Press Enter to Continue...');
    readln;
end;


function HitungPenjumlahan(var a,b: Tmatriks; baris,kolom: integer): Tmatriks;
var
    i,j: integer;
    c : Tmatriks;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            c[i,j] := a[i,j] + b[i,j];
        end;
    end;
    HitungPenjumlahan := c;
end;

function HitungPengurangan(var a,b : Tmatriks; baris,kolom: integer) : Tmatriks;
var
    i,j : integer;
    c : Tmatriks;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            c[i,j] := a[i,j] - b[i,j];
        end;
    end;
    HitungPengurangan := c;
end;

function HitungPerkalian(var a,b : Tmatriks; barisA,kolomA,barisB,kolomB : integer) : Tmatriks;
var
    i,j,k : integer;
    c : Tmatriks;
begin
    for i := 1 to barisA do
    begin
        for j := 1 to kolomB do
        begin
            c[i,j] := 0;
        end;
    end;

    for i := 1 to barisA do
    begin
        for j := 1 to kolomB do
        begin
            for k := 1 to kolomA do
            begin
                c[i,j] := c[i,j] + a[i,k] * b[k,j];
            end;
        end;
    end;
    HitungPerkalian := c;
end;

function HitungTranspos(var a : Tmatriks; baris,kolom: integer) : Tmatriks;
var
    i,j : integer;
    transpos : Tmatriks;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            transpos[j,i] := a[i,j];
        end;
    end;
    HitungTranspos := transpos;
end;

function HitungDeterminan2(var a : Tmatriks) : longint;
begin
    HitungDeterminan2 := (a[1,1] * a[2,2]) - (a[1,2] * a[2,1]);
end;

function HitungDeterminan3(var a : Tmatriks) : longint;
begin
    HitungDeterminan3 := (a[1,1] * a[2,2] * a[3,3]) + (a[1,2] * a[2,3] * a[3,1]) + (a[1,3] * a[2,1] * a[3,2]) - (a[1,3] * a[2,2] * a[3,1]) - (a[1,1] * a[2,3] * a[3,2]) - (a[1,2] * a[2,1] * a[3,3]);
end;

procedure hasil(var c : Tmatriks; baris,kolom : integer; Awal_X,Awal_Y : integer);
var
    i,j : integer;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));writeln(c[i,j]);
        end;
    end;
end;

procedure hasilkali(var c : Tmatriks; baris,kolom : integer; Awal_X,Awal_Y : integer);
var
    i,j : integer;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j - 1) * 10)),(Awal_Y + i));writeln(c[i,j]);
        end;
    end;
end;
procedure batastranspos2;
begin
    gotoxy(5,1);writeln('|');
    gotoxy(5,2);writeln('|');
    gotoxy(16,1);writeln('|');
    gotoxy(16,2);writeln('|');

    gotoxy(30,1);writeln('|');
    gotoxy(30,2);writeln('|');
    gotoxy(41,1);writeln('|');
    gotoxy(41,2);writeln('|');
end;

procedure batastranspos3;
begin
    gotoxy(5,1);writeln('|');
    gotoxy(5,2);writeln('|');
    gotoxy(5,3);writeln('|');
    gotoxy(22,1);writeln('|');
    gotoxy(22,2);writeln('|');
    gotoxy(22,3);writeln('|');

    gotoxy(35,1);writeln('|');
    gotoxy(35,2);writeln('|');
    gotoxy(35,3);writeln('|');
    gotoxy(52,1);writeln('|');
    gotoxy(52,2);writeln('|');
    gotoxy(52,3);writeln('|');
end;

procedure batasordo2;
begin
    gotoxy(1,1);writeln('|');
    gotoxy(12,1);writeln('|');
    gotoxy(1,2);writeln('|');
    gotoxy(12,2);writeln('|');

    gotoxy(20,1);writeln('|');
    gotoxy(31,1);writeln('|');
    gotoxy(20,2);writeln('|');
    gotoxy(31,2);writeln('|');
end;

procedure batashasilordo2;
begin
    gotoxy(39,1);writeln('|');
    gotoxy(39,2);writeln('|');
    gotoxy(53,1);writeln('|');
    gotoxy(53,2);writeln('|');
end;

procedure batashasilkaliordo2;
begin
    gotoxy(39,1);writeln('|');
    gotoxy(39,2);writeln('|');
    gotoxy(59,1);writeln('|');
    gotoxy(59,2);writeln('|');
end;
procedure batasordo3;
begin
    gotoxy(1,1);writeln('|');
    gotoxy(1,2);writeln('|');
    gotoxy(1,3);writeln('|');
    gotoxy(18,1);writeln('|');
    gotoxy(18,2);writeln('|');
    gotoxy(18,3);writeln('|');

    gotoxy(26,1);writeln('|');
    gotoxy(26,2);writeln('|');
    gotoxy(26,3);writeln('|');
    gotoxy(43,1);writeln('|');
    gotoxy(43,2);writeln('|');
    gotoxy(43,3);writeln('|');
end;

procedure batashasilordo3;
begin
    gotoxy(51,1);writeln('|');
    gotoxy(51,2);writeln('|');
    gotoxy(51,3);writeln('|');
    gotoxy(71,1);writeln('|');
    gotoxy(71,2);writeln('|');
    gotoxy(71,3);writeln('|');
end;

procedure batashasilkaliordo3;
begin
    gotoxy(49,1);writeln('|');
    gotoxy(49,2);writeln('|');
    gotoxy(49,3);writeln('|');
    gotoxy(79,1);writeln('|');
    gotoxy(79,2);writeln('|');
    gotoxy(79,3);writeln('|');
end;

procedure batasdeterminan2;
begin
    gotoxy(1,1);writeln('A = ');

    gotoxy(5,1);writeln('|');
    gotoxy(16,1);writeln('|');
    gotoxy(5,2);writeln('|');
    gotoxy(16,2);writeln('|');

    gotoxy(21,1);writeln('det(A) = ');
end;

procedure batasdeterminan3;
begin
    gotoxy(1,2);writeln('A = ');

    gotoxy(5,1);writeln('|');
    gotoxy(5,2);writeln('|');
    gotoxy(5,3);writeln('|');
    gotoxy(22,1);writeln('|');
    gotoxy(22,2);writeln('|');
    gotoxy(22,3);writeln('|');

    gotoxy(37,2);writeln('det(A) = ');
end;

procedure bataskofaktor2(var a : Tmatriks);
begin
    gotoxy(1,1);writeln('A = ');

    gotoxy(5,1);writeln('|');
    gotoxy(16,1);writeln('|');
    gotoxy(5,2);writeln('|');
    gotoxy(16,2);writeln('|');

    gotoxy(21,1);writeln('det(A) = ');
    gotoxy(21,2);writeln('A^T = ');
    gotoxy(32,2);writeln('Kofaktor = ');
    gotoxy(32,3);writeln('Adjoint = ');
end;

procedure bataskofaktor3(var a : Tmatriks);
begin
    gotoxy(1,2);writeln('A = ');

    gotoxy(5,1);writeln('|');
    gotoxy(5,2);writeln('|');
    gotoxy(5,3);writeln('|');
    gotoxy(22,1);writeln('|');
    gotoxy(22,2);writeln('|');
    gotoxy(22,3);writeln('|');

    gotoxy(37,2);writeln('det(A) = ');
    gotoxy(37,3);writeln('A^T = ');
    gotoxy(48,3);writeln('Kofaktor = ');
    gotoxy(48,4);writeln('Adjoint = ');
end;

procedure inputan2(var Matriks : Tmatriks ;baris,kolom : integer;Awal_X,Awal_Y : integer;pilihan : char);
var
    i,j : integer;
    input : string;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
            readln(input);
            while Length(input) > 4 do
            begin
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
                ClrEol;
                batasordo2;
                Tanda(pilihan,baris,kolom);
                gotoxy(1,5);writeln('INPUTAN TAK BOLEH LEBIH DARI 4 DIGIT! ');
                TekanEnter;
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));readln(input);
            end;
            Matriks[i,j] := StrToInt(input);
        end;
    end;
end;

procedure inputanTranspos2(var Matriks : Tmatriks ;baris,kolom : integer;Awal_X,Awal_Y : integer;pilihan : char);
var
    i,j : integer;
    input : string;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
            readln(input);
            while Length(input) > 4 do
            begin
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
                ClrEol;
                batastranspos2;
                Tanda(pilihan,baris,kolom);
                gotoxy(1,5);writeln('INPUTAN TAK BOLEH LEBIH DARI 4 DIGIT! ');
                TekanEnter;
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));readln(input);
            end;
            Matriks[i,j] := StrToInt(input);
        end;
    end;
end;

procedure inputanTranspos3(var Matriks : Tmatriks ;baris,kolom : integer;Awal_X,Awal_Y : integer;pilihan : char);
var
    i,j : integer;
    input : string;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
            readln(input);
            while Length(input) > 4 do
            begin
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
                ClrEol;
                batasTranspos3;
                Tanda(pilihan,baris,kolom);
                gotoxy(1,5);writeln('INPUTAN TAK BOLEH LEBIH DARI 4 DIGIT! ');
                TekanEnter;
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));readln(input);
            end;
            Matriks[i,j] := StrToInt(input);
        end;
    end;
end;

procedure inputanDeterminan2(var Matriks : Tmatriks ;baris,kolom : integer;Awal_X,Awal_Y : integer;pilihan : char);
var
    i,j : integer;
    input : string;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));readln(input);
            while Length(input) > 4 do
            begin
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));ClrEol;
                batasdeterminan2;
                gotoxy(1,5);writeln('INPUTAN TAK BOLEH LEBIH DARI 4 DIGIT! ');
                TekanEnter;
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));readln(input);
            end;
            Matriks[i,j] := StrToInt(input);
        end;
    end;
end;

procedure inputanDeterminan3(var Matriks : Tmatriks ;baris,kolom : integer;Awal_X,Awal_Y : integer;pilihan : char);
var
    i,j : integer;
    input : string;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j -1 ) * 6)),(Awal_Y + i));readln(input);
            while (length(input) > 4 ) do
            begin
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));ClrEol;
                batasdeterminan3;
                gotoxy(1,5);writeln('INPUTAN TAK BOLEH LEBIH DARI 4 DIGIT! ');
                TekanEnter;
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));readln(input);
            end;
            Matriks[i,j] := strtoint(input);
        end;
    end;
    gotoxy(24,1);writeln(Matriks[1,1]);
    gotoxy(29,1);writeln(Matriks[1,2]);
    
    gotoxy(24,2);writeln(Matriks[2,1]);
    gotoxy(29,2);writeln(Matriks[2,2]);

    gotoxy(24,3);writeln(Matriks[3,1]);
    gotoxy(29,3);writeln(Matriks[3,2]);
end;

procedure inputan3(var Matriks : Tmatriks ;baris,kolom : integer;Awal_X,Awal_Y : integer;pilihan : char);
var
    i,j : integer;
    input : string;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
            readln(input);
            while Length(input) > 4 do
            begin
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
                ClrEol;
                batasordo3;
                Tanda(pilihan,baris,kolom);
                gotoxy(1,5);writeln('INPUTAN TAK BOLEH LEBIH DARI 4 DIGIT! ');
                TekanEnter;
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));readln(input);
            end;
            Matriks[i,j] := StrToInt(input);
        end;
    end;
end;

procedure inputanPerkalian2(var Matriks : Tmatriks ;baris,kolom : integer;Awal_X,Awal_Y : integer;pilihan : char);
var
    i,j : integer;
    input : string;
begin
    for i := 1 to baris do
    begin
        for j := 1 to kolom do
        begin
            Awal_Y := 0;
            gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
            readln(input);
            while Length(input) > 4 do
            begin
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));
                ClrEol;
                batasordo2;
                Tandakali(pilihan,baris,kolom);
                gotoxy(1,5);writeln('INPUTAN TAK BOLEH LEBIH DARI 4 DIGIT! ');
                TekanEnter;
                gotoxy((Awal_X + ((j - 1) * 6)),(Awal_Y + i));readln(input);
            end;
            Matriks[i,j] := StrToInt(input);
        end;
    end;
end;

var
    baris,kolom,i,j,barisA,kolomA,barisB,kolomB : byte;
    yakin,keluar,ulang,pilihan,pilih_determinan : char;
    a,b,c : Tmatriks;
    pengguna : Tpengguna;


begin
clrscr;
    writeln('       OPERASI MATRIKS  ');
    writeln('============================');
    writeln;

    writeln('          Halo!   ');
    writeln('      Nama Aku Kayyy!');
    writeln;
    kayyy;
    writeln;
    TekanEnter;
writeln;
    writeln('Sebelum Masuk Ke Programnya, Aku Mau Kenalan Dulu Sama Kamu!');
    writeln;
    with pengguna do
    begin
        write('Nama panggilan kamu siapa? : ');readln(nama);
        isi_lagi:
        write('Umur berapa?       : ');readln(umur);
        if umur < 1 then
            goto isi_lagi;
        write('Terus Hobinya apa? : ');readln(hobi);
    end;
writeln;  
    intro(pengguna); 
writeln;
TekanEnter;

clrscr;
menu_utama:
    writeln('       OPERASI MATRIKS  ');
    writeln('============================');
    writeln;

    writeln('       MENU OPERASI');
    writeln('----------------------------');
    writeln('1.PENJUMLAHAN');
    writeln('2.PENGURANGAN');
    writeln('3.PERKALIAN');
    gotoxy(17,6);writeln('4.TRANSPOS');
    gotoxy(17,7);writeln('5.DETERMINAN');
    gotoxy(17,8);writeln('6.KELUAR');
    writeln;

    write('Masukkan Pilihan Kamu (1-6) : ');readln(pilihan);
    writeln;
   
case pilihan of
    '1' : goto penjumlahan;
    '2' : goto pengurangan;
    '3' : goto perkalian;
    '4' : goto transpos;
    '5' : goto determinan;
    '6' : begin
            isikeluar:
            writeln;
            kayyy;
            writeln;
            write('Kamu Beneran Yakin Nih Mau Keluar? (Y/T) : ');readln(yakin);
            if((upcase(yakin) <> 'T') and (upcase(yakin) <> 'Y')) then
            begin
                writeln;
                clrscr;
                goto isikeluar;
            end;

            if(upcase(yakin) = 'Y') then
            begin
                clrscr;
                writeln('Yaudah Deh... Sampai Jumpa Lagi Ya!');
                writeln;
                kayyy;
                writeln;
                write('Press Enter To Exit...');
                readln;
                halt;
            end
            else
                writeln;
                clrscr;
                goto menu_utama;
        end;
    else
    begin
        clrscr;
        writeln('Pilihan Kamu Tuh Gak Ada!');
        writeln;
        kayyy;
        writeln;
        writeln('Pilih Orang Baru Atau Orang Lama nih?');
        writeln;
        write('Pilih Yang Pasti ajaa...!  ');
        writeln('hihihi :V');
        writeln;
        TekanEnter;
        clrscr; 
        goto menu_utama;    
    end;
end;

penjumlahan:
writeln('PENJUMLAHAN MATRIKS');
writeln('-------------------');
writeln('NOTE : 1 <= BARIS & KOLOM <= 3');
writeln('BACA : (BARIS DAN KOLOM HARUS BERADA DI ANTARA 1 DAN 3)');
writeln;
write('Panjang Baris : ');readln(baris);
write('Panjang Kolom : ');readln(kolom);

if ((baris < 1) or  (kolom < 1) or  (baris > 3) or  (kolom > 3)) then
begin
    clrscr;
    writeln('KAMU TUH UDAH DILUAR BATAS KEWAJARAN MEVVING!');
    writeln;
    kayyy;
    writeln;
    writeln('Masukin Angka Yang Bener Dong!');
    writeln;
    TekanEnter;
    writeln;
    clrscr;
    goto penjumlahan;
end;

clrscr;
    
if((baris<= 2) and (kolom <= 2)) then
begin
    batasordo2;
    Tanda(pilihan,baris,kolom);             
    inputan2(a,baris,kolom,2,1,pilihan);
    inputan2(b,baris,kolom,21,1,pilihan);

    c := HitungPenjumlahan(a,b,baris,kolom);

    gotoxy(35,1);writeln('=');
    batashasilordo2;
    hasil(c,baris,kolom,40,1);
end
else
begin
    batasordo3;
    Tanda(pilihan,baris,kolom);
    inputan3(a,baris,kolom,2,1,pilihan);
    inputan3(b,baris,kolom,27,1,pilihan);

    c := HitungPenjumlahan(a,b,baris,kolom);

    gotoxy(46,2);writeln('=');
    batashasilordo3;
    hasil(c,baris,kolom,52,1);
end;
writeln;
gotoxy(1,6);TekanEnter;
gotoxy(1,7);write('Kamu Mau Menjumlahkan Lagi? (Y/T) : ');readln(ulang);
if(upcase(ulang) = 'Y') then
begin
    clrscr;
    goto penjumlahan;
end
else
begin
    clrscr;
    goto menu_utama;
end;

pengurangan:
writeln('PENGURANGAN MATRIKS');
writeln('-------------------');
writeln;
writeln('NOTE : 1 <= BARIS & KOLOM <= 3');
writeln('BACA : (BARIS DAN KOLOM HARUS BERADA DI ANTARA 1 DAN 3)');
writeln;
write('Panjang Baris : ');readln(baris);
write('Panjang Kolom : ');readln(kolom);

if((baris < 1) or (kolom < 1) or (baris > 3) or (kolom > 3)) then
begin
    clrscr;
    writeln('KAMU UDAH DILUAR BATAS KEWAJARAN MEVVING!');
    writeln;
    kayyy;
    writeln;
    writeln('Masukin Angka Yang Bener Dong!');
    writeln;
    TekanEnter;
    writeln;
    clrscr;
    goto pengurangan;
end;
clrscr;

if((baris <= 2) and (kolom <= 2)) then  
begin
    batasordo2;
    Tanda(pilihan,baris,kolom);
    inputan2(a,baris,kolom,2,1,pilihan);
    inputan2(b,baris,kolom,21,1,pilihan);

    c := HitungPengurangan(a,b,baris,kolom);

    gotoxy(35,1);writeln('=');
    batashasilordo2;
    hasil(c,baris,kolom,40,1);
end
else
begin
    batasordo3;
    Tanda(pilihan,baris,kolom);
    inputan3(a,baris,kolom,2,1,pilihan);
    inputan3(b,baris,kolom,27,1,pilihan);

    c := HitungPengurangan(a,b,baris,kolom);

    gotoxy(47,2);writeln('=');
    batashasilordo3;
    hasil(c,baris,kolom,52,1);
end;
writeln;
gotoxy(1,6);TekanEnter;
gotoxy(1,7);write('Kamu Mau Mengurangkan Lagi? (Y/T) : ');readln(ulang);
if(upcase(ulang) = 'Y') then
begin
    clrscr;
    goto pengurangan;
end
else
begin
    clrscr;
    goto menu_utama;
end;

perkalian:
writeln('PERKALIAN MATRIKS');
writeln('-----------------');
writeln('NOTE : 1 <= BARIS & KOLOM <= 3');
writeln('BACA : (BARIS DAN KOLOM HARUS BERADA DI ANTARA 1 DAN 3)');
writeln;
writeln('NOTE : Kolom A = Baris B');
writeln('BACA : (KOLOM MATRIKS A HARUS SAMA DENGAN BARIS MATRIKS B)');
writeln;
writeln('MATRIKS A');
writeln('---------');
write('Panjang Baris : ');readln(barisA);
write('Panjang Kolom : ');readln(kolomA);
writeln;
writeln('MATRIKS B');
writeln('---------');
write('Panjang Baris : ');readln(barisB);
write('Panjang Kolom : ');readln(kolomB);

if(kolomA <> barisB) then
begin
    clrscr;
    writeln('Waduh gabisa nih, Kolom Matriks A harus sama dengan Baris Matriks B!');
    writeln('Kan udah aku ingetin tadi!, Kamu Tuh Yaa...!');
    writeln;
    kayyy;
    writeln;
    TekanEnter;
    clrscr;
    goto perkalian;
end;

if((barisA < 1) or (kolomA < 1) or (barisA > 3) or (kolomA > 3) or (barisB < 1) or (kolomB < 1) or (barisB > 3) or (kolomB > 3)) then
begin
    clrscr;
    writeln('KAMU UDAH DILUAR BATAS KEWAJARAN MEVVING!');
    writeln;
    kayyy;
    writeln;
    writeln('Masukin Angka Yang Bener Dong!');
    writeln;
    TekanEnter;
    writeln;
    clrscr;
    goto perkalian;
end;
clrscr;

if((barisA <= 2) and (kolomA <= 2) and (kolomB <= 2)) then
begin
    batasordo2;
    Tandakali(pilihan,barisA,kolomB);
    inputanPerkalian2(a,barisA,kolomA,2,1,pilihan);
    inputanPerkalian2(b,barisB,kolomB,21,1,pilihan);

    c := HitungPerkalian(a,b,barisA,kolomA,barisB,kolomB);

    gotoxy(35,1);writeln('=');
    batashasilkaliordo2;
    hasilkali(c,barisA,kolomB,40,1);
end
else
begin
    batasordo3;
    Tandakali3(pilihan,barisA,kolomB,kolomA);
    inputan3(a,barisA,kolomA,2,1,pilihan);
    inputan3(b,barisB,kolomB,27,1,pilihan);

    c := HitungPerkalian(a,b,barisA,kolomA,barisB,kolomB);

    gotoxy(46,2);writeln('=');
    batashasilkaliordo3;
    hasilkali(c,barisA,kolomB,50,1);
end;
writeln;
gotoxy(1,6);TekanEnter;
gotoxy(1,7);write('Kamu Mau Melakukan Perkalian Lagi? (Y/T) : ');readln(ulang);
if(upcase(ulang) = 'Y') then
begin
    clrscr;
    goto perkalian;
end
else
begin
    clrscr;
    goto menu_utama;
end;

transpos:
    writeln('TRANSPOS MATRIKS');
    writeln('----------------');
    writeln('NOTE : 1 <= BARIS & KOLOM <= 3');
    writeln('BACA : (BARIS DAN KOLOM HARUS BERADA DI ANTARA 1 DAN 3)');
    writeln;
    write('Panjang Baris : ');readln(baris);
    write('Panjang Kolom : ');readln(kolom);

    if((baris < 1) or (kolom < 1) or (baris > 3) or (kolom > 3)) then
    begin
        clrscr;
        writeln('KAMU UDAH DILUAR BATAS KEWAJARAN MEVVING!');
        writeln;
        kayyy;
        writeln;
        writeln('Masukin Angka Yang Bener Dong!');
        writeln;
        TekanEnter;
        writeln;
        clrscr;
        goto transpos;
    end;

    clrscr;
    if((baris <= 2) and (kolom <= 2)) then
    begin
        batastranspos2;
        Tanda(pilihan,baris,kolom);
        inputanTranspos2(a,baris,kolom,6,1,pilihan);

        c := HitungTranspos(a,baris,kolom);

        hasil(c,kolom,baris,31,1);
    end
    else
    begin
        batastranspos3;
        Tanda(pilihan,baris,kolom);
        inputanTranspos3(a,baris,kolom,6,1,pilihan);

        c := HitungTranspos(a,baris,kolom);

        hasil(c,kolom,baris,36,1);
    end;
    writeln;
    gotoxy(1,6);TekanEnter;
    gotoxy(1,7);write('Kamu Mau Melakukan Transpos Lagi? (Y/T) : ');readln(ulang);
    if(upcase(ulang) = 'Y') then
    begin
        clrscr;
        goto transpos;
    end
    else
    begin
        clrscr;
        goto menu_utama;
    end;

determinan:
    writeln('Determinan Matriks');
    writeln('------------------');
    writeln('1. Ordo 2 X 2');
    writeln('2. Ordo 3 X 3');
    writeln('3. Kembali');
    writeln;
    write('Masukkan Pilihan Kamu (1-3) : ');readln(pilih_determinan);
    writeln;
    case pilih_determinan of
    '1' : begin
          clrscr;
          batasdeterminan2;
          inputanDeterminan2(a,2,2,6,1,pilihan);
          HitungDeterminan2(a);
          gotoxy(30,1);writeln(HitungDeterminan2(a));
          end;
    '2' : begin
          clrscr;
          batasdeterminan3;
          inputanDeterminan3(a,3,3,6,1,pilihan);
          HitungDeterminan3(a);
          gotoxy(46,2);writeln(HitungDeterminan3(a));
          end;
    '3' : begin
          clrscr;
          goto menu_utama;
          end;
    else
          begin
          clrscr;
          writeln('Kamu suka banget yaa, milih yang gak ada!');
          writeln;
          kayyy;
          writeln;
          TekanEnter;
          clrscr;
          goto determinan;
          end;
    end;
    gotoxy(1,6);TekanEnter;
    gotoxy(1,7);write('Kamu Mau Menghitung Determinan Lagi? (Y/T) : ');readln(ulang);
    if(upcase(ulang) = 'Y') then
    begin
        clrscr;
        goto determinan;
    end
    else
    begin
        clrscr;
        goto menu_utama;
    end;
end.