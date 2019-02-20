package Role::Serializable::JSON;
use JSON qw(encode_json decode_json);
use Moo::Role;
use strictures 2;

with 'Role::Serializable';

sub freeze {
    my $self = shift;
    encode_json $self->pack;
}

sub thaw {
    my ($class, $json) = @_;
    $class->unpack(decode_json $json);
}

1;
