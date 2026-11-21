use std::io::{self, BufRead, BufReader, Read, Write};
use std::net::{TcpListener, TcpStream};
use std::time::Duration;

fn main() -> io::Result<()> {
    let listener = TcpListener::bind("0.0.0.0:8080")?;
    for connection in listener.incoming() {
        if let Err(error) = connection.and_then(respond) {
            eprintln!("Request failed: {error}");
        }
    }
    Ok(())
}

fn respond(mut stream: TcpStream) -> io::Result<()> {
    stream.set_read_timeout(Some(Duration::from_secs(2)))?;
    for line in BufReader::new(&stream).take(8192).lines() {
        if line?.is_empty() {
            break;
        }
    }

    let body = "Hello from Rust\n";
    write!(
        stream,
        "HTTP/1.1 200 OK\r\nContent-Type: text/plain; charset=utf-8\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
        body.len()
    )
}
