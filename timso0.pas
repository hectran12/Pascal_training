program demso;
type
    sokhong = record
                vitri : integer;
              end;
    sothuong = record
                vitri : integer;
              end;
    Menu = record
            title : string;
            number : integer;
            end;

const 
    menulist : array[0..1] of Menu = (
        (title:'Kiem tra tren chuoi';number:1),
        (title:'Kiem tra tren mang nhap vao';number:2)
    );
    
var
    soluong_number_0 : array[0..100] of sokhong;
    soluong_number_diff : array[0..100] of sothuong;
    (*Input variables*)
    nhap : string;
    result_input,i,stt,stt2 : integer;
function print_menu(Menu: Array of Menu): integer;
var i : integer;
begin
    
    for i := 0 to length(Menu)-1 do begin
        writeln(Menu[i].number, ' => ' , Menu[i].title);
    end;
    
    write('Nhap lua chon cua bạn: ');
    readln(print_menu);
end;

procedure locsokhong();
var text : string;
begin
    {
        Default các kí tự trong unicode ở Pascal lần lượt là
        1 -> n khác với những ngôn ngữ khác là 0->n 
        Từ đó ý tưởng ta như sau: lấy length rồi dùng for để duyệt
    }
    
    write('Nhap vao chuoi: ');
    readln(text);
    stt := 0;
    stt2 := 0;
    for i:=1 to length(text) do begin
        if(text[i] = '0') then begin
            soluong_number_0[stt].vitri := i;
            stt := stt + 1;
        end
        else begin
            soluong_number_diff[stt2].vitri := i;
            stt2 := stt2 + 1;
        end;
    end;
    writeln('Vi tri cua cac so 0 trong chuoi');
    (*In ra vị trí của các số 0*)
    for i:=0 to stt-1 do begin
        write(soluong_number_0[i].vitri, ' ');
    end;writeln('');
    writeln('Tong cong co: ', stt);
    writeln('Vi tri cua cac so khac so 0 trong chuoi');
    (*In ra vị trí của các số khác số 0*)
    for i:=0 to stt2-1 do begin
        write(soluong_number_diff[i].vitri,' ');
    end;writeln('');
    write('Tong cong co: ', stt2);
end;

procedure locsokhonginarr();
var sophantu : integer;
     numbers : array[0..100] of integer;
begin
    
    write('Nhap vao so phan tu: ');
    readln(sophantu);
    for i:=0 to sophantu-1 do begin
        write('[',i+1,'] => nhap so: ');
        readln(numbers[i]);
    end;
    
    stt := 0;
    stt2 := 0;
    (*Lọc số*)
    for i:=0 to sophantu-1 do begin
        if(numbers[i] = 0) then begin
            soluong_number_0[stt].vitri := i;
            stt := stt + 1;
        end
        else begin
            soluong_number_diff[stt2].vitri := i;
            stt2 := stt2 + 1;
        end;
    end;
    (*Vị trí để đồng bộ thì mình cho 1->n giống với bên chuỗi, nếu không thích thì bạn bỏ +1*)
    (*In ra vị trí và tổng các số 0 trong mảng*)
    writeln('Vi tri cua so 0 trong mang la: ');
    for i:=0 to stt-1 do begin
        write(soluong_number_0[i].vitri+1, ' ');
    end;writeln('');
    writeln('Tong cong co: ', stt);
    (*In ra vi trí và tổng các số khác 0 trong mảng*)
    writeln('Vi tri cua so khac 0 trong mang la: ');
    for i:=0 to stt2-1 do begin
        write(soluong_number_diff[i].vitri+1,' ');
    end;writeln('');
    writeln('Tong cong co: ', stt2);
end;

begin
    (*procedure phạm vi truy cập là toàn cầu, bạn nên nhớ điều đó để lọc ra những biến cần thiết*)
    result_input := print_menu(menulist);
    if(result_input = 1) then begin
        locsokhong(); 
    end
    else if(result_input = 2) then begin
        locsokhonginarr(); 
    end
    else
        write('Khong co trong lua chon!');

end.
