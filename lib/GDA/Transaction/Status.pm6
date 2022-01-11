use v6.c

use Method::Also;
use NativeCall;

use GDA::Raw::Types;

use GLib::Roles::Object;

our subset GdaTransactionStatusAncestry is export of Mu
  where GdaTransactionStatus | GObject;

class GDA::Transaction::Status {
  also does GLib::Roles::Object;

  has GdaTransactionStatus $!gts is implementor;

  submethod BUILD ( :$gda-transaction-status ) {
    self.setGdaTransactionStatus($gda-transaction-status)
      if $gda-transaction-status;
  }

  method setGdaTransactionStatus (GdaTransactionStatusAncestry $_) {
    my $to-parent;

    $!gts = do {
      when GdaTransactionStatus {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaTransactionStatus, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaTransactionStatus
    is also<GdaTransactionStatus>
  { $!gts }

  multi method new (
    GdaTransactionStatusAncestry  $gda-transaction-status,
                                 :$ref                     = True
  ) {
    return Nil unless $gda-transaction-status;

    my $o = self.bless( :$gda-transaction-status );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name) {
    my $gda-transaction-status = gda_transaction_status_new($name);

    $gda-transaction-status ?? self.bless( :$gda-transaction-status ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_transaction_status_get_type, $n, $t );
  }

}


### /usr/include/libgda-5.0/libgda/gda-transaction-status.h

sub gda_transaction_status_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_transaction_status_new (Str $name)
  returns GdaTransactionStatus
  is native(gda)
  is export
{ * }
