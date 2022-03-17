use v6.c;

use GDA::Raw::Types;

use GDA::Column;
use GDA::Holder;
use GDA::Set;

use GDA::Roles::Data::Model;

class GDA::Server::Operation::Node {
  has GdaServerOperationNode $!gson;

  submethod BUILD ( :$node ) {
    $!gson = $node;
  }

  method new ($node) {
    $node ?? self.bless( :$node ) !! Nil;
  }

  method getTypePair {
    GdaServerOperationNode, GDA::Server::Operation::Node;
  }

  method type {
    GdaServerOperationNodeTypeEnum($!gson.type);
  }

  method status {
    GdaServerOperationNodeStatusEnum($!gson.status)
  }

  method plist ( :$raw = False ) {
    propReturnObject(
      $!gson.plist,
      $raw,
      |GDA::Set.getTypePair
    );
  }

  method model ( :$raw = False ) {
    propReturnObject(
      $!gson.model,
      $raw,
      GDA::Data::Model.getTypePair
    );
  }

  method column ( :$raw = False ) {
    propReturnObject(
      $!gson.column,
      $raw,
      |GDA::Column.getTypePair
    );
  }

  method param ( :$raw = False ) {
    propReturnObject(
      $!gson.param,
      $raw,
      GDA::Holder.getTypePair
    );
  }

}
