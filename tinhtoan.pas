program caculator;

(*thư viện*)
uses crt;

(*type*)
{
    History : Loại này để set lịch sử
    Menu : Loại này để set Menu
}
type
    History = record
                stt : integer;
                title : string;
                result : integer;
               end;

    Menu = record
                stt : integer;
                title : string;
               end;

(*const*)
{
    (*Msg*)

}
const
    msg_WELCOME = 'Xin chào bạn tới máy tính toán bằng Pascal';
    msg_INPUTPT = 'Mời bạn nhập phép tính (ex: 1+2+3-4+5/6*7): ';
    
    msg_INPUT_CHOOSE_MENU = 'Nhập lựa chọn Menu: ';
    msg_ERROR_CHOOSE_MENU = 'Sao lại nhập lớn hơn 2? ';

    menuOut : array[0..1] of Menu = (
        (stt:1;title:'Tính'),
        (stt:2;title:'Xem lịch sử tính')
    );
    DataMenuOut_Count = 1;

(*var*)
{
    x , y , z , u , a : support variables
    ask1 , ask2 : support string variables
    ask3 , ask4 : support string variables
}
var
    x , y , z , u , a : integer;
    ask1 , ask2 : integer;
    ask3 , ask4 : string;
     (*while var*) whileCheck : integer;

(*procedure*)
{
    tinh - Tính toán
    lichsu - Lịch sử
    xuly - xử lý các bài toán
}

procedure tinh();
begin


end;

procedure lichsu();
begin


end;

procedure xuly();
begin

end;

begin

    (* 
        start while - continue or break is stop program {
            or clear session 
        }
    *)

    while whileCheck < 1000 do begin

        (*in code*)
        clrscr;
        writeln(msg_WELCOME);
        for x:=0 to DataMenuOut_Count do begin
            writeln('[',menuOut[x].stt,'] => ',menuOut[x].title);
        end;
        write(msg_INPUT_CHOOSE_MENU);
        readln(ask1);

        (*check menu choose*)
        if ask1 = 1 then begin
            tinh();
            continue;
        end
        else if ask1 = 2 then begin
            lichsu();
            continue;
        end
        else
            write(msg_ERROR_CHOOSE_MENU);
            continue;


    end;
    


end.
