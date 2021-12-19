use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Lockable {
  has GdaLockable $!gl is implementor;

  method roleInit-GdaLockable is also<roleInit_GdaLockable> {
    my \i = findProperImplementor(self.^attributes);

    $!gl = cast(GdaLockable, i.get_value(self) )
  }

  method gdalockable_get_type is also<gdalockable-get-type> {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &gda_lockable_get_type, $n, $t );
  }

  method lock {
    gda_lockable_lock($!gl);
  }

  method trylock {
    so gda_lockable_trylock($!gl);
  }

  method unlock {
    gda_lockable_unlock($!gl);
  }
}

use GLib::Roles::Object;

our subset GdaLockableAncestry is export of Mu
  where GdaLockable | GObject;

class GDA::Lockable {
  also does GLib::Roles::Object;
  also does GDA::Roles::Lockable;

  submethod BUILD ( :$gda-lockable ) {
    self.setGdaLockable($gda-lockable) if $gda-lockable;
  }

  method setGdaLockable (GdaLockableAncestry $_) {
    my $to-parent;

    $!gl = do {
      when GdaLockable {
        $to-parent = cast(GObject, $_);
        cast(GdaLockable, $_);
      }

      default {
        $to-parent = $_;
        cast(GdaLockable, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaLockable
    is also<GdaLockable>
  { $!gl }

  multi method new (GdaLockableAncestry $gda-lockable, :$ref = True) {
    return Nil unless $gda-lockable;

    my $o = self.bless( :$gda-lockable );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    self.gdalockable_get_type;
  }
}

### /usr/include/libgda-5.0/libgda/gda-lockable.h

sub gda_lockable_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_lockable_lock (GdaLockable $lockable)
  is native(gda)
  is export
{ * }

sub gda_lockable_trylock (GdaLockable $lockable)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_lockable_unlock (GdaLockable $lockable)
  is native(gda)
  is export
{ * }
