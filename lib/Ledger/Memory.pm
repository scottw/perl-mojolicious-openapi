package Ledger::Memory;
use strictures 2;
use Types::Standard qw(ArrayRef);

use Moo;
use namespace::clean;

with 'Role::Ledger';

has _ledger => (is => 'ro', isa => ArrayRef, default => sub { [] });

sub append {
    push @{shift->_ledger}, @_;
}

sub scan {
    my ($self, $sub) = @_;
    $sub->($_) for @{$self->_ledger};
}

1;
