# See LICENSE for license details.

#*****************************************************************************
# bf-hello.S
#-----------------------------------------------------------------------------
# Output Hello World by natively executing brainfuck code
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 1
  la t1, bf_code
  la t2, bf_data
  la t3, bf_output
  la t4, bf_output_end
1:
  .insn r CUSTOM_0, 0x7, 'B', t0, t1, t2
  lbu t5, 0(t3)
  bne t0, t5, fail
  addi t3, t3, 1
  addi gp, gp, 1
  blt t3, t4, 1b
  j pass

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

bf_code:
  /* Source: <https://esolangs.org/wiki/Brainfuck> */
  .ascii "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>."
  .ascii ">---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."

bf_data:
  .fill 7

bf_output:
  .ascii "Hello World!\n"
bf_output_end:

RVTEST_DATA_END
