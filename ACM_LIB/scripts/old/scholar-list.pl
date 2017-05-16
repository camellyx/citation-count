#!/usr/bin/env perl

use strict;
use warnings;

my $confname = $ARGV[0];
opendir(DIR, "../PaperPage/".$confname) or die $!;
if (!-d "../DblpList/".$confname) {
  mkdir("../DblpList/".$confname);
}
my @conferences = readdir(DIR);
closedir(DIR);

foreach my $conference (@conferences) {
  opendir(DIR, "../PaperPage/".$confname."/".$conference) or die $!;
  my @papers = grep {/.html$/} readdir(DIR);
  closedir(DIR);

  open(OUTFILE, ">../DblpList/".$confname."/".$conference.".txt") or die $!;

  foreach my $paper (@papers) {
    open(FILE, "../PaperPage/".$confname."/".$conference."/".$paper)
      or die $!;
    my $title = "no";
    my $citecnt = -1;
    while (<FILE>) {
      my $line = $_;
      if ($line =~ m/margin-top:0px; margin-bottom:0px;\"><strong>/) {
        ($title) = $line =~ /<strong>(.*)<\/strong>/;
        $title =~ s/ /+/g;
      }
    }
    if ($title eq "no") {
      print STDERR "Can't find title in ".$paper."\n";
      exit;
    }
    print OUTFILE "http://scholar.google.com/scholar?q=".$title.".\n";
    print STDERR "http://scholar.google.com/scholar?q=".$title.".\n";
    close(FILE);
  }
  close(OUTFILE);
}
