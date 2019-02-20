#!perl
use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Time::Tracker', {ledger_class => 'Ledger::Memory'});

## empty summary
$t->get_ok('/v1/timers/summary')->status_is(200)->json_is('/summary' => {});

## add some events
$t->post_ok('/v1/timers', json => {start => 100, stop => 200, activity => 'working'})
  ->status_is(201)->json_has('/message');

$t->post_ok('/v1/timers', json => {start => 100, stop => 200, activity => 'working'})
  ->status_is(201)->json_has('/message');

$t->post_ok('/v1/timers', json => {start => 100, stop => 200, activity => 'sleeping'})
  ->status_is(201)->json_has('/message');

## full summary
$t->get_ok('/v1/timers/summary')->status_is(200)->json_is('/summary/working' => 200)
  ->json_is('/summary/sleeping' => 100);

done_testing();
