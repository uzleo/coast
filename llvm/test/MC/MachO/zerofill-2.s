// RUN: llvm-mc -triple i386-apple-darwin9 %s -filetype=obj -o - | llvm-readobj -file-headers -s -sd -r -t --macho-segment --macho-dysymtab --macho-indirect-symbols | FileCheck %s

        .byte 0

        // This file has size 2, the tail padding doesn't count.
        .zerofill       __DATA, __bss, sym_a, 1

// CHECK: File: <stdin>
// CHECK: Format: Mach-O 32-bit i386
// CHECK: Arch: i386
// CHECK: AddressSize: 32bit
// CHECK: MachHeader {
// CHECK:   Magic: Magic (0xFEEDFACE)
// CHECK:   CpuType: X86 (0x7)
// CHECK:   CpuSubType: CPU_SUBTYPE_I386_ALL (0x3)
// CHECK:   FileType: Relocatable (0x1)
// CHECK:   NumOfLoadCommands: 4
// CHECK:   SizeOfLoadCommands: 312
// CHECK:   Flags [ (0x0)
// CHECK:   ]
// CHECK: }
// CHECK: Sections [
// CHECK:   Section {
// CHECK:     Index: 0
// CHECK:     Name: __text (5F 5F 74 65 78 74 00 00 00 00 00 00 00 00 00 00)
// CHECK:     Segment: __TEXT (5F 5F 54 45 58 54 00 00 00 00 00 00 00 00 00 00)
// CHECK:     Address: 0x0
// CHECK:     Size: 0x1
// CHECK:     Offset: 340
// CHECK:     Alignment: 0
// CHECK:     RelocationOffset: 0x0
// CHECK:     RelocationCount: 0
// CHECK:     Type: 0x0
// CHECK:     Attributes [ (0x800000)
// CHECK:       PureInstructions (0x800000)
// CHECK:     ]
// CHECK:     Reserved1: 0x0
// CHECK:     Reserved2: 0x0
// CHECK:     SectionData (
// CHECK:       0000: 00                                   |.|
// CHECK:     )
// CHECK:   }
// CHECK:   Section {
// CHECK:     Index: 1
// CHECK:     Name: __bss (5F 5F 62 73 73 00 00 00 00 00 00 00 00 00 00 00)
// CHECK:     Segment: __DATA (5F 5F 44 41 54 41 00 00 00 00 00 00 00 00 00 00)
// CHECK:     Address: 0x1
// CHECK:     Size: 0x1
// CHECK:     Offset: 0
// CHECK:     Alignment: 0
// CHECK:     RelocationOffset: 0x0
// CHECK:     RelocationCount: 0
// CHECK:     Type: LocReloc (0x1)
// CHECK:     Attributes [ (0x0)
// CHECK:     ]
// CHECK:     Reserved1: 0x0
// CHECK:     Reserved2: 0x0
// CHECK:   }
// CHECK: ]
// CHECK: Relocations [
// CHECK: ]
// CHECK: Symbols [
// CHECK:   Symbol {
// CHECK:     Name: sym_a (1)
// CHECK:     Type: Section (0xE)
// CHECK:     Section: __bss (0x2)
// CHECK:     RefType: UndefinedNonLazy (0x0)
// CHECK:     Flags [ (0x0)
// CHECK:     ]
// CHECK:     Value: 0x1
// CHECK:   }
// CHECK: ]
// CHECK: Indirect Symbols {
// CHECK:   Number: 0
// CHECK:   Symbols [
// CHECK:   ]
// CHECK: }
// CHECK: Segment {
// CHECK:   Cmd: LC_SEGMENT
// CHECK:   Name: 
// CHECK:   Size: 192
// CHECK:   vmaddr: 0x0
// CHECK:   vmsize: 0x2
// CHECK:   fileoff: 340
// CHECK:   filesize: 1
// CHECK:   maxprot: rwx
// CHECK:   initprot: rwx
// CHECK:   nsects: 2
// CHECK:   flags: 0x0
// CHECK: }
// CHECK: Dysymtab {
// CHECK:   ilocalsym: 0
// CHECK:   nlocalsym: 1
// CHECK:   iextdefsym: 1
// CHECK:   nextdefsym: 0
// CHECK:   iundefsym: 1
// CHECK:   nundefsym: 0
// CHECK:   tocoff: 0
// CHECK:   ntoc: 0
// CHECK:   modtaboff: 0
// CHECK:   nmodtab: 0
// CHECK:   extrefsymoff: 0
// CHECK:   nextrefsyms: 0
// CHECK:   indirectsymoff: 0
// CHECK:   nindirectsyms: 0
// CHECK:   extreloff: 0
// CHECK:   nextrel: 0
// CHECK:   locreloff: 0
// CHECK:   nlocrel: 0
// CHECK: }
