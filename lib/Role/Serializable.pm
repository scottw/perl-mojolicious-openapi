package Role::Serializable;
use Moo::Role;
use strictures 2;

requires qw(freeze thaw);

with 'Role::Packable';

1;
