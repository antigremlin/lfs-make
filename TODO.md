# Todo List

## Temporary Tools (Ch. 5)

Builds to be scripted:

- binutils
- GCC
- Linux kernel headers
- Glibc
- libstdc++
- tcl-core
- expect
- DejaGNU
- check
- ncurses
- bash

Builds to move to separate files:

- bzip2
- gettext

Yet to be built:

- Perl

Signature checks:

- kernel.org approach (unpacked tar has signature): kernel source, util-linux
- xz uses .sig but not covered by $(download-gnu)
- need a pluggable approach to downloads and signature/hash checks

Errors in packaging:

- error in sed dist-xz
- error in texinfo dist-xz
- error in util-linux dist-xz
