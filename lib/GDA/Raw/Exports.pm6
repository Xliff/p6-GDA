use v6.c;

unit package GDA::Raw::Exports;

our @gda-exports is export;

BEGIN {
  @gda-exports = <
    GDA::Raw::Definitions
    GDA::Raw::Enums
    GDA::Raw::Structs
  >;
}
