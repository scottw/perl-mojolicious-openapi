#!perl
use strict;
use warnings;
use Test::More;

use_ok 'Timer';

my $timer;

## test full constructor
$timer = Timer->new(start => 1000, stop => 1501, activity => 'phone call');
is $timer->duration, 501, 'duration calculated';

## test duration calculation
$timer->stop(1502);
is $timer->duration, 502, 'duration re-calculated';

## test delayed duration calulation
$timer = Timer->new(activity => 'sleeping');
$timer->start(1000);
is $timer->duration, 0, 'no duration yet';
$timer->stop(1500);
is $timer->duration, 500, 'duration calculated';

## test default duration calculation (could fail occasionally if we cross the second boundary)
$timer = Timer->new(activity => 'throwing up');
$timer->stop(time + 5);
is $timer->duration, 5, 'duration calculated from defaults';

## test input checking
$timer = Timer->new(activity => 'golfing');
eval { $timer->start('dork') };
like $@, qr/type.*int/i, 'start type error';

## round-trip serialization
my $timer2 = Timer->thaw($timer->freeze);
is_deeply $timer, $timer2, 'round-trip serialization';

done_testing();
exit;
