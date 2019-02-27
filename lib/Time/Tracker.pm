package Time::Tracker;
use Mojo::Base 'Mojolicious';
use Class::Load 'load_class';
use Tracker;

sub startup {
    my $self = shift;

    $self->plugin('Config');

    my $ledger_class = load_class $self->config->{'ledger_class'};
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
