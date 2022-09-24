program QUYDOITIEN;
uses crt;
type
    item = record 
            sotien: longInt;
            kihieu: string;
        end;
const
    listItem: array[0..8] of item = (
        (sotien: 500000; kihieu: 'Năm trăm ngàn'),
        (sotien: 200000; kihieu: 'Hai trăm ngàn'),
        (sotien: 100000; kihieu: 'Một trăm ngàn'),
        (sotien: 50000; kihieu: 'Năm mươi ngàn'),
        (sotien: 20000; kihieu: 'Hai mươi ngàn'),
        (sotien: 10000; kihieu: 'Mười ngàn'),
        (sotien: 5000; kihieu: 'Năm ngàn'),
        (sotien: 2000; kihieu: 'Hai ngàn'),
        (sotien: 1000; kihieu: 'Một ngàn')
    );
var
    i, count: integer;
    myMoney: longInt;
begin clrscr;
    writeln('Nhap so tien: ');
    readln(myMoney);
    for i:=0 to 8 do begin
        if myMoney >= listItem[i].sotien then begin
            count := 0;
            while myMoney >= listItem[i].sotien do begin
                myMoney := myMoney - listItem[i].sotien;
                count := count + 1;
            end;
            if count > 0 then writeln(listItem[i].kihieu, '=>', count);
        end;
    end;
    writeln('Dư', '=>', myMoney);
end.
