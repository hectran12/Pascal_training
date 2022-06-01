program messenger;
uses crt;
(*type*)
type 
    ACCOUNT = record
                fullName : string[30];
                Alias : string[15];
                Age : integer;
                Bio : string;
                iStatus : boolean;
                Friends : integer;
                Friends_list : string;
                idAcc : longInt;
              end;
    MESSAGE = record
                Author : ACCOUNT;
                Message : Pchar;
                toFriend : ACCOUNT;
              end;
    FORWARD_ = record
                Author : ACCOUNT;
                MESSAGE : Pchar;
                toFriend : array[0..0] of ACCOUNT;
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
    DataMenu : array[0..6] of MENU_ITEM = (
        (*[1]*) (Number:1;Title:'Tạo tài khoản'),
        (*[2]*) (Number:2;Title:'Thêm bạn bè'),
        (*[3]*) (Number:3;Title:'Chấp nhận lời mời'),
        (*[4]*) (Number:4;Title:'Nhắn tin'),
        (*[5]*) (Number:5;Title:'Xóa bạn bè'),
        (*[6]*) (Number:6;Title:'Chuyển tài khoản'),
        (*[7]*) (Number:7;Title:'Đăng xuất')
    );
    

    DataMenu_LEN = 6;
    (*Text action*)
    BAR : Pchar = '==============================================';
    msg_CHOOSE_FUNCTION = 'Chọn chức năng muốn sử dụng: ';
    msg_SEND = 'Gửi tin nhắn thành công';
    msg_FORWARD = 'Chuyển tiếp tin nhắn tới ';
    msg_STATUS = 'Trạng thái hoạt động ';
    msg_INPUT = 'Nhập tin nhắn muốn gửi: ';
    msg_ALL_FRIENDS = 'Tất cả bạn bè';
    (*Change text*)
    msg_CHANGE_ACCOUNT = 'Nhập vị trí tài khoản muốn đổi: ';
    (*Text ask*)
    msg_ASK_CREATE = 'Bạn muốn tạo tài khoản mới? (y/n): ';
    
    (*Text register*)
    msg_VUONG = '[';
    msg_DATABASE_count = 'Số tài khoản hiện có trong database là: ';
    msg_INPUT_FULLNAME = 'Nhập họ và tên: ';
    msg_INPUT_ALIAS = 'Nhập bí danh: ';
    msg_INPUT_AGE = 'Nhập tuổi: ';
    msg_INPUT_Bio = 'Nhập tiểu sử: ';
    msg_REG_SUCCESS = 'Tạo tài khoản thành công, id là: ';
    msg_KIEM = '=>';
    msg_ID_ = ' || ID: ';
    msg_VUONG_2 = ']';
    msg_IV = 'Bạn chưa có tài khoản hãy tạo một tài khoản!';
    msg_CIR = '(';
    msg_CIR_2 = ')';
    (*Text online*)
    msg_ONLINE_PP = 'Số người online: ';
    msg_OFFLINE_PP = 'Số người offline: ';
    msg_NO_THERE_AT_ON = 'Chưa có ai online';
    (*WARING CHANGE*)
    msg_CHANGE_LESS = 'Không được nhập lớn hơn số tài khoản hiện có!';
    msg_CHANGE_AM = 'Số tài khoản không được nhỏ hơn 0';
    
    (*USER TEXT*)
    msg_WELCOME = 'Xin chào: ';
    msg_FRIENDS = 'Friends: ';
    msg_STATUS_ACC = 'Trạng thái: ';
    msg_ACTIVE_ACC = 'Hoạt động';
    msg_OFFLINE_ACC = 'Không hoạt động!';
    
    (*ADD FRIENDS*)
    msg_ADD_FR = 'Nhập vị trí bạn muốn kết bạn (ex 1 2 3): ';
var 
    is_Active : boolean;
    
    (*Support variables*)
    a : integer; (*for 1*)

    x : integer; (*for 2*)

    ask1 : integer; (*ask 1*)
    ask2 : string; (*ask 2*)
    boTemp : boolean; (*boolean temporary*)
    (*Data*)
    AMOUNT_ACCOUNT : longInt;
    
    (*System data*)
    (*Không giới hạn nếu chạy trên môi trường này*)
    Data_Account : array[0..0] of ACCOUNT;
    Online_account : integer;
    Offline_account : integer;
    (*My account*)
    myAccount : ACCOUNT;
    isLogin : boolean;
    Session : longInt;


(*support procedure*)

(*procedure*)
{
    CREATE_ACCOUNT : tạo tài khoản
    MANAGE_ACCOUNT : Quản lý tài khoản
}

procedure ADD_FRIENDS ();
begin
    for a:=0 to AMOUNT_ACCOUNT do begin
        writeln(msg_VUONG,a+1,msg_VUONG_2,msg_KIEM,Data_Account[a].fullName,msg_ID_,Data_Account[a].idAcc);
    end;
    write(msg_ADD_FR);
    readln(ask2);
    
