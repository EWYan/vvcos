# target
TARGET := vvcos

# compiler linker flags
linker_flags := -C link-arg=--script=./linker.ld 
linker_flags += -C link-arg=--Map=target/armv7r-none-eabi/debug/${TARGET}.map

# macro defines

# build target
all:
	@cargo rustc -- ${linker_flags} --verbose
	@arm-none-eabi-objdump -D target/armv7r-none-eabi/debug/${TARGET} > target/armv7r-none-eabi/debug/$(TARGET).asm 
	@arm-none-eabi-objcopy -O binary target/armv7r-none-eabi/debug/${TARGET} target/armv7r-none-eabi/debug/${TARGET}.bin 

vtest:
	@echo not support for now

clean:
	@rm -rf target/

phony: all clean test
