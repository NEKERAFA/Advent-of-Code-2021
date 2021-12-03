type last_number = None | Some of int;;

let file = "input.txt";;

let f = open_in file;;

let larger_measurements = ref 0;;

let rec read_file f result last value =
  	match last with
            | None -> read_file f result (Some value) (int_of_string (input_line f))
            | Some last_val -> if value > last_val then (
                                   result := !result + 1;
                                   read_file f result (Some value) (int_of_string (input_line f))
                               ) else read_file f result (Some value) (int_of_string (input_line f));;

let () =
    try
        read_file f larger_measurements None (int_of_string (input_line f))
    with End_of_file ->
        close_in f;
        print_int !larger_measurements;
        print_newline ()
