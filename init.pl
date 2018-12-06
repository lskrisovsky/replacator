#!/usr/bin/perl

use Cwd;
use warnings;
no warnings ('uninitialized', 'substr');

#############################
## SCRIPT HEADER     ########
#############################
my $process_nm = 'Replace text - initialization';
my $author = 'Ladislav Skrisovsky';
my $version_num = '1.0';

#############################
## INITIALIZING      ########
#############################
my @args = @ARGV;
if ($args[0] eq '\\?' || $args[0] eq '\\help' || $args[0] eq '-help' || $args[0] eq '--help' ) {
  die "Usage: init.pl PROJECT_NAME PATH\nExample: init.pl PCR C:\Projects\PCR\n";
}

#############################
## CONSTANTS         ########
#############################
my $c_project_template_shotcut = '{prjShNm}';
my $c_project_templates_dir = '_templates';
my $c_rules_checkIn_template = 'rules_checkIn_template.txt';
my $c_rules_checkOut_template = 'rules_checkOut_template.txt';

#############################
## GLOBAL VARIABLES  ########
#############################
# Folder settings
my $program_directory = getcwd;
my $project_name = $args[0];
my $project_path = $args[1] // $program_directory;

#############################
## PRINT INIT        ########
############################# 
print "#########################################\n";
print "# INITIALIZING - Start                 ##\n";
print "# ------------------------------------ ##\n";
print "# Start timestamp: ".get_current_timestamp()." ##\n";
print "#########################################\n";
print "Process name:              $process_nm\n";
print "Author:                    $author\n";
print "Version number:            $version_num\n";
print "-----------------------------------------------\n";
print "Program directory:         $program_directory\n";
print "Project directory:         $project_path\n";
print "Project name:              $project_name\n";

#############################
## CORE PRAGRAM      ########
#############################

#############################
# Read - CheckOut template
my $f_r_chOut_filename = $project_path.'/'.$c_project_templates_dir.'/'.$c_rules_checkOut_template;
open(my $f_r_chOut, "<", $f_r_chOut_filename)
               or die "Can't open < $f_r_chOut_filename: $!";
# Read - CheckIn template
my $f_r_chIn_filename = $project_path.'/'.$c_project_templates_dir.'/'.$c_rules_checkIn_template;
open(my $f_r_chIn, "<", $f_r_chIn_filename)
               or die "Can't open < $f_r_chIn_filename: $!";

# Compute output filenames
$out_chOut_filename = $c_rules_checkOut_template;
$out_chIn_filename = $c_rules_checkIn_template;
$out_chOut_filename =~ s/_template//gi;
$out_chIn_filename =~ s/_template//gi;
$out_chOut_filename = $project_path.'/'.$project_name.'_'.$out_chOut_filename;
$out_chIn_filename = $project_path.'/'.$project_name.'_'.$out_chIn_filename;
# Write - CheckOut final
open(my $f_w_chOut, ">", $out_chOut_filename)
               or die "Can't open < $out_chOut_filename: $!";
# Write - CheckIn final
open(my $f_w_chIn, ">", $out_chIn_filename)
               or die "Can't open < $out_chIn_filename: $!";
#############################

#############################
# Output files 
# Replace character - checkOut
while( my $strSrcLine = $f_r_chOut->getline() ) {
  $strSrcLine =~ s/$c_project_template_shotcut/$project_name/gi;
  print $f_w_chOut $strSrcLine;
}
print "\nCreate output file:        $out_chOut_filename\n";
# Replace character - checkOut
while( $strSrcLine = $f_r_chIn->getline() ) {
  $strSrcLine =~ s/$c_project_template_shotcut/$project_name/gi;
  print $f_w_chIn $strSrcLine;
}
print "Create output file:        $out_chIn_filename\n";
#############################

#############################
## FINISHING         ########
print "#########################################\n";
print "# FINISHING                            ##\n";
print "# ------------------------------------ ##\n";
print "# End timestamp:   ".get_current_timestamp()." ##\n";
print "#########################################\n";
#############################

#############################
## SUB-PRAGRAMS  ############
#############################
sub get_current_timestamp {
  my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
  my $s = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year+1900, $mon+1, $mday, $hour, $min, $sec);
  return $s;
}
