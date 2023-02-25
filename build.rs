use std::env;
use std::path::Path;
use std::process::Command;

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();
    let dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let mut objs = Vec::new();
    for entry in std::fs::read_dir("./src/ffi_c").unwrap() {
        let path = entry.unwrap().path();
        let path_str = path.to_str().unwrap();
        println!("{}", path_str);
        let temp1 = path_str.split("/").collect::<Vec<_>>();
        let file_c = temp1[temp1.len() - 1];
        let obj = file_c.split(".").collect::<Vec<_>>()[0];
        objs.push(file_c.replace("c","o"));
        Command::new("arm-none-eabi-gcc")
                .args(&[path_str, "-c", "-fPIC", "-o"])
                .arg(&format!("{}/{}.o", out_dir, obj))
                .status()
                .unwrap();
    }

    println!("{:?}", objs);
    Command::new("arm-none-eabi-ar")
        .args(&["crus", "libffic.a"])
        .args(&objs)
        .current_dir(&Path::new(&out_dir))
        .status().unwrap();

    println!("cargo:rustc-link-search=native={}", out_dir);
    println!("cargo:rustc-link-search=native={}", Path::new(&dir).join("lib").display());
    println!("cargo:rustc-link-lib=static=ffic");
    println!("cargo:return-if-changed=src/ffi_c/");

}