#!/usr/bin/env perl

use strict;
use warnings;
use File::Path qw(make_path remove_tree);

my $confname = $ARGV[0];
opendir(DIR, "../ConfPage/".$confname) or die $!;
if (!-d "../PaperPage/".$confname) {
  make_path("../PaperPage/".$confname) or die $!;
}

my @conferences = grep {
/.html$/
} readdir(DIR);

closedir(DIR);

foreach my $conference (@conferences) {
  open(FILE, "../ConfPage/".$confname."/".$conference) or die $!;
  $conference = substr($conference, 0, -5);
  my $outdir = "../Paper/".$conference;
  print STDERR "$outdir\n";
  if (!-e $outdir) {
    make_path($outdir) or die $!;
  }
  my $count = 0;
  while (<FILE>) {
    my $line = $_;
    if ($line =~ m/Full\ text:/) {
      my @fields = split(/[ ]+/,$line);
      my $link = substr($fields[7], 6, -1);
      my $dest = $outdir."/".$conference.".$count.pdf";
      $count = $count + 1;
      if (!-e $dest) {
        system("wget \"dl.acm.org/$link\" -O $dest");
        my $time = 15 + rand(15);
        sleep($time);
      }
      print STDERR $line;
      print STDERR "$link\n";
    }
  }
  close(FILE);
}
