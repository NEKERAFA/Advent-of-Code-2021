use std::fs::File;
use std::process;
use std::io::{BufReader, BufRead};

fn main() {
    let f = match File::open("input.txt") {
        Ok(file) => file,
        Err(e) => {
            eprintln!("error opening file: {}", e);
            process::exit(-1);
        }
    };
    
    let mut reader = BufReader::new(f);
    let mut number_buf = String::new();

    reader.read_line(&mut numbersBuf);

    let numbers : Vec<&str> = numbers_buf.split(',').collect();

    for x in &numbers {
        print!("{} ", x);
    }

    println!("");
}

