# test if our own version numbers meet expectations

use strict;
eval 'use warnings';
use lib "lib";

my @m;
if ($ENV{PERL_CORE}){
  @m = ("CPAN", map { "CPAN::$_" } qw(Debug
                                      DeferredCode
                                      Distroprefs
                                      FirstTime
                                      Kwalify
                                      Nox
                                      Queue
                                      Tarzip
                                      Version
                                     ));
} else {
  opendir DH, "lib/CPAN" or die;
  @m = ("CPAN", map { "CPAN::$_" } grep { s/\.pm$// } readdir DH);
}

use Test::More;
plan(tests => scalar @m);

for my $m (@m) {
  local $^W = 0;
  eval "require $m";
  ok($m->VERSION >= 1.76, sprintf "Found version > 1.76 for %20s: %s", $m, $m->VERSION);
}

# Local Variables:
# mode: cperl
# cperl-indent-level: 2
# End:
