#!perl
use strict;
use warnings;
use Test::More;
use Ledger::Memory;

use_ok 'Ledger::Memory';

my $ledger = Ledger::Memory->new;

$ledger->append('foo');
$ledger->append('bar');

my @list = ();
$ledger->scan(sub { push @list, shift });
is_deeply \@list,  ['foo', 'bar'], "scan ledger";

done_testing();
