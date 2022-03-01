use v6;

use GDA::Raw::Types;

use GLib::GSList;
use GDA::Set;
use GDA::Holder;

# .new-inline shouold take a: Pair, 2 element array, GdaHolder
my @holders;
for [ 'a string', 'A string Value' ],
    [ 'an int',    12              ],
    [ 'a picture', GdaBinary       ]
{
  my $h = get-gda-holder-from-proxy-value($_);
  @holders.push( GDA::Holder.new($h, :!ref) );
}

my $gslist = GLib::GSList.new(@holders);

say '-- preGS';
my @returned-holders = returnGSList(
  $gslist.GSList,
  False,
  False,
  |GDA::Holder.getTypePair
).flat;
say '-- postGS';

@returned-holders.gist.say;
.id.say for @returned-holders;

my $set = GDA::Set.new($gslist);
$set.gist.say;
$set.get-holder-value('an int').value.say;
