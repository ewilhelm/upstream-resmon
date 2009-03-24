package Resmon::Module::PGREP;
use Resmon::ExtComm qw/cache_command/;
use vars qw/@ISA/;
@ISA = qw/Resmon::Module/;

sub handler {
  my $arg = shift;
  my $proc = $arg->{'object'};
  my $args = join(' ',$arg->{'arg0'},$arg->{'arg1'},$arg->{'arg2'});
  $args =~s/\s+$//;
  $proc .= " $args" if $args;
  my $output = cache_command("pgrep -f -l '$proc' | grep -v sh | head -1", 500);
  if($output) {
    chomp $output;
    return("OK(pid:$output)");
  }
  return("BAD(no output)");
};
1;
