# crategrep

## Initial Setup

```bash
$ rm -rf crates-mirror/index/
$ git clone https://github.com/rust-lang/crates.io-index.git crates-mirror/index
$ # These next steps take a while because we are literally downloading and
$ # extracting the source of EVERY crate on crates.io
$ # If this gets interrupted, it will not start from the beginning
$ cargo install --git https://github.com/C4K3/crates-ectype
$ crates-ectype crates-mirror/ --no-update-index
$ for crate in $(ls crates-mirror/*.crate); do echo "Extracting source in $crate..."; tar xvzf $crate --directory crates-mirror; done
```
