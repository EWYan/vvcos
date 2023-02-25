#![no_std]
#![no_main]
use core::{
    panic::PanicInfo,
};

mod arch;
mod driver;

extern  "C" {
    fn hw_init();
}

pub unsafe fn main() -> !{
    unsafe {
        hw_init();
    }
    loop {
        core::arch::asm!("nop");
    }
}

#[panic_handler]
fn panic (_info: &PanicInfo) -> ! {
    loop {}
}