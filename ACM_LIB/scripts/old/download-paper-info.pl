#!/usr/bin/env perl

use strict;
use warnings;
use File::Path qw(make_path remove_tree);

my $confname = $ARGV[0];
opendir(DIR, "../ConfPage/".$confname) or die $!;
if (!-d "../PaperPage/".$confname) {
  make_path("../PaperPage/".$confname);
}

my @conferences = grep {
/.html$/
} readdir(DIR);

closedir(DIR);

foreach my $conference (@conferences) {
  open(FILE, "../ConfPage/".$confname."/".$conference) or die $!;
  $conference = substr($conference, 0, -5);
  my $outdir = "../PaperPage/".$confname."/".$conference;
  print STDERR "$outdir\n";
  if (!-e $outdir) {
    make_path($outdir) or die $!;
  }
  my $count = 0;
  while (<FILE>) {
    my $line = $_;
    if ($line =~ m/colspan=\"1\"/) {
      if ($line =~ m/Cover /
        || $line =~ m/copyright/i
        || $line =~ m/chair/i
        || $line =~ m/referees/i
        || $line =~ m/committee/i
        || $line =~ m/publisher/i
        || $line =~ m/conference organization/i
        || $line =~ m/opening remarks/i
        || $line =~ m/sigarch/i
        || $line =~ m/reviewers/i
        || $line =~ m/sponsors/i
        || $line =~ m/author index/i
        || $line =~ m/title/i) {
        print STDERR "@@@ Ignored $line";
        next;
      }
      $line =~ s/<italic>//g;
      $line =~ s/<\/italic>//g;
      $line =~ s/<u>//g;
      $line =~ s/<\/u>//g;
      $line =~ s/<sup>//g;
      $line =~ s/<\/sup>//g;
      $line =~ s/<supscrpt>//g;
      $line =~ s/<\/supscrpt>//g;
      my @fields = split(/[<>]+/, $line);
      my $paper_name = $fields[-5];
      my $link = substr($fields[-6], 8, -1);
      my $dest = $outdir."/".$conference.".$count.html";
      $count = $count + 1;
      if (!-e $dest) {
        system("wget \"dl.acm.org/$link\" -O $dest");
        my $time = 15 + rand(15);
        sleep($time);
      }
      print STDERR $line;
      print STDERR "$link | $paper_name\n";
    }
  }
  close(FILE);
}
