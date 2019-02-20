package Ledger::File;
use strictures 2;
use Types::Standard qw(Str);

use Moo;
use namespace::clean;

with 'Role::Ledger';

has ledger_file => (is => 'ro', isa => Str, required => 1);

sub append {
    my ($self, $string) = @_;

    open my $fh, ">>", $self->ledger_file
      or die "Unable to open '" . $self->ledger_file . "' for append: $!\n";
    chomp $string;
    print $fh $string . "\n";

    close $fh;
}

sub scan {
    my ($self, $sub) = @_;

    open my $fh, "<", $self->ledger_file
      or die "Unable to open '" . $self->ledger_file . "' for read: $!\n";
    while (my $line = <$fh>) {
        chomp $line;
        $sub->($line);
    }
    close $fh;
}

1;
