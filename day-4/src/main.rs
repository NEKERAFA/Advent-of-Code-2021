use std::fs::File;
use std::process;
use std::io::{BufReader, BufRead};

/**
 * Reads the list of numbers
 */
fn read_numbers<R: BufRead>(reader: &mut R) -> Vec<i32> {
    let mut numbers_buf = String::new();

    if let Err(e) = reader.read_line(&mut numbers_buf) {
        eprintln!("error reading line: {}", e);
        process::exit(-1);
    }

    let numbers = numbers_buf.split(',').map(|x| x.trim().parse::<i32>().unwrap()).collect();
    
    numbers_buf.clear();
    if let Err(e) = reader.read_line(&mut numbers_buf) {
        eprintln!("error reading line: {}", e);
        process::exit(-1);
    }

    if numbers_buf.trim().len() != 0 {
        eprintln!("format invalid");
        process::exit(-1);
    }

    return numbers;
}

fn main() {
    let f = match File::open("input.txt") {
        Ok(file) => file,
        Err(e) => {
            eprintln!("error opening file: {}", e);
            process::exit(-1);
        }
    };
    
    let mut reader = BufReader::new(f);
    let numbers = read_numbers(&mut reader);

    for x in &numbers {
        print!("{} ", x);
    }

    println!("End");
}

