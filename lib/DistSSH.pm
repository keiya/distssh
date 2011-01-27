use strict;
use warnings;

package DistSSH;

sub new {
	#my $class = shift;
	my ($class, %args) = @_;
	my $cmd = $args{'cmd'};
#	open ($self->{'fh'}, '|'.$cmd)
#	     or die "[DistSSH] Pipe open failed\n";
# print $self->{'fh'}, "echo test>>zzzzzzzzzzzzzzzzzzzzzzzzz";

	open (my $fh, '|'.$args{'cmd'})
	     or die "[DistSSH.pm] Pipe open failed\n";
	my $self = {fh=>$fh,dbg=>$args{'dbg'}};
	print "[DistSSH.pm]new: $args{'cmd'}\n" if $self->{dbg} == 1;
	return bless $self,$class;
}

sub do {
	my ($self, $cmd) = @_;
	my $fh = $self->{fh};
	print $fh $cmd."\n";
	print "[DistSSH.pm]do: $cmd\n" if $self->{dbg} == 1;
	return bless $self;
}

sub DESTROY {
	my $self = shift;
	my $fh = $self->{fh};
	print $fh "exit\n";
	close ($fh)
	      or die "[DistSSH.pm] Pipe close failed\n";
	return bless $self;
}

1;
