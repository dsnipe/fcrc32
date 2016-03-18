// ///////////////////////////////////////////////////////////
// Copyright (c) 2011-2015 Stephan Brumme. All rights reserved.
// Slicing-by-16 contributed by Bulat Ziganshin
// see http://create.stephan-brumme.com/disclaimer.html
//

// g++ -o Crc32 Crc32.cpp -O3 -lrt -march=native -mtune=native

#include <ruby.h>
#include <fcrc32.h>
#include <stdlib.h>

// Ruby bindings
void Init_fcrc32() {
  VALUE FCRC32 = rb_define_module("FCrc32");
  rb_define_singleton_method(FCRC32, "c_calculate", crc32_16bytes, 3);
}
// compute CRC32 (Slicing-by-16 algorithm)
VALUE crc32_16bytes(VALUE self, VALUE data, VALUE length, VALUE previousCrc32)
{
  uint32_t datalen;
  uint32_t crc;
  uint32_t one, two, three, four;
  char *bindata;
  uint32_t* current;
  unsigned char* currentChar;

  crc = ~NUM2UINT(previousCrc32); // ^ ~ 0U; // same as previousCrc32 ^ 0xFFFFFFFF
  datalen = NUM2UINT(length);
  bindata = StringValuePtr(data);

  current = (uint32_t*) bindata;

  // enabling optimization (at least -O2) automatically unrolls the inner for-loop
  /* const size_t Unroll = 4; */
  /* const size_t BytesAtOnce = 16 * Unroll; */

  while (datalen >= 16)
  {
    one   = *current++ ^ crc;
    two   = *current++;
    three = *current++;
    four  = *current++;

    crc  = Crc32Lookup[ 0][(four  >> 24) & 0xFF] ^
      Crc32Lookup[ 1][(four  >> 16) & 0xFF] ^
      Crc32Lookup[ 2][(four  >>  8) & 0xFF] ^
      Crc32Lookup[ 3][ four         & 0xFF] ^
      Crc32Lookup[ 4][(three >> 24) & 0xFF] ^
      Crc32Lookup[ 5][(three >> 16) & 0xFF] ^
      Crc32Lookup[ 6][(three >>  8) & 0xFF] ^
      Crc32Lookup[ 7][ three        & 0xFF] ^
      Crc32Lookup[ 8][(two   >> 24) & 0xFF] ^
      Crc32Lookup[ 9][(two   >> 16) & 0xFF] ^
      Crc32Lookup[10][(two   >>  8) & 0xFF] ^
      Crc32Lookup[11][ two          & 0xFF] ^
      Crc32Lookup[12][(one   >> 24) & 0xFF] ^
      Crc32Lookup[13][(one   >> 16) & 0xFF] ^
      Crc32Lookup[14][(one   >>  8) & 0xFF] ^
      Crc32Lookup[15][ one          & 0xFF];

    datalen -= 16;
  }

  currentChar = (unsigned char*) current;
  // remaining 1 to 63 bytes (standard algorithm)
  while (datalen-- != 0)
    crc = (crc >> 8) ^ Crc32Lookup[0][(crc & 0xFF) ^ *currentChar++];

  crc = ~crc;

  VALUE crc32 = rb_uint2inum(crc);
  return crc32;
}
