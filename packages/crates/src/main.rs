use clap::Parser;
use ps2_bios_checksum::{format_file_size, hash_file};

#[derive(Parser, Debug)]
#[command(name = "ps2-bios-checksum", about = "Hash a local PS2 BIOS dump (MD5/SHA-1)")]
struct Args {
    /// Path to a local BIOS dump
    file: String,
}

fn main() {
    let args = Args::parse();
    match hash_file(&args.file) {
        Ok(result) => {
            println!("File:   {}", args.file);
            println!("Size:   {}", format_file_size(result.size_bytes));
            println!("MD5:    {}", result.md5);
            println!("SHA-1:  {}", result.sha1);
            println!("Status: {}", result.validation.summary);
        }
        Err(err) => {
            eprintln!("Couldn't read file: {err}");
            std::process::exit(1);
        }
    }
}
