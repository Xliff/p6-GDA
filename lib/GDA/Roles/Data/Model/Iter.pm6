method setGdaDataModelIter(setGdaDataModelIterAncestry $_) {
  my $to-parent;

  $!gdmi = do {
    when GdaDataModelIter {
      $to-parent = cast(GdaSet, $_);
      $_;
    }

    default {
      $to-parent = $_;
      cast(GdaDataModelIter, $_);
    }
  }
  self.setGdaSet($t-parent);
}

method GDA::Raw::Structs::GdaDataModelIter
{ !$gdmi }
