#![feature(plugin, custom_derive)]
#![plugin(rocket_codegen)]

extern crate rocket;

use std::process::Command;

#[derive(FromForm)]
struct Query {
    pattern: String,
}

#[get("/")]
fn index() -> &'static str {
    "Try /search?pattern=hello\nTry /search?pattern=cargo"
}

#[get("/search?<query>")]
fn search(query: Query) -> String {
    let output = Command::new("sh").arg("-c")
        .arg(format!("rg '{}' crates-mirror/**/*.rs", query.pattern))
        .output()
        .expect("Could not search");

    let results = String::from_utf8(output.stdout)
        .expect("Could not decode results to string");
    let errors = String::from_utf8(output.stderr)
        .expect("Could not decode errors to string");

    format!("RESULTS:\n\n{}\nERRORS:\n\n{}", results, errors)
}

fn main() {
    rocket::ignite().mount("/", routes![
        index,
        search,
    ]).launch();
}
