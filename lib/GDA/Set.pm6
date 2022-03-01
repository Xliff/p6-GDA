use v6.c;

use NativeCall;

use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Set;
use GDA::Raw::Exceptions;

use LibXML::Raw; # for anyNode;

use GLib::GList;
use GLib::GSList;
use GDA::Holder;

use GLib::Roles::Object;
use GDA::Roles::Signals::Set;

class GDA::Set::Group  { ... }
class GDA::Set::Node   { ... }
class GDA::Set::Source { ... }

our subset GdaSetAncestry is export of Mu
  where GdaSet | GObject;

class GDA::Set {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Set;

  has GdaSet $!gs is implementor;

  submethod BUILD ( :$gda-set ) {
    self.setGdaSet($gda-set) if $gda-set;
  }

  method setGdaSet (GdaSetAncestry $_) {
    my $to-parent;
    $!gs = do {
      when GdaSet {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaSet, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Structs::GdaSet
    is also<GdaSet>
  { $!gs }

  multi method new (GdaSetAncestry $gda-set, :$ref = True) {
    return Nil unless $gda-set;

    my $o = self.bless( :$gda-set );
    $o.ref if $ref;
    $o;
  }
  multi method new (*@list where *.elems > 1) {
    samewith(@list)
  }
  multi method new (@list) {
    samewith( GLib::GSList.new(@list, typed => GdaHolder) )
  }
  multi method new (GSList() $list-of-holders) {
    my $gda-set = gda_set_new($list-of-holders);

    $gda-set ?? self.bless( :$gda-set ) !! Nil;
  }

  method new_from_spec_node (
    anyNode                 $xml_spec,
    CArray[Pointer[GError]] $error
  )
    is also<new-from-spec-node>
  {
    clear_error;
    my $gda-set = gda_set_new_from_spec_node($xml_spec, $error);
    set_error($error);

    $gda-set ?? self.bless( :$gda-set ) !! Nil;
  }

  method new_from_spec_string (
    Str()                   $xml_spec,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<new-from-spec-string>
  {
    clear_error;
    my $gda-set = gda_set_new_from_spec_string($!gs, $xml_spec, $error);
    set_error($error);

    $gda-set ?? self.bless( :$gda-set ) !! Nil
  }

  # cw: varargs is currently out of scope!
  proto method new_inline (|)
    is also<new-inline>
  { * }

  multi method new_inline (+@holders) {
    samewith(@holders);
  }
  multi method new_inline (@holders) {
    @holders .= map({ get-gda-holder-from-proxy-value($_) });

    self.new( GLib::GSList.new(@holders, typed => GdaHolder) );
  }

  # cw: Marked as private, but still a part of the public API. For now we
  # trust the .h file.
  #method new_read_only (GSList() $holders) {
  #   my $gda-set = gda_set_new_read_only($!gs, $holders);
  #
  #   $gda-set ?? self.bless( :$gda-set ) !! Nil;
  # }

  # Is originally:
  # GdaSet*set --> GError *
  method validate-set is also<validate_set> {
    self.connect-validate-set($!gs);
  }

  # Is originally:
  # GdaSet set,  GdaHolder holder, Str attr_name, GValue attr_value --> void
  method holder-attr-changed is also<holder_attr_changed> {
    self.connect-holder-attr-changed($!gs);
  }

  # Is originally:
  # GdaSet set,  GdaHolder holder --> void
  method holder-type-set is also<holder_type_set> {
    self.connect-holder-type-set($!gs);
  }

  # Is originally:
  # GdaSet set,  GdaSetSource *source --> void
  method source-model-changed is also<source_model_changed> {
    self.connect-source-model-changed($!gs);
  }

  # Is originally:
  # GdaSet set,  GdaHolder holder,  GValue new_value --> GError
  method validate-holder-change is also<validate_holder_change> {
    self.connect-validate-holder-change($!gs);
  }

  # Is originally:
  # GdaSet set,  GdaHolder holder --> void
  method holder-changed is also<holder_changed> {
    self.connect-holder-changed($!gs);
  }

  # Is originally:
  # GdaSet *et --> void
  method public-data-changed is also<public_data_changed> {
    self.connect-public-data-changed($!gs);
  }

  method add_holder (GdaHolder() $holder) is also<add-holder> {
    so gda_set_add_holder($!gs, $holder);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gda_set_copy($!gs),
      $raw,
      |self.getTypePair
    );
  }

  method error_quark (GDA::Set:U: ) is also<error-quark> {
    gda_set_error_quark();
  }

  method get_group (GdaHolder() $holder, :$raw = False) is also<get-group> {
    propReturnObject(
      gda_set_get_group($!gs, $holder),
      $raw,
      |GDA::Set::Group.getTypePair
    );
  }

  method get_holder (Str() $holder_id, :$raw = False) is also<get-holder> {
    propReturnObject(
      gda_set_get_holder($!gs, $holder_id),
      $raw,
      |::('GDA::Holder').getTypePair
    );
  }

  method get_holder_value (Str() $holder_id, :$raw = False)
    is also<get-holder-value>
  {
    propReturnObject(
      gda_set_get_holder_value($!gs, $holder_id),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method get_node (GdaHolder() $holder, :$raw = False) is also<get-node> {
    propReturnObject(
      gda_set_get_node($!gs, $holder),
      $raw,
      |GDA::Set::Node.getTypePair
    );
  }

  method get_nth_holder (Int() $pos, :$raw = False) is also<get-nth-holder> {
    my gint $p = $pos;

    propReturnObject(
      gda_set_get_nth_holder($!gs, $pos),
      $raw,
      |::('GDA::Holder').getTypePair
    );
  }

  method get_source (GdaHolder() $holder, :$raw = False) is also<get-source> {
    propReturnObject(
      gda_set_get_source($!gs, $holder),
      $raw,
      |GDA::Set::Source.getTypePair
    );
  }

  method get_source_for_model (GdaDataModel() $model, :$raw = False)
    is also<get-source-for-model>
  {
    propReturnObject(
      gda_set_get_source_for_model($!gs, $model),
      $raw,
      |GDA::Set::Source.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_set_get_type, $n, $t );
  }

  method is_valid (CArray[Pointer[GError]] $error = gerror) is also<is-valid> {
    clear_error;
    my $rv = so gda_set_is_valid($!gs, $error);
    set_error($error);
    $rv;
  }

  method merge_with_set (GdaSet() $set_to_merge) is also<merge-with-set> {
    gda_set_merge_with_set($!gs, $set_to_merge);
  }

  method remove_holder (GdaHolder() $holder) is also<remove-holder> {
    gda_set_remove_holder($!gs, $holder);
  }

  method replace_source_model (GdaSetSource() $source, GdaDataModel() $model)
    is also<replace-source-model>
  {
    gda_set_replace_source_model($!gs, $source, $model);
  }

  # cw: varargs, so currently out-of-scope. Howevver, research should
  #     be conducted to see if a suitable work-around can be constructed
  #method set_holder_value (CArray[Pointer[GError]] $error, Str $holder_id) {
  #    gda_set_set_holder_value($!gs, $error, $holder_id, ...S);
  #}

}

# BOXED

class GDA::Set::Group {
  also does GLib::Roles::Implementor;

  has GdaSetGroup $!gsg is implementor;

  submethod BUILD ( :$gda-set-group ) {
    $!gsg = $gda-set-group if $gda-set-group;
  }

  submethod DESTROY {
    # The call to free() should be attached to the implementor, not the object!
    #self!free;
  }

  method GDA::Raw::Definitions::GdaSetGroup
  { $!gsg }

  method new (GdaSetNode() $node) {
    my $gda-set-group = gda_set_group_new($node);

    $gda-set-group ?? self.bless( :$gda-set-group ) !! Nil;
  }

  method add_node (GdaSetNode() $node) is also<add-node> {
    gda_set_group_add_node($!gsg, $node);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gda_set_group_copy($!gsg),
      $raw,
      self.getTypePair
    );
  }

  method !free {
    gda_set_group_free($!gsg);
  }

  # is also<elems>
  method get_n_nodes is also<get-n-nodes> {
    gda_set_group_get_n_nodes($!gsg),
  }

  method get_node ( :$raw = False ) is also<get-node> {
    propReturnObject(
      gda_set_group_get_node($!gsg),
      $raw,
      |GDA::Set::Node.getTypePair
    );
  }

  method get_nodes (:$glist = False, :$raw = False) is also<get-nodes> {
    returnGList(
      gda_set_group_get_nodes($!gsg),
      $raw,
      $glist,
      |GDA::Set::Node.getTypePair
    );
  }

  method get_source ( :$raw = False ) is also<get-source> {
    propReturnObject(
      gda_set_group_get_source($!gsg),
      $raw,
      |GDA::Set::Source.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_set_group_get_type, $n, $t );
  }

  method set_source (GdaSetSource() $source) is also<set-source> {
    gda_set_group_set_source($!gsg, $source);
  }
}

class GDA::Set::Source {
  also does GLib::Roles::Implementor;

  has GdaSetSource $!gss is implementor;

  submethod BUILD ( :$gda-set-source ) {
    $!gss = $gda-set-source if $gda-set-source;
  }

  submethod DESTROY {
    # The call to free() should be attached to the implementor, not the object!
    #self!free;
  }

  method new (GdaDataModel() $model) {
    my $gda-set-source = gda_set_source_new($model);

    $gda-set-source ?? self.bless( :$gda-set-source ) !! Nil;
  }

  method add_node (GdaSetNode() $node) is also<add-node> {
    gda_set_source_add_node($!gss, $node);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gda_set_source_copy($!gss),
      $raw,
      |self.getTypePair
    );
  }

  method !free {
    gda_set_source_free($!gss);
  }

  method get_data_model ( :$raw = False ) is also<get-data-model> {
    propReturnObject(
      gda_set_source_get_data_model($!gss),
      $raw,
      |::('GDA::Data::Model').getTypePair
    );
  }

  # is also<elems>
  method get_n_nodes is also<get-n-nodes> {
    gda_set_source_get_n_nodes($!gss);
  }

  method get_nodes(:$glist = False, :$raw = False ) is also<get-nodes> {
    returnGList(
      gda_set_source_get_nodes($!gss),
      $raw,
      $glist,
      |GDA::Set::Node.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_set_source_get_type, $n, $t );
  }

  method set_data_model (GdaDataModel() $model) is also<set-data-model> {
    gda_set_source_set_data_model($!gss, $model);
  }

}

class GDA::Set::Node {
  also does GLib::Roles::Implementor;

  has GdaSetNode $!gsn is implementor;

  submethod BUILD ( :$gda-set-node ) {
    $!gsn = $gda-set-node if $gda-set-node;
  }

  submethod DESTROY {
    # The call to free() should be attached to the implementor, not the object!
    #self!free;
  }

  method new (GdaHolder() $holder) {
    my $gda-set-node = gda_set_node_new($holder);

    $gda-set-node ?? self.bless( :$gda-set-node ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gda_set_node_copy($!gsn),
      $raw,
      |self.getTypePair
    );
  }

  method !free {
    gda_set_node_free($!gsn);
  }

  method get_data_model ( :$raw = False ) is also<get-data-model> {
    propReturnObject(
      gda_set_node_get_data_model($!gsn),
      $raw,
      |::('GDA::Data::Model').getTypePair
    );
  }

  method get_holder ( :$raw = False ) is also<get-holder> {
    propReturnObject(
      gda_set_node_get_holder($!gsn),
      $raw,
      |::('GDA::Holder').getTypePair
    );
  }

  method get_source_column is also<get-source-column> {
    gda_set_node_get_source_column($!gsn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_set_node_get_type, $n, $t );
  }

  method set_data_model (GdaDataModel() $model) is also<set-data-model> {
    gda_set_node_set_data_model($!gsn, $model);
  }

  method set_holder (GdaHolder() $holder) is also<set-holder> {
    gda_set_node_set_holder($!gsn, $holder);
  }

  method set_source_column (Int() $column) is also<set-source-column> {
    my gint $c = $column;

    gda_set_node_set_source_column($!gsn, $c);
  }
}