end;
procedure CREATE_ACCOUNT ();
begin
    writeln(msg_DATABASE_count,AMOUNT_ACCOUNT+1);
    AMOUNT_ACCOUNT := AMOUNT_ACCOUNT+1;
    write(msg_INPUT_FULLNAME);
    readln(Data_Account[AMOUNT_ACCOUNT].fullName);
    write(msg_INPUT_ALIAS);
    readln(Data_Account[AMOUNT_ACCOUNT].Alias);
    write(msg_INPUT_AGE);
    readln(Data_Account[AMOUNT_ACCOUNT].Age);
    write(msg_INPUT_Bio);
    readln(Data_Account[AMOUNT_ACCOUNT].Bio);
    Data_Account[AMOUNT_ACCOUNT].iStatus := False;
    Data_Account[AMOUNT_ACCOUNT].idAcc := Random(1000);
    for a:=0 to AMOUNT_ACCOUNT do begin
        if Data_Account[AMOUNT_ACCOUNT].idAcc = Data_Account[a].idAcc then begin
            Data_Account[AMOUNT_ACCOUNT].idAcc := Random(1000);
        end;
    end;
    writeln(msg_REG_SUCCESS,Data_Account[AMOUNT_ACCOUNT].idAcc);

end;

procedure MANAGE_ACCOUNT();
begin
    for a:=0 to AMOUNT_ACCOUNT do begin
        writeln(msg_VUONG,a+1,msg_VUONG_2,msg_KIEM,Data_Account[a].fullName,msg_ID_,Data_Account[a].idAcc);
    end;
    write(msg_CHANGE_ACCOUNT);
    readln(ask1);
    if ask1 > AMOUNT_ACCOUNT+1 then begin
        writeln(msg_CHANGE_LESS);
    end
    else if ask1 < 0 then begin
        writeln(msg_CHANGE_AM);
    end
    else
        ask1 := ask1 - 1;
    Data_Account[ask1].iStatus := True;
    myAccount := Data_Account[ask1];
    myAccount.iStatus := True;
    isLogin := True;
    Session := Data_Account[ask1].idAcc;
    boTemp := True;
end;

procedure CHECK_ACTIVE_USER();
begin
    Online_account := 0;
    Offline_account := 0;
    for a:=0 to AMOUNT_ACCOUNT do begin
        if Data_Account[AMOUNT_ACCOUNT].iStatus = True then begin
            Online_account := Online_account + 1
        end
        else
            Offline_account := Offline_account + 1;
    end;
end;

begin
    (*setup*)
    AMOUNT_ACCOUNT := -1;
    isLogin := False;
    
    Session := 0;
    x := 0;
    boTemp := False;
    while x<1000 do begin
        clrscr;
        
        Randomize;

        (*Show menu*)
        if AMOUNT_ACCOUNT >= 0 then begin
            CHECK_ACTIVE_USER();
            writeln(msg_ONLINE_PP,' ',msg_VUONG,Online_account,msg_VUONG_2,' ',msg_OFFLINE_PP,' ',msg_VUONG,Offline_account,msg_VUONG_2);
        end 
        else
            writeln(msg_NO_THERE_AT_ON);
        
        if isLogin = False then begin
            writeln(msg_IV);
        end
        else 
            if boTemp = False then begin
                MANAGE_ACCOUNT();
                continue;
            end;
            for a:=0 to AMOUNT_ACCOUNT do begin
                if Session = Data_Account[a].idAcc then begin
                    boTemp := True;
                    
                end
            end;
            
        if boTemp = True then begin
            writeln(msg_WELCOME,myAccount.fullName,msg_CIR,myAccount.Alias,msg_CIR_2);
            writeln(msg_FRIENDS,myAccount.Friends);
            if myAccount.iStatus = True then begin
                writeln(msg_STATUS_ACC,msg_ACTIVE_ACC);
            end
            else
                writeln(msg_STATUS_ACC,msg_OFFLINE_ACC);
        end;
        
        for a:=0 to DataMenu_LEN do begin
            writeln(msg_VUONG,DataMenu[a].Number,msg_VUONG_2,' ',DataMenu[a].Title);
        end;
        write(msg_CHOOSE_FUNCTION);
        readln(ask1);
        
        (*Function action*)
        if ask1 = 1 then begin
            CREATE_ACCOUNT();
            isLogin := True;
            
        end
        else if ask1 = 2 then begin
            write('so 2');
        end
        else if ask1 = 3 then begin
            write('so 3');
        end
        else if ask1 = 4 then begin
            write('so 4');
        end
        else if ask1 = 5 then begin
            write('so 5');
        end
        else
            write('so 6');
        write('Nhấn enter để back về menu!');
        readln;
        continue;
    end;

end.
