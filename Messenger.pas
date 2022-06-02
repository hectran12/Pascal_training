program messenger;
uses crt,sysutils;
(*type*)
type 
    ACCOUNT = record
                fullName : string[30];
                Alias : string[15];
                Age : integer;
                Bio : string;
                iStatus : boolean;
                Friends : integer;
                Friends_list : array[0..1000] of integer;
                inv_Friends : array[0..1000] of longInt;
                inv_amount : integer;
                accep_friends : array[0..1000] of integer;
                accep_am : integer;
                logs : array[0..1000] of string;
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
                
                
    (*split string extension*)
    get = record
            start : integer;
            ends : integer;
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
    msg_ADD_FR = 'Nhập số thứ tự bạn muốn kết bạn (ex 1 2 3): ';
    msg_NO_FR = 'Hiện không có ai để kết bạn!';
    msg_ADD_SUCCESS = 'Gửi lời mời thành công cho ';
    msg_IDNE = '|| ID: ';
    msg_IS_INV = '[Đã gửi lời mời]';
    msg_CANCEL_FR = 'Đã hủy lời mời kết bạn với ';
    msg_YOUR_SELF = '[Tài khoản đang sử dụng]';
    msg_NOT_ADD_YOUR_SELF = 'Không thể kết bạn với chính bản thân';
    (*LOGOUT TEXT*)
    msg_LOGOUT = 'Đăng xuất thành công!';
    (*accept friend*)
    msg_ACCEPTFR = 'Nhập số bạn muốn chấp nhận kết bạn (ex: 1 2 3): ';
    msg_IDS_FR = 'ID: ';
    msg_NAMES_FR = ' || TÊN: ';
    msg_ACCEPT_SUCCESS = 'Chấp nhận kết bạn thành công với ';
    (*Messenger text*)
    msg_TITLE_SEND = 'Nhắn tin với ';
    msg_SENDMESSENGER = 'Nhập tin nhắn muốn gửi: ';
var 
    is_Active : boolean;
    
    (*Support variables*)
    a : integer; (*for 1*)

    x : integer; (*for 2*)

    ask1 : integer; (*ask 1*)
    ask2 : string; (*ask 2*)
    boTemp_2 : boolean;
    boTemp : boolean; (*boolean temporary*)
    (*Data*)
    AMOUNT_ACCOUNT : longInt;
    
    (*System data*)
    (*Không giới hạn nếu chạy trên môi trường này*)
    Data_Account : array[0..1000] of ACCOUNT;
    Online_account : integer;
    Offline_account : integer;
    (*My account*)
    myAccount : ACCOUNT;
    isLogin : boolean;
    Sessions : longInt;

    Text : string; (*Văn bản cần tách*)
    Result : array[0..1000] of string; (*Kí tự cần tách*)
    amRes : integer; (*Số phần tử*)
    status : boolean; (*Trạng thái tách*)
   
    Session : string; (*support length*)
    liChar : array[0..1000] of string; (*Toàn kí tự dạng chuỗi*)
    amAC : integer; (*Phiên*)
    isCheck : boolean; (*Check length*)
    (*explode variable*)
    allText : string; (*Tất cả kí tự*)
    allStt : integer; (*phiên*)
    myBoolen : boolean;
    listTemp : array[0..1000] of ACCOUNT;
    listInt : array[0..1000] of integer; (*Session*)
    {
        Session variales
    }
    y : integer;
    z : integer;
    listLocal : array[0..1000] of get;
(*support procedure*)
{
    Lấy độ dài kí tự
    how to use:
        - Ghi chuỗi vào biến (*Text*)
        - gọi hàm ra getLength()
        - Số kí tự trả về bên trong biến (*amAC*)
}
procedure getLength();
const chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY, (.\+*?[^]$(){}=!<>|:-)';
begin
    isCheck := False;
    amAC := 0;
    for a:=1 to 1000 do begin
        for y:=1 to 85 do begin
            if Text[a] = chars[y] then begin
                liChar[a] := Text[a]; 
                amAC := amAC + 1;
                isCheck := True;
            end;
        end;
        if isCheck = False then begin
                break;
        end;
    end;
end;

{
    Cắt chuỗi ( 1 kí tự )
    how to use:
        - Ghi chuỗi vào biến (*Text*)
        - gọi hàm ra Split('<kí tự muốn tách>')
        - Kết quả trả về dạng array , được gán vào biến (*Result*) ( Kiểu dữ liệu mỗi phần tử là String )
}
procedure Split(s: string);
begin
    getLength();
    amRes := -1;
    Session := '';
    for a:=0 to amAC do begin
        if liChar[a] = s then begin
            amRes := amRes + 1;
            Result[amRes] := Session;
            Session := '';
        end
        else
            Session := Session + liChar[a];
    end;
    amRes := amRes + 1;
    Result[amRes] := Session;
end;

