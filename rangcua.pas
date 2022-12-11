program rangcua;
uses crt;
const
        fileinp = 'inp.inp';
        fileout = 'out.out';
var
        f,g :text;
        number, i, last, location: longint;
        firstNumber,firstcheck,  check, checkRs: boolean;
        result: string;
begin
        firstNumber:=False;
        check:=False;
        checkRs := True;
        firstCheck := False;
        location := 0;
        assign(f, fileinp);
        reset(f);
        assign(g, fileout);
        rewrite(g);
        result := '';
        read(f, number);
        for i:=1 to number do begin
            read(f, number);
            if firstNumber = True then begin
                if firstCheck = False then begin
                    if last > number then check:=True;
                    if last < number then check:=False;
                    firstCheck := True;
                end
                else begin
                    if check = False then begin
                        if last > number then check:=True
                        else begin
                            checkRs := False;
                            location := i;
                            break;
                        end;
                    end
                    else begin
                        if last < number then check:=False
                        else begin
                            checkRs := False;
                            location := i;
                            break;
                        end;
                    end
                end;
            end
            else begin
                 firstNumber := True;
                 last := number;
            end;
            last := number;
        end;
        if checkRs = True then begin
            write(g, 'Yes');
        end
        else begin
            write(g, 'No ');
            write(g, location);
        end;
        close(f);
        close(g);

end.
