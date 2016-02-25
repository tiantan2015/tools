#!/usr/bin/perl
use strict;
use warnings;

&main();

sub usage
{
	printf "# usage:
#      perl ds52xdb.pl ds5_script.ds xdb_script.xdb
#          ds5_script.ds: the input data stream 5 script
#          xdb_script:    the output XDB file
";
}

sub main
{
	my ($input, $output);
	my ($register, $length, $value, $length_string);
	open( $input, '<', $ARGV[0]) or die usage();
	open( $output, '>', $ARGV[1]) or die usage();
	
	while(<$input>){
		if(/^memory\s+set\s+(\S+)\s+(\S+)\s+(\S+)/){
			$register = $1;
			$length = $2;
			$value = $3;

			$length_string = "LONG";	
			if($length eq 16){ $length_string = "SHORT";}
			elsif($length eq 8) { $length_string = "CHAR";}

			print $output "SET VALUE /SIZE=".$length_string." CORE:1(".$register.")=".$value."\n";
		}
	}

	close($input);
	close($output);
}