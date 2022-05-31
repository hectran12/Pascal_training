program messenger;
uses crt;
(*type*)
type 
    ACCOUNT = record
                fullName : string[30];
                Alias : string[15];
                Age : integer;
                Bio : Pchar;
                iStatus : boolean;
              end;
    MESSAGE = record
                Author : ACCOUNT;
                Message : Pchar;
                toFriend : ACCOUNT;
              end;
    FORWARD_ = record
                Author : ACCOUNT;
                MESSAGE : Pchar;
                toFriend : array[0..100] of ACCOUNT;
               end;
    MENU_ITEM = record
                 Number : longInt;
                 Title : string;
                end;
(*MESSAGE BAR*)
const
    (*Data board*)
    {
        [1] Tạo tài khoản
        [2] Thêm bạn bè
        [3] Chấp nhận lời mời
        [4] Nhắn tin
        [5] Xóa bạn bè
        [6] Chuyển tài khoản
    }
    DataMenu : array[0..5] of MENU_ITEM = (
        (*[1]*) (Number:1;Title:'Tạo tài khoản'),
        (*[2]*) (Number:2;Title:'Thêm bạn bè'),
        (*[3]*) (Number:3;Title:'Chấp nhận lời mời'),
        (*[4]*) (Number:4;Title:'Nhắn tin'),
        (*[5]*) (Number:5;Title:'Xóa bạn bè'),
        (*[6]*) (Number:6;Title:'Chuyển tài khoản')
    );
    DataMenu_LEN = 5;
    (*Text action*)
    BAR : Pchar = '==============================================';
    msg_CHOOSE_FUNCTION = 'Chọn chức năng muốn sử dụng: ';
    msg_SEND = 'Gửi tin nhắn thành công';
    msg_FORWARD = 'Chuyển tiếp tin nhắn tới ';
    msg_STATUS = 'Trạng thái hoạt động ';
    msg_INPUT = 'Nhập tin nhắn muốn gửi: ';
    msg_ALL_FRIENDS = 'Tất cả bạn bè';
    (*Text ask*)
    msg_ASK_CREATE = 'Bạn muốn tạo tài khoản mới? (y/n): ';
   
var 
    is_Active : boolean;
    
    (*Support variables*)
    a : integer; (*for 1*)
    x : integer; (*for 2*)
    ask1 : string; (*ask 1*)
    ask2 : string; (*ask 2*)
begin
    x := 0;
    while x<1000 do begin
        clrscr;
        
        (*Show menu*)
        for a:=0 to DataMenu_LEN do begin
            writeln('[',DataMenu[a].Number,'] ',DataMenu[a].Title);
        end;
        write(msg_CHOOSE_FUNCTION);
        readln(ask1);
        
        
    end;

end.
