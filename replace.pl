#!/usr/bin/perl
use Cwd;
use warnings;
no warnings ('uninitialized', 'substr');

#############################
## SCRIPT HEADER     ########
#############################
my $process_nm = 'Replace text';
my $author = 'Ladislav Skrisovsky';
my $version_num = '1.0';

#############################
## INITIALIZING      ########
#############################
my @args = @ARGV;
if ($args[0] eq '\\?' || $args[0] eq '\\help' || $args[0] eq '-help' || $args[0] eq '--help' ) {
  die "Usage: replace.pl SOURCE_FILENAME TARGET_FILENAME RULE_FILE\nExample:\n replace.pl src.txt trg.txt rule.txt\n";
}

#############################
## GLOBAL VARIABLES  ########
#############################
# Folder settings
my $strRulesSeparator = ';';
my $program_directory = getcwd;
my $source_filename_with_path = $args[0];
my $target_filename_with_path = $args[1];
my $rules_filename_with_path = $args[2];

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
print "Source filename:           $source_filename_with_path\n";
print "Target filename:           $target_filename_with_path\n";
print "Filename with rules:       $rules_filename_with_path\n";

#############################
## CORE PRAGRAM      ########
#############################

#############################
# Read - SOURCE FILE
open(my $f_r_Src, "<", $source_filename_with_path)
               or die "Can't open < $source_filename_with_path: $!";
# Read - RULE FILE
open(my $f_r_Rul, "<", $rules_filename_with_path)
               or die "Can't open < $rules_filename_with_path: $!";
# Write - TARGET FILE
open(my $f_w_Trg, ">", $target_filename_with_path)
               or die "Can't open > $target_filename_with_path: $!";
#############################

#############################
# Load RULES
my @strOld;
my @strNew;
my $iRulCycleCnt = 0;
my $iSepIndex;
while( my $strRulLine = $f_r_Rul->getline() ) {
  $strRulLine =~ s/\R//g;
  $iRulCycleCnt++;
  $iSepIndex = index($strRulLine, $strRulesSeparator);
  $strOld[$iRulCycleCnt] = substr($strRulLine, 0, $iSepIndex);
  $strNew[$iRulCycleCnt] = substr($strRulLine, $iSepIndex + 1);
}
#############################

#############################
# Replace character
my $strTrg;
my $iSrcCycleCnt = 0;
while( my $strSrcLine = $f_r_Src->getline() ) {
  for ( $iSrcCycleCnt = 0; $iSrcCycleCnt <= $iRulCycleCnt; $iSrcCycleCnt++ )
  {
    $strSrcLine =~ s/$strOld[$iSrcCycleCnt]/$strNew[$iSrcCycleCnt]/gi;
  }
  print $f_w_Trg $strSrcLine;
}
#############################

#############################
## FINISHING         ########
print "Rule file rows:            $iRulCycleCnt\n\n";
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
