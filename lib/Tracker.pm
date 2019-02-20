package Tracker;
use strictures 2;
use Timer;

use Moo;
use namespace::clean;

has ledger => (is => 'ro', does => 'Role::Ledger', required => 1);

sub append_event {
    my ($self, $timer) = @_;

    $self->ledger->append($timer->freeze);
}

sub summary {
    my $self = shift;

    my %summary = ();

    $self->ledger->scan(
        sub {
            my $entry = shift;
            my $timer = Timer->thaw($entry);

            $summary{$timer->activity} ||= 0;
            $summary{$timer->activity} += $timer->duration;
        }
    );

    return \%summary;
}

1;
