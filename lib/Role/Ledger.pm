package Role::Ledger;
use Moo::Role;
use strictures 2;

requires qw(append scan);

1;
