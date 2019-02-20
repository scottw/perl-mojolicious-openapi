package Timer;
use strictures 2;
use Types::Standard qw/Int Str/;

use Moo;
use namespace::clean;

has start => (is => 'rw', isa => Int, default => sub {time});
has stop => (
    is      => 'rw',
    isa     => Int,
    trigger => sub {
        my $s = shift;
        $s->_set_duration($s->stop - $s->start);
    },
    default => sub {time}
);
has activity => (is => 'rw',  isa => Str, default => sub {''});
has duration => (is => 'rwp', isa => Int, default => sub {0});

sub pack {
    my $self = shift;
    scalar {map { $_ => $self->$_ } qw/start stop activity/};
}

sub unpack {
    my ($class, $args) = @_;
    $class->new(%$args);
}

with 'Role::Serializable::JSON';

1;
