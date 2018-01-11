# crategrep

This project is a web service that allows you to search all of the source code
on crates.io with ripgrep.

## Dependencies

Make sure you have [ripgrep](https://github.com/BurntSushi/ripgrep) installed.

The easiest way is probably to use `cargo install --force ripgrep`, though there
may be another way you prefer for your specific platform. See the ripgrep
repository for more installation instructions.

## Mirror All Source Code

To make this work, you need to have a mirror of all of the source code hosted on
crates.io. Running the following script will do just that. It may take a while.

```bash
$ ./mirror-sources.sh
```

## Building & Running

To start the server, run:

```bash
$ cargo run
```

This should automatically install the right toolchain listed in the
`rust-toolchain` file. To make sure you have a recent Rust nightly installed,
use `rustup install nightly`.
