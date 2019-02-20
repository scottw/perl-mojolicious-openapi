package Time::Tracker;
use Mojo::Base 'Mojolicious';
use Tracker;

sub startup {
    my $self = shift;

    $self->plugin('Config');

    my $ledger_class = $self->config->{'ledger_class'};
    eval "require $ledger_class";
    die "Unable to load ledger class '$ledger_class': $@\n" if $@;

    my $ledger_args = $self->app->config->{'ledger_args'} // {};

    my $tracker;
    $self->helper(
        tracker => sub {
            my $c = shift;
            return $tracker //= Tracker->new(ledger => $ledger_class->new($ledger_args));
        }
    );

    $self->plugin(OpenAPI => {url => 'swagger.yaml'});
}

1;