{
    Cắt chuỗi nhiều kí tự , theo dộ dài
    how to use:
        - Ghi chuỗi vào biến (*Text*)
        - gọi hàm ra Explode_Count('<chuỗi muốn tách>','<độ dài chuỗi muốn tách>')
        - Kết quả trả về được gán vào biến (*listLocal*)
        - Kiểu dữ liệu trả về là get được record trong type với (*start*) và (*ends*) là 2 integer
        - Lấy ra bằng cách như demo bên dưới
        CÁCH SỬ DỤNG CHI TIẾT:
        - Biến (*amRes*) là tổng số lần gặp kí tự muốn cắt trong chuỗi tìm được
        - Lấy nó và dùng for từ 0 đến amRes
        - Ta lấy được 2 giá trị từ 2 biến loại bản ghi là (*start*) và (*ends*)
        - start: Lấy vị trí đầu gặp chuỗi muốn cắt
        - ends: Lấy vị trí cuối của chuỗi đã gặp
}
procedure Explode_Count(s: string; len: integer);
begin
    getLength();
    allText := '';
    allStt := 0;
    amRes := -1;
    for a:=1 to amAC+1 do begin
        if allStt >= len then begin
            (*alltext*)
            for z:=0 to allStt do begin
                alltext := alltext + liChar[listInt[z]];
            end;
            (*get text Session*)
            Session := '';
            for z:=listInt[0] to a-1 do begin
                Session:=Session+liChar[z];
            end;
            if Session = s then begin
                amRes := amRes + 1;
                listLocal[amRes].start := a-len;
                listLocal[amRes].ends := a+len-len-1;
            end;
            allStt := 0;
        end;
        listInt[allStt] := a;
        allStt := allStt + 1;
    end;
end;

(*procedure*)
{
    CREATE_ACCOUNT : tạo tài khoản
    MANAGE_ACCOUNT : Quản lý tài khoản
}


procedure UPDATE_ACCOUNT_IN_DATABASE();
begin
    for x:=0 to AMOUNT_ACCOUNT do begin
        if Data_Account[x].idAcc = myAccount.idAcc then begin
            Data_Account[x] := myAccount;
            break;
        end;
    end;
end;


procedure ACCEPT_FR();
begin
    z := -1;
    for a:=0 to myAccount.accep_am do begin
        y := myAccount.accep_friends[a];
        
        for x:=0 to AMOUNT_ACCOUNT do begin
            if Data_Account[x].idAcc = y then begin
                z := z+1;
                listTemp[z] := Data_Account[x];
                break;
            end;
        end;

    end;

    for a:=0 to z do begin
        writeln(msg_VUONG,a+1,msg_VUONG_2,msg_KIEM,' ',msg_IDS_FR,listTemp[a].idAcc,msg_NAMES_FR,listTemp[a].fullName);
    end;
    write(msg_ACCEPTFR);
    readln(ask2);
    Text := ask2;
    myBoolen := False;
    if length(Text) = 1 then begin
        amRes := 0;
        Result[amRes] := Text;
    end
    else if length(Text) > 1 then begin
        Split(' ');
    end
    else
        myBoolen := True;

    if myBoolen = False then begin
         for x:=0 to amRes do begin
         {
            writeln(listTemp[StrToInt(Result[x])-1].idAcc);
         }
            myAccount.accep_am := myAccount.accep_am - 1;
            for z:=0 to myAccount.accep_am do begin
                y := myAccount.accep_friends[a];
                if listTemp[StrToInt(Result[x])-1].idAcc = y then begin
                    myAccount.accep_friends[a] := 0;
                end;
            end;
            myAccount.Friends := myAccount.Friends + 1;
            myAccount.Friends_list[myAccount.Friends-1] := listTemp[StrToInt(Result[x])-1].idAcc;
            writeln(msg_ACCEPT_SUCCESS,listTemp[StrToInt(Result[x])-1].fullName);
         end;
    end;
    
end;

procedure SEND_MESSENGER();
begin
    for x:=0 to myAccount.Friends-1 do begin
        {
            writeln(myAccount.Friends_list[x]);
        }
        {
            Mai update tiếp
        }
    end;
end;

