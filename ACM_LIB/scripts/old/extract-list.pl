#!/usr/bin/env perl

use lib 'Text-Capitalize-1.3/lib';
use strict;
use warnings;

use Text::Capitalize;

open(HTML, '>', "index.html") or die $!;
# open(LIST, "list.txt") or die $!;

my $confname = $ARGV[0];
opendir(DIR, "../ConfPage/".$confname) or die $!;
if (!-d "../PaperPage/".$confname) {
  mkdir("../PaperPage/".$confname);
}

my @conferences
= grep {
/.html$/
} readdir(DIR);

@conferences = sort {$a cmp $b} @conferences;

closedir(DIR);

print HTML "<!DOCTYPE html>
<html lang=\"en\">
<head>
<title>List of Eligible Papers for the Micro Test of Time Award 2015</title>
<meta charset=\"utf-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
<link rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css\">
<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js\"></script>
<script src=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js\"></script>
</head>
<body>

<div class=\"container\">
<h2>List of Eligible Papers for the Micro Test of Time Award 2015</h2>
";

foreach my $conference (@conferences) {
  open(FILE, "../ConfPage/".$confname."/".$conference) or die $!;
  $conference = substr($conference, 5, -5);
  my $conf_year = $conference + 1967;
  print HTML "<h3>Micro ".$conf_year."</h3>";
  print HTML "
  <table class=\"table table-striped\">
  <thead>
  <tr><th>Paper Title</th><th>Authors</th></tr>
  </thead>
  <tbody>
  ";
  my $outdir = "../PaperPage/".$confname."/".$conference;
  #print STDERR "$outdir\n";
  if (!-e $outdir) {
    mkdir($outdir) or die $!;
  }
  my $count = 0;
  my $title = "nil";
  my $author = "nil";
  my $link = "nil";
  while (<FILE>) {
    my $line = $_;
    if ($line =~ m/Citation Count:/) {
      my @fields = split(/ /, $line);
      $fields[-2] =~ s/,//g;
      my $citecnt = int($fields[-2]);
      print STDERR $line;
    }
    if ($line =~ m/colspan=\"1\"/) {
      # print
      if ($title ne "nil") {
        if ($author eq "nil") {
          print STDERR "Author not found for $title\n";
        }
        my $caps_title = capitalize_title($title, PRESERVE_ANYCAPS=>1);
        print "$title, $author\n";
        print HTML "<td width=\"60%\"><a href=\"".$link."\">".$caps_title."</a></td><td>".$author."</td></tr>\n";
      }
      # extract title
      $title = "nil";
      $author = "nil";
      $link = "nil";
      if ($line =~ m/cover art/i
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
        || $line =~ m/roster page/i
        || $line =~ m/foreword/i
        || $line =~ m/index of authors/i
        || $line =~ m/preface/i
        || $line =~ m/biographies/i
        || $line =~ m/symposium/i
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
      $line =~ s/&ldquo;/"/g;
      $line =~ s/&rdquo;/"/g;
      my @fields = split(/[<>]+/, $line);
      my $paper_name = $fields[-5];
      $title = $paper_name;
      $link = substr($fields[-6], 8, -1);
      $link = "http://dl.acm.org/".$link;
      my $dest = $outdir."/".$conference.".$count.html";
      $count = $count + 1;
      # print STDERR $line;
      # print STDERR "$paper_name\n";
    }
    if ($line =~ m/author_page/) {
      # extract author
      my @fields = split(/[<>]+/, $line);
      my $name = $fields[-3];
      if ($author eq "nil") {
        $author = $name;
      } else {
        $author = $author." and ".$name;
      }
      #print STDERR "$author\n";
    }
#     if ($line =~ m/Full\ text/i) {
#       # print
#       if ($title ne "nil") {
#         if ($author eq "nil") {
#           print STDERR "Author not found for $title\n";
#         }
#         my $caps_title = capitalize_title($title, PRESERVE_ANYCAPS=>1);
#         print HTML "<td><a href=\"".$link."\">".$caps_title."</a></td><td>".$author."</td></tr>\n";
#       }
#     }
  }
  # print
  if ($title ne "nil") {
    if ($author eq "nil") {
      print STDERR "Author not found for $title\n";
    }
    my $caps_title = capitalize_title($title, PRESERVE_ANYCAPS=>1);
    print "$caps_title, $author\n";
    print HTML "<td><a href=\"".$link."\">".$caps_title."</a></td><td>".$author."</td></tr>\n";
  }

  print HTML "
  </tbody>
  </table>
  ";
  close(FILE);
}

print HTML "
</div>
</body>
</html>
";
