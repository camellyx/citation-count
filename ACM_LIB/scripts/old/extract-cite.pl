#!/usr/bin/env perl

use strict;
use warnings;

my $confname = $ARGV[0];
opendir(DIR, "../PaperPage/".$confname) or die $!;
if (!-d "../CiteCnt/".$confname) {
  mkdir("../CiteCnt/".$confname);
}
my @conferences = readdir(DIR);
closedir(DIR);

foreach my $conference (@conferences) {
  opendir(DIR, "../PaperPage/".$confname."/".$conference) or die $!;
  my @papers = grep {/.html$/} readdir(DIR);
  closedir(DIR);

  open(OUTFILE, ">tmp.txt") or die $!;
  #open(OUTFILE, ">../CiteCnt/".$confname."/".$conference.".txt") or die $!;

  foreach my $paper (@papers) {
    open(FILE, "../PaperPage/".$confname."/".$conference."/".$paper)
      or die $!;
    my $title = "no";
    my $citecnt = -1;
    while (<FILE>) {
      my $line = $_;
      if ($line =~ m/margin-top:0px; margin-bottom:0px;\"><strong>/) {
        ($title) = ($line =~ /<strong>(.*)<\/strong>/);
      }
      if ($line =~ m/Citation Count:/) {
        my @fields = split(/ /, $line);
        $citecnt = int($fields[-2]);
      }
    }
    if ($title eq "no") {
      print STDERR "Can't find title in ".$paper."\n";
      exit;
    }
    if ($citecnt < 0) {
      print STDERR "Citation Count for ".$paper." is $citecnt\n";
      exit;
    }
    print OUTFILE "$citecnt | $title | $conference\n";
    print STDERR "$paper | $citecnt | $title\n";
    close(FILE);
  }
  close(OUTFILE);
  system("sort -nr tmp.txt > ../CiteCnt/$confname/$conference.txt");
}
