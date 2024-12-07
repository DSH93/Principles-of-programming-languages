fun func_power (func: 'a -> 'a, n: int): 'a -> 'a =
    if n = 0 then fn x => x
    else fn x => func ((func_power (func, n-1)) x);

fun replace_helper (s: string, old: string, new: string, index: int): string =
    let
        val s_len = String.size s
        val old_len = String.size old
    in
        if index > s_len - old_len then s
        else if String.substring (s, index, old_len) = old then
            replace_helper (String.substring (s, 0, index) ^ new ^ String.substring (s, index + old_len, s_len - (index + old_len)), old, new, index + String.size new)
        else
            replace_helper (s, old, new, index + 1)
    end;

fun replace (s: string, old: string, new: string): string =
    let
        val s_new = replace_helper (s, old, new, 0)
    in
        if s_new = s then s
        else replace (s_new, old, new)
    end;

    
    
fun digit_to_string (n: int): string =
    if n < 0 orelse n > 9 then
        raise Fail "Invalid digit"
    else
        Int.toString n;

val coeff = ref "" : string ref;

fun han (n: int): string =
    if n = 0 then 
        (coeff := ""; "")  
    else
        let
            val updated_coeff = !coeff ^ (digit_to_string n) ^ !coeff
        in
            coeff := updated_coeff;
            updated_coeff
        end;



val curry2 : ('a * 'b -> 'c) -> 'a -> 'b -> 'c =
    fn f => fn x => fn y => f (x, y);

val curry3 : ('a * 'b * 'c -> 'd) -> 'a -> 'b -> 'c -> 'd =
    fn f => fn x => fn y => fn z => f (x, y, z);

val uncurry2 : ('a -> 'b -> 'c) -> 'a * 'b -> 'c =
    fn f => fn (x, y) => f x y;

val uncurry3 : ('a -> 'b -> 'c -> 'd) -> 'a * 'b * 'c -> 'd =
    fn f => fn (x, y, z) => f x y z;



        