procedure ADD_FRIENDS ();
begin
    if AMOUNT_ACCOUNT <= 0 then begin
        writeln(msg_NO_FR);
    end
    else if AMOUNT_ACCOUNT > 0 then begin
        for a:=0 to AMOUNT_ACCOUNT do begin
            
            boTemp_2 := False;
            for x:=0 to myAccount.inv_amount do begin
                if myAccount.inv_Friends[x] = Data_Account[a].idAcc then begin
                    writeln(msg_VUONG,a+1,msg_VUONG_2,msg_KIEM,Data_Account[a].fullName,msg_ID_,Data_Account[a].idAcc,' ',msg_IS_INV);
                    boTemp_2 := True;
                    break;
                end;
            end;
            if boTemp_2 = False then begin
                if myAccount.idAcc = Data_Account[a].idAcc then begin
                    writeln(msg_VUONG,a+1,msg_VUONG_2,msg_KIEM,Data_Account[a].fullName,msg_ID_,Data_Account[a].idAcc,' ',msg_YOUR_SELF);
                
                end
                else
                    writeln(msg_VUONG,a+1,msg_VUONG_2,msg_KIEM,Data_Account[a].fullName,msg_ID_,Data_Account[a].idAcc);
            end;
        end;
        write(msg_ADD_FR);
        readln(ask2);
        Text := ask2;
        getLength();
        
        myBoolen := False;
        if length(Text) = 1 then begin
            amRes := 0;
            Result[amRes] := Text;
        end
        else if length(Text) > 1 then begin
            Split(' ');
        end
        else
            myBoolen := True;

        if myBoolen = False then begin
            for x:=0 to amRes do begin
                
                boTemp_2 := False;
                for a:=0 to myAccount.inv_amount do begin
                    
                    if myAccount.inv_Friends[a] = Data_Account[StrToInt(Result[x])-1].idAcc then begin
                        myAccount.inv_Friends[a] := -1;
                        boTemp_2 := True;
                        break;
                    end;
                end;

                if boTemp_2 = False then begin
                    if myAccount.idAcc = Data_Account[StrToInt(Result[x])-1].idAcc then begin
                        writeln(msg_NOT_ADD_YOUR_SELF);
                        continue;
                    end;
                    myAccount.inv_amount := myAccount.inv_amount + 1;
                    myAccount.inv_Friends[myAccount.inv_amount] := Data_Account[StrToInt(Result[x])-1].idAcc;
                    Data_Account[StrToInt(Result[x])-1].accep_am := Data_Account[StrToInt(Result[x])-1].accep_am + 1;
                    Data_Account[StrToInt(Result[x])-1].accep_friends[Data_Account[StrToInt(Result[x])-1].accep_am] := myAccount.idAcc;
                    writeln(msg_ADD_SUCCESS,Data_Account[StrToInt(Result[x])-1].fullName);
                end
                else if boTemp_2 = True then begin
                    writeln(msg_CANCEL_FR,Data_Account[StrToInt(Result[x])-1].fullName);
                end;
                
            
            end;
            
            
        end;
    end;
    UPDATE_ACCOUNT_IN_DATABASE();
    
end;
procedure CREATE_ACCOUNT ();
begin
    myAccount.iStatus := False;
    UPDATE_ACCOUNT_IN_DATABASE();
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
    Randomize;
    Data_Account[AMOUNT_ACCOUNT].idAcc := Random(1000);
    for a:=0 to AMOUNT_ACCOUNT do begin
        if Data_Account[AMOUNT_ACCOUNT].idAcc = Data_Account[a].idAcc then begin
            Data_Account[AMOUNT_ACCOUNT].idAcc := Random(1000);
        end;
    end;
    Data_Account[AMOUNT_ACCOUNT].inv_amount := -1;
    Data_Account[AMOUNT_ACCOUNT].accep_am := -1;
    writeln(msg_REG_SUCCESS,Data_Account[AMOUNT_ACCOUNT].idAcc);
    boTemp := False;
    isLogin := False;
end;

procedure MANAGE_ACCOUNT();
begin
    myAccount.iStatus := False;
    UPDATE_ACCOUNT_IN_DATABASE();
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
    {
    Data_Account[ask1].iStatus := True;
    }
    myAccount := Data_Account[ask1];
    myAccount.iStatus := True;
    UPDATE_ACCOUNT_IN_DATABASE();
    isLogin := True;
    Sessions := Data_Account[ask1].idAcc;
    boTemp := True;
end;

procedure CHECK_ACTIVE_USER();
begin
    Online_account := 0;
    Offline_account := 0;
    for a:=0 to AMOUNT_ACCOUNT do begin
        if Data_Account[a].iStatus = True then begin
            Online_account := Online_account + 1
        end
        else
            Offline_account := Offline_account + 1;
    end;
end;

procedure LOGOUT();
begin
    for x:=0 to AMOUNT_ACCOUNT do begin
        if Data_Account[x].idAcc = myAccount.idAcc then begin
            Data_Account[x].iStatus := False;
            writeln(msg_LOGOUT);
            MANAGE_ACCOUNT();
            break;
        end;
    end;
end;


begin
    (*setup*)
    AMOUNT_ACCOUNT := -1;
    isLogin := False;
    
    Sessions := 0;
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
                if Sessions = Data_Account[a].idAcc then begin
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
            ADD_FRIENDS();
        end
        else if ask1 = 3 then begin
            ACCEPT_FR();

        end
        else if ask1 = 4 then begin
            SEND_MESSENGER();
        end
        else if ask1 = 5 then begin
            write('so 5');
        end
        else if ask1 = 6 then begin
            MANAGE_ACCOUNT();
        end
        else if ask1 = 7 then begin
            LOGOUT();
        end;
        write('Nhấn enter để back về menu!');
        readln;
        continue;
    end;

end.
