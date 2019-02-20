package Time::Tracker::Controller::Timers;
use Mojo::Base 'Mojolicious::Controller';
use Timer;

sub summary {
    my $c = shift->openapi->valid_input or return;

    $c->render(openapi => {summary => $c->tracker->summary});
}

sub append {
    my $c = shift->openapi->valid_input or return;

    my $timer_data = $c->validation->param('timer');
    my $timer = Timer->new($timer_data);

    $c->tracker->append_event($timer);

    $c->render(openapi => {message => "timer created"}, status => 201);
}

1;
