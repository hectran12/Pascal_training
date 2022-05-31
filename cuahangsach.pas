program bookz;
uses crt;
type
    Book = record
                tenSach : string;
                price : integer;
                tacGia : string;
            end;
const
    PriceTrungBinh = 19;
    Menu : array[0..2] of string = (
        '[1] Thêm sách','[2] Mua sách','[3] Nạp tiền'
    );
    
var 
    dsBook : array[0..100] of Book;
    x : integer;
    z : integer;
    choose : integer;
    them   : integer;
    ask    : integer;
    soSach : integer;
    money  : integer;
    chon   : integer;
    naptien : integer;
begin
    soSach := 0;
    x := 0;
    money := 100;
    while x<1000 do begin
        clrscr;
        writeln('Tổng số sách: ',soSach);
        writeln('Số tiền hiện có: ',money);
        for x:=0 to 2 do begin
            writeln(Menu[x]);
        end;
        write('Nhập số: ');
        readln(choose);
        
        if choose = 1 then begin
            write('Nhập số sách muốn thêm ( không quá 100 cuốn ): ');
            readln(them);
            for z:=soSach to soSach+them-1 do begin
                write('Không muốn thêm nữa thì ấn 1, không thì ấn 0: ');
                readln(ask);
                if ask = 1 then begin
                    write('Nhập tên sách: ');
                    readln(dsBook[z].tenSach);
                    write('Nhập giá sách: ');
                    readln(dsBook[z].Price);
                    if dsBook[z].Price < PriceTrungBinh then begin
                        writeln('Đã tự set giá lên ',PriceTrungBinh);
                        dsBook[z].Price := PriceTrungBinh;
                    end;
                    write('Nhập tác giả: ');
                    readln(dsBook[z].tacGia);
                    soSach := soSach + 1;
                end;
            end;
            continue;
        end
        else if choose = 2 then begin
            if soSach = 0 then begin
                    writeln('Không có sách!, enter để back về menu: ');
                    readln;
                    continue;
            end;
            for z:=0 to soSach-1 do begin
                
                writeln('[',z+1,'] Tên sách: ',dsBook[z].tenSach,' || Tác giả: ',dsBook[z].tacGia,' || Gía: ',dsBook[z].Price);
                
            end;
            write('Nhập số: ');
            readln(chon);
            chon := chon-1;
            if dsBook[chon].Price <= money then
            begin
                money := money - dsBook[chon].Price;
                soSach := soSach - 1;
                writeln('Mua thành công!, enter để back về menu: ');
                readln;
                continue;
            end
            else    
                writeln('Không đủ tiền!, enter để back về menu: ');
                readln;
                continue;
        end
        else
            write('Nạp số tiền muốn nạp: ');
            readln(naptien);
            money := money + naptien;
            write('Nạp tiền thành công!, enter để back về menu: ');
            readln;
            continue;
            
    end;
end.
