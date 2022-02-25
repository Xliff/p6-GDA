use v6.c;

unit package GDA::Raw::Exceptions;

class X::GDA::Holder::InvalidHolderProxy is Exception is export {
  has $!bad-var is built;

  method new ($bad-var) {
    self.bless( :$bad-var );
  }

  method message {
    "An invalid value of type {
     $!bad-var.^name } was used in lieu of a GdaHolder"
  }

}

class X::GDA::Holder::InvalidType is Exception is export {
  has $!bad-var is built;

  method new ($bad-var) {
    self.bless( :$bad-var )
  }

  method message {
    "An invalid type of { $!bad-var.^name } was used."
  }

}
