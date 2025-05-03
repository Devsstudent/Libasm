fn main() {
    println!("cargo:rustc-link-lib=static=asm");
    println!("cargo:rustc-link-search=native=.");
}
