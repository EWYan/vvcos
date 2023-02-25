

use core::arch::global_asm;

global_asm!(".section .text.vec");
global_asm!(include_str!("boot.s"));

#[no_mangle]
pub unsafe fn _start_rs() -> ! {
    extern "C" {
        static mut __vec_addr: u32;
    }
    let reset_addr:*mut u32 = core::ptr::null_mut();
    let vector_tbl_addr = __vec_addr as *const u32;
    core::ptr::copy_nonoverlapping(vector_tbl_addr, reset_addr, 8_usize);

    crate::main();
}