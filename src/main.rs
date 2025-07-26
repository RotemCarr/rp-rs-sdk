#![no_std]
#![no_main]

use core::panic::PanicInfo;

extern "C" {
    fn blink_led();
    // fn uart_shim_init();
    // fn uart_shim_write(c: u8);
    // fn uart_shim_read() -> u8;
}

#[no_mangle]
pub extern "C" fn main() -> ! {
    // unsafe {
    //     uart_shim_init();
    //     uart_shim_write(b'H');
    //     uart_shim_write(b'e');
    //     uart_shim_write(b'l');
    //     uart_shim_write(b'l');
    //     uart_shim_write(b'o');
    //     uart_shim_write(b'\n');
    // }

    loop {
        // Optionally echo back received bytes
        unsafe {
            // let c = uart_shim_read();
            // uart_shim_write(c);
            blink_led();
        }
    }
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}