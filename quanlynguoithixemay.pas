program laixe_moto;
uses crt;
type
    nguoithi = record
                tenthisinh: string;
                lythuyet: real;
                thuchanh: real;
                dtrungbinh: real;
            end;
    

var
    listThiSinh: array[0..1000] of nguoithi;
    tempLength: integer;
    choice: integer;
    i: integer;
function inputTheNumber(): integer;
type
    Menu = record
                title: string;
                number: integer;
            end;
const listMenu: array[0..1] of Menu = (
    (title:'Thêm thí sinh';number:1),
    (title:'Xem tổng điểm';number:2)
);
var i, input: integer;
begin clrscr;
    for i:=0 to 1 do begin
        writeln(listMenu[i].number, '=>', listMenu[i].title);
    end;
    write('Nhập số: ');
    readln(input);
    if input < 3 then begin
        inputTheNumber := input;
    end
    else begin
        writeln('Nhập quá giới hạn');
        inputTheNumber := 0;
    end;
end;

procedure themthisinh ();
var
    thisinhclone: nguoithi;
begin
    write('Nhập tên thí sinh: ');
    readln(thisinhclone.tenthisinh);
    write('Nhập điểm lý thuyết: ');
    readln(thisinhclone.lythuyet);
    write('Nhập điểm thực hành: ');
    readln(thisinhclone.thuchanh);
    thisinhclone.dtrungbinh := (thisinhclone.lythuyet + thisinhclone.thuchanh*3)/4;
    listThiSinh[tempLength] := thisinhclone;
    tempLength := tempLength + 1;
    write('Thêm thí sinh thành công!');
end;


procedure xemtongdiem();
begin
    for i:=0 to tempLength-1 do begin
        writeln('[',i+1,']',listThiSinh[i].tenthisinh , '=>', 'Lý thuyết:',listThiSinh[i].lythuyet:0:2,'=>','Thực hành:', listThiSinh[i].thuchanh:0:2,'=>','Đ.trungbinh:',listThiSinh[i].dtrungbinh:0:2);
    end;
    write('Enter để tiếp tục!');
    readln;
end;

begin
    tempLength := 0;
    while True do begin
        choice := inputTheNumber();
        if choice <> 0 then begin
            case (choice) of
                1: begin
                    themthisinh();
                end;
                2: begin
                    xemtongdiem();
                end;
            end;
        end;
    end;
end.
