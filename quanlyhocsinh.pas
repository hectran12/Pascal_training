program quanlyhocsinh;
uses crt;
type
    mezu = record
            title: string;
            number: integer;
            end;
    student = record
            firstName: string;
            lastName: string;
            fullName: string;
            Lop: string;
            end;
const
    Menu: array[0..1] of mezu = (
        (title:'Thêm học sinh'; number: 1),
        (title:'Quản lý học sinh';number: 2)
    );
var
    listStudents: array[0..100] of student;
    countStudents: integer;
    i: integer;
    hocSinh: student;
    ask: integer;
procedure themHocSinh ();
begin
    write('Nhập họ: ');
    readln(hocSinh.lastName);
    write('Nhập tên: ');
    readln(hocSinh.firstName);
    write('Nhập lớp (ví dụ: 6A): ');
    readln(hocSinh.lop);
    hocSinh.fullName := hocSinh.firstName + ' ' + hocSinh.lastName;
    countStudents := countStudents + 1;
    listStudents[countStudents] := hocSinh;
    write('Thêm thành công!');
end;

procedure xemHocSinh ();
begin
    for i:=1 to countStudents do begin
        hocSinh := listStudents[i];
        writeln('[', i, '] => FullName: ' + hocSinh.fullName + ', class: ' + hocSinh.lop);
    end;
end;
begin
    countStudents := 0;
    while True do begin
        clrscr;
        for i:=0 to 1 do begin
            writeln('[', Menu[i].number, '] => ', Menu[i].title);
        end;
        readln(ask);
        if ask = 1 then begin
            themHocSinh();
        end
        else if ask = 2 then begin
            xemHocSinh();
        end;
        writeln('Enter để tiếp tục');
        readln;
    end;
    
end.
