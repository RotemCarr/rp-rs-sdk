fn main() {
    println!("cargo:rustc-link-search=native=./bind_layer/build");
    println!("cargo:rustc-link-lib=static=bind_layer");
}